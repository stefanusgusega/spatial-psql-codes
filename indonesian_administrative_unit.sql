CREATE TABLE Province (
    prov_id INTEGER,
    prov_name VARCHAR(30),
    geometry REGION,
    PRIMARY KEY (prov_id)
)

CREATE TABLE Kabupaten (
    kab_id INTEGER,
    kab_name VARCHAR(30),
    prov_id INTEGER,
    geometry REGION,
    PRIMARY KEY (kab_id),
    FOREIGN KEY (prov_id) REFERENCES Province
)

CREATE TABLE Kecamatan (
    kec_id INTEGER,
    kec_name VARCHAR(30),
    population INTEGER,
    kab_id INTEGER,
    geometry REGION,
    PRIMARY KEY (kec_id),
    FOREIGN KEY (kab_id) REFERENCES Kabupaten
)

SELECT population
FROM Kabupaten, Kecamatan
WHERE Kabupaten.kab_id = Kecamatan.kab_id
AND Kabupaten.kab_name = 'Bandung'
AND Kecamatan.kec_name = 'Soreang'

SELECT kec_name
FROM Kabupaten, Kecamatan
WHERE Kabupaten.kab_id = Kecamatan.kab_id
AND Kabupaten.kab_name = 'Bandung'

SELECT SUM(population)
FROM Kecamatan kec
INNER JOIN Kabupaten kab ON kec.kab_id = kab.kab_id
INNER JOIN Province prov ON kab.prov_id = prov.prov_id
WHERE prov.prov_name = 'Jawa Barat'

SELECT kec1.kec_name
FROM Kecamatan kec1, Kecamatan kec2, Kabupaten kab
WHERE kab.kab_id = kec1.kab_id
AND kab.kab_id = kec2.kab_id
AND kec1.kab_id = kec2.kab_id
AND kab.kab_name = 'Bandung'
AND kec2.kec_name = 'Soreang'
AND Meets(kec1.geometry, kec2.geometry)

SELECT geometry
FROM Kabupaten
WHERE Kabupaten.kab_name = 'Bandung'

SELECT kec.*
FROM Kecamatan kec 
WHERE Area(kec.geometry) > (
    SELECT MAX(Area(kec1.geometry))
    FROM Kecamatan kec1
    INNER JOIN Kabupaten kab ON kec1.kab_id = kab.kab_id
    WHERE kab.kab_name = 'Bandung'
)

SELECT kec_name
FROM Kecamatan
WHERE PointInRegion(geometry, @point)

SELECT kec_name, geometry
FROM Kecamatan
WHERE OverlapsRect(geometry, @rectangle)

SELECT Clipping(geometry, @rectangle)
FROM Kecamatan