
<!-- README.md is generated from README.Rmd. Please edit that file -->

# canmap

<!-- badges: start -->

<!-- badges: end -->

`canmap` provides easy access to standard Canadian geographic
shapefiles, as well as the associated metadata that helps pick which one
you’d like.

## Installation

You can install the development version of `canmap` with:

``` r
remotes::install_github("tweed1e/canmap")
```

## Example

``` r
library(canmap)

tibble::as_tibble(shapefile_paths)
#> # A tibble: 34 x 10
#>    filepath size  path  ref_date geo_code geo_level file_type format projection
#>    <chr>    <chr> <chr>    <dbl> <chr>    <chr>     <chr>     <chr>  <chr>     
#>  1 lada000… 41.4… http…     2016 ada      aggregat… cartogra… ArcGI… projectio…
#>  2 lcar000… 29.5… http…     2016 car      census a… cartogra… ArcGI… projectio…
#>  3 lccs000… 41.3… http…     2016 ccs      census c… cartogra… ArcGI… projectio…
#>  4 lcd_000… 31.5… http…     2016 cd_      census d… cartogra… ArcGI… projectio…
#>  5 lcma000… 3.53M http…     2016 cma      census m… cartogra… ArcGI… projectio…
#>  6 lcsd000… 46.6… http…     2016 csd      census s… cartogra… ArcGI… projectio…
#>  7 lct_000… 8.05M http…     2016 ct_      census t… cartogra… ArcGI… projectio…
#>  8 lda_000… 88.3M http…     2016 da_      dissemin… cartogra… ArcGI… projectio…
#>  9 ldb_000… 231.… http…     2016 db_      dissemin… cartogra… ArcGI… projectio…
#> 10 ldpl000… 2.27M http…     2016 dpl      designat… cartogra… ArcGI… projectio…
#> # … with 24 more rows, and 1 more variable: language <chr>

# then pick a shapefile and get the link:
(url <- shapefile_paths[1, ]$path)
#> [1] "http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/2016/lada000b16a_e.zip"

# then you can download it yourself, or use download_geography(url)
```

## Documentation

A list of useful links to clean up later:

  - [Geography definitions and
    documentation](https://www.statcan.gc.ca/eng/subjects/standard/sgc/geography)
  - [Root for geography downloads and
    documentation](https://www12.statcan.gc.ca/census-recensement/2016/geo/index-eng.cfm)
  - [Direct link to download directory for 2016
    shapefiles](https://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/bound-limit-2016-eng.cfm)
  - [Heirarchy of
    geography](https://www150.statcan.gc.ca/n1/pub/92-195-x/2011001/other-autre/hierarch/h-eng.htm)

### Parsing the filename for metadata

Suppose you’ve downloaded the geography file `lpr_000a16a_e.zip`. The
filename defines the important geographic characteristics of the file
(you can process using the `code_pos` dataset for code positions, or
`get_geoinfo`).

``` r
str(get_geoinfo("lpr_000a16a_e"))
#> Classes 'tbl_df', 'tbl' and 'data.frame':    1 obs. of  9 variables:
#>  $ filename    : chr "lpr_000a16a_e"
#>  $ ref_date    : chr "2016"
#>  $ geo_code    : chr "pr_"
#>  $ geo_level   : chr "province and territory"
#>  $ file_type   : chr "digital boundary file"
#>  $ format      : chr "ArcGIS (.shp)"
#>  $ projection  : chr "projection in Lambert conformal conic"
#>  $ geo_coverage: chr "canada"
#>  $ language    : chr "english"
```

And each of these codes has a meaning that can be found (sometimes) in
the geography guide that accompanies a downloaded file (but you can’t
find out the details until *after* you’ve downloaded it, and is missing
some information).

Your first default parameters should be:

  - `file_type == "a"` (digital boundary file—it doesn’t look as good
    but it’s smaller)
  - `format == "a"` (ArcGIS/ArcInfo®/.shp—for use with `sf` and other
    `R` geographic packages)
  - `geo_coverage == "000"` (Canada—the only option AFAIK)
  - `projection == "g"` (geographic projection/lat-long—this makes it
    less likely for the user to get caught up in coordinate reference
    systems \[CRS\] conversion issues)

The most important choices for the user are: year (2016 is the latest
census year currently available), language (english or french) and
geo\_code/geo\_level. A list of geo codes and geo levels are given in
the `code_book` dataset:

``` r
dplyr::filter(code_book, code_type == "geo_level")
#> # A tibble: 34 x 3
#>    code_type code  code_desc                                        
#>    <chr>     <chr> <chr>                                            
#>  1 geo_level pr_   province and territory                           
#>  2 geo_level cd_   census division                                  
#>  3 geo_level ccs   census consolidated subdivision                  
#>  4 geo_level csd   census subdivision                               
#>  5 geo_level er_   economic region                                  
#>  6 geo_level cma   census metropolitan area and census agglomeration
#>  7 geo_level fed   federal electoral district                       
#>  8 geo_level ct_   census tract                                     
#>  9 geo_level dpl   designated place                                 
#> 10 geo_level pc_   population centre                                
#> # … with 24 more rows
```

Business data usually isn’t released below the economic region level
(`er_`), while census data can go down to census tract (`ct_`),
dissemination area (`da_`) or dissemination block (`db_`).

These are english codes, while the french codes are also in the
dataset—english and french maps are in different files, so they have
different codes: `lpr_000a16a_e.zip` has the english province/territory
maps and `lpr_000a16a_f.zip` has the french province/territory maps. The
only difference, AFAIK, is that the guide and geography names are in
french in the french version.

## Download and extract shapefiles to `./geography/`

``` r
download_geography("lpr_000a16a_e")
```

## Notes

Please note that the ‘canmap’ project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.
