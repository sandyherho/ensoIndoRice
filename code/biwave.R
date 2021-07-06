"
Wavelet coherence

Sandy H. S. Herho <herho@umd.edu>
2021/07/05
"

rm(list = ls(all.names = TRUE))
gc()


library(biwavelet)

df <- read.csv("https://raw.githubusercontent.com/sandyherho/ensoIndoRice/main/data/new_dataset.csv")
df$date <- as.Date(df$date)

xwt <- xwt(subset(df, select = c("date", "mei")),
                    subset(df, select = c("date", "scaled_yield_idx")))

cairo_ps("fig3.eps")
par(oma = c(0, 0, 0, 1), mar = c(5, 4, 4, 5) + 0.1)
plot(xwt, plot.cb = TRUE, plot.phase = TRUE)
dev.off()


