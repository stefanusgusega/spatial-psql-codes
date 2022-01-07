CREATE TABLE Land_Use (
    Region_Name VARCHAR(50),
    Land_Use_Type VARCHAR(50),
    Geometry REGION,
    PRIMARY KEY (Region_Name)
)

SELECT Intersection(k.geometry, l.geometry)
FROM Land_Use l, Kecamatan k
WHERE k.kec_name = 'Soreang'
AND l.land_use_type = 'residential area'
AND Overlaps(k.geometry, l.geometry)

SELECT k.geometry, l.geometry
FROM Land_Use l, Kecamatan k