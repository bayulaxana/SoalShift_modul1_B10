{
    if($7 == "2012" && $1 == "United States") { 
        productLine[$4] = productLine[$4] + $10;
    }
}

END {
    for (var in productLine) {
        print productLine[var] " " var;
    }
}
# awk -F ',' -f soal2b.awk  WA_Sales_Products_2012-14.csv | sort -nr | head -3