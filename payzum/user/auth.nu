
def "set auth" [data:  record] {
  let dir = ($env.HOME | path join "payzum")
  if not ($dir | path exists) {
    mkdir $dir
  }
  $data | save -f ($dir | path join "auth.nuon")
}

def "get header" [token?: string] {
  if ($token | is-empty) {
    []
  } else {
    [Authorization, $"Bearer ($token)"]
  }
}

def "get base" [url: string] {
  $"http://localhost:3000/api/v1/client/auth($url)"
}

def "post" [url: string, body: record, token?: string] {
  (http post -f -e -t "application/json" -H (get header $token) (get base $url) $body)
}

export def "signup email" [key: string@select] {
  let resp = (post "/email/signup" (get user $key | into record))
  if $resp.status != 200 {
    print $resp.body
    return
  }

  let resp = (post "/email/signup/register" {} $resp.body.data)
  if $resp.status != 200 {
    print $resp.body
    return
  }

  set auth $resp.body.data
}

export def "signup phone" [key: string@select] {
  let resp = (post "/phone/signup" (get user $key | into record))
  if $resp.status != 200 {
    print $resp.body
    return
  }

  let resp = (post "/phone/signup/register" {} $resp.body.data)
  if $resp.status != 200 {
    print $resp.body
    return
  }

  set auth $resp.body.data
}

export def "signin email" [key: string@select] {
  let resp = (post "/email/signin" (get user $key | into record))
  if $resp.status != 200 {
    print $resp.body
    return
  }

  let resp = (post "/2fa/login" {} $resp.body.data.jwt_2fa)
  if $resp.status != 200 {
    print $resp.body
    return
  }

  set auth $resp.body.data
}

export def "signin phone" [key: string@select] {
  let resp = (post "/phone/signin" (get user $key | into record))
  if $resp.status != 200 {
    print $resp.body
    return
  }

  let resp = (post "/2fa/login" {} $resp.body.data.jwt_2fa)
  if $resp.status != 200 {
    print $resp.body
    return
  }

  set auth $resp.body.data
}

def "select" [] {
  ["anthony", "smith"]
}

export def "get user" [key: string] {
  {
    "anthony": {
      email: "anthony@gmail.com"
      password: "asdASD123"
      phone_dial: "51"
      phone_number: "911111111"
    }
    "smith": {
      email: "smith@gmail.com"
      password: "asdASD123"
      phone_dial: "52"
      phone_number: "922222222"
    }
  } | get -i $key
}

