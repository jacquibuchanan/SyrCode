# server.R

# Read in CSV file

setwd( "C:/Users/Ben/Dropbox/.Maxwell Files/Data Driven Management II/")

dat <- read.csv("SyracuseCodeViolations.csv")

# Drop dates before 2012

gt.2012 <- dat$Violation.Date > "2011-12-31"

dat <- dat[ gt.2012 , ]



violation.date <- as.Date( dat$Violation.Date, "%m/%d/%Y" )


# this creates a factor for month-year

month.year <- cut( violation.date, breaks="month" )

# this creates pretty names

month.year.name <- format( violation.date, "%b-%Y" )

# table( dat$Complaint.Type, month.year )

dat$month.year <- month.year

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
    
    pretty.names <- format( as.Date(names(complaint.sub)), "%b-%Y" )
    
    month.labels <- format( as.Date(names(complaint.sub)), "%b" )
    
    plot( complaint.sub, type="b", pch=19, xaxt="n", bty="n" )
    
    axis( side=1, at=(1:length(complaint.sub))[c(T,F,F)], labels=pretty.names[c(T,F,F)], cex.axis=0.5, las=2 )
    
    text( 1:length(complaint.sub), complaint.sub, month.labels, pos=3, cex=0.5 )
    
    
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