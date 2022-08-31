# SENSOR RECORDS

/api/SensorRecords (GET) => Tüm Sensör kayıtlarını getirir.


/api/SensorRecords (POST) => Yeni Sensör kaydı ekler.

{
  "cihazId": 0,
  "sicaklik": 0,
  "pil": 0
}


/api/SensorRecords/{id} (GET) => Belirtilen id'nin kaydını getirir.
Örnek: api/SensorRecords/3 => 3 numaralı kayıt.


/api/SensorRecords/{id} (DELETE) => Verilen id'nin kaydını siler.
/api/SensorRecords/3


/api/SensorRecords/byDate/{id}/{lastXDays} (GET) => Belirtilen cihaz id'li kaydın son x gün içerisindeki tüm değerleri.
Örnek: /api/SensorRecords/byDate/2/4 => id'si 2 olan cihazın son 4 gün içerisindeki tüm kayıtları.


# USERS


/api/Users/getAllUsers (GET) => Tüm kullanıcıları döndürür.


/api/Users/{username} (GET) => Belirtilen username'li kullanıcıyı döndürür aksi takdirde 404.


/api/Users/register (POST) => Yeni kullanıcı kaydı

{
  "username": "string",
  "password": "string",
  "fullname": "string"
}


/api/Users/login (POST) => Kullanıcı girişi

{
  "username": "string",
  "password": "string"
}


/api/Users/deleteUser/{username} (DELETE) => Belirtilen username'li kullanıcıyı siler


/api/Users/find/{username} (GET) => username parametresini içeren tüm kullanıcıları döndürür.

# Mobile APP Screenshots
![Ekran görüntüsü 2022-08-28 143659](https://user-images.githubusercontent.com/56596454/187672483-d5aafb81-8d0f-4aa4-9532-d3fdaa48b712.jpg)
![Ekran görüntüsü 2022-08-28 143716](https://user-images.githubusercontent.com/56596454/187672505-5e20b7f4-8ca3-4563-aac9-0fd060a844fc.jpg)
![Ekran görüntüsü 2022-08-28 143747](https://user-images.githubusercontent.com/56596454/187672527-73f5c72c-5a9d-4248-85c6-5e9e9fbc60cd.jpg)
![Ekran görüntüsü 2022-08-28 143804](https://user-images.githubusercontent.com/56596454/187672532-7569b204-3dca-4357-b5ce-0404ac12d820.jpg)
![Ekran görüntüsü 2022-08-28 143833](https://user-images.githubusercontent.com/56596454/187672558-10bdd8bc-bd03-449c-a786-f1f44e006173.jpg)
![Ekran görüntüsü 2022-08-28 143845](https://user-images.githubusercontent.com/56596454/187672580-8f50f621-bdb7-4bc7-86ac-84bb30a5a1f0.jpg)
![Ekran görüntüsü 2022-08-28 143859](https://user-images.githubusercontent.com/56596454/187672743-afe89f80-3e42-42bc-b807-8f526e7573dc.jpg)
