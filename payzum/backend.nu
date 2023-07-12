
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

def cmd_clone [repo: string] {
  let $path = ($env.HOME | path join "Documents" "gitlab" "payzum-backend")
  if not ($path | path exists) {
    mkdir $path
  }
  git -C $path clone $repo
}

def cmd_pull [name: string] {
  let dir = (base $name)
  git -C $dir fetch
  git -C $dir pull
}

def names [] {
  [ 
    "main"
    "out"
    "price"
    "upload"
    "nanod"
    "bitcoind"
  ]
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
  run "nanod"
  run "bitcoind"
}

export def stop [n: string@names] {
  cmd_stop (name $n)
}

export def down [] {
  stop "main"
  stop "out"
  stop "price"
  stop "upload"
  stop "nanod"
  stop "bitcoind"
}

export def restart [n: string@names] {
  cmd_restart (name $n)
}

export def restarts [] {
  restart "main"
  restart "out"
  restart "price"
  restart "upload"
  restart "nanod"
  restart "bitcoind"
}

export def pull [n: string@names] {
  cmd_pull (name $n)
}

export def pulls [] {
  pull "main"
  pull "out"
  pull "price"
  pull "upload"
  pull "nanod"
  pull "bitcoind"
}

export def clones [] {
  cmd_clone "git@192.168.100.11:payzum-backend/payzum-backend-all.git"
  cmd_clone "git@192.168.100.11:payzum-backend/payzum-backend-main.git"
  cmd_clone "git@192.168.100.11:payzum-backend/payzum-backend-out.git"
  cmd_clone "git@192.168.100.11:payzum-backend/payzum-backend-price.git"
  cmd_clone "git@192.168.100.11:payzum-backend/payzum-backend-upload.git"
  cmd_clone "git@192.168.100.11:payzum-backend/payzum-backend-nanod.git"
  cmd_clone "git@192.168.100.11:payzum-backend/payzum-backend-bitcoind.git"
}

export def log [n: string@names] {
  cmd_log (name $n)
}
