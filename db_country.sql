-- Selezionare tutte le nazioni il cui nome inizia con la P e la cui area è maggiore di 1000 kmq
SELECT c.name 
FROM countries c 
WHERE name LIKE 'P%' 
AND c.area > 1000;
-- Selezionare le nazioni il cui national day è avvenuto più di 100 anni fa
SELECT c.name 
FROM countries c 
WHERE TIMESTAMPDIFF(YEAR, c.national_day, CURDATE()) >= 100;
-- Selezionare il nome delle regioni del continente europeo, in ordine alfabetico
SELECT r.name 
FROM regions r 
INNER JOIN continents c 
ON r.continent_id = c.continent_id  
WHERE r.continent_id = 4
ORDER BY c.name;
-- Contare quante lingue sono parlate in Italia V1
SELECT COUNT(cl.language_id) as 'Lingue parlate'
FROM country_languages cl
WHERE country_id = 107;
-- Contare quante lingue sono parlate in Italia V2
SELECT COUNT(l.language_id) as 'Numero lingue parlate'
FROM languages l 
INNER JOIN country_languages cl 
ON cl.language_id = l.language_id 
INNER JOIN countries c 
ON c.country_id = cl.country_id 
WHERE c.name = 'Italy';
-- Selezionare quali nazioni non hanno un national day
SELECT c.name
FROM countries c
WHERE c.national_day IS NULL 
-- Per ogni nazione selezionare il nome, la regione e il continente 
SELECT c.name, r.name, c2.name  
FROM countries c
INNER JOIN regions r 
ON r.region_id = c.region_id 
INNER JOIN continents c2 
ON c2.continent_id = r.continent_id;
-- Modificare la nazione Italy, inserendo come national day il 2 giugno 1946
UPDATE countries c SET c.national_day = "1946-06-02" WHERE c.name = 'Italy';
-- Per ogni regione mostrare il valore dell'area totale
SELECT r.name as 'Nome_regione', SUM(c.area) as 'Area_totale' 
FROM regions r 
INNER JOIN countries c 
ON r.region_id = c.region_id 
GROUP BY r.name 
ORDER BY Area_totale DESC;
-- Selezionare le lingue ufficiali dell'Albania
SELECT l.`language`  
FROM countries c
INNER JOIN country_languages cl 
ON cl.country_id  = c.country_id  
INNER JOIN languages l 
ON l.language_id  = cl.language_id  
WHERE cl.official is true AND c.name LIKE 'Albania';
-- Selezionare il Gross domestic product (GDP) medio dello United Kingdom tra il 2000 e il 2010
SELECT avg(cs.gdp) AS Media_GDP 
FROM country_stats cs
INNER JOIN countries c
ON c.country_id = cs.country_id 
WHERE c.name LIKE 'United Kingdom' AND cs.`year` >= 2000 AND cs.`year` <= 2010
-- Selezionare tutte le nazioni in cui si parla hindi, ordinate dalla più estesa alla meno estesa
SELECT c.name as 'Paesi_in_cui_si_parla_Hindi'
FROM countries c
INNER JOIN country_languages cl 
ON cl.country_id = c.country_id 
INNER JOIN languages l 
ON l.language_id = cl.language_id 
WHERE l.`language` LIKE 'Hindi'
-- Per ogni continente, selezionare il numero di nazioni con area superiore ai 10.000 kmq ordinando i risultati a partire dal continente che ne ha di più
SELECT con.name, COUNT(c2.country_id) as 'Nazioni_con_area_superiore_a_10000'
FROM continents con
INNER JOIN regions r 
ON r.continent_id  = con.continent_id  
INNER JOIN countries c2 
ON c2.region_id  = r.region_id 
WHERE c2.area > 10000
GROUP BY con.name 
ORDER BY Nazioni_con_area_superiore_a_10000 DESC;