library(readr)
dataset1_kpn_contacts <- read_csv("Downloads/Case seminar 3/dataset1_kpn_contacts.csv")
View(dataset1_kpn_contacts)

library(tidyverse)


dataset1_kpn_contacts<- as.data.frame(dataset1_kpn_contacts)
#Columns
dataset1_kpn_contacts<- dataset1_kpn_contacts %>% 
  rename(y_Purchase = y_aankooporder,
         y_order_kpneen_fixed = y_order_kpneen_vast,
         y_order_kpneen_mobile = y_order_kpneen_mobiel,
         Number_Employees_Factor = Klasse_Aantal_Medewerkers,
         Number_Locations_Parent = Klasse_Aantal_Locaties_Concern,
         Legal_Form = Klasse_Rechtsvorm, 
         Number_Employees = Aantal_Medewerkers,
         Behavioral_Description = Bedrijfsgedragstype, 
         Industry_Segment = Omschrijving_Segment,
         Industry_Segment_Parent = Omschrijving_Segment_Concern,
         Work_Type = Werk_Type,
         Think_or_Do = Werk_Denken_Doen,
         Revenue_Factor = Klasse_Omzet
         )

#Factor
colsd<- c("y_Purchase", "y_order_kpneen_fixed", "y_order_kpneen_mobile",  "customer_id",  "y_positive_campaign_result", "y_positive_response_tm",
         "y_click", "y_click_mopinion", "y_churn")


colsc<-c("Number_Employees_Factor", 
         "Number_Locations_Parent", "Legal_Form", "Behavioral_Description", "Industry_Segment",
         "Industry_Segment_Parent", "Work_Type", "Think_or_Do", "Revenue_Factor", "campaign_code",
         "campaign_name","campaign_channel", "campaign_status", "campaign_train",
         "train_channel_first", "train_channel_last", "Treatment_Code", "FK", "XSellTarget")

dataset1_kpn_contacts[colsd] <- lapply(dataset1_kpn_contacts[colsd], factor)
dataset1_kpn_contacts[colsc] <- lapply(dataset1_kpn_contacts[colsc], factor)


#Levels
library(plyr)
dataset1_kpn_contacts$Behavioral_Description<-mapvalues(dataset1_kpn_contacts$Behavioral_Description, 
                  from = c("Dagelijkse Kantoorwerkers", "Faciliterende beheerders", 
                  "Mobiele handelaren","Onbekend","Regionale uitvoerders","Verstrekkende aanbieders","Verzorgende specialisten"), 
                  to = c("Daily Office Workers", "Facilitating Administrators",
                 "Mobile Traders", "Unknown", "Regional Executives", "Suppliers",
                 "Caring Specialists"))  #creerende arbeiders = manual workers, financiele regelaars= financial fixers



dataset1_kpn_contacts$Work_Type<- mapvalues(dataset1_kpn_contacts$Work_Type,
                                            from = c( "Advies","Agrarisch","Hand","Horeca","Ontwerp","Op pad","Overig","Uitvoering","Winkel"),
                                            to = c("Consultancy", "Agricultural", "Manual", "HotelRestauranCafe", "Design", "On the Road",
                                                   "Other", "Executing/performing", "Store"))



dataset1_kpn_contacts$Think_or_Do<- mapvalues(dataset1_kpn_contacts$Think_or_Do,
                                              from =c("Denken","Doen"), to = c("Think", "Do"))

dataset1_kpn_contacts$Number_Employees_Factor<- mapvalues(dataset1_kpn_contacts$Number_Employees_Factor,
                                                          from = c("0 medewerkers","1 medewerker","1.000 of meer medewerkers", "10 t/m 19 medewerkers" ,   
                                                                   "100 t/m 199 medewerkers","2 t/m 4 medewerkers","20 t/m 49 medewerkers","200 t/m 499 medewerkers",  
                                                                   "5 t/m 9 medewerkers","50 t/m 99 medewerkers","500 t/m 749 medewerkers","750 t/m 999 medewerkers",  
                                                                   "Onbekend"),
                                                          to = c("0", "1", "1000+", "10-19", "100-199", "2-4", "20-49", "200-499", "5-9", "50-99", "500-749",
                                                                 "750-999", "Unknown"))

dataset1_kpn_contacts$Number_Employees<- factor(dataset1_kpn_contacts$Number_Employees, levels = c("Unknown","0", "1","2-4","5-9","10-19", "20-49","50-99","100-199", "200-499",
                                                                                                   "500-749", "750-999", "1000+")) #remove Unknown

dataset1_kpn_contacts$Number_Locations_Parent<- mapvalues(dataset1_kpn_contacts$Number_Locations_Parent,
                                                          from = c("1 (alle instellingen concern op 1 locatie)","1 (zelfstandige instelling)","11 t/m 25 locaties",                       
                                                                   "2 locaties","26 of meer locaties","3 t/m 5 locaties",                          
                                                                   "6 t/m 10 locaties"),
                                                              to =  c("1 Parent/Concern", "1 Independent Institution","11-25", "2", "26+", "3-5",
                                                                    "6-10"))



