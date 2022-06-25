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
