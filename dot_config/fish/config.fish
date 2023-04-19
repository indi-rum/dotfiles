#########################################################################################
# Author            : Sharath Shetty
# Gitlab            : https://gitlab.com/parafait
# Use               : Config for FISH Shell
# Reference         : ArcoLinux config.fish, fish documentation and github fish configs
#########################################################################################

# Make sure fish is in interactive mode

if not status --is-interactive
  exit
end

# User paths
# /var/lib/flatpak/exports/bin/ for having flatpak exec in path, some flatpak not creating .desktop files
set -U fish_user_paths $HOME/.bin $HOME/.local/bin $HOME/Applications $fish_user_paths
#set -U fish_user_paths $HOME/.spicetify $fish_user_paths

# set various values
set -x EDITOR vim                                    # set editor as nvim
set -x VISUAL subl                                    # set editor as nvim
set fish_greeting                                     # suppress fish greeting
set fish_color_autosuggestion '#7d7d7d'
if type -q bat 
  set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"     # set 'bat' as manpager
end

# Prevent directories names from being shortened,need to use if starship prompt is not used
# set fish_prompt_pwd_dir_length 0

# Source Various files
# if [-f ~/.config/fish/functions/functions.fish]
#   source ~/.config/fish/functions/functions.fish
# end

#source ~/.config/fish/functions/fish_prompt.fish

# Use fish prompt if starship prompt not installed
if type -q starship
  starship init fish | source
else
  source ~/.config/fish/functions/fish_prompt.fish
end

# Ignore duplicate commands in history
set HISTCONTROL ignoredups

### ALIASES ###

#Adding some flags
alias df="df -h"
alias free="free -mt"
alias wget="wget -c"
alias hw="hwinfo --short"
#systeminfo
alias probe="sudo -E hw-probe -all -upload"
alias sysfailed="systemctl list-units --failed"

# Applications #
alias neofetch="neofetch --ascii_distro arcolinux_small"

#arcolinux logout unlock
alias rmlogoutlock="sudo rm /tmp/arcologout.lock"

#userlist
alias userlist="cut -d: -f1 /etc/passwd"

#merge new settings
alias merge="xrdb -merge ~/.Xresources"

#grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
#grub issue 08/2022
alias install-grub-efi="sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi"

#backup contents of /etc/skel to hidden backup folder in home/user
alias bupskel="cp -Rf /etc/skel ~/.skel-backup-(date +%Y.%m.%d-%H.%M.%S)"

#switch between bash, zsh and fish
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Done. Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Done. Now log out.'"

#check vulnerabilities microcode
alias microcode="grep . /sys/devices/system/cpu/vulnerabilities/*"

#get fastest mirrors in your neighborhood
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"

## gpg ##
#verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
alias fix-gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
#receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"
alias fix-gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"
alias fix-keyserver="[ -d ~/.gnupg ] || mkdir ~/.gnupg ; cp /etc/pacman.d/gnupg/gpg.conf ~/.gnupg/ ; echo 'done'"

#fixes
alias fix-permissions="sudo chown -R $USER:$USER ~/.config ~/.local"
alias fixkey="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias fix-pacman-conf="/usr/local/bin/arcolinux-fix-pacman-conf"
alias fix-pacman-keyserver="/usr/local/bin/arcolinux-fix-pacman-gpg-conf"

## YOUTUBE-DLP ##
# Video Alias
alias ytv='yt-dlp'
alias ytv-best='yt-dlp --ignore-config -o "$HOME/Videos/%(title)s_%(channel)s.%(ext)s" -f "bv*+ba/b" --remux-video "mkv"'
alias ytv-batch='yt-dlp -a "$HOME/Videos/yt-batch.txt"'
alias ytvp='yt-dlp --config-location "$HOME/.config/yt-dlp/config_playlist"'
alias ytp-batch='yt-dlp -a "$HOME/Videos/ytp-batch.txt" --config-location "$HOME/.config/yt-dlp/config_playlist"'
# Audio Alias
alias yta='yt-dlp -o "$HOME/Downloads/yt_audio/%(title)s_%(channel)s.%(ext)s" -x --audio-format "vorbis" --audio-quality "best"'
alias ytap='yt-dlp -o "$HOME/Downloads/yt_audio/%(playlist_title)s/%(playlist_index)s_%(title)s.%(ext)s" -x --audio-format "best" --audio-quality "best" '

# exa as ls alias
alias ls='exa -ax --icons --sort name --group-directories-first'
alias ll='exa -lhb --time-style default --icons -s name --group-directories-first'
alias lla='exa -lahb --time-style default --icons -s name --group-directories-first'
alias llr='exa -ahlT --icons --sort name --time-style default --group-directories-first -L 2'
alias lsr='exa -lRL 2 -s name --group-directories-first --icons'
# exa as tree
alias tree='exa -T'                                           # executes recursively
alias trl='exa -alT --time-style default --sort name -L'      # need to specify the directory depth during command execution

# cd alias
alias ..='cd ..'
alias ...='cd ../..'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# alias for the dotfiles backup 
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# other alias
alias grep='rg'
alias cat='bat'

## Abbreviations ##
abbr att archlinux-tweak-tool
abbr . 'cd ~'
abbr cg 'cd ~/repos'
abbr upall 'paru -Syu --noconfirm'
abbr ufc 'sudo fc-cache -f'
abbr qq exit

# Editor abbreviations
abbr nb '$EDITOR .bashrc'
abbr nbp '$EDITOR .bashrc-personal'
abbr nf '$EDITOR ~/.config/fish/config.fish'
abbr na '$EDITOR ~/.config/alacritty/alacritty.yml'

# pacman abbreviations
abbr install 'sudo pacman -S'
abbr update 'sudo pacman -Syyu'
abbr remove 'sudo pacman -Rns'
abbr uninstall 'sudo pacman -Rs'

# git abbreviations
abbr gi 'git init'
abbr ga 'git add'
abbr gc 'git clone'
abbr gcm 'git commit -m'
abbr gp 'git push'
abbr gb 'git branch'
abbr gpl 'git pull'
abbr gf 'git fetch'
abbr gchk 'git checkout'

# dotfiles abbreviations
abbr cnfa 'config add'
abbr cnfc 'config commit -m'
abbr cnfp 'config push'
abbr cnfs 'config status'
abbr cnfco 'config checkout'
abbr cnfpull 'config pull'

# Weather
abbr weather 'curl wttr.in'
abbr wmang 'curl wttr.in/mangaluru'
abbr wbang 'curl wttr.in/bengaluru'

# Mirrors
abbr mirl 'sudo reflector --latest 10 --sort rate --age 24 --country India,HongKong,Japan,Singapore,Sweden --verbose --save /etc/pacman.d/mirrorlist'
abbr mir 'sudo reflector --latest 10 --sort rate --age 24 --verbose --save /etc/pacman.d/mirrorlist'



### FUNCTIONS ###
# Fish command history
function history
    builtin history --show-time='%F %T ' | sort
end

# recently installed packages
function ripp --argument length -d "List the last n (100) packages installed"
    if test -z $length
        set length 100
    end
    expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | tail -n $length | nl
end

# Function to extracts a compressed file
function ex --description "Extract bundled & compressed files"
    if test -f "$argv[1]"
        switch $argv[1]
            case '*.tar.bz2'
                tar xjfv $argv[1]
            case '*.tar.gz'
                tar xzfv $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xfv $argv[1]
            case '*.tbz2'
                tar xjfv $argv[1]
            case '*.tgz'
                tar xzfv $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z $argv[1]
            case '*.deb'
                ar $argv[1]
            case '*.tar.xz'
                tar xfv $argv[1]
            case '*.tar.zst'
                tar xfv $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via ex"
        end
   else
       echo "'$argv[1]' is not a valid file"
   end
end

## To use !! and !$ in fish shell
# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Set the terminal title
function fish_title
    printf 'Alacritty'
end

# function less
#     command less -R $argv
# end

# Move the given directory and ls the contents
function cd
 builtin cd $argv; and ls
end


# Run a fetch tool on startup
#paleofetch
#ufetch
pfetch
#ufetch-arco
