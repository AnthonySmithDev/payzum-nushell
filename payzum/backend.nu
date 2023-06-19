
def base [name: string] {
  $env.HOME | path join "Documents" "gitlab" "payzum-backend" $name
}

def cmd_run [name: string] {
  let dir = (base $name)
  # docker volume create golang
  docker run --rm --name $name -d -w "/wd" -v $"($dir):/wd" -v "golang:/go/pkg" --network "host" "cosmtrek/air" -c ./tools/air.toml
}

def cmd_stop [name: string] {
  docker stop $name
}

def cmd_restart [name: string] {
  docker restart $name
}

def cmd_log [name: string] {
  docker logs -f $name
}

def cmd_pull [name: string] {
  let dir = (base $name)
  git -C $dir fetch
  git -C $dir pull
}

def names [] {
  [ "main" "out" "price" "upload" "daemon" ]
}

def name [n: string] {
  $"payzum-backend-($n)"
}

export def run [n: string@names] {
  cmd_run (name $n)
}

export def up [] {
  run "main"
  run "out"
  run "price"
  run "upload"
  run "daemon"
}

export def stop [n: string@names] {
  cmd_stop (name $n)
}

export def down [] {
  stop "main"
  stop "out"
  stop "price"
  stop "upload"
  stop "daemon"
}

export def restart [n: string@names] {
  cmd_restart (name $n)
}

export def restarts [] {
  restart "main"
  restart "out"
  restart "price"
  restart "upload"
  restart "daemon"
}

export def pull [n: string@names] {
  cmd_pull (name $n)
}

export def pulls [] {
  pull "main"
  pull "out"
  pull "price"
  pull "upload"
  pull "daemon"
}

export def log [n: string@names] {
  cmd_log (name $n)
}
