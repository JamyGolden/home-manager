# https://nixos.org/download/
# Linux single user
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# MacOS
sh <(curl -L https://nixos.org/nix/install)

ln -s ~/projects/jamygolden-home-manager/config/nix ~/.config/nix

# https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixos-unstable nixpkgs
nix-channel --update

nix-shell '<home-manager>' -A install

ln -s $DOTFILES_REPO_PATH/config/nix $HOME/.config/nix

# To install zsh
echo "/home/$USER/.nix-profile/bin/zsh" | sudo tee -a /etc/shells
cat /etc/shells # to ensure path exists
chsh -s $(which zsh) $USER