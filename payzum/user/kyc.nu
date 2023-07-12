
use utils/request.nu

export def "create info" [] {
  (request post "/kyc/personal/info" (data | get info) | get body)
}

export def "create doc" [] {
  (request post "/kyc/personal/doc" (data | get doc) | get body)
}

export def "create verify" [] {
  (request post "/kyc" {} | get body)
}

export def "complete" [] {
  create info
  create doc
  create verify
}

export def "update status" [] {
  sql query $"UPDATE kyc SET status = '1', admin_id = '(random uuid)' WHERE status <> 1"
}

def "data" [] {
  {
    info: {
      first_name: "anthony"
      middle_name: "smith"
      last_name: "aguirre"
      city: "lima"
      postal_code: "12233"
      address: "aaa bbb ccc"
      country_id: 168
      date_of_birth: 665347560
    }  
    doc: {
      country_id: 168
      document_type_id: 1
      document_number: "87654321"
      date_exp: 1688151660
      back_img: (random uuid)
      front_img: (random uuid)
      selfie_img: (random uuid)
    }
  }
}
