#
# ACS for TSP Manual
#
## The application of Ant Colony System for TSP.

Untuk menjalankan program gunakan file *main.m*. 

Ada 3 data yang digunakan untuk percobaan ini, yaitu:
1. city10.csv
2. berlin52.csv
3. ei51.csv

Jika ingin mengganti data yang digunakan silahkan mengganti nama data yang digunakan pada codingan berikut ini di *main.m*:
```
> cities = csvread('ei51.csv'); 
%ganti 'ei51.csv' menjadi nama file yang diinginkan.
```

Inisialisasi pheromone matrix dilakukan dengan menggunakan rumus: 1/(n*bks) dengan *bks* yang dimaksud adalah *best known solution* .
Constant yang digunakan dalam algoritma ini adalah:
```
alpha = 0.1;
beta = 2;
rho = 0.1;
Q = 1;
```

Jumlah semut yang digunakan adalah 10 dan iterasi yang dilakukan adalah sebanyak 3000.
Algoritma ini dimulai dengan penempatan 10 semut di kota berbeda sebagai *start position*. Untuk setiap semut, transition rule yang akan dilakukan adalah berdasarkan kemungkinan 90% *exploitation* dan 10% *exploration*. 

Berikut ini adalah penjelasan mengenai fungsi-fungsi yang ada:
`StartCity` digunakan untuk penempatan posisi awal semut agar semua semut berada di posisi yang berbeda saat *start*
```

> startCity(cities, n)
%cities = koordinat masing-masing kota
%n = jumlah semut
```

`exploit` digunakan untuk menentukan kota selanjutnya berdasarkan *pseudo-random-proportional rule*. *Edge* yang memiliki nilai **p** terbaik akan dipilih menjadi kota yang akan dikunjungi selanjutnya.
```
> exploit(p, unVisitedCity)
%p = hasil perhitungan pseudo-random-proportional rule untuk masing-masing edge
%unVisitedCity = kota-kota yang belum dikunjungi
```
`explore` digunakan untuk menentukan kota selanjutnya berdasarkan metode *RouletteWheel selection* dimana angka acak akan dibangkitkan dan kemungkinan dari setiap edge akan diakumulasikan untuk menentukan kota selanjutnya berdasarkan angka yang dibangkitkan.
```
> explore(p, unVisitedCity)
%p = hasil perhitungan pseudo-random-proportional rule untuk masing-masing edge
%unVisitedCity = kota-kota yang belum dikunjungi
```

`tourLength` digunakan untuk menghitung *cost* dari sebuah perjalanan yang dilakukan semut. Semakin kecil *cost*-nya semakin baik hasilnya.
```
> tourLength(D, ant, n)
%D = distance matrix
%ant = semut yang akan dihitung cost-nya
%n = banyak kota
```

`localBest` digunakan untuk mencari solusi terbaik dari sebuah iterasi (*local best solution*).
```
> localBest(ants)
%ants = semua semut yang ada pada sebuah iterasi
```
`plotTravel` digunakan untuk melakukan plot perjalanan yang dilakukan oleh semut.
```
> plotTravel(city,tabu)
%city = koordinat kota
%tabu = rute perjalanan yang dilalui semut
```

## CITY10
Hasil terbaik untuk data city10.csv adalah dengan nilai cost = **48**. Jumlah iterasi untuk 10 kota ini dikurangi menjadi 100 iterasi saja.

![alt text](https://raw.githubusercontent.com/nettys/ACS-for-TSP/master/city10-Iteration.png "Iteration")

Berikut ini adalah grafik performa dari algoritma ACS untuk city10:
![alt text](https://raw.githubusercontent.com/nettys/ACS-for-TSP/master/city10-Performance.png "Performance")


## EI51

Setelah melakukan beberapa percobaan, didapatkan hasil terbaik nilai cost minimum untuk ei51 = **426**. Hasil ini didapat pada iterasi ke **709**. Berikut ini adalah *screenshot* hasilnya:
![alt text](https://raw.githubusercontent.com/nettys/ACS-for-TSP/master/ei51-Iteration.png "Iteration")

Berikut ini adalah grafik performa dari algoritma ACS untuk ei51:
![alt text](https://raw.githubusercontent.com/nettys/ACS-for-TSP/master/ei51-Performance.png "Performance")

## BERLIN52
Setelah melakukan beberapa percobaan, didapatkan hasil terbaik nilai cost minimum untuk berlin52 = **7542**. Hasil ini didapat pada iterasi ke **1078**. Berikut ini adalah *screenshot* hasilnya:

![alt text](https://raw.githubusercontent.com/nettys/ACS-for-TSP/master/berlin52-Iteration.png "Iteration")

![alt text](https://raw.githubusercontent.com/nettys/ACS-for-TSP/master/berlin52-Performance.png "Performance")