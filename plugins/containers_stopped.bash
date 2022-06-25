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
