test_login <- function() {
  download("https://bacdive.dsmz.de/api/bacdive/DSM%20319/?format=json",
    userpwd = paste(id_pw, sep = ":")) ==
    ""
  # [ ]
}
