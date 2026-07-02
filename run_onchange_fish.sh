#!/home/linuxbrew/.linuxbrew/bin/fish

if not functions -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    and fisher install jorgebucaran/fisher
    and fisher install jorgebucaran/nvm.fish
end
