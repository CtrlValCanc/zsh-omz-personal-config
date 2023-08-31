#!/bin/bash

echo "Setting up Zsh and Oh My Zsh..."

# Install Zsh using pacman
sudo pacman -S zsh curl git

# Install Oh My Zsh using installation command from GitHub
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Zsh and Oh My Zsh installed."

# Change default shell to Zsh for the current user
chsh -s $(which zsh)

echo "Changed default shell to Zsh."

# Clone zsh-autosuggestions plugin from GitHub repository
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

# Clone zsh-syntax-highlighting plugin from GitHub repository
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

echo "Cloned zsh-autosuggestions and zsh-syntax-highlighting plugins."

# Modify the ~/.zshrc file to include zsh-autosuggestions and zsh-syntax-highlighting plugins
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# Update the Zsh configuration file
source ~/.zshrc

echo "Updated Zsh configuration."

# Install Nerd Font (Meslo) using yay
yay -S ttf-meslo-nerd-font-powerlevel10k

echo "Installed Nerd Font."

# Install Powerlevel10k theme for Zsh using git
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Installed Powerlevel10k theme."

# Ask the user if they want to add aliases
read -p "Do you want to add aliases? (y/N): " add_aliases

# Check the user's response
if [ "$add_aliases" == "y" ]; then
    # Loop to add aliases until the user chooses to stop
    while true; do
        read -p "Enter an alias (or press Enter to exit): " new_alias
        if [ -z "$new_alias" ]; then
            break
        fi
        echo "alias $new_alias" >> ~/.zshrc
        source ~/.zshrc
        echo "Added alias: $new_alias"
    done
fi

echo "Everything has been set up successfully. You can restart the terminal to see the changes."
