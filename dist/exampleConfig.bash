get_containers_healthy() {

  nerd_font="${nerd_font:=off}"
  while [[ "$1" ]]; do
    case $1 in
    "--nerd_font") nerd_font="$2" ;;
    esac
  done

  if [ ! -x "$(command -v docker)" ]; then
    containers_healthy="No docker command"
    return
  fi
  names=$(docker container ls --all --filter "status=running" --format "{{.Names}}")
  count=$(printf %s "$names" | wc -l)
  if [ -z "$count" ] || [ "$count" == 0 ]; then
    return
  fi
  actualCount=$((count + 1))
  if [ "$nerd_font" == "on" ]; then
    containers_healthy="$(color 14)$actualCount  $(color fg)$names"
  else
    containers_healthy="$(color 14)[$actualCount] $(color fg)$names"
  fi

}

get_containers_healthy() {

  nerd_font="${nerd_font:=off}"
  while [[ "$1" ]]; do
    case $1 in
    "--nerd_font") nerd_font="$2" ;;
    esac
  done

  if [ ! -x "$(command -v docker)" ]; then
    containers_healthy="No docker command"
    return
  fi
  names=$(docker container ls --all --filter "status=running" --filter "health=healthy" --format "{{.Names}}")
  count=$(printf %s "$names" | wc -l)
  if [ -z "$count" ] || [ "$count" == 0 ]; then
    return
  fi
  actualCount=$((count + 1))
  if [ "$nerd_font" == "on" ]; then
    containers_healthy="$(color 14)$actualCount  $(color fg)$names"
  else
    containers_healthy="$(color 14)[$actualCount] $(color fg)$names"
  fi

}

get_containers_unhealthy() {

  nerd_font="${nerd_font:=off}"
  while [[ "$1" ]]; do
    case $1 in
    "--nerd_font") nerd_font="$2" ;;
    esac
  done

  if [ ! -x "$(command -v docker)" ]; then
    containers_unhealthy="No docker command"
    return
  fi
  names=$(docker container ls --all --filter "status=running" --filter "health=unhealthy" --format "{{.Names}}")
  count=$(printf %s "$names" | wc -l)
  if [ -z "$count" ] || [ "$count" == 0 ]; then
    return
  fi
  actualCount=$((count + 1))
  if [ "$nerd_font" == "on" ]; then
    containers_unhealthy="$(color 9)$actualCount  $(color fg)$names"
  else
    containers_unhealthy="$(color 9)[$actualCount] $(color fg)$names"
  fi

}

get_containers_paused() {

  nerd_font="${nerd_font:=off}"
  while [[ "$1" ]]; do
    case $1 in
    "--nerd_font") nerd_font="$2" ;;
    esac
  done

  if [ ! -x "$(command -v docker)" ]; then
    containers_paused="No docker command"
    return
  fi
  names=$(docker container ls --all --filter "status=paused" --format "{{.Names}}")
  count=$(printf %s "$names" | wc -l)
  if [ -z "$count" ] || [ "$count" == 0 ]; then
    return
  fi
  actualCount=$((count + 1))
  if [ "$nerd_font" == "on" ]; then
    containers_paused="$(color 11)$actualCount  $(color fg)$names"
  else
    containers_paused="$(color 11)[$actualCount] $(color fg)$names"
  fi

}

get_containers_stopped() {

  nerd_font="${nerd_font:=off}"
  while [[ "$1" ]]; do
    case $1 in
    "--nerd_font") nerd_font="$2" ;;
    esac
  done

  if [ ! -x "$(command -v docker)" ]; then
    containers_stopped="No docker command"
    return
  fi
  names=$(docker container ls --all --filter "status=exited" --format "{{.Names}}")
  count=$(printf %s "$names" | wc -l)
  if [ -z "$count" ] || [ "$count" == 0 ]; then
    return
  fi
  actualCount=$((count + 1))
  if [ "$nerd_font" == "on" ]; then
    containers_stopped="$(color 8)$actualCount  $(color fg)$names"
  else
    containers_stopped="$(color 8)[$actualCount] $(color fg)$names"
  fi

}

print_info() {
  info model
  info underline
  info "Containers running" containers_running # https://github.com/Jaid/neofetch-plugins/blob/main/dist/plugins/containers_running.bash
  info "Containers healthy" containers_healthy # https://github.com/Jaid/neofetch-plugins/blob/main/dist/plugins/containers_healthy.bash
  info "Containers unhealthy" containers_unhealthy # https://github.com/Jaid/neofetch-plugins/blob/main/dist/plugins/containers_unhealthy.bash
  info "Containers paused" containers_paused # https://github.com/Jaid/neofetch-plugins/blob/main/dist/plugins/containers_paused.bash
  info "Containers stopped" containers_stopped # https://github.com/Jaid/neofetch-plugins/blob/main/dist/plugins/containers_stopped.bash
  info cols
}

# If on, Nerd Fonts icons will be used
# See https://github.com/ryanoasis/nerd-fonts
#
# Default: 'on'
# Values:  'on', 'off'
# Flag: --nerd_font
nerd_font="on"
