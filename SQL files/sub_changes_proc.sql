--Procedure Name: sp_changes
--Procedure For: suburb changes
--Date: 03-08-2017
--Author: Bharath


-- Input:     lifestyle = sea change

-- Output:   suburb_id
--           suburb
--           distance_to_city,
--           distance_to_city_rate,
--           commercial_rate,
--           commercial_rate,
--           residential_rate,
--           residential_percent,
--           population_density,
--           health_services,
--           accident_count_rate,
--           aged_care,
--           aged_care_rate,
--           time_to_hospital,
--           crime_rate,
--           top_country_of_birth_1,
--           top_country_of_birth_2,
--           top_country_of_birth_3,
--           top_country_of_birth_4,
--           top_country_of_birth_5,
--           top_language_spoken_1,
--           top_language_spoken_2,
--           top_language_spoken_3,
--           top_language_spoken_4,
--           top_language_spoken_5,
--           nearest_public_hospital


ALTER PROCEDURE sp_changes (@lifestyle nvarchar(127))


AS
BEGIN
       select suburb_id,
              suburb ,
              distance_to_city_rate ,
              distance_to_city ,
              residential_rate ,
              residential_percent ,
              commercial_rate ,
              commercial_percent ,
              health_services ,
              nearest_public_hospital ,
              disability_care_rate ,
              disability_care ,
              aged_care_rate ,
              aged_care ,
              time_to_hospital ,
              population_density ,
              top_country_of_birth_1 ,
              top_country_of_birth_2 ,
              top_country_of_birth_3 ,
              top_country_of_birth_4 ,
              top_country_of_birth_5 ,
              top_language_spoken_1 ,
              top_language_spoken_2 ,
              top_language_spoken_3 ,
              top_language_spoken_4 ,
              top_language_spoken_5 ,
              accident_count ,
              accident_count_rate ,
              offence_count ,
              crime_rate ,
              crime_offence_count ,
              crime_against_person_rate ,
              burglary_offence_count ,
              burglary_rate ,
              theft_offence_count ,
              theft_rate

      from rating_it2
        where  life_style = ISNULL(@lifestyle, life_style)



END


EXECUTE sp_changes 'city change';






