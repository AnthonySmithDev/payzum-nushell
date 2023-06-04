
def "get auth" [] {
  ($env.HOME | path join "payzum" "auth.nuon" | open)
}

def "get header" [] {
  let auth = (get auth)
  [
    "Authorization", $auth.jwt_access
    "X-Device-Jwt", $auth.jwt_device
  ]
}

def "get base" [url: string] {
  $"http://localhost:3000/api/v1/client/kyc($url)"
}

def "post" [url: string, body: record] {
  http post -t "application/json" -H (get header) (get base $url) $body
}

export def "personal info" [] {
  post "/personal/info" (get info)
}

export def "personal doc" [] {
  post "/personal/doc" (get doc)
}

export def "create" [] {
  post "/" {}
}

export def "update" [] {
  sql query "update kyc set status = 1 where status <> 1"
}

export def "complete" [] {
  personal info
  personal doc
  create
}

def "get info" [] {
  {
    first_name: "anthony"
    middle_name: "smith"
    last_name: "aguirre"
    city: "lima"
    postal_code: "12233"
    address: "aaa bbb ccc"
    country_id: 168
    date_of_birth: 665347560
  }  
}

def "get doc" [] {
  {
    country_id: 168
    document_type_id: 1
    document_number: "87654321"
    date_exp: 1688151660
    back_img: (random uuid)
    front_img: (random uuid)
    selfie_img: (random uuid)
  }
}

