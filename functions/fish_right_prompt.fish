# You can override some default options with config.fish:
#
#  set -g theme_hide_right_prompt yes

function fish_right_prompt
  if test "$theme_hide_right_prompt" = 'yes'
    return
  end

  set_color $fish_color_autosuggestion 2> /dev/null; or set_color 555
  date "+%H:%M:%S"
  set_color normal
end
