
def base [dir: string] {
  $env.HOME | path join "Documents" "gitlab" "payzum-frontend" $dir
}

def cmd_run [name: string, version?: string] {
  let image = if ($version | is-empty) { 
    "node:latest" 
  } else { 
    $"node:($version)" 
  }
  let dir = (base $name)
  docker run --rm --name $name -d -w "/wd" -v $"($dir):/wd" --network "host" $image /bin/bash -c "npm run dev"
}

def cmd_stop [name: string] {
  docker stop $name
}

def cmd_restart [name: string] {
  docker restart $name
}

def cmd_clone [repo: string] {
  let path = ($env.HOME | path join "Documents" "gitlab" "payzum-frontend")
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

def name [n: string] {
  $"payzum-frontend-($n)"
}

export def up [] {
  cmd_run (name "user") "16"
  cmd_run (name "admin") "18"
  cmd_run (name "payment") "20"
}

export def down [] {
  cmd_stop (name "user")
  cmd_stop (name "admin")
  cmd_stop (name "payment")
}

export def restarts [] {
  cmd_restart (name "user")
  cmd_restart (name "admin")
  cmd_restart (name "payment")
}

export def pulls [] {
  cmd_pull (name "user")
  cmd_pull (name "admin")
  cmd_pull (name "payment")
}

export def clones [] {
  cmd_clone "git@192.168.100.11:JeanMg25/payzum-frontend-user.git"
  cmd_clone "git@192.168.100.11:root/payzum-frontend-admin.git"
  cmd_clone "git@192.168.100.11:JeanMg25/payzum-frontend-payment.git"
}
