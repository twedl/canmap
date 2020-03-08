## Utility functions for Canadian geographic shapefiles and filenames




#' Download and unzip Canadian shapefiles
#'
#' Download and unzip Canadian shapefiles from Statistics Canada
#'
#' @param geo_path Full path/url to zipped shapefile
#' @param geo_dir Directory to download to --- may not keep this.
#'
#'
#' @export
#'
#' @return A tibble of shapefiles along with metadata, including
#' \code{filepath}, \code{size}, \code{path},
#' \code{ref_date}, \code{geo_code}, \code{geo_level},
#' \code{file_type}, \code{format}, \code{projection},
#' and \code{language}.
#'
#' @examples
#' \donttest{
#' download_geography("http://www12.statcan.gc.ca/census-recensement/2011/
#' geo/bound-limit/files-fichiers/2016/lpr_000a16a_e.zip")
#' }
download_geography <- function(geo_path, geo_dir = NULL) {

  file_name <- fs::path_file(geo_path)
  geo_folder_name <-  fs::path_ext_remove(file_name)

  if (is.null(geo_dir)) {
    geo_dir <- here::here("geography", geo_folder_name)
  }

  temp <- tempfile()

  utils::download.file(geo_path, temp)

  unzipped_files <- utils::unzip(temp, exdir = geo_dir)

  unlink(temp)

  shp_path <- stringr::str_subset(unzipped_files, pattern = ".shp")

  shp_path
}



#' Get metadata associated with geographic filename.
#'
#' Get metadata associated with geographic filename.
#'
#' @param filename Name of geography file
#'
#' @export
#'
#' @return A one-row tibble of metadata associated with the filename
#' of Statistics Canada's shapefiles.
#'
#' @examples
#' \donttest{
#' get_geoinfo("lpr_000a16a_e")
#' }
get_geoinfo <- function(filename) {

  # yy <- canmap::code_pos %>%
  #   dplyr::mutate(code = stringr::str_sub(filename, start_chr, stop_chr)) %>%
  #   dplyr::select(-start_chr, -stop_chr)
  #
  # z <- yy %>%
  #   dplyr::left_join(canmap::code_book %>% dplyr::select(code_type, code, code_desc, long_desc), by = c("code_type", "code")) %>%
  #   dplyr::select(code_type, code_desc) %>%
  #   tidyr::spread(code_type, code_desc)
  #
  # z$geo_code <- yy %>%
  #   dplyr::filter(code_type == "geo_level") %>%
  #   dplyr::pull(code)
  #
  # z %>%
  #   dplyr::mutate(filename = filename) %>%
  #   dplyr::select(filename, ref_date, geo_code, geo_level, file_type, format, projection, geo_coverage, language)
  extract_codes <- code_pos

  extract_codes$code <- stringr::str_sub(filename,
                                         code_pos$start_chr,
                                         code_pos$stop_chr)

  extract_codes[, c("start_chr", "stop_chr")] <- NULL

  code_descriptions <- dplyr::left_join(extract_codes,
                                        canmap::code_book,
                                        by = c("code_type", "code"))
  code_descriptions[, "code"] <- NULL
  code_descriptions <- tidyr::spread(code_descriptions,
                                     .data$code_type,
                                     .data$code_desc)



  code_descriptions$geo_code <- extract_codes[extract_codes$code_type == "geo_level", ]$code
  code_descriptions$filename <- filename

  dplyr::select(code_descriptions, .data$filename, .data$ref_date,
                .data$geo_code, .data$geo_level, .data$file_type,
                .data$format, .data$projection, .data$geo_coverage,
                .data$language)

}
