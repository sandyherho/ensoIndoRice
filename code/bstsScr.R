"
BSTS with covariates

Sandy H. S. Herho <herho@umd.edu>
2021/07/06
"

rm(list = ls(all.names = TRUE))
gc()

library(readr)
library(bsts)

df <- read_csv("https://raw.githubusercontent.com/sandyherho/ensoIndoRice/main/data/new_dataset.csv")
df <- subset(df, select = c("mei", "scaled_yield_idx"))

ss <- list()
ss <- AddLocalLinearTrend(ss, y = df$scaled_yield_idx)
ss <- AddSeasonal(ss, df$scaled_yield_idx, 
                  nseasons = nrow(df))
rlls_model <- bsts(scaled_yield_idx ~ ., 
             state.specification = ss,
             data = df, niter = 1e3,
             ping = 0, expected.model.size = 1)

cairo_ps("fig4.eps")
plot(rlls_model, 'components',
     xlab = 'time step',
     ylab = 'Standardized rice yield index')
dev.off()

cairo_ps("fig5.eps")
plot(rlls_model, 'coefficients')
dev.off()
