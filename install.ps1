# ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
# ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
# ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
# ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
# ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
# ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
# 输出以上字符串
Write-Host "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
Write-Host "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
Write-Host "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
Write-Host "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
Write-Host "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
Write-Host "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"

# 判断 scoop 是否安装，如果未安装则安装 scoop
$scoop = Get-Command scoop -ErrorAction SilentlyContinue
if ($scoop -eq $null) {
    Write-Host "Installing scoop..."
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    Write-Host "scoop installed."
} else {
    Write-Host "scoop already installed."
}


# 判断 neovim 是否安装，如果未安装则安装 neovim
$nvim = Get-Command nvim -ErrorAction SilentlyContinue
if ($nvim -eq $null) {
    Write-Host "Installing neovim..."
    scoop install neovim -y
    Write-Host "neovim installed."
} else {
    Write-Host "neovim already installed."
}

# 判断 nodejs 是否安装，如果未安装则安装 nodejs
$node = Get-Command node -ErrorAction SilentlyContinue
if ($node -eq $null) {
    Write-Host "Installing nodejs..."
    scoop install nodejs -y
    Write-Host "nodejs installed."
} else {
    Write-Host "nodejs already installed."
}

# 创建数组，用于存放需要安装的软件
$apps = @(
    "git",
    "curl",
    "wget",
    "gzip",
    "rust",
    "yarn"
)
# 循环安装软件，如果已安装则跳过
foreach ($app in $apps) {
    $ok = Get-Command $app -ErrorAction SilentlyContinue
    if ($ok -eq $null) {
        Write-Host "Installing $app..."
        scoop install $app
        Write-Host "$app installed."
    } else {
        Write-Host "$app already installed."
    }
}

$python_deps = @(
    "pynvim",
	"debugpy",
	"black"
)
Write-Host "Installing python dependencies..."
foreach ($dep in $python_deps) {
    $ok = Get-Command $dep -ErrorAction SilentlyContinue
    if ($ok -eq $null) {
        Write-Host "Installing python $dep..."
        pip install $dep
        Write-Host "$dep installed."
    } else {
        Write-Host "$dep already installed."
    }
}

$node_deps = @(
    "neovim",
	"prettier",
	"eslint"
)

Write-Host "Installing nodejs dependencies..."
foreach ($dep in $node_deps) {
    $ok = Get-Command $dep -ErrorAction SilentlyContinue
    if ($ok -eq $null) {
        Write-Host "Installing $dep..."
        yarn global add $dep
        Write-Host "$dep installed."
    } else {
        Write-Host "$dep already installed."
    }
}

# 克隆 https://github.com/yeezc/neovim-conf.git 到 ~/AppData/Local/nvim
Write-Host "Cloning neovim-conf..."
# 删除已存在的 neovim-conf
Remove-Item -Recurse -Force $HOME\AppData\Local\nvim
git clone --branch main "https://github.com/yeezc/neovim-conf.git" $HOME\AppData\Local\nvim
Write-Host "neovim-conf cloned."

# 执行 nvim --headless
Write-Host "Installing plugins..."
nvim --headless +"Lazy sync" +qall
Write-Host "Plugins installed."