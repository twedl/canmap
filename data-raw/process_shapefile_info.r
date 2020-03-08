library(tidyverse)
library(fs)
library(usethis)
library(httr) # for later.


# shapefile_info <- readr::read_csv("data-raw/shapefile_info.csv")
shapefile_paths <- readr::read_csv("data-raw/shapefile_paths.csv")

base_url_1 <- "http://www12.statcan.gc.ca/census-recensement/"
base_url_2 <- "/geo/bound-limit/files-fichiers/"


shapefile_paths %>% count(geo_code)
# only get shapefiles
shapefile_paths <- shapefile_paths %>%
  filter(format == "ArcGIS (.shp)" & language == "english" & geo_code != "rnf") %>%
  dplyr::mutate(path = stringr::str_c(base_url_1,
                      "2011", # idk why they have 2011 in the url for every year?
                      base_url_2,
                      ref_date,
                      "/",
                      filepath, ".zip")) %>%
    filter(!is.na(file_type) & !is.na(path))

######
# Need to double-check these all exist, they might not.
######
# httr::

si <- shapefile_paths %>%
  distinct() %>%
  # select(path) %>%
  # slice(1:100) %>%
  rowwise() %>%
  mutate(http_type = path %>%
           httr::HEAD() %>%
           httr::http_type())

si %>% count(http_type)

si <- si %>% filter(http_type == "application/x-zip-compressed")

shapefile_paths <- shapefile_paths %>% semi_join(si, by = "path")

usethis::use_data(shapefile_paths, overwrite = TRUE)

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

code_book_ <- readr::read_csv("data-raw/code_book.csv")
code_book <- dplyr::select(code_book_, -start_chr, -stop_chr, -long_desc)
usethis::use_data(code_book, internal = FALSE, overwrite = TRUE)

 # save this as well.
code_pos <- code_book_ %>%
  dplyr::distinct(code_type, start_chr, stop_chr)
usethis::use_data(code_pos, internal = FALSE, overwrite = TRUE)
