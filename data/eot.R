library(remote)

pr <- brick("monInaRain19792020.nc")
sst <- brick("sstTroPac19792020.nc")

sst_pred <- deseason(sst, cycle.window = 12)
pr_resp <- deseason(pr, cycle.window = 12)

sst_predDns <- denoise(sst_pred, expl.var = 0.9)
pr_respDns <- denoise(pr_resp, expl.var = 0.9)

ina_modes <- eot(x = sst_predDns, y = pr_respDns, n = 1,
                 standardised = FALSE, reduce.both = FALSE, 
                 verbose = FALSE)

plot(ina_modes, y = 1, 
     show.bp = TRUE, arrange = "long")