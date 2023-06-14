use backend.nu
use frontend.nu

export def up [] {
  backend up
  frontend up
}

export def down [] {
  backend down
  frontend down
}
