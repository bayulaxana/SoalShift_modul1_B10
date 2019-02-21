BEGIN {
    productLine["1"]="Personal Accessories";
    productLine["2"]="Camping Equipment";
    productLine["3"]="Outdoor Protection";
}

{
    if ($7 == "2012" && $1 == "United States") {
        for (x in productLine) {
            if ($4 == productLine[x]) {
                product[$6] = product[$6] + $10;
            }
        }
    }
}

END {
    for (y in product) {
        print product[y] " " y
    }
}