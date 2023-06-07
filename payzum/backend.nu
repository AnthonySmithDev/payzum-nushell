
def run [name: string, wd: string] {
  docker run --rm --name $name -d -w "/wd" -v $"($wd):/wd" --network "host" "cosmtrek/air" -c ./tools/air.toml
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

def names [] {
  [ "main" "out" "price" "upload" "daemon" ]
}

def name [n: string] {
  $"payzum-backend-($n)"
}

export def up [] {
  run (name "main") (base (name "main"))
  run (name "out") (base (name "out"))
  run (name "price") (base (name "price"))
  run (name "upload") (base (name "upload"))
  run (name "daemon") (base (name "daemon"))
}

export def down [] {
  stop (name "main")
  stop (name "out")
  stop (name "price")
  stop (name "upload")
  stop (name "daemon")
}

export def refresh [] {
  update (base (name "main"))
  update (base (name "out"))
  update (base (name "price"))
  update (base (name "upload"))
  update (base (name "daemon"))
}

export def logs [n: string@names] {
  docker logs -f (name $n)
}
