
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
shapefile_paths[1, c("filepath", "path")]
#> # A tibble: 1 x 2
#>   filepath      path                                                            
#>   <chr>         <chr>                                                           
#> 1 lada000b16a_e http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-li…
```

Please note that the ‘canmap’ project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.
