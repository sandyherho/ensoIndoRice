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

l <- as.integer(85 / 100 * nrow(df))
df_train <- df[1 : l,] # 85% training
df_test <- df[(1 + l): nrow(df),] # 15% testing

nseasons <- 50

ss <- list()
ss <- AddLocalLinearTrend(ss, y = df_train$scaled_yield_idx)
ss <- AddSeasonal(ss, df_train$scaled_yield_idx, 
                  nseasons = nrow(df_train))
rlls_model <- bsts(scaled_yield_idx ~ ., 
             state.specification = ss,
             data = df_train, niter = 1e3,
             ping = 0, expected.model.size = 1)

cairo_ps("fig4.eps")
plot(rlls_model, 'components',
     xlab = 'time step',
     ylab = 'Standardized rice yield index')
dev.off()

cairo_ps("fig5.eps")
plot(rlls_model, 'coefficients')
dev.off()

rlls_model_pred <- predict(rlls_model, newdata = df_test,
                           horizon = nrow(df_test))


plot(rlls_model_pred, plot.original = nrow(df),
     xlab = 'time', ylab = 'Standardized rice yield index')
