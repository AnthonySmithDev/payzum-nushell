
def run [name: string, wd: string] {
  (docker run --rm --name $name -d -w "/wd" -v $"($wd):/wd" --network "host" "cosmtrek/air" -c ./tools/air.toml)
}

def stop [name: string] {
  docker stop $name
}

def update [repo: string] {
  git -C $repo fetch
  git -C $repo pull
}

def base [dir: string] {
  $env.HOME | path join "Documents" "gitlab" "payzum-backend" $dir
}

export def up [] {
  run "payzum-backend-main" (base "payzum-backend-main")
  run "payzum-backend-out" (base "payzum-backend-out")
  run "payzum-backend-price" (base "payzum-backend-price")
  run "payzum-backend-upload" (base "payzum-backend-upload")
  run "payzum-backend-daemon" (base "payzum-backend-daemon")
}

export def down [] {
  stop "payzum-backend-main"
  stop "payzum-backend-out"
  stop "payzum-backend-price"
  stop "payzum-backend-upload"
  stop "payzum-backend-daemon"
}

export def refresh [] {
  update (base "payzum-backend-main")
  update (base "payzum-backend-out")
  update (base "payzum-backend-price")
  update (base "payzum-backend-upload")
  update (base "payzum-backend-daemon")
}
