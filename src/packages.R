if (!require(pacman)) install.packages("pacman")

pacman::p_load(
    tidyverse, magrittr, readxl,
    purrr, installr, tufte,
    BiocManager, rmdformats,
    knitr, kableExtra
)

if (!(rmarkdown::pandoc_available())) install.pandoc()

table_from_test <- function(test) {
    data.frame(
        p.value = c(test$p.value),
        result = c(if (test$p.value > 0.05) "Aceita H0" else "Rejeita H0")
    ) %>%
        kable(
            col.names = c("P-valor", "Conclusão"),
            escape = T, caption = test$data %>% str_replace("by", "por")
        ) %>%
        return()
}


table_from_indep_test <- function(dataset, hypo.test = chisq.test) {
    test <- dataset %>%
        table() %>%
        hypo.test()

    variables <- names(dataset)

    data.frame(
        p.value = c(test$p.value),
        result = c(if (test$p.value > 0.05) "Aceita H0" else "Rejeita H0")
    ) %>%
        kable(
            col.names = c("P-valor", "Conclusão"),
            escape = T,
            caption = paste(
                variables[1], variables[2],
                sep = " por "
            )
        ) %>%
        return()
}