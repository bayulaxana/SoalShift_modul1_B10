# SoalShift_modul1_B10

### Soal Nomor 1

Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah
dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah **nature.zip**. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul **14:14** pada tanggal **14 Februari** atau hari tersebut adalah hari jumat pada bulan Februari.

## Penyelesaian:
(untuk source codenya bisa cek di folder Soal 1>soal1.sh
 - Pertama buat file .sh untuk mendecript file zip tersebut -> menggunakan **```base64 -d```**
 - Lalu reverse hexdump filenya dengan **```xxd -r```**
 - Untuk pengaturan waktunya, edit ```crontab -e``` lalu input perinta berikut(bisa juga dicek di crontab.txt):
 
 ```14 14 2 5 /bin/bash /home/pootreth/soal1.sh```
  
---

### Soal Nomor 2

Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta
untuk memberikan laporan berdasarkan file **WA_Sales_Products_2012-14.csv**.
Laporan yang diminta berupa:

* **[ a ] Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.**

    Sintaks awk-nya adalah sebagai berikut:

    ```bash
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
    ```

    Potongan kode di atas bekerja dengan cara memeriksa kolom 7, yakni kolom tahun yang hanya tahun 2012. Kemudian, menggunakan array dengan indeks **Nama Negara** (kolom 1) dengan menjumlahkannya dengan **_quantity_** (kolom 10). Setelah pencarian selesai, dicari negara dengan kuantitas tertinggi pada blok **END**.

* **[ b ] Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.**

    Sintaks awk-nya adalah sebagai berikut:

    ```bash
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
    ```

    Setelah didapatkan **negara** pada poin (a), selanjutnya adalah menjumlahkan **Product Line** (kolom 4) dengan kuantitasnya. Ini disimpan menggunakan array dengan indeks **Product Line**. Kemudian hasilnya diurutkan berdasarkan kuantitasnya dan di-print tiga teratas.

    > Untuk mengurutkan dapat menggunakan _command_ **```sort -nr```** (numerical,reverse) dan untuk mencetak hanya tiga baris menggunakan **```awk NR <=3```**.

* **[ c ] Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.**

    ```bash
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
    ```

    Prinsipnya sama dengan 2(b) tadi. Setelah didapatkan tiga _Product Line_ teratas, kemudian dicetak tiga _Product_ teratas berdasarkan tiap _Product Line_. Cara kerjanya mirip dengan Soal 2(b).

---

### Soal Nomor 3

Buatlah sebuah script bash yang dapat menghasilkan password secara acak
sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password
acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama
sebagai berikut:

### Penyelesaian

* **Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt**

    + Pertama kali yang dilakukan adalah memeriksa apakah dalam direktori tersebut ada file **password1.txt** atau tidak. Scriptnya adalah sebagai berikut.
        ```bash
        i=1
        while [ true ]
        do
            check=`ls "password"$i".txt" 2> /dev/null`
            if [ ${#check} == 0 ]
            then
                fname="password"$i".txt"
                break
            fi
            i=`expr $i + 1`
        done
        ```
        > Potongan script di atas bekerja dengan cara melakukan loop hingga nama file **password[i].txt** tidak ditemukan.

* **Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.**

    + Potongan kode sebelumnya sudah mengatasi untuk menyimpan file bernama **password[i].txt** dengan **i** terurut (i = 1,2,3...).

* **Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.**

    + Potongan kode sebelumnya juga sudah mengatasi apabila salah satu file dihapus, namun akan tidak akan terlewatkan jika dibuat baru lagi.

* **Password yang dihasilkan tidak boleh sama.**

    ```bash
    passCheck=`grep -w $newPass password*.txt 2> /dev/null`
    while [ ${#passCheck} != 0 ]
    do
        makePassword
        passCheck=`grep -w $newPass password*.txt 2> /dev/null`
    done
    ```

* ### Script

    ```bash
    #!/bin/bash

    makePassword() {
        newPass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
    }

    fname=""
    i=1
    while [ true ]
    do
        check=`ls "password"$i".txt" 2> /dev/null`
        if [ ${#check} == 0 ]
        then
            fname="password"$i".txt"
            break
        fi
        i=`expr $i + 1`
    done
    makePassword
    passCheck=`grep -w $newPass password*.txt 2> /dev/null`
    while [ ${#passCheck} != 0 ]
    do
        makePassword
        passCheck=`grep -w $newPass password*.txt 2> /dev/null`
    done
    echo $newPass > $fname
    ```

* Untuk membuat password secara random yang mengandung huruf kecil, huruf besar, dan angka menggunakan sintaks:

    ```bash
    makePassword() {
        newPass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
    }
    ```

---

### Soal Nomor 4

Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string
manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai
berikut:

* **Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.**

* **Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke empat belas, dan seterusnya.**

* **setelah huruf z akan kembali ke huruf a**

* **Backup file syslog setiap jam.**

* **dan buatkan juga bash script untuk dekripsinya.**

### Penyelesaian

* ### Script untuk Enkripsi

    ```bash
    #!/bin/bash

    convert() {
        printf "\\$(printf "%03o" "$1")"
    }

    hour=`date +%H`
    fname=`date +"%H:%M %d-%m-%Y"`
    log=`cat /var/log/syslog`

    lwer=$(($hour + 97))
    lwer=$(($lwer % 122))
    if [ $lwer == 0 ]
    then
        lwer=122
    fi

    firstChar=`convert $lwer`
    lastChar=`convert $(($lwer-1))`

    if [ $lwer == 97 ]
    then
        var=`printf '%s' "$log"`
    else
        var=`printf '%s' "$log" | tr a-zA-Z $firstChar-za-$lastChar${firstChar^^}-ZA-${lastChar^^}`
    fi

    printf '%s\n' "$var" > "$fname".txt
    ```
* Hal pertama yang dilakukan adalah meng-ekstrak jam, menit, hari, tanggal, dan tahun dari **date/tanggal**. Setelah didapatkan jam, menit, hari, tanggal, dan tahun, langkah selanjutnya adalah menyiapkan **nama file** nya dalam format **jam:menit tanggal-bulan-tahun**

    ```bash
    fname=`date +"%H:%M %d-%m-%Y"`
    ```
    > Untuk mendapatkan nilai dari jam, menit, hari, tanggal, dan tahun dapat menggunakan **date +%\<FORMAT>**

* Kemudian, untuk tahapan enkripsi. Tahapannya adalah dengan menambahkan **jam** dengan representasi **ASCII** dari salah satu huruf, yakni **'a'**. Mengapa **'a'**? Karena huruf ini merupakan huruf dasar untuk melakukan enkripsi pada huruf-huruf selanjutnya.

    ```bash
    lwer=$(($hour + 97))
    lwer=$(($lwer % 122))
    if [ $lwer == 0 ]
    then
        lwer=122
    fi
    ```
    > Sintaks ```lwer=$(($hour + 97))``` digunakan untuk menambahkan huruf dengan **jam**. Angka 97 adalah representasi **ASCII** dari huruf **'a'**.

* Kemudian dari **ASCII** baru yang telah didapat dari variabel **```lwer```**, dikonversi menjadi karakter menggunakan fungsi **```convert()```**.

    ```bash
    convert() {
        printf "\\$(printf "%03o" "$1")"
    }
    ```

* Sintaks dibawah berfungsi untuk mengkonversi huruf **'a'** dan huruf **'z'**.

    ```bash
    firstChar=`convert $lwer`
    lastChar=`convert $(($lwer-1))`
    ```
* **Lanjutan:**

    ```bash
    log=`cat /var/log/syslog`
        ...
        ...
        ...
    if [ $lwer == 97 ]
    then
        var=`printf '%s' "$log"`
    else
        var=`printf '%s' "$log" | tr a-zA-Z $firstChar-za-$lastChar${firstChar^^}-ZA-${lastChar^^}`
    fi

    printf '%s\n' "$var" > "$fname".txt
    ```

* Dari variabel **```log```** yang berisi **syslog**, kemudian isi dar i  **```log```** dibuatkan _Back Up_ file dari variabel **```fname```** (jam:menit tanggal-bulan-tahun). If jam menunjukkan **00** atau jam 12 malam, maka tidak perlu di-enkripsi.

    > Untuk melakukan enkripsi digunakan _command_ **```tr``` (translate)** dengan mengubah huruf **a-z dan A-Z** menjadi huruf-huruf enkripsinya.

* ### Script untuk dekripsi

    ```bash
    #!/bin/bash

    convert() {
        printf "\\$(printf "%03o" "$1")"
    }

    hour=`echo $1 | cut -d':' -f 1`
    log=`cat "$1$2"`

    lwer=$(($hour + 97))
    lwer=$(($lwer % 122))
    if [ $lwer == 0 ]
    then
        lwer=122
    fi

    firstChar=`convert $lwer`
    lastChar=`convert $(($lwer-1))`

    if [ $lwer == 97 ]
    then
        var=`printf '%s' "$log"`
    else
        var=`printf '%s' "$log" | tr $firstChar-za-$lastChar${firstChar^^}-ZA-${lastChar^^} a-zA-Z`
    fi
    printf '%s\n' "$var"
    ```

* Langkah untuk melakukan dekripsi hampir sama dengan enkripsi, bedanya kita hanya mengambil **jamnya** saja dari nama file menggunakan _command_ cut.

* Untuk dekripsinya, _command_ **```tr```** hanya perlu dibalik saja.

    > **Nama file diinputkan berupa argumen**

**Untuk crontab nomor 4, dapat dilihat pada file crontab.txt**

---

### Soal Nomor 5

Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi
kriteria berikut:

* a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.

* b. Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.

* c. Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.

* d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.

## Penyelesaian
buat file awk -> source code saya taruh di Folder Soal 5>soal5.sh 

untuk menjawab soal a dan b, caranya yaitu sebagai berikut:
![Ini](https://drive.google.com/open?id=1fuPdaBKifM4fX8JyxDtoWItJSGBr886A)

untuk soal c, berikut caranya:)

```/var/log/syslog > /home/pootreth/modul1/soal5.log```


untuk soal d, crontabnya bisa dilihat di file "crontab.txt" :)

```2-30/6 * * * * /bin/bash /home/pootreth/soal5.sh```
