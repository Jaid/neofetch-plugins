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
