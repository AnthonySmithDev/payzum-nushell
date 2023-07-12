
def "get header" [] {
  let auth = ($env.HOME | path join "payzum" "auth.nuon" | open)
  [
    "Authorization", $auth.jwt_access
    "X-Device-Jwt", $auth.jwt_device
  ]
}

def "get base" [url: string] {
  $"http://localhost:3000/api/v1/user($url)"
}

export def "post" [url: string, body: record] {
  http post -f -e -t "application/json" -H (get header) (get base $url) $body
}
