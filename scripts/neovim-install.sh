cd ~
dir="~/nvim"

if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    echo "Directory created: $dir"
else
    echo "Directory already exists: $dir"
fi

# clone
git clone --depth 1 --branch nightly https://github.com/neovim/neovim.git
cd nvim

# build and install
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

export PATH="$HOME/nvim/bin:$PATH"

# run
nvim
