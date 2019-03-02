#!/bin/bash

# (a)
printf ">> Nomor 2a:\n"
awk -F ',' '{
    if($7 == "2012") { listOfCountry[$1] = listOfCountry[$1] + $10;}
}

END {
    max=0;
    country="";
    for (var in listOfCountry) {
        if (max < listOfCountry[var]) {
            max = listOfCountry[var];
            country=var;
        }
    }
    print country;
}' WA_Sales_Products_2012-14.csv

# (b)
printf "\n>> Nomor 2b:\n"
awk -F ',' '{
    if($7 == "2012" && $1 == "United States") { 
        productLine[$4] = productLine[$4] + $10;
    }
}

END {
    for (var in productLine) {
        print productLine[var] " " var;
    }
}' WA_Sales_Products_2012-14.csv | sort -nr | awk 'NR <= 3 {print $2, $3}'

# (c)
printf "\n>> Nomor 2c:\n"

printf "Personal Accessories : \n"
awk -F ',' '{
    if ($1 == "United States" && $7 == "2012") {
        if ($4 == "Personal Accessories") {
            product[$6] += $10;
        }
    }
}

END {
    for (var in product) {
        print product[var], var;
    }
}' WA_Sales_Products_2012-14.csv | sort -nr | awk 'NR <=3 {print $2, $3, $4}'

printf "\nCamping Equipment : \n"
awk -F ',' '{
    if ($1 == "United States" && $7 == "2012") {
        if ($4 == "Camping Equipment") {
            product[$6] += $10;
        }
    }
}

END {
    for (var in product) {
        print product[var], var;
    }
}' WA_Sales_Products_2012-14.csv | sort -nr | awk 'NR <=3 {print $2, $3, $4}'

printf "\nOutdoor Protection : \n"
awk -F ',' '{
    if ($1 == "United States" && $7 == "2012") {
        if ($4 == "Outdoor Protection") {
            product[$6] += $10;
        }
    }
}

END {
    for (var in product) {
        print product[var], var;
    }
}' WA_Sales_Products_2012-14.csv | sort -nr | awk 'NR <=3 {print $2, $3, $4}'
