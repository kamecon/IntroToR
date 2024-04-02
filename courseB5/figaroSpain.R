
# Input output table ------------------------------------------------------

figaro <- read.csv(file = "figaroIO/matrix_eu-ic-io_ind-by-ind_23ed_2021.csv")

figaroSpainGVA <- figaro |> 
  select(rowLabels, starts_with("ES")) |> 
  select(-starts_with("ES_P3"), -starts_with("ES_P5")) |> 
  tibble::column_to_rownames("rowLabels") |>
  tail() |>
  head(4)

figaroSpain <- figaro |> 
  select(rowLabels, starts_with("ES")) |> 
  dplyr::filter(grepl(x = rowLabels, "^ES")) |> 
  tibble::column_to_rownames("rowLabels")

figaroSpainDemand <- figaroSpain |> 
  select(starts_with("ES_P3"), starts_with("ES_P5"))

figaroSpainInd <- figaroSpain |> 
  select(-starts_with("ES_P3"), -starts_with("ES_P5"))

figaroSpainOutput <- figaroSpain |> 
  mutate(output = rowSums(pick(where(is.numeric)))) |> 
  select(output)

x <- figaroSpainOutput$output |> 
  as.vector()
names(SpainX) <- rownames(figaroSpainOutput)  

Z <- as.matrix(figaroSpainInd)

A = Z %*% diag(1 / x) 

# Número de setores
n = length(x) 
# Matriz identidade
I = diag(n) 
# Matriz inversa de Leontief
B = solve(I - A) 

# Visualização de elementos específicos da matriz A e B
A[1, 1]
A[2, 1]
B[1, 1]
B[2, 1]


total <- colSums(B, na.rm = TRUE)

total[which.max(total)]
sort(total, decreasing = TRUE)




# Use table ---------------------------------------------------------------

figaroUse <- read.csv(file = "figaroIO/matrix_eu-ic-use_23ed_2021.csv")

figaroSpainUse <- figaroUse |> 
  select(rowLabels, starts_with("ES")) |> 
  dplyr::filter(grepl(x = rowLabels, "ES")) |> 
  tibble::column_to_rownames("rowLabels")
