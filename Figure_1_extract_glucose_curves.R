# Extract glucose std curves for comparison with EPS quantification method

## load required packages:
library(tidyverse)
library(magick)
library(tcltk)

##dubois 1956

## load required data:
dubois_glucose <- image_read("EPS_Method_Manuscript_Data/Dubois_glucose.jpg")
plot(dubois_glucose)

## select points:
cat("Click on points representing glucose values\n")
coords <- locator(type = "p", col = "red", pch = 1)

## Define 2 known points on each axis to transform pixel -> data coordinates:
cat("Click points along the x-axis (10 and 100 mg sugar)\n")
x_cal <- locator(n = 2, type = "p", col = "blue", pch = 4)
cat("Click points along the y-axis (0.1 and 1.0 abs)\n")
y_cal <- locator(n = 2, type = "p", col = "blue", pch = 4)

## extract axis data:
x_pixels <- x_cal$x
x_data <- c(10, 100)
y_pixels <- y_cal$y
y_data <- c(0.1, 1.0)

## linear transformations:
pixel_to_x <- function(px) approx(x_pixels, x_data, xout = px)$y
pixel_to_y <- function(py) approx(y_pixels, y_data, xout = py)$y

## convert pixel coordinates of selected points to data units:
x_vals <- pixel_to_x(coords$x)
y_vals <- pixel_to_y(coords$y)

## print results:
dubois_glucose_data <- data.frame(ug_glu = x_vals, Abs = y_vals)
write_csv(dubois_glucose_data, "Results/dubois_glucose_data.csv")

##taylor 1995

## load required data:
taylor_glucose <- image_read("EPS_Method_Manuscript_Data/Taylor1995.jpg")
plot(taylor_glucose)

## select points:
cat("Click on points representing glucose values\n")
coords <- locator(type = "p", col = "red", pch = 1)

## Define 2 known points on each axis to transform pixel -> data coordinates:
cat("Click points along the x-axis (0 and 0.35 mM sugar)\n")
x_cal <- locator(n = 2, type = "p", col = "blue", pch = 4)
cat("Click points along the y-axis (0 and 2.5 abs)\n")
y_cal <- locator(n = 2, type = "p", col = "blue", pch = 4)

## extract axis data:
x_pixels <- x_cal$x
x_data <- c(0, 0.35)
y_pixels <- y_cal$y
y_data <- c(0, 2.5)

## linear transformations:
pixel_to_x <- function(px) approx(x_pixels, x_data, xout = px)$y
pixel_to_y <- function(py) approx(y_pixels, y_data, xout = py)$y

## convert pixel coordinates of selected points to data units:
x_vals <- pixel_to_x(coords$x)
y_vals <- pixel_to_y(coords$y)

## print results:
taylor_glucose_data <- data.frame(mM_glu = x_vals, Abs = y_vals)
write_csv(taylor_glucose_data, "Results/taylor_glucose_data.csv")

##rasouli 2014

## load required data:
rasouli_glucose <- image_read("EPS_Method_Manuscript_Data/rasouli2014.jpg")
plot(rasouli_glucose)

## select points:
cat("Click on points representing glucose values\n")
coords <- locator(type = "p", col = "red", pch = 1)

## Define 2 known points on each axis to transform pixel -> data coordinates:
cat("Click points along the x-axis (0 and 25 ug glucose)\n")
x_cal <- locator(n = 2, type = "p", col = "blue", pch = 4)
cat("Click points along the y-axis (0 and 1 abs)\n")
y_cal <- locator(n = 2, type = "p", col = "blue", pch = 4)

## extract axis data:
x_pixels <- x_cal$x
x_data <- c(0, 25)
y_pixels <- y_cal$y
y_data <- c(0, 1)

## linear transformations:
pixel_to_x <- function(px) approx(x_pixels, x_data, xout = px)$y
pixel_to_y <- function(py) approx(y_pixels, y_data, xout = py)$y

## convert pixel coordinates of selected points to data units:
x_vals <- pixel_to_x(coords$x)
y_vals <- pixel_to_y(coords$y)

## print results:
rasouli_glucose_data <- data.frame(ug_glu = x_vals, Abs = y_vals)
write_csv(rasouli_glucose_data, "Results/rasouli_glucose_data.csv")

## read our standard curve average abs values:
bogar_std2 <- read_rds("Results/std_2_avg.rds")
bogar_std3 <- read_rds("Results/std_3_avg.rds")
bogar_std4 <- read_rds("Results/std_4_avg.rds")
bogar_std5 <- read_rds("Results/std_5_avg.rds")

## create avg std curve:
ug_mL_glu <- c(2.69,5.37,26.87,80.69)
Abs <- c(bogar_std2,bogar_std3,bogar_std4,bogar_std5)
bogar_std_curve <- data.frame(ug_mL_glu = ug_mL_glu, Abs = Abs)

## print results:
write_csv(bogar_std_curve, "Results/bogar_std_curve.csv")









