{
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
    print country " " max;
}
# awk -F ',' -f soal2a.awk WA_Sales_Products_2012-14.csv