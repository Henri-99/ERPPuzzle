# Calculate market real-return from JSE ALSI
# Calculate risk-free return
# Calculate risk premium
# Compare to theoretical analysis

library(tidyverse)
library(lubridate)

#setwd("C:/Users/Henri/OneDrive - University of Cape Town/ECO4053S/ERPPuzzle")
JSE <- read_csv("JSE_ALSH.csv")
dates <- apply(JSE[,1], 2, mdy)
dates <- as.Date(dates, origin='1970-01-01')
JSE$Date <- dates

head(JSE)

plot(x = JSE$Date[1:1000],
     y = JSE$Close[1:1000],
     type = "l",
     xlab = "Date",
     ylab = "Closing Price",
     main = "JSE All Share",
     ylim = c(30000, 80000))

# Daily returns
JSE.d <- (JSE$Close - JSE$Open)/JSE$Open

# Yearly returns
year = 2022
closing = cbind(as.character(JSE$Date[1]), JSE$Close[1])
opening = NULL
for (i in 1:nrow(JSE)){
  if(JSE$Date[i] < as.Date(paste(year, '-01-01', sep = ""))){
    opening <- rbind(opening,
                     c(as.character(JSE$Date[i-1]),JSE$Open[i-1]))
    closing <- rbind(closing,
                     c(as.character(JSE$Date[i]),JSE$Close[i]))
    year <- year - 1
  }
}
opening <- rbind(opening,
                 c(as.character(JSE$Date[6976]),JSE$Open[6976]))


JSE.y <- as.data.frame(cbind(opening, closing))
colnames(JSE.y) <- c("Start", "Open", "End", "Close")
JSE.y$Open <- as.numeric(JSE.y$Open)
JSE.y$Close <- as.numeric(JSE.y$Close)

Return <- (JSE.y$Close - JSE.y$Open) / JSE.y$Open
JSE.y <- cbind(JSE.y, Return)
ri <- mean(JSE.y$Return[2:27])

# Risk free
RF <- read_csv(file = "RISK_FREE.csv")
rf <- mean(RF$Price)/100

# Equity risk premium
ERP <- ri - rf


#--------------------------

# library(readxl)
# ct <- read_xlsx("ct.xlsx", sheet = "Sheet1")
# 
# 
# ct.vector <-as.data.frame(ct[5:29,])
# ct.vector <-ct.vector[order(ct.vector$year, decreasing = TRUE),] 
# 
# ri.vector<-as.data.frame(JSE.y[4:28,c(1,5)])
# 
# 
# ln.ct <-log(ct.vector$congrowth) 
# R <-ri.vector$Return+1
# 
# gamma <- (ri - rf)/cov(ln.ct,R)

#-----------------------------------

ct <- read_xlsx("ct.xlsx", sheet = "Sheet2")


ct.vector <-as.data.frame(ct[6:29,])
ct.vector <-ct.vector[order(ct.vector$year, decreasing = TRUE),] #consumption growth| 1995-2018


ri.vector<-as.data.frame(JSE.y[5:28,c(1,5)]) #return on equity | 1995-2018 


ln.ct <-log(ct.vector$congrowth) 
R <-ri.vector$Return+1

gamma <- (ri - rf)/cov(ln.ct,R)






















