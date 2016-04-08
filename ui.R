
#ui.r

library(shiny)
library(RCurl)

# Read in CSV file

#setwd( "C:/Users/Ben/Dropbox/.Maxwell Files/Data Driven Management II/")

#dat <- read.csv("SyracuseCodeViolations.csv", stringsAsFactors = FALSE)

# Drop dates before 2012

#gt.2012 <- dat$Violation.Date > "2011-12-31"

#dat <- dat[ gt.2012 , ]


#violation.date <- as.Date( dat$Violation.Date, "%m/%d/%Y" )


# this creates a factor for month-year

#month.year <- cut( violation.date, breaks="month" )

# this creates pretty names

#month.year.name <- format( violation.date, "%b-%Y" )

#change date to month
#date <- as.Date(dat.referrals$Timestamp, "%m/%d/%Y")

#month <- format( date, "%b")

# you need to do this to ensure months are ordered correctly, default is alphabetic

#month <- factor( month, levels=c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"))

# Set Violation Types for Checkboxes

violation.types <- c("Property Maintenance-Int", 
                     "Trash/Debris-Private, Occ", 
                     "Bed Bugs", 
                     "Property Maintenance-Ext", 
                     "Building W/O Permit",
                     "Overgrowth: Private, Occ",
                     "Zoning Violations",
                     "Fire Safety",
                     "Fire Alarm",
                     "Unsafe Conditions",
                     "Infestation",
                     "Other (FPB)")


shinyUI(fluidPage(
  titlePanel('City of Syracuse - Code Violations'),
  
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("show_comps", 
                          label = h3("Complaint types:"), 
                          choices = violation.types)
    ),
    
    mainPanel = (tabsetPanel(id='dataset',
                             tabPanel("Complaints", plotOutput("complaints"))
    )
    ))
))