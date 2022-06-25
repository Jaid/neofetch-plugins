get_containers_healthy() {
  if [ ! -x "$(command -v docker)" ]; then
    containers_healthy="No docker command"
    return
  fi
  names=$(docker container ls --all --filter "status=running" --filter "health=healthy" --format "{{.Names}}")
  count=$(printf %s "$names" | wc -l)
  if [ -z "$count" ] || [ "$count" == 0 ]; then
    return
  fi
  containers_healthy="[$((count + 1))] $names"
}

get_containers_unhealthy() {
  if [ ! -x "$(command -v docker)" ]; then
    containers_healthy="No docker command"
    return
  fi
  names=$(docker container ls --all --filter "status=running" --filter "health=unhealthy" --format "{{.Names}}")
  count=$(printf %s "$names" | wc -l)
  if [ -z "$count" ] || [ "$count" == 0 ]; then
    return
  fi
  containers_unhealthy="[$((count + 1))] $names"
}

get_containers_paused() {
  if [ ! -x "$(command -v docker)" ]; then
    containers_healthy="No docker command"
    return
  fi
  names=$(docker container ls --all --filter "status=paused" --format "{{.Names}}")
  count=$(printf %s "$names" | wc -l)
  if [ -z "$count" ] || [ "$count" == 0 ]; then
    return
  fi
  containers_paused="[$((count + 1))] $names"
}

get_containers_stopped() {
  if [ ! -x "$(command -v docker)" ]; then
    containers_healthy="No docker command"
    return
  fi
  names=$(docker container ls --all --filter "status=exited" --format "{{.Names}}")
  count=$(printf %s "$names" | wc -l)
  if [ -z "$count" ] || [ "$count" == 0 ]; then
    return
  fi
  containers_stopped="[$((count + 1))] $names"
}

print_info() {
  info model
  info underline
  info "Containers healthy" containers_healthy # https://github.com/Jaid/neofetch-plugins/blob/main/dist/plugins/containers_healthy.bash
  info "Containers unhealthy" containers_unhealthy # https://github.com/Jaid/neofetch-plugins/blob/main/dist/plugins/containers_unhealthy.bash
  info "Containers paused" containers_paused # https://github.com/Jaid/neofetch-plugins/blob/main/dist/plugins/containers_paused.bash
  info "Containers stopped" containers_stopped # https://github.com/Jaid/neofetch-plugins/blob/main/dist/plugins/containers_stopped.bash
  info cols
}
