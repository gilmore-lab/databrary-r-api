# databrary-r-api

R code to access the Databrary.org API.

- `databrary_config.R`, Configuration for Databrary
- `databrary_authenticate.R`, Authenticate to Databrary via cookie or login
- `databrary_login.R`, Expects JSON credentials file, typically in (`~/api-keys/json/databrary-keys.json`) or as specified in `credentials.file` parameter. See `databrary-keys.json` for format of file.
- `databrary_logout.R`
- `databrary_download.csv.R`
- `databrary_download_containers_records.R`
- `databrary_download_party.R`
- `databrary_download_volume_summary.R`, Plots gender x age distribution by race.