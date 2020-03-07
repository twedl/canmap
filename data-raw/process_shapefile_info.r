library(tidyverse)
library(fs)
library(usethis)
library(httr) # for later.


shapefile_info <- readr::read_csv("data-raw/shapefile_info.csv")

base_url_1 <- "http://www12.statcan.gc.ca/census-recensement/"
base_url_2 <- "/geo/bound-limit/files-fichiers/"


shapefile_info %>% count(geo_code)
# only get shapefiles
shapefile_info <- shapefile_info %>%
  filter(format == "ArcGIS (.shp)" & language == "english" & geo_code != "rnf") %>%
  dplyr::mutate(path = stringr::str_c(base_url_1,
                      "2011", # idk why they have 2011 in the url for every year?
                      base_url_2,
                      ref_date,
                      "/",
                      filepath, ".", ext)) %>%
    filter(!is.na(file_type) & !is.na(path))

######
# Need to double-check these all exist, they might not.
######
# httr::

si <- shapefile_info %>%
  distinct() %>%
  # select(path) %>%
  # slice(1:100) %>%
  rowwise() %>%
  mutate(http_type = path %>%
           httr::HEAD() %>%
           httr::http_type())

si %>% count(http_type)

si <- si %>% filter(http_type == "application/x-zip-compressed")

shapefile_info <- shapefile_info %>% semi_join(si, by = "path")

shapefile_info <- shapefile_info %>% distinct()

usethis::use_data(shapefile_info, overwrite = TRUE)

# x <- fs::dir_info("//fld6filer/fichiersGEOfiles/Geographie_2016_Geography/Spatial_Info_Products-Produits_d'info_spatiale", recursive = TRUE) %>%
#   mutate(ext = fs::path_ext(path),
#          filepath = fs::path_file(path) %>% fs::path_ext_remove()) %>%
#   select(filepath, ext, type, size, path)
#
# y <- x %>%
#   filter(type == "file" & ext == "zip") %>%
#   pull(filepath) %>%
#   map_df(get_geoinfo)
#
# # that's a lot, holy moly.s
#
# shapefile_paths <- x %>%
#   filter(type == "file" & ext == "zip") %>%
#   mutate(filepath = as.character(filepath)) %>%
#   left_join(y, by = c("filepath" = "filename"))

# usethis::use_data(shapefile_paths)




############# and code info

code_book <- readr::read_csv("data-raw/code_book.csv")
usethis::use_data(code_book, internal = TRUE, overwrite = TRUE)

 # save this as well.
code_pos <- code_book %>%
  dplyr::distinct(code_type, start_chr, stop_chr)
usethis::use_data(code_pos, internal = TRUE, overwrite = TRUE)
