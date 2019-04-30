install.packages("httr")
install.packages("glue")

library(httr)
library(glue)

# geocoding from LocationIQ

geo_key <- 
  "abc123456789" # enter real key here
geo_url <- 
  "https://eu1.locationiq.com/v1/search.php"
location <- 
  "Barcelona"
geo_params <- list(
  q = location,
  key = geo_key,
  format = "json"
)
geo_resp <- 
  httr::GET(url = geo_url, query = geo_params)
httr::status_code(geo_resp) # if it's 2XX you're OK
httr::headers(geo_resp) # check the reponse metadata
geo_contents <- 
  httr::content(geo_resp, as = "parsed") 
str(geo_contents)
geo_contents[[1]]$lat
geo_contents[[1]]$lon

# weather data from Dark Sky

ds_key <- 
  "789654123ujhujheqkiw" # enter real key here
ds_url <- glue::glue(
  "https://api.darksky.net/forecast/{key}/{lat},{lon}",
  key = ds_key,
  lat = geo_contents[[1]]$lat,
  lon = geo_contents[[1]]$lon)
ds_params <-
  list(
    lang = "es",
    units = "si")
ds_resp <- 
  httr::GET(url = ds_url, query = ds_params)
httr::status_code(ds_resp)
httr::headers(ds_resp)
ds_contents <- 
  httr::content(ds_resp, as = "parsed")
str(ds_contents)
ds_contents$currently

# our own API

endpoint <- 
  "http://52.215.54.164:8004/ocpu/user/diego/library/myapi/R/predict_outcome/json"
params <- 
  list(x = "0:11")
tst <- 
  httr::POST(url = endpoint, body = params)
httr::status_code(tst)
httr::headers(tst)
tst_contents <- 
  httr::content(tst, as = "parsed")
str(tst_contents)