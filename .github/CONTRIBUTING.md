# Contributing to BacDiveR

This outlines how to propose a change to BacDiveR. Because this project should 
be developed according to the needs of BacDive users, please in particular 
feel free to up- or down-vote existing issues, pull requests or comments. 
Thumbs-up and -down reactions will inform which issues to prioritise.


### Improving texts

Small typos or grammatical errors in documentation may be edited directly using
the GitHub web interface, so long as the changes are made in a _source_ file.

*  YES: you edit a roxygen comment in an `.R` file below `R/` or any `.Rmd` file.
*  NO: you edit an `.Rd` file below `man/`.

When in doubt, please proceed with:


### Filing issues (See also: [`ISSUE_TEMPLATE.md`](https://github.com/tibhannover/BacDiveR/blob/master/.github/ISSUE_TEMPLATE.md))

Please don't hesitate to open an [issue][issues] if you:

a) want to ask a question,
a) suggest a new feature, 
a) found a bug. Illustrating it with a [minimal, reproducible example][reprex] 
   is extremely helpful for fixing it ;-) 
a) in other cases, such as wanting to discuss substantial changes before sending
   a pull request.

Please spend a few minutes searching the [existing issues (also the closed ones)][issues],
though. What you want to write might have been already ;-)

[issues]: https://github.com/tibhannover/BacDiveR/issues/
[reprex]: https://www.tidyverse.org/help/#reprex


### Sending pull requests (See also: [`PULL_REQUEST_TEMPLATE.md`](https://github.com/tibhannover/BacDiveR/blob/master/.github/PULL_REQUEST_TEMPLATE.md))

Contributions through pull requests are welcome, and will be replied to within 1 
or 2 (non-holi)days. Please:

*  Create a separate Git branch for each PR, preferably off the [`master`][master]
   branch and with an issue number prepended to your [branch's name][bn].
*  Style all added or modified code with `styler::style_pkg()`. Using RStudio's
   built-in `Shift`+`Ctrl/Cmd`+`A` is also fine ("Code Tools" menu > "Reformat Code").
*  Run `devtools::document()` in case you modified any function documentation
   within a `#'`-denoted [roxygen2](https://cran.r-project.org/package=roxygen2)
   block and commit any `.Rd` file changes to your PR branch.
*  Add or modify tests if you add or modify code. We use 
   [testthat](https://cran.r-project.org/package=testthat) and contributions
   with test cases included are easier to accept.  

[bn]: https://github.com/tibhannover/BacDiveR/branches
[master]: https://github.com/TIBHannover/BacDiveR/tree/master
