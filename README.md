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

