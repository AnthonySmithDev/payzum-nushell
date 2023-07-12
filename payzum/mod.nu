use backend.nu
use frontend.nu

export def up [] {
  frontend up
  backend up
}

export def down [] {
  frontend down
  backend down
}

export def pulls [] {
  frontend pulls
  backend pulls
}

export def restarts [] {
  frontend restarts
  backend restarts
}
