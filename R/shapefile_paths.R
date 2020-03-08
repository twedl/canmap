#' Metadata for Canadian geographic datasets
#'
#' Filepaths and information of geographic datasets at Statistics Canada.
#'
#'
#' @format A data frame.
#' \describe{
#'   \item{filepath}{The name of the file.}
#'   \item{size}{Zipped file size.}
#'   \item{path}{Url (external) or filepath (internal.)}
#'   \item{ref_date}{Year of the geography, usually Census year.}
#'   \item{geo_code}{Code for the geo_level, e.g., province (pr_), census
#'   subdivision (csd), etc.}
#'   \item{geo_level}{Description of the geo_code.}
#'   \item{file_type}{Cartographic or digital boundary file.}
#'   \item{format}{Arcgis (.shp), or MapInfo or some other one.}
#'   \item{projection}{lat/long or Lambert conformal conic.}
#'   \item{language}{English or French.}
#' }
#' @source \url{https://www150.statcan.gc.ca/n1/pub/92-196-x/92-196-x2016001-eng.htm}
"shapefile_paths"

