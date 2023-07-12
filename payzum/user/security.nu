
use utils/request.nu

def "random code" [] {
  random integer 111111..999999 | into string
}

export def "add otp" [] {
  let body = {
    account: "account@gmail.com"
    otp_code: (random code)
    otp_secret: (random chars -l 16)
  }
  (request post "/security/otp" $body | get body)
}

export def "add email" [] {
  let body = {
    new_email: "account@gmail.com"
    new_email_code: (random code)
  }
  (request post "/security/email" $body | get body)
}

export def "add phone" [] {
  let body = {
    new_phone_dial: "53"
    new_phone_number: "933333333"
    new_phone_code: (random code)
  }
  (request post "/security/phone" $body | get body)
}
