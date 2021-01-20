library(stringr)
library(lubridate)

################################ Contacts ######################################
contacts <- read.csv("~/R/EUR/SeminarCaseStudies/dataset1_kpn_contacts.csv", 
                     stringsAsFactors=TRUE)
# Convert this columns as Date for better manipulation
contacts$selection_date <- as_date(contacts$selection_date)
contacts$first_selection_date <- as_date(contacts$first_selection_date)

# Extracted message and message type from column Treatment Code
minidf <- as.data.frame(str_split_fixed(contacts$Treatment_Code, "/", 4))
contacts$message <- as.factor(minidf$V3)
contacts$message_type <- as.factor(minidf$V4)

# Deleted column Treatment Code (all data is in 4 diff columns now) and row number
contacts <- contacts[,-c(1,36)]
# Reorder columns so FK is at the end
contacts <- contacts[,c(1:34,36,37,38,35)]
# Write as CSV (row number column will be created again)
write.csv(contacts, "~/R/EUR/SeminarCaseStudies/CONTACTS.csv")

################################# EMDS #########################################
edms <- read.csv("~/R/EUR/SeminarCaseStudies/dataset2_kpn_edms.csv", quote="", 
                 stringsAsFactors=TRUE)

# Remove all weird quotes
for (i in 1:length(edms)){
  edms[,i] <- str_remove_all(edms[,i], "\"")}

# rename cols (this can be changed later to coincide with the other dataset)
cols <- c("X", "Treatment_code", "customer_id", "edm_event", "resp_dtm", "sel_dtm", "FK")
colnames(edms) <- cols

# Extract data from column Treatment_code into 4 columns and append to original dataset
n_cols <- as.data.frame(str_split_fixed(edms$Treatment_code, "/", 4))
data$campaign_code <- as.numeric(n_cols$V1)
data$campaign_channel <- as.factor(n_cols$V2)
data$message <- as.factor(n_cols$V3)
data$message_type <- as.factor(n_cols$V4)

# Coerce this columns to match the other dataset
data$FK <- as.factor(data$FK)
data$customer_id <- as.numeric(data$customer_id)
data$edm_event <- as.factor(data$edm_event)

# Convert this columns as Date for better manipulation
data$resp_dtm <- as_date(data$resp_dtm)
data$sel_dtm <- as_date(data$sel_dtm) 

# Deleted column Treatment Code (all data is in 4 diff columns now) and row number
data <- edms[,-c(1,2)]

# Reorder columns so FK is at the end
data <- data[,c(1,2,3,4,6,7,8,9,5)]

# Write as CSV (row number column will be created again)
write.csv(data, "~/R/EUR/SeminarCaseStudies/EDM.csv")



