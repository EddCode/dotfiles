set -g __fish_prompt_grey A3A3A3

# Git prompt icons
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_stateseparator  " "\Ue725" "  #\U0020
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""
set -g __fish_git_prompt_char_upstream_equal '💯 '
set -g __fish_git_prompt_char_upstream_diverged '🚧  '

# git prompt colors
set -g __fish_git_prompt_color $__fish_prompt_grey
set -g __fish_git_prompt_color_branch magenta -i
set -g __fish_git_prompt_color_cleanstate green
set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_untrackedfiles $__fish_prompt_grey #$fish_color_normal


set -g __fish_git_prompt_hide_untrackedfiles 1
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showcolorhints 1
set -g __fish_git_prompt_showupstream "informative"


function fish_prompt
  set -l last_status $status
  set -l pathcolor $__fish_prompt_grey

  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l magenta (set_color -o magenta)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l normal (set_color normal)

  set -l apple ""
  set -l cwd $blue(prompt_pwd)
  set -l git $magenta(fish_git_prompt)
  set -l end $blue"𝄡"


  echo -n "$apple $cwd $git"

  if not test $last_status -eq 0
    set_color $fish_color_error
  end

  if fish_is_root_user
    echo -n "♯"
  end
  echo -n " $end "
end
