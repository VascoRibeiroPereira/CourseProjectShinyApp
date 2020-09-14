library(lubridate)
library(dplyr)

filesList <- list.files("~/R/carspeed/RawData", full.names = TRUE)

carspeed <- tibble()
for (i in 1:length(filesList)) {
        tmp<- read.csv(filesList[i])   
        
        carspeed <- rbind(tmp, carspeed)
}

carspeed$Direction <- as.factor(carspeed$Direction)
carspeed_Clean <- filter(carspeed, Speed < 120 & Speed > 10)
carspeed_Clean <- carspeed_Clean[,-2]
carspeed_Clean <- mutate(carspeed_Clean, valid = paste(Date, Time, sep = " "))
carspeed_Clean <- carspeed_Clean[,-c(1,2)]

carspeed_Clean$valid <- parse_date_time(carspeed_Clean$valid, "Ymd HM", tz="Europe/Lisbon")
carspeed_Clean$valid <- round_date(carspeed_Clean$valid, unit = "hour")

carspeed_filter <- filter(carspeed_Clean, valid >= as.Date("2020-08-03"))

groupedData <- carspeed_filter %>% group_by(valid, Direction)
speed_Analysis <- groupedData %>% summarise(meanSpeed = mean(Speed))


speed_Analysis$Direction <- as.integer(speed_Analysis$Direction)

for(i in 1:length(speed_Analysis$Direction)) {
        if (speed_Analysis$Direction[i] == 1) speed_Analysis$Direction[i] <- "Sintra-MemMartins" 
        else speed_Analysis$Direction[i] <- "MemMartins-Sintra"
}

speed_Analysis$Direction <- as.factor(speed_Analysis$Direction)

Data <- speed_Analysis$valid
Direção <- speed_Analysis$Direction
Velocidade <- speed_Analysis$meanSpeed

df <- tibble(Data, Direção, Velocidade) 

write.csv(df, file = "cleanData.csv")

rm(list = ls())

myData <- read.csv("cleanData.csv", 
                       colClasses = c("factor", "POSIXct", "factor", "numeric"))

myData <- as_tibble(myData)[,-1]



