############################################################## .
## Capitulo 3: Estimacion Puntual Bayesiana
##
## Autor: Jose Pliego
## Fecha: 2021-02-19
############################################################## .

if (!require("pacman")) install.packages("pacman")
pacman::p_load("latex2exp", "viridis")

mu <- 3
sigma <- 0.1
m <- 2
s <- 0.1
n <- 3

set.seed(42)

x <- rnorm(n, mean = mu, sd = sigma)

sx <- (n * sigma^(-2) + s^(-2))^(-1/2)
mx <- (n * sigma^(-2) * mean(x) + m * s^(-2)) * sx^2

points <- seq(from = 1.5, to = 3.5, by = 0.01)
likelihood <- dnorm(points, mean = mu, sd = sigma)
prior <- dnorm(points, mean = m, sd = s)
posterior <- dnorm(points, mean = mx, sd = sx)

png(
  filename = "graphs/pointwise_estimation.png",
  width = 25,
  height = 20,
  units = "cm",
  res = 300
  )

plot(
  points,
  posterior,
  type = "l",
  col = viridis(3)[[1]],
  ylab = TeX("$f_{\\mu}$"),
  xlab = ""
)
points(points, prior, type = "l", col = viridis(3)[[2]])
points(points, likelihood, type = "l", col = viridis(3)[[3]])
lines(
  x = c(mx, mx),
  y = c(0, dnorm(mx, mean = mx, sd = sx)),
  lty = 2,
  col = viridis(3)[[1]]
)
lines(
  x = c(m, m),
  y = c(0, dnorm(m, mean = m, sd = s)),
  lty = 2,
  col = viridis(3)[[2]]
)
lines(
  x = c(mu, mu),
  y = c(0, dnorm(mu, mean = mu, sd = sigma)),
  lty = 2,
  col = viridis(3)[[3]]
)

dev.off()
