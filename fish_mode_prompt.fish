function fish_mode_prompt
  switch "$fish_bind_mode"
  case default
    set_color --bold $fish_color_error
    printf 'n '
  case insert
    set_color --bold $fish_color_match
    printf 'i '
  case replace-one
    set_color --bold $fish_color_match
    printf 'r '
  case visual
    set_color --bold $fish_color_command
    printf 'v '
  end
end
