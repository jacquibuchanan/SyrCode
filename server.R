# server.R

library(plyr)  # required for round_any function

# Read in CSV file

setwd( "C:/Users/Ben/Dropbox/.Maxwell Files/Data Driven Management II/")

dat <- read.csv("SyracuseCodeViolations.csv")

# Drop dates before 2012

violation.date <- as.Date( dat$Violation.Date, "%m/%d/%Y" )

gt.2012 <- violation.date > "2011-12-31"

dat <- dat[ gt.2012 , ]

#violation.date <- as.Date( dat$Violation.Date, "%m/%d/%Y" )
#hist( violation.date, "months" )
#min( violation.date)

#violation.date <- as.Date(dat$Violation.Date, "%m/%d/%Y" )


violation.date <- as.Date( dat$Violation.Date, "%m/%d/%Y" )

# this creates a factor for month-year

month.year <- cut( violation.date, breaks="month" )

# this creates pretty names

month.year.name <- format( violation.date, "%b-%Y" )

# table( dat$Complaint.Type, month.year )

dat$month.year <- month.year


# Set Violation Types for Drop Down

violation.types <- c("Property Maintenance-Int", 
                     "Trash/Debris-Private, Occ", 
                     "Bed Bugs", 
                     "Property Maintenance-Ext", 
                     "Building W/O Permit",
                     "Overgrowth",
                     "Zoning Violations",
                     "Fire Safety",
                     "Fire Alarm",
                     "Unsafe Conditions",
                     "Infestation",
                     "Other (FPB)")

# Plot 

###############

#change date to month
#date <- as.Date(dat.referrals$Timestamp, "%m/%d/%Y")

#month <- format( date, "%b")

# you need to do this to ensure months are ordered correctly, default is alphabetic

#month <- factor( month,levels=c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"))

shinyServer(function(input,output){
  
  output$complaints <- renderPlot({
    
    dat.sub <- dat[ dat$Complaint.Type %in% input$show_comps , ]
    

    
    # Create chart for a subset of data
    
    complaint.sub <- tapply( dat.sub$Complaint.Type, dat.sub$month.year, length )
    
    complaint.sub[ is.na(complaint.sub) ] <- 0
    
    # Set maximum y limit
    
    complaint.sub.df <- as.data.frame(complaint.sub)
    
    max.ylim <- round_any((1.1*max(complaint.sub.df[ , 1 ] )), 10, f = ceiling)
    
    # Set pretty names
    
    pretty.names <- format( as.Date(names(complaint.sub)), "%b-%Y" )
    
    month.labels <- format( as.Date(names(complaint.sub)), "%b" )
    
    plot( complaint.sub, type="b", pch=19, xaxt="n", bty="n", col="steelblue", 
          ylab = "Number of Complaints",
          xlab = "Time",
          ylim = c(0, max.ylim)
          )
    
    axis( side=1, at=(1:length(complaint.sub))[c(T,F,F)], labels=pretty.names[c(T,F,F)], cex.axis=0.8, las=2 )
    
    text( 1:length(complaint.sub), complaint.sub, month.labels, pos=3, cex=0.7 )
    
    
    ##############
    
    # Create a matrix of the two inputs and their counts
#    counts <- NULL
    
    # Create the selector vector - returns a TRUE value only when both columns are in the respective vectors of checkbox choices
#    these.complaints <- (dat$Complaint.Type %in% input$show_comps)
    
    # Create a subset of the full data based on the selector vector
#    dat.subset <- dat[these.complaints, ]
    
    # Create a table (matrix) of the two values and the counts 
#    counts <- table(dat.subset$Complaint.Type, month.year)
    
    # Chart the bar plot and the legend based on the counts matrix
#    plot(counts, 
#         main="Complaints",
#         ylab="Number of Complaints",
#         bty="n"
#        )
#    legend("topright",fill=agencies.colors, legend=rownames(counts), title="Complaints")
  })
})