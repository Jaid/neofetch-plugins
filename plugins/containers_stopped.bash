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
