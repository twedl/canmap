#' Download and unzip Canadian shapefiles
#'
#' Download and unzip Canadian shapefiles from Statistics Canada
#'
#' @param geo_path X
#'
#' @export
#'
#' @return A tibble of shapefiles along with metadata, including
#' \code{filepath}, \code{ext}, \code{type}, \code{path},
#' \code{ref_date}, \code{geo_code}, \code{geo_level},
#' \code{file_type}, \code{format}, \code{projection}, \code{geo_coverage},
#' and \code{language}.
#'
#' @examples
#' \donttest{
#' download_geography("http://www12.statcan.gc.ca/census-recensement/2011/
#' geo/bound-limit/files-fichiers/2016/lpr_000a16a_e.zip")
#' }
download_geography <- function(geo_path) {

  file_name <- fs::path_file(geo_path)
  geo_folder_name <-  fs::path_ext_remove(file_name)

  geo_dir <- here::here("geography", geo_folder_name)

  temp <- tempfile()

  utils::download.file(geo_path, temp)

  unzipped_files <- utils::unzip(temp, exdir = geo_dir)

  unlink(temp)

  shp_path <- stringr::str_subset(unzipped_files, pattern = ".shp")

  shp_path
}
