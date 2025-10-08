## Data Wrangling with `tidyverse`

This repository contains scripts, slides, and post-workshop notes from the "**Data Wrangling with `tidyverse`**" workshop held on July 26th as part of the [SARA Institute of Science Summer School 2025](https://sara-edu.netlify.app/summer/2025-r4b/).

## Prerequisites

Before getting started, make sure you have the following:

-   **Software**
    -   [R](https://cran.r-project.org/)
    -   [RStudio](https://posit.co/download/rstudio/)
    -   [Quarto](https://quarto.org/docs/get-started/)
-   **R Packages**
    -   `tidyverse`
    -   `quarto`
    -   `gapminder`

## Installation

To install the required packages, run the following command in your R console:

```         
# This command checks which packages are already installed and installs only the missing ones.
install.packages(setdiff(c("tidyverse", "gapminder"), rownames(installed.packages())))
```

### How to Use This Repository

Start by opening the `data-wrangling.R` script and follow the exercises. The solved versions are available in `post-workshop-notes.Rmd` for reference.

You can find the slides [here](https://cecibaldoni.github.io/data-wrangling-tidyverse/#/title-slide)

### License

This project is licensed under the MIT License.