

#Imported 12 Tripdata CSV files and used rbind Function 
cyclist<-rbind(cyclist,read_csv("202212-divvy-tripdata.csv"))


#Dropped The Columns which are not required for the analysis
cyclist<-cyclist[-c(14)]


#Extracting Date from the Date Time Column
cyclist$starting_date<-as.Date(cyclist$started_at) #Starting Date
cyclist$ended_date<-as.Date(cyclist$ended_at) #Ended Date


#Extracting Time From the DateTime Column
cyclist$starting_time<-format(cyclist$starting_at, "%H:%M:%S") #Starting time
cyclist$ended_time<-format(cyclist$ended_at, "%H:%M:%S") #Ending Time


#Sorting the Dates in ascending order
cyclist<-cyclist[order(cyclist$starting_time),]


#Calculating the Ride Length
cyclist$ride_length<-difftime(cyclist$ended_at,cyclist$started_at,units="mins")

#Extracting Weekday
cyclist$start_day<-weekdays(cyclist$starting_date)
cyclist$end_day<-weekdays(cyclist$ended_date)

#Extracting Month By Number
cyclist$start_month<-format(cyclist$starting_date,"%m")

#Getting Name of The Month By Number
cyclist$end_month<-month.name[as.integer(cyclist$end_month)]
cyclist$start_month<-month.name[as.integer(cyclist$start_month)]



#Organizing the Columns in the dataset
cyclist<-cyclist %>% relocate(ride_length, .after=end_month)
cyclist<-cyclist %>% relocate(ended_at, .after=start_month)

write.csv(cyclist,"Combined_Dataset.csv")

