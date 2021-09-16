source('src/packages.R')

read_excel_with_groups <- function(filename, sheet, ...) {
  ## read dataset and add group column
  read_excel(filename, sheet = sheet, ...) %>%
    # create column with treatment as group
    mutate(Grupo = sheet) %>%
    return()
}

map(
  c("Oxigenoterapia", "Oxigenoterapia + Outros"), # setting groups
   # reading datasets from excel sheets
  ~read_excel_with_groups("data/bronquiolite.xlsx", sheet = .) %>%
    select(
      Reinternações, Grupo, Desconforto,
      `Melhora dos sinais de desconforto respiratório (leve, parcial, significativa)`,
      Complicações, Tempo,
      Oxigênio = oxigênio,
      Saturação
    ) # selecionando colunas que vão ser usadas
) %>%
  bind_rows() %>%
  write.csv("data/bronquiolite.xlsx")