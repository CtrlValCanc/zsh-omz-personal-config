#!/bin/bash

echo "Setting up Zsh and Oh My Zsh..."

# Install Zsh using pacman
if ! sudo apt install zsh curl git; then
    echo "Error: Zsh installation failed."
    exit 1
fi

echo "Zsh installed."

# Install Oh My Zsh using installation command from GitHub
if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
    echo "Error: Oh My Zsh installation failed."
    exit 1
fi

echo "Oh My Zsh installed."

# Change default shell to Zsh for the current user
	chsh -s $(which zsh);

echo "Changed default shell to Zsh."

# Clone zsh-autosuggestions plugin from GitHub repository
if ! git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions; then
    echo "Error: Cloning zsh-autosuggestions plugin failed."
    exit 1
fi

# Clone zsh-syntax-highlighting plugin from GitHub repository
if ! git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting; then
    echo "Error: Cloning zsh-syntax-highlighting plugin failed."
    exit 1
fi

echo "Cloned zsh-autosuggestions and zsh-syntax-highlighting plugins."

# Modify the ~/.zshrc file to include zsh-autosuggestions and zsh-syntax-highlighting plugins
if ! sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc; then
    echo "Error: Modifying ~/.zshrc failed."
    exit 1
fi

# Update the Zsh configuration file
if ! source ~/.zshrc; then
    echo "Error: Updating Zsh configuration failed."
    exit 1
fi

echo "Updated Zsh configuration."


# Install Powerlevel10k theme for Zsh using git
if ! git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k; then
    echo "Error: Installing Powerlevel10k theme failed."
    exit 1
fi

echo "Installed Powerlevel10k theme."

# Download and install fonts
if ! wget -P ~/.local/share/fonts/ https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf &&
     wget -P ~/.local/share/fonts/ https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf &&
     wget -P ~/.local/share/fonts/ https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf &&
     wget -P ~/.local/share/fonts/ https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf; then
    echo "Error: Font download failed."
    exit 1
fi

# Update font cache
fc-cache -vf ~/.local/share/fonts/
echo "Fonts downloaded and cache updated."


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
        if ! source ~/.zshrc; then
            echo "Error: Adding alias failed."
            exit 1
        fi
        echo "Added alias: $new_alias"
    done
fi

echo "Everything has been set up successfully. You can restart the terminal to see the changes."
