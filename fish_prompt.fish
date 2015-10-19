# You can override some default options with config.fish:
#
#  set -g theme_short_path

set _color_success    (printf $fish_pager_color_progress ^/dev/null; or echo cyan)
set _color_error      (printf $fish_color_error ^/dev/null; or echo red --bold)
set _color_directory  (printf $fish_color_quote ^/dev/null; or echo brown)
set _color_repository (printf $fish_color_cwd ^/dev/null; or echo green)

set _prompt_fish         "⋊>"
set _prompt_vcs_clean    "○"
set _prompt_vcs_touched  "●"
set _prompt_vcs_ahead    "↑"
set _prompt_vcs_behind   "↓"
set _prompt_vcs_diverged "⥄ "
set _prompt_vcs_detached "⸗"

set _prompt_status_symbols "$_prompt_vcs_ahead" \
                           "$_prompt_vcs_behind" \
                           "$_prompt_vcs_diverged" \
                           "$_prompt_vcs_detached" \
                           "$_prompt_vcs_clean"

function fish_prompt
  set -l last_command_status $status
  set -l cwd

  if set -q theme_short_path
    set cwd (basename (prompt_pwd))
  else
    set cwd (prompt_pwd)
  end

  if test $last_command_status -eq 0
    tint: $_color_success $_prompt_fish
  else
    tint: $_color_error $_prompt_fish
  end

  if vcs.present
    if set -q theme_short_path
      set root_folder (vcs.root)
      set parent_root_folder (dirname $root_folder)
      set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
    end

    inline: " "(tint: $_color_directory $cwd)" on "(tint: $_color_repository (vcs.branch))" "

    if vcs.touched
      inline: $_prompt_vcs_touched
    else
      inline: (vcs.status $_prompt_status_symbols)
    end
  else
    tint: $_color_directory $cwd
  end

  inline: " "
end
