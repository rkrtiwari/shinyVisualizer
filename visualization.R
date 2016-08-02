getwd()
setwd("~/consultancyWork/")
booking <- read.table("data/booking_table2_01Aug.csv", sep = ",", nrows = -1,
                      header = TRUE)
head(booking)
names(booking)
booking$activity_date <- as.Date(booking$activity_date)
booking$booking_date <- as.Date(booking$booking_date)

nrow(booking)

sapply(booking, class)

plot(booking$booking_date, booking$activity_date)

months(head(booking$activity_date))

names(booking)


head(booking$pickup_required)
head(booking$booking_amount)

plot(booking$booking_date, booking$booking_amount, ylim = c(0,5000))

#########
min(booking$booking_date)
max(booking$booking_date)
monthlyBookingAmount <- tapply(booking$booking_amount, months(booking$booking_date), sum)
monthlyBookingAmount <- as.data.frame(monthlyBookingAmount)
monthlyBookingAmount <- monthlyBookingAmount[c(5,4,8,1,9,7,6,2,12,11,10),]

monthlyBookingAmount <- as.data.frame(monthlyBookingAmount)
barplot(monthlyBookingAmount$monthlyBookingAmount, horiz = TRUE, las =2)

monthlyBookingAmount <- tapply(booking$booking_amount, 
                               list(months(booking$booking_date), year), sum)
monthlyBookingAmount <- as.data.frame(monthlyBookingAmount)
monthlyBookingAmount <- monthlyBookingAmount[c(5,4,8,1,9,7,6,2,12,11,10),]




##############################################################################
# activity_id
#############################################################################
booking$activity_id <- factor(booking$activity_id)
table(booking$activity_id)
sum(booking$activity_id==21049)




###############################################################################
# agent country
##############################################################################
barData <- table(booking$agent_country)
barData <- as.data.frame(barData)

# top_n
index <- order(barData$Freq, decreasing = TRUE)
barData <- barData[index, ]
top_n <- 5
barplot(barData$Freq[1:top_n], names.arg = barData$Var1[1:top_n])

# bottom_n
index <- order(barData$Freq, decreasing = FALSE)
barData <- barData[index, ]
bottom_n <- 5
barplot(barData$Freq[1:bottom_n], names.arg = barData$Var1[1:bottom_n])

# range
#max <- nrow(barData)
#min <- 1

min <- 5
max <- 8

index <- order(barData$Freq, decreasing = FALSE)
barData <- barData[index, ]
barplot(barData$Freq[min:max], names.arg = barData$Var1[min:max])

