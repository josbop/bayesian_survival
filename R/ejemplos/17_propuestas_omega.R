############################################################## .
## Capitulo 5: Propuestas para omega con Metropolis-Hastings
##
## Autor: Jose Pliego
## Fecha: 2021-02-19
############################################################## .

if (!require("pacman")) install.packages("pacman")
pacman::p_load("latex2exp", "viridis")

iter <- 2e4
y <- 2
h <- 0.9
g <- 1


# 1. Propuesta gamma ------------------------------------------------------

sim <- vector(length = iter, mode = "double")

q <- function(propuesta, anterior) {
  
  l <-
    y*(log(propuesta) - log(propuesta - h) - log(anterior) + log(anterior - h))
  
  return(exp(l))
  
}

set.seed(42)

sim[1] <- rgamma(n = 1, shape = 1 + y, rate = 1 + g) + h

for (i in 2:iter) {
  
  candidato <- rgamma(n = 1, shape = 1 + y, rate = 1 + g) + h
  rho <- min(q(candidato, sim[i - 1]), 1)
  sim[i] <- sim[i - 1] + (candidato - sim[i - 1]) * (runif(n = 1) < rho)
  
}

png(
  filename = "graphs/propuesta_gamma.png",
  width = 30,
  height = 20,
  units = "cm",
  res = 300
)

plot(
  x = 1:length(sim),
  y = sim,
  type = "l",
  xlab = "",
  ylab = TeX("$\\omega_{ij}$"),
  col = viridis(1)
)

dev.off()


# 2. Propuesta uniforme ---------------------------------------------------

prop <- function(x, omega, y, gamma) {
  
  l <- y*(log(x) - log(omega)) - (1 + gamma)*(x - omega)
  
  return(exp(l))
  
}

sim3 <- vector(length = iter, mode = "double")

set.seed(42)

a <- y + 1
sim3[1] <- rgamma(n = 1, shape = a, scale = 1 + g) + h

for (i in 2:iter) {
  
  omega <- sim3[i - 1]
  candidato <- runif(n = 1, min = max(h, omega - a), max = omega + a)
  r <- min(prop(candidato, omega, y, g), 1)
  sim3[i] <- sim3[i - 1] + (candidato - sim3[i - 1]) * (runif(n = 1) < r)
  
}

png(
  filename = "graphs/propuesta_uniforme.png",
  width = 30,
  height = 20,
  units = "cm",
  res = 300
)

plot(
  x = 1:length(sim),
  y = sim3,
  type = "l",
  xlab = "",
  ylab = TeX("$\\omega_{ij}$"),
  col = viridis(1)
)

dev.off()
