# _____________________________/\\\_________        
#  ____________________________\/\\\_________       
#   ____________________________\/\\\_________      
#    __/\\\\\\\\\\\__/\\\\\\\\\\_\/\\\_________     
#     _\///////\\\/__\/\\\//////__\/\\\\\\\\\\__    
#      ______/\\\/____\/\\\\\\\\\\_\/\\\/////\\\_   
#       ____/\\\/______\////////\\\_\/\\\___\/\\\_  
#        __/\\\\\\\\\\\__/\\\\\\\\\\_\/\\\___\/\\\_ 
#         _\///////////__\//////////__\///____\///__
#-------------OMZ features without OMZ -------------

# Prompt
PROMPT="%n@%m %~ $ "

# History
HISTFILE=~/.cache/zsh_history
HISTSIZE=10000
SAVEHIST=10000

# General
autoload -U colors && colors	# Load colors
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments
if [ -f $HOME/.config/light-toggle ]
then
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ffffff,bg=#000000"
else

	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#000000,bg=#ffffff"
fi

# better tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case insensitivity
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.

# History based searching
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# auto escape shit like url
autoload -U url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# fixing autosuggestion issues with magic quotes
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic 
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# Sourcing shit
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'm' vi-backward-char
bindkey -M menuselect 'e' vi-up-line-or-history
bindkey -M menuselect 'i' vi-forward-char
bindkey -M menuselect 'n' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Aliases
# This is always in sudo
for command in mount powertop tlp umount systemctl pmm nala apt brl pacman xbps-install xbps-remove dpkg updatedb su shutdown poweroff reboot ; do
	alias $command="sudo $command"
done; unset command

# Verbosity and settings that you pretty much just always are going to want.
alias cp="cp -iv" 
alias mv="mv -iv" 
alias rm="rm -vI" 
alias rf="rm -vIrf" 
alias la="ls -a" 
alias bc="bc -ql" 
alias mkdir="mkdir -pv" 
alias du="du -h" 
alias df="df -h" 
alias ffmpeg="ffmpeg -hide_banner" 
alias less="bat"

# Colorize commands when possible.
alias ls="ls -hN --color=auto --group-directories-first" 
alias grep="grep --color=auto" 
alias diff="diff --color=auto" 


# Package manager aliases
alias ki="yay -S"
alias ku="yay -Syu --noconfirm"
alias ks="yay -Ss" 
alias kq="yay -Si" 
alias kr="yay -Rns"
alias kar="yay -Rns $(yay -Qtdq)"
alias kf="yay -Fy"
alias kcc="yay -Scc --noconfirm"

alias fpi="flatpak install"
alias fps="flatpak search"
alias fpr="flatpak remove"
alias fp-delete="flatpak remove --delete-data"
alias fp-autoremove="flatpak remove --unused"

# General shortening
alias sdn="poweroff" 
alias src="source $HOME/.config/zsh/.zshrc" 
alias v="$EDITOR" 
alias sv="sudo $EDITOR" 
alias ani="ani-cli -q 1080" 
alias nfh="neofetch" 
alias rg="ranger" 
alias trrl="watch -n 1 transmission-remote -l"
alias trr="transmission-remote"
alias btp="btop"
alias ksend="kdeconnect-cli -n M31s --share"
alias drg="dragon-drop"
alias yt="yt-dlp -f 'bestvideo[height<=?1080][vcodec^=avc1]+bestaudio/best'"
alias ytp="yt -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias ytf="ytfzf -t"
alias chx="chmod +x"
alias mkd="mkdir"
alias x="exit"
alias pg="pgrep -a -i"

# Easily edit certain files with these commands
alias cfz="$EDITOR ~/.config/zsh/.zshrc"
alias cfs="$EDITOR ~/.config/sway/config"
alias cfw="$EDITOR ~/.config/waybar/config"
alias cfww="$EDITOR ~/.config/waybar/style.css"
alias cff="$EDITOR ~/.config/foot/foot.ini"


# Easily go places with this commands
alias gd="cd ~/Documents" 
alias gD="cd  ~/Downloads"  
alias gss="cd ~/Pictures/Screenshots" 
alias gsr="cd ~/Videos/Screencasts" 
alias gw="cd ~/Pictures/Wallpapers" 
alias gW="ranger ~/Pictures/Wallpapers" 
alias sc="cd ~/Documents/Scripts"
alias site="cd ~/Documents/git/pages"
alias site2="cd ~/Documents/git/akhilkrishauk.github.io"
alias gt="cd ~/Documents/git/"
alias md="cd ~/Documents/Markdown"


# Shell functions

 #auto ls on cd 
cd(){
	builtin cd $@
	ls;
}

# use fzf to edit my configs and scripts
cf(){
	find $HOME/.config $HOME/Documents/Scripts -type f | fzf | xargs -r $EDITOR;
}
 
# convert vids to work with shitty apps that doesnt support shit.
conv(){
	ffmpeg -i $1 -c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p $1-fixed.mp4
}

# show the time that has passed since it was last plugged in
batlife(){
	echo $(upower -d | grep updated | head -n1 | awk '{printf $8}' | cut -d\( -f2)/3600 | bc 
}

# convert an image to grayscale
grayscale(){
	convert $1 -colorspace Gray $1-gray.jpg
}

# split video into 30 second clips
vidsplit(){
	#ffmpeg -i $1 -c copy -map 0 -segment_time 00:29:00 -f segment -reset_timestamps 1 out%03d.mkv
	ffmpeg -i $1 -segment_time 30 -f segment -reset_timestamps 1 out%d.mkv
}

# Runs a command in an infinite loop until you kill it
loop(){
	while true;
	do
		$*
		sleep 1
	done
}

# Zips all the folders in a folder
zipall(){
	for i in $(ls); do
		zip -r $i.zip $i/
	done
}

# Foot shell integration
function osc7 {
    local LC_ALL=C
    export LC_ALL

    setopt localoptions extendedglob
    input=( ${(s::)PWD} )
    uri=${(j::)input/(#b)([^A-Za-z0-9_.\!~*\'\(\)-\/])/%${(l:2::0:)$(([##16]#match))}}
    print -n "\e]7;file://${HOSTNAME}${uri}\e\\"
}
add-zsh-hook -Uz chpwd osc7

# interactive fuzzy pacman search
function kif() {
  yay -Sl | fzf --multi --preview="yay -Si {1}/{2}" --preview-window=top,50% --bind 'enter:execute( yay -S {1}/{2})'
}

# quick qr creation
qr(){
	clip=$(wl-paste)
	x="/tmp/ytqr.png"
	qrencode -l H -o "$x" "$clip"
	swayimg $x
	rm "$x"
}

# git clone
gtc(){
	git clone https://github.com/$1
}

# chatgpt
ask(){
	clear
	tgpt "$*"	
}

# copybuffer (stolen from OMZ)
copybuffer () {
    printf "%s" "$BUFFER" | wl-copy
}

zle -N copybuffer

bindkey -M emacs "^O" copybuffer
bindkey -M viins "^O" copybuffer
bindkey -M vicmd "^O" copybuffer

