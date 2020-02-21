tmpdir <- tempdir()

# Bootstrap 4 SASS port
# https://github.com/papakay/selectize-bootstrap-4-style
version <- "1.0.1"
zip_src <- sprintf("https://github.com/papakay/selectize-bootstrap-4-style/archive/%s.zip", version)
zip_target <- file.path(tmpdir, "select-bs4.zip")
download.file(zip_src, zip_target)
unzip(zip_target, exdir = dirname(zip_target))
target <- "inst/www/shared/selectize/scss"
unlink(target)
dir.create(target)
file.rename(
  file.path(tmpdir, sprintf("selectize-bootstrap-4-style-%s/src/selectize", version)),
  target
)

# Remove the unnecessary imports of Bootstrap
# TODO: consider doing this to the plugin imports as well (and only including if needed)?
scss_file <- "inst/www/shared/selectize/scss/selectize.bootstrap4.scss"
scss <- readLines(scss_file)
scss <- scss[!grepl('@import\\s+"\\.\\./bootstrap', scss)]
writeLines(scss, scss_file)

# Bootstrap 3 SASS port
# https://github.com/herschel666/selectize-scss
# Note that the base selectize.scss, as well as the plugins, are identical
# to the BS4 port, so we only need the selectize.bootstrap3.scss file
version <- "0.10.1"
zip_src <- sprintf("https://github.com/herschel666/selectize-scss/archive/v%s.zip", version)
zip_target <- file.path(tmpdir, "select-bs3.zip")
download.file(zip_src, zip_target)
unzip(zip_target, exdir = dirname(zip_target))
target <- "inst/www/shared/selectize/scss/selectize.bootstrap3.scss"
file.rename(
  file.path(tmpdir, sprintf("selectize-scss-%s/src/selectize.bootstrap3.scss", version)),
  target
)
