############################################################## .
## Capitulo 4: Normal bivariada con Gibbs Sampler
##
## Autor: Jose Pliego
## Fecha: 2021-02-19
############################################################## .

if (!require("pacman")) install.packages("pacman")
pacman::p_load("viridis")

nsim <- 1e4
x <- vector(mode = "double", length = nsim)
y <- vector(mode = "double", length = nsim)

set.seed(42)
x[1] <- rnorm(1)
y[1] <- rnorm(1)
rho <- 0.8

for (i in 1:(nsim - 1)) {
  y[i + 1] <- rnorm(1, mean = rho * x[i], sd = sqrt((1 - rho^2)))
  x[i + 1] <- rnorm(1, mean = rho * y[i + 1], sd = sqrt((1 - rho^2)))
}

png(
  filename = "graphs/x_norm.png",
  width = 30,
  height = 30,
  units = "cm",
  res = 300
)

hist(
  x,
  probability = TRUE,
  breaks = seq(from = -4.5, to = 4.5, by = 0.1),
  ylab = "f(x)",
  col = viridis(2)[[2]],
  border = viridis(2)[[2]],
  main = ""
)
curve(
  dnorm(x, mean = 0, sd = 1),
  from = -4.5,
  to = 4.5,
  add = TRUE,
  lwd = 2,
  col = viridis(2)[[1]],
)

dev.off()

png(
  filename = "graphs/y_norm.png",
  width = 30,
  height = 30,
  units = "cm",
  res = 300
)

hist(
  x,
  probability = TRUE,
  breaks = seq(from = -4.7, to = 4.7, by = 0.1),
  ylab = "f(y)",
  col = viridis(2)[[2]],
  border = viridis(2)[[2]],
  main = ""
)
curve(
  dnorm(x, mean = 0, sd = 1),
  from = -4.7,
  to = 4.7,
  lwd = 2,
  add = TRUE,
  col = viridis(2)[[1]],
)

dev.off()

png(
  filename = "graphs/bivnorm.png",
  width = 30,
  height = 30,
  units = "cm",
  res = 300
)

plot(
  x,
  y,
  pch = 19,
  col = scales::alpha(viridis(1), alpha = 0.2),
  ylim = c(-4.7, 4.7),
  xlim = c(-4.7, 4.7)
)

dev.off()
