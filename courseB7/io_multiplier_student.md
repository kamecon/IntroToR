---
name: io-multiplier-analysis-basic
description: Compute Input-Output multipliers from IO table
workflow_stage: analysis
compatibility:
  - openai
author: Kamal Romero
version: 1.0.0
tags:
  - R
  - input-output
  - multipliers
  - economics
---

# Input Output Multiplier Analysis

## What is this skill for

This skill computes the multipliers from an Input-Output table. It calculates the technical coefficients, the Leontief inverse and then the multipliers for each sector.

## When to use

Use this skill when you have an IO table and want to find out which sectors have the biggest impact on the economy.

## Steps

### Step 1: Load the data

First we need to load the IO table from an Excel file. We need two things: the interindustry matrix Z and the total output vector X.

**File details:**
- File: `FIGARO_ICIOI_23ed_2021.xlsb` (located in `./materiales/data/`)
- Sheet: `BE` (Belgium)
- Z matrix range: `C12:L22` (10x10 matrix)
- X vector range: `S12:S22` (column with total output values)

### Step 2: Convert to matrices

We need to convert the data to matrix format so we can do matrix algebra. Also give names to rows and columns.

### Step 3: Calculate technical coefficients

The technical coefficient A shows how much input each sector needs from other sectors to produce one unit. Formula: A = Z * (1/x) diagonal matrix

### Step 4: Calculate Leontief inverse

The Leontief inverse B = (I - A)^-1 gives us the total requirements including indirect effects.

### Step 5: Calculate multipliers

Add up the columns of A for direct effects and columns of B for total effects.

### Step 6: Present results

Sort the multipliers and show which sectors have highest values.

## R Code Structure

```r
# SECTION 1: LOAD PACKAGES AND DATA
# - Load readxlsb package
# - Read Z matrix: sheet "BE", range "C12:L22"
# - Read X vector: sheet "BE", range "S12:S22"
# - File path: "./materiales/data/FIGARO_ICIOI_23ed_2021.xlsb"

# SECTION 2: PREPARE MATRICES
# - Convert Z to matrix
# - Add row names to Z
# - Convert X to vector

# SECTION 3: COMPUTE TECHNICAL COEFFICIENTS
# - Create diagonal matrix from 1/x
# - Multiply Z by diagonal matrix to get A

# SECTION 4: COMPUTE LEONTIEF INVERSE
# - Create identity matrix I
# - Subtract A from I
# - Use solve() to get inverse

# SECTION 5: COMPUTE MULTIPLIERS
# - Sum columns of A for direct effects
# - Sum columns of B for total effects

# SECTION 6: SHOW RESULTS
# - Print or plot the multipliers
# - Find sector with highest multiplier
```

## Example

```r
# This is just a sketch of what the code should look like
# The actual code would go here

# Load data
data <- read_excel("io_table.xlsx")

# Do calculations
A <- calculate_A(Z, x)
B <- calculate_B(A)
multipliers <- calculate_multipliers(B)

# Show results
print(multipliers)
```

## What you need

- R
- readxl or readxlsb package
- An IO table in Excel format

## How to interpret

- Direct effects show what each sector needs from other sectors directly
- Total effects (multipliers) include the whole supply chain
- Higher multiplier = more important sector for the economy