# ============================================
# Input Output Multiplier Analysis
# Generated from: io_multiplier_student skill
# ============================================

# SECTION 1: LOAD PACKAGES AND DATA
# ----------------------------------
# Load readxlsb package
library(readxlsb)

# Read Z matrix: sheet "BE", range "C12:L22"
# File path: "./materiales/data/FIGARO_ICIOI_23ed_2021.xlsb"
BE_Z <- read_xlsb(
  path = "./materiales/data/FIGARO_ICIOI_23ed_2021.xlsb",
  sheet = "BE",
  range = "C12:L22"
)

# Read X vector: sheet "BE", range "S12:S22"
BE_X <- read_xlsb(
  path = "./materiales/data/FIGARO_ICIOI_23ed_2021.xlsb",
  sheet = "BE",
  range = "S12:S22"
)


# SECTION 2: PREPARE MATRICES
# ----------------------------------
# Convert Z to matrix
Z <- as.matrix(BE_Z)

# Add row names to Z
rownames(Z) <- colnames(Z)

# Convert X to vector
x <- as.vector(BE_X$X)


# SECTION 3: COMPUTE TECHNICAL COEFFICIENTS
# ------------------------------------------
# Create diagonal matrix from 1/x
diag_matrix <- diag(1 / x)

# Multiply Z by diagonal matrix to get A
A <- Z %*% diag_matrix

# Add column names
colnames(A) <- rownames(A)


# SECTION 4: COMPUTE LEONTIEF INVERSE
# ------------------------------------
# Create identity matrix I
I <- diag(length(x))

# Subtract A from I and use solve() to get inverse
B <- solve(I - A)


# SECTION 5: COMPUTE MULTIPLIERS
# ----------------------------------
# Sum columns of A for direct effects
direct <- colSums(A)

# Sum columns of B for total effects
total <- colSums(B)


# SECTION 6: SHOW RESULTS
# ----------------------------------
# Print or plot the multipliers
print("Direct effects:")
print(sort(direct, decreasing = TRUE))

print("Total multipliers:")
print(sort(total, decreasing = TRUE))

# Find sector with highest multiplier
key_sector <- names(which.max(total))
cat("Key sector:", key_sector, "\n")
cat("Multiplier:", total[key_sector], "\n")