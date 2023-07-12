
export def "download country" [] {
  let url = "https://accounts.binance.com/bapi/accounts/v1/public/country/list"
  mkdir binance
  http get $url | get data | reject cn bizType | save binance/country.csv
}

export def "download bank" [] {
  let url = "https://www.binance.com/bapi/c2c/v2/public/c2c/trade-method/list-by-page?page=1&rows=1000"
  mkdir binance
  http get $url | get data | save binance/bank.csv
}
