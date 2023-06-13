
def run [name: string, wd: string, version?: string] {
  let image = if ($version | is-empty) { 
    "node:latest" 
  } else { 
    $"node:($version)" 
  }
  docker run --rm --name $name -d -w "/wd" -v $"($wd):/wd" --network "host" $image /bin/bash -c "npm run dev"
}

def stop [name: string] {
  docker stop $name
}

def update [repo: string] {
  git -C $repo fetch
  git -C $repo pull
}

def base [dir: string] {
  $env.HOME | path join "Documents" "gitlab" "payzum-frontend" $dir
}

export def up [] {
  run "payzum-frontend-user" (base "payzum-frontend-user") "16"
  run "payzum-frontend-admin" (base "payzum-frontend-admin") "18"
  run "payzum-frontend-payment" (base "payzum-frontend-payment") "20"
}

export def down [] {
  stop "payzum-frontend-user"
  stop "payzum-frontend-admin"
  stop "payzum-frontend-payment"
}

export def refresh [] {
  update (base "payzum-frontend-user")
  update (base "payzum-frontend-admin")
  update (base "payzum-frontend-payment")
}
