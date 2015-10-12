# You can override some default options with config.fish:
#
#  set -g theme_short_path

function fish_prompt
  set -l last_command_status $status
  set -l cwd

  if set -q theme_short_path
    set cwd (basename (prompt_pwd))
  else
    set cwd (prompt_pwd)
  end

  set -l fish     "⋊>"
  set -l ahead    "↑"
  set -l behind   "↓"
  set -l diverged "⥄ "
  set -l dirty    "⨯"
  set -l none     "◦"

  set -l success    (printf $fish_pager_color_progress ^/dev/null; or echo cyan)
  set -l error      (printf $fish_color_error ^/dev/null; or echo red --bold)
  set -l directory  (printf $fish_color_quote ^/dev/null; or echo brown)
  set -l repository (printf $fish_color_cwd ^/dev/null; or echo green)

  if test $last_command_status -eq 0
    tint: $success $fish
  else
    tint: $error $fish
  end

  if vcs.present
    if set -q theme_short_path
      set root_folder (vcs.root)
      set parent_root_folder (dirname $root_folder)
      set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
    end

    inline: " "(tint: $directory $cwd)" on "(tint: $repository (vcs.branch))" "

    if vcs.touched
      inline: $dirty
    else
      inline: (vcs.status $ahead $behind $diverged $none)
    end
  else
    tint: $directory $cwd
  end

  inline: " "
end
