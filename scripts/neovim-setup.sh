cd ~

config_dir="$HOME/.config"
neovim_config_dir="$HOME/.config/nvim"

# Check if .config exists
if [ ! -d "$config_dir" ]; then
    mkdir -p "$config_dir"  # Create the directory if it doesn't exist
    echo "Created ~/.config directory"
fi

cd "$config_dir" || exit 1

# check if nvim exists
if [ ! -d "$neovim_config_dir" ]; then
    mkdir -p "$neovim_config_dir"  # Create the directory if it doesn't exist
    echo "Created ~/.config/nvim directory"
fi

cd "$neovim_config_dir" || exit 1

mkdir after
mkdir lua
mkdir plugin
touch init.lua

#setup after folder
cd after
mkdir plugin
cd plugin

# sym link plugins
ln -s $(pwd)/config/nvim/after/plugin/* $HOME/.config/nvim/after/plugin/

# sym link lua/kg
ln -s $(pwd)/config/nvim/lua/kg/* $HOME/.config/nvim/lua/kg/

# sym link init.lua
ln -s $(pwd)/config/nvim/init.lua $HOME/.config/nvim/init.lua

cd ../../lua
