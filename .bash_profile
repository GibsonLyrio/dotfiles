#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

echo "Hello World!" >> ~/.bash_profile_log.txt
