
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mapcan

<!-- badges: start -->

<!-- badges: end -->

The goal of mapcan is to …

## Installation

You can install the released version of `mapcan` with:

``` r
remotes::install_github("tweed1e/mapcan")
```

## Example

``` r
library(mapcan)

tibble::as_tibble(shapefile_info)
#> # A tibble: 88 x 13
#>    filepath ext   type  size  path  ref_date geo_code geo_level file_type format
#>    <chr>    <chr> <chr> <chr> <chr>    <dbl> <chr>    <chr>     <chr>     <chr> 
#>  1 gada000… zip   file  57.7… http…     2016 ada      aggregat… cartogra… ArcGI…
#>  2 gcar000… zip   file  41.5… http…     2016 car      census a… cartogra… ArcGI…
#>  3 gccs000… zip   file  57.3… http…     2016 ccs      census c… cartogra… ArcGI…
#>  4 gcd_000… zip   file  44.1… http…     2016 cd_      census d… cartogra… ArcGI…
#>  5 gcma000… zip   file  4.8M  http…     2016 cma      census m… cartogra… ArcGI…
#>  6 gcsd000… zip   file  64.5… http…     2016 csd      census s… cartogra… ArcGI…
#>  7 gct_000… zip   file  10.6… http…     2016 ct_      census t… cartogra… ArcGI…
#>  8 gda_000… zip   file  120.… http…     2016 da_      dissemin… cartogra… ArcGI…
#>  9 gdb_000… zip   file  298.… http…     2016 db_      dissemin… cartogra… ArcGI…
#> 10 gdpl000… zip   file  2.98M http…     2016 dpl      designat… cartogra… ArcGI…
#> # … with 78 more rows, and 3 more variables: projection <chr>,
#> #   geo_coverage <chr>, language <chr>
```

Please note that the ‘mapcan’ project is released with a [Contributor
Code of Conduct](.github/CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.
