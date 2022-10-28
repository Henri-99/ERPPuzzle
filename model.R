# Calculate market real-return from JSE ALSI
# Calculate risk-free return
# Calculate risk premium
# Compare to theoretical analysis


setwd("C:/Users/Henri/OneDrive - University of Cape Town/ECO4053S/ERPPuzzle")

JSE <- read_csv("JSE_ASLH.csv")
JSE <- read_csv("JSE_ALSH.csv", show_col_types = F)
JSE.d <- JSE[,'Close'] - JSE[,'Open']
JSE.r
head(JSE)
