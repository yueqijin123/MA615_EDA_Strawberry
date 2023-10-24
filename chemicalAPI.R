library(httr)
library(jsonlite)

# https://rpubs.com/plantagenet/481658
# https://ordspub.epa.gov/ords/pesticides/apprilapi/?q=%7b%22ais%22:%7b%22$instr%22:%22080803%22%7d%7d
# https://ordspub.epa.gov/ords/pesticides/r/cswu/338/files/static/v213/APPRIL_REST_API_User_Guide.pdf

# https://ordspub.epa.gov/ords/pesticides/f?p=113:1::::RP,17,1::
# https://ordspub.epa.gov/ords/pesticides/f?p=APPRIL_PUBLIC:2::::::

path <- "https://ordspub.epa.gov/ords/pesticides/apprilapi/?q=%7b%22ais%22:%7b%22$instr%22:%22128810%22%7d%7d"

r <- GET(url = path)

status_code(r)

str(content(r))

r_text <- content(r, as = "text", encoding = "UTF-8")
df <- fromJSON(r_text,flatten = TRUE)
View(df)

View(df$items)

View(df$items[grepl("Strawberries", df$items$sites, fixed=T),])
View(df$items[grepl("Sorghum", df$items$sites, fixed=T),])


## Get strawberry PC code in a column
## contruct the path s.t.
# paste0("https://ordspub.epa.gov/ords/pesticides/apprilapi/?q=%7b%22ais%22:%7b%22$instr%22:%22",
#         PC code,
#         "%22%7d%7d"")

# the for each PC code in our column, make a unique path
# convert the json to a data frame
# filter the item dataframe for sites that include "strawberry/ies(?)"
# trim the response down to just the data you want to keep
# return a list of outputs corresponding to each element of our PC code column

# https://ordspub.epa.gov/ords/pesticides/apprilapi/


#?q=%7b%22sites%22:%7b%22$instr%22:%22wineries%22%7d,%22pests%22:%7b%22$instr%22:%22mosq%22%7d,%22status_group%22:%22Active%22,%22reg_type%22:%22Sec3%22%7d

#{"sites":{"$instr":"wineries"}}
#{"sites":{"$instr":"Strawberries"}}
#{"ais":{"$instr":OUR PC CODE IN A STRING}}
#{"ais":{"$instr":"128810"}}

path <- "https://ordspub.epa.gov/ords/pesticides/apprilapi/"

q1 <- "\"sites\":{\"$instr\":\"Strawberries\"}"
q2 <- "\"ais\":{\"$instr\":\"128810\"}"

aString <- "\"hello\""
aString

URLencode(aString, reserved = T)
p1 <- URLencode(q1, reserved = T)
p2 <- URLencode(q2, reserved = T)

qStr <- paste0("{",p1,",",p2,"}")
qStr <- URLencode(qStr, reserved = T)



