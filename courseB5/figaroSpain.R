
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

# Belgium example ---------------------------------------------------------

BE_Z <- read_xlsb(path = "figaroIO/FIGARO_ICIOI_23ed_2021.xlsb",
                  sheet = "BE",
                  range = "C12:L22")

BE_Ytemp <- read_xlsb(path = "figaroIO/FIGARO_ICIOI_23ed_2021.xlsb",
                      sheet = "BE",
                      range = "M12:R22")

BE_Y <- rowSums(BE_Ytemp)

BE_X <- read_xlsb(path = "figaroIO/FIGARO_ICIOI_23ed_2021.xlsb",
                  sheet = "BE",
                  range = "S12:S22")

Z <- as.matrix(BE_Z)
rownames(Z) <- colnames(Z)
x <- as.vector(BE_X$X)

A = Z %*% diag(1 / x) 
colnames(A) <- rownames(A)

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

# Closed model ------------------------------------------------------------

BE_C <- read_xlsb(path = "figaroIO/FIGARO_ICIOI_23ed_2021.xlsb",
                  sheet = "BE",
                  range = "N12:N22")

c <- as.matrix(BE_C$P3_S14) 

BE_R <- read_xlsb(path = "figaroIO/FIGARO_ICIOI_23ed_2021.xlsb",
                  sheet = "BE",
                  range = "C27:L28")

rTemp <- t(BE_R) 
r <- as.matrix(rTemp)

hc = c / sum(r) # Coeficientes de consumo

hr = r / x # Coeficientes de remuneração do trabalho (renda)

hr = t(hr) # Coeficientes de remuneração do trabalho (renda) transposto

AF = matrix(NA, ncol = n + 1, nrow = n + 1)  # Criação da matriz A do modelo fechado
AF = rbind(cbind(A, hc), cbind(hr, 0)) # Matriz de coeficientes técnicos
View(AF) # Matriz de coeficientes técnicos
IF = diag(n + 1) # Matriz identidade (n+1)x(n+1)
View(IF) # Matriz identidade (n+1)x(n+1)
BF = solve(IF - AF) # Matriz inversa de Leontief no modelo fechado
View(BF) # Matriz inversa de Leontief

totalF <- colSums(BF[,1:n], na.rm = TRUE)

total[which.max(total)]
sort(total, decreasing = TRUE)
