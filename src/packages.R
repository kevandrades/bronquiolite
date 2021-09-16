if (!require(pacman)) install.packages('pacman')

pacman::p_load(tidyverse, magrittr, readxl, purrr, installr, tufte)

if (!(rmarkdown::pandoc_available())) install.pandoc()