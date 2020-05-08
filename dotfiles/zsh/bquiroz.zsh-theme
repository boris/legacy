local ret_status="%(?:%{$FG[075]%}➜:%{$fg_bold[red]%}➜%s)"
local rbenv_version=''
if which rbenv &> /dev/null; then
  ruby_version="$(rbenv version | sed -e "s/ (set.*$//")"
fi

function get_pwd() {
  echo "${PWD/$HOME/~}"
}

PROMPT='%{$FG[075]%}$USER@%m %{$FG[007]%}$(get_pwd)%{$FG[043]%} $(git_prompt_info)$(bzr_prompt_info)$(virtualenv_prompt_info)%{$fg_bold[blue]%}%{$reset_color%}$fg_bold[gray]%}
[%w %*] ${ret_status}%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="git:[%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[043]%}]%{$fg[yellow]%} ✗ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[043]%}] "
