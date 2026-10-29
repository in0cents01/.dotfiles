# fzf
command -v fzf >/dev/null && source <(fzf --zsh)

# zoxide
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# eza aliases
if command -v eza >/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -lah --icons --group-directories-first'
fi

# plugins
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# starship
command -v starship >/dev/null && eval "$(starship init zsh)"

# syntax highlighting (last)
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 


# fix installation
# sudo apt install zsh-autosuggestions zsh-syntax-highlighting fzf zoxide 
#
#
#  starship (official installer)
#  curl -sS https://starship.rs/install.sh | sh

# eza (Ubuntu  has it in apt)
# sudo apt install eza 
#
# sudo mkdir -p /etc/apt/keyrings
# wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
# echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
# sudo apt update
# sudo apt install eza 
# 

# check 
# which fzf zoxide starship eza
# ls /usr/share/zsh-autosuggestions /usr/share/zsh-syntax-highlighting
export PATH="/opt/nvim-linux-x86_64/bin:$PATH" 

