# SoalShift_modul1_B10

### Soal Nomor 1

Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah
dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah
**nature.zip**. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh
file tersebut jika pukul **14:14** pada tanggal **14 Februari** atau hari tersebut adalah hari
jumat pada bulan Februari.

### Penyelesaian:
Pertama buat file .sh dimana perintah untuk me-unlock filenya yang corrupt.

### Soal Nomor 2

Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta
untuk memberikan laporan berdasarkan file **WA_Sales_Products_2012-14.csv**.
Laporan yang diminta berupa:

a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.

b. Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.

c. Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.

### Soal Nomor 3

Buatlah sebuah script bash yang dapat menghasilkan password secara acak
sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password
acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama
sebagai berikut:

a. Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt

b. Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.

c. Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.

d. Password yang dihasilkan tidak boleh sama.

### Soal Nomor 4

Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-
bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string
manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai
berikut:

a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.

b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke empat belas, dan seterusnya. 

c. setelah huruf z akan kembali ke huruf a

d. Backup file syslog setiap jam.

e. dan buatkan juga bash script untuk dekripsinya.

### Penyelesaian

**Script untuk enkripsi :**

```
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

```
fname=`date +"%H:%M %d-%m-%Y"`
```
> Untuk mendapatkan nilai dari jam, menit, hari, tanggal, dan tahun dapat menggunakan **date +%\<FORMAT>**

* Kemudian, untuk tahapan enkripsi. Tahapannya adalah dengan menambahkan **jam** dengan representasi **ASCII** dari salah satu huruf, yakni **'a'**. Mengapa **'a'**? Karena huruf ini merupakan huruf dasar untuk melakukan enkripsi pada huruf-huruf selanjutnya.

```
lwer=$(($hour + 97))
lwer=$(($lwer % 122))
if [ $lwer == 0 ]
then
    lwer=122
fi
```
> Sintaks ```lwer=$(($hour + 97))``` digunakan untuk menambahkan huruf dengan **jam**. Angka 97 adalah representasi **ASCII** dari huruf **'a'**.

* Kemudian dari **ASCII** baru yang telah didapat dari variabel **```lwer```**, dikonversi menjadi karakter menggunakan fungsi **```convert()```**.

```
convert() {
    printf "\\$(printf "%03o" "$1")"
}
```

* Sintaks dibawah berfungsi untuk mengkonversi huruf **'a'** dan huruf **'z'**.

```
firstChar=`convert $lwer`
lastChar=`convert $(($lwer-1))`
```
**Lanjutan:**

```
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

* Dari variabel **```log```** yang berisi **syslog**, kemudian isi dari  **```log```** dibuatkan _Back Up_ file dari variabel **```fname```** (jam:menit tanggal-bulan-tahun). If jam menunjukkan **00** atau jam 12 malam, maka tidak perlu di-enkripsi.

> Untuk melakukan enkripsi digunakan _command_ **```tr``` (translate)** dengan mengubah huruf **a-z dan A-Z** menjadi huruf-huruf enkripsinya.

**Script untuk dekripsi :**

```
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

### Soal Nomor 5

Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi
kriteria berikut:

a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.

b. Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.

c. Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.

d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.
