#!/usr/bin/env bash
set -eo pipefail

OS="$(uname -s)"

declare -xr CONF_ROOT="$HOME/.config"
declare -xr NVIM_CONF_LUA="${CONF_ROOT}/nvim"
declare -xr NVIM_INSTALL_PATH="${NVIM_INSTALL_PATH:-/usr/local}"

declare -xr NVIM_SRC_PATH="${NVIM_SRC_PATH:-$HOME/.local/src/nvim}"

declare -a __npm_deps=(
	"neovim"
	"prettier"
	"eslint"
)
# treesitter installed with brew causes conflicts #3738
if ! command -v tree-sitter &>/dev/null; then
	__npm_deps+=("tree-sitter-cli")
fi

function print_missing_dep_msg() {
	if [ "$#" -eq 1 ]; then
		echo "[ERROR]: Unable install [$1]"
		echo "Please install it first and re-run the installer. Try: $RECOMMEND_INSTALL $1"
	else
		local cmds
		cmds=$(for i in "$@"; do echo "$RECOMMEND_INSTALL $i"; done)
		printf "[ERROR]: Unable to install [%s]" "$@"
		printf "Please install any one of the dependencies and re-run the installer. Try: \n%s\n" "$cmds"
	fi
}

declare -a __pip_deps=(
	"pynvim"
	"debugpy"
	"black"
)

declare -a __rust_deps=(
	"fd::fd-find"
	"rg::ripgrep"
	"stylua::stylua"
)

declare -a __go_deps=(
	"golang.org/x/tools/gopls"
	"github.com/go-delve/delve/cmd/dlv"
	"golang.org/x/tools/cmd/goimports"
	"mvdan.cc/sh/v3/cmd/shfmt"
)

declare -a __tools=(
	"curl"
	"git"
	"nvim"
	"lazygit"
)

function is_arch() {
	return [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]
}

function is_darwin() {
	return [ "$OS" = "Darwin" ]
}

function is_go_installed() {
	return command -v go &>/dev/null
}

function clone_configuration() {
	mkdir -p $CONF_ROOT
	rm -rf $NVIM_CONF_LUA
	msg "Cloning neovim configuration"
	if ! git clone --branch main \
		"https://github.com/yeezc/neovim-conf.git" "$NVIM_CONF_LUA"; then
		echo "Failed to clone repository. Installation failed."
		exit 1
	fi
}

function install_tools() {
	echo "Installing required tools.."
	for dep in "${__tools[@]}"; do
		if ! command -v "${dep}" &>/dev/null; then
			echo "${dep} will be install"
			if [ "lazygit" = ${dep} ]; then
				case "$OS" in
				Linux)
					if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]; then
						bash -c "$RECOMMEND_INSTALL ${dep}" || return 1
					elif [ -f "/etc/fedora-release" ] || [ -f "/etc/redhat-release" ]; then
						bash -c "$RECOMMEND_INSTALL ${dep}" || return 1
					elif [ -f "/etc/gentoo-release" ]; then
						bash -c "$RECOMMEND_INSTALL ${dep}" || return 1
					else # assume debian based
						LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
						curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
						tar xf lazygit.tar.gz lazygit
						sudo install lazygit /usr/local/bin/lazygit
						rm -rf lazygit.tar.gz lazygit
					fi
					;;
				*)
					bash -c "$RECOMMEND_INSTALL ${dep}" || return 1
					;;
				esac
			elif [ "nvim" = ${dep} ]; then
				if is_arch || is_darwin; then
					bash -c "$RECOMMEND_INSTALL neovim" || return 1
				else
					install_neovim_from_src || return 1
				fi
			else
				bash -c "$RECOMMEND_INSTALL ${dep}" || return 1
			fi
		fi
	done
	echo "All tools are successfully installed"
}

function detect_platform() {
	case "$OS" in
	Linux)
		if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]; then
			RECOMMEND_INSTALL="sudo pacman -S"
		elif [ -f "/etc/fedora-release" ] || [ -f "/etc/redhat-release" ]; then
			RECOMMEND_INSTALL="sudo dnf install -y"
		elif [ -f "/etc/gentoo-release" ]; then
			RECOMMEND_INSTALL="emerge -tv"
		else # assume debian based
			RECOMMEND_INSTALL="sudo apt install -y"
		fi
		;;
	FreeBSD)
		RECOMMEND_INSTALL="sudo pkg install -y"
		;;
	NetBSD)
		RECOMMEND_INSTALL="sudo pkgin install"
		;;
	OpenBSD)
		RECOMMEND_INSTALL="doas pkg_add"
		;;
	Darwin)
		if ! command -v brew &>/dev/null; then
			msg "install brew..."
			bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
			if [ $? -ne 0 ]; then
				print_missing_dep_msg "brew"
				exit 1
			fi
		fi
		RECOMMEND_INSTALL="brew install"
		;;
	*)
		echo "OS $OS is not currently supported."
		exit 1
		;;
	esac
}

function install_neovim_from_src() {
	msg "Installing neovim from source..."
	echo "Installing requirements..."
	case "$OS" in
	Linux)
		if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]; then
			sudo pacman -S base-devel cmake unzip ninja curl
		elif [ -f "/etc/fedora-release" ] || [ -f "/etc/redhat-release" ]; then
			sudo dnf install -y ninja-build cmake gcc make unzip gettext curl
		elif [ -f "/etc/gentoo-release" ]; then
			emerge -tv ninja cmake gcc make unzip gettext curl
		else # assume debian based
			sudo apt install -y ninja-build gettext cmake unzip curl
		fi
		;;
	FreeBSD)
		sudo pkg install -y cmake gmake sha unzip wget gettext curl
		;;
	NetBSD)
		sudo pkgin install cmake gmake sha unzip wget gettext curl
		;;
	OpenBSD)
		doas pkg_add gmake cmake unzip curl gettext-tools
		;;
	Darwin)
		brew install ninja cmake gettext curl
		;;
	*)
		echo "OS $OS is not currently supported."
		exit 1
		;;
	esac
	msg "Cloning neovim..."
	mkdir -p $NVIM_SRC_PATH/..
	rm -rf $NVIM_SRC_PATH
	if ! git clone --branch stable \
		"https://github.com/neovim/neovim.git" "$NVIM_SRC_PATH"; then
		echo "Failed to clone repository. Installation failed."
		exit 1
	fi
	msg "Building neovim..."
	cd $NVIM_SRC_PATH
	make CMAKE_BUILD_TYPE=Release
	msg "Installing neovim..."
	sudo make install
	echo "Cleaning up..."
	cd $HOME
	sudo rm -rf $NVIM_SRC_PATH
	msg "Neovim is successfully installed"
}

function install_neovim_from_binary() {
	msg "Installing neovim from binary..."
	SUFFIX=""
	MAC=0
	case "$OS" in
	Linux)
		SUFFIX="-linux64"
		;;
	Darwin)
		SUFFIX="-macos"
		MAC=1
		;;
	*)
		echo "OS $OS is not currently supported."
		exit 1
		;;
	esac
	msg "Downloading neovim..."
	mkdir -p $NVIM_SRC_PATH
	cd $NVIM_SRC_PATH
	curl -Lo "nvim${SUFFIX}.tar.gz" "https://github.com/neovim/neovim/releases/download/stable/nvim${SUFFIX}.tar.gz"
	if [ $MAC =1 ]; then
		xattr -c ./nvim-macos.tar.gz
	fi
	msg "Extracting neovim..."
	tar xzvf "nvim${SUFFIX}.tar.gz" -C ${NVIM_SRC_PATH}
	sudo rm -rf ${NVIM_INSTALL_PATH}/bin/nvim ${NVIM_INSTALL_PATH}/share/nvim ${NVIM_INSTALL_PATH}/lib/nvim
	sudo chmod +x "${NVIM_SRC_PATH}/nvim${SUFFIX}/bin/nvim"
	echo "Installing neovim..."
	sudo install "${NVIM_SRC_PATH}/nvim${SUFFIX}/bin/nvim" "${NVIM_INSTALL_PATH}/bin/nvim"
	sudo cp -r "${NVIM_SRC_PATH}/nvim${SUFFIX}/share/nvim" "${NVIM_INSTALL_PATH}/share/nvim"
	sudo cp -r "${NVIM_SRC_PATH}/nvim${SUFFIX}/lib/nvim" "${NVIM_INSTALL_PATH}/lib/nvim"
	echo "Cleaning up..."
	rm -rf "nvim${SUFFIX}.tar.gz"
	cd $HOME
	rm -rf ${NVIM_SRC_PATH}
	msg "Neovim is successfully installed"
}

function msg() {
	local text="$1"
	local div_width="80"
	printf "%${div_width}s\n" ' ' | tr ' ' -
	printf "%s\n" "$text"
}

function print_logo() {
	cat <<'EOF'
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
                                                  
EOF
}

function check_neovim_min_version() {
	local verify_version_cmd='if !has("nvim-0.9") | cquit | else | quit | endif'

	# exit with an error if min_version not found
	if ! nvim --headless -u NONE -c "$verify_version_cmd"; then
		echo "[ERROR]: this config requires at least Neovim v0.9 or higher"
		exit 1
	fi
}

function install_python_deps() {
	echo "Verifying that pip is available.."
	if ! python3 -m ensurepip >/dev/null; then
		if ! python3 -m pip --version &>/dev/null; then
			echo "[WARN]: skipping installing optional python dependencies"
			return 1
		fi
	fi
	echo "Installing with pip.."
	for dep in "${__pip_deps[@]}"; do
		python3 -m pip install --user "$dep" || return 1
	done
	echo "All Python dependencies are successfully installed"
}

function __validate_node_installation() {
	local pkg_manager="$1"
	local manager_home

	if ! command -v "$pkg_manager" &>/dev/null; then
		return 1
	fi

	if [ "$pkg_manager" == "npm" ]; then
		manager_home="$(npm config get prefix 2>/dev/null)"
	elif [ "$pkg_manager" == "pnpm" ]; then
		manager_home="$(pnpm config get prefix 2>/dev/null)"
	else
		manager_home="$(yarn global bin 2>/dev/null)"
	fi

	if [ ! -d "$manager_home" ] || [ ! -w "$manager_home" ]; then
		return 1
	fi

	return 0
}

function __install_nodejs_deps_yarn() {
	echo "Installing node modules with yarn.."
	yarn global add "${__npm_deps[@]}"
	echo "All NodeJS dependencies are successfully installed"
}

function install_nodejs_deps() {
	local -a pkg_managers=("pnpm" "yarn" "npm")
	for pkg_manager in "${pkg_managers[@]}"; do
		if __validate_node_installation "$pkg_manager"; then
			eval "__install_nodejs_deps_$pkg_manager"
			return
		fi
	done
	echo "[WARN]: skipping installing optional nodejs dependencies due to insufficient permissions."
	echo "check how to solve it: https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally"
}

function __attempt_to_install_with_cargo() {
	if ! command -v cargo &>/dev/null; then
		curl https://sh.rustup.rs -sSf | sh
		if ! source ~/.cargo/env &>/dev/null; then
			echo "[WARN]: Unable to find cargo. Make sure to install it to avoid any problems"
			exit 1
		fi
	fi
	echo "Installing missing Rust dependency with cargo"
	cargo install "$1"
}

# we try to install the missing one with cargo even though it's unlikely to be found
function install_rust_deps() {
	for dep in "${__rust_deps[@]}"; do
		if ! command -v "${dep%%::*}" &>/dev/null; then
			__attempt_to_install_with_cargo "${dep##*::}"
		fi
	done
	echo "All Rust dependencies are successfully installed"
}

function install_go_deps() {
	if ! is_go_installed; then
		echo "[WARN]: skipping installing optional go dependencies"
	else
		for dep in "${__go_deps[@]}"; do
			go install "${dep}@latest" || return 1
		done
		echo "All Go dependencies are successfully installed"
	fi
}

function main() {
	print_logo
	msg "Detecting platform for managing any additional neovim dependencies"
	detect_platform
	install_tools
	install_nodejs_deps
	install_python_deps
	install_rust_deps
	install_go_deps

	if [ -e "$HOME/.config/nvim" ]; then
		rm -rf $HOME/.config/nvim
	fi
	check_neovim_min_version
	clone_configuration

	# 自动安装 vim plugins
	msg "install neovim plugins..."
	bash -c "nvim --headless '+Lazy sync' +qa"
	msg "Successfully install neovim plugins."
	msg "Thank you for installing NeoVim!!"
}

main "$@"
