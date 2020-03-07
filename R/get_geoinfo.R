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

  yy <- code_pos %>%
    dplyr::mutate(code = stringr::str_sub(filename, start_chr, stop_chr)) %>%
    dplyr::select(-start_chr, -stop_chr)

  z <- yy %>%
    dplyr::left_join(code_book %>% dplyr::select(code_type, code, code_desc, long_desc), by = c("code_type", "code")) %>%
    dplyr::select(code_type, code_desc) %>%
    tidyr::spread(code_type, code_desc)

  z$geo_code <- yy %>%
    dplyr::filter(code_type == "geo_level") %>%
    dplyr::pull(code)

  z %>%
    dplyr::mutate(filename = filename) %>%
    dplyr::select(filename, ref_date, geo_code, geo_level, file_type, format, projection, geo_coverage, language)
}
