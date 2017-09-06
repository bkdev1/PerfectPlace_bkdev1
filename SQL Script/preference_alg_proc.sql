--Procedure Name: sp_preference
--Procedure For: Preference based search
--Date: 02-08-2017
--Author: Bharath


-- Input:     very_near_distance_to_city = Very Near
--            very_high_moreshops = Very High
--            very_high_health_services = Very High
--            low_accident_rate = Low
--            very_high_more_agedcare = Very High
--            very_less_time_to_hospital = Very Less
--            low_crime_rate = Low
--            top_country_of_birth = Selected Country Name

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
--           accident_count
--           accident_count_rate
--           offence_count
--           crime_rate
--           crime_offence_count ,
--                 crime_against_person_rate ,
--                 burglary_offence_count ,
--                 burglary_rate ,
--                 theft_offence_count ,
--                 theft_rate,
--                 house_median_quartile,
--                 house_median_quartile_string,
--                 unit_median_quartile,
--                 unit_median_quartile_string


ALTER PROCEDURE sp_preference (@very_near_distance_to_city nvarchar(127),

                               @very_high_moreshops nvarchar(127),
                               @very_high_health_services nvarchar(127),
                               @low_accident_rate nvarchar(127),
                               @very_high_more_agedcare nvarchar(127),
                               @very_less_time_to_hospital nvarchar(127),
                               @low_crime_rate nvarchar(127),
                               @top_country_of_birth nvarchar(127))


AS
BEGIN
  DECLARE @v_suburb INTEGER
  SET @v_suburb = 2


    if @v_suburb < (select count(suburb_id) from rating_it2
        where  distance_to_city_rate = ISNULL(@very_near_distance_to_city, distance_to_city_rate)
        and commercial_rate =   ISNULL(@very_high_moreshops, commercial_rate)
        and health_services = ISNULL(@very_high_health_services, health_services)
        and accident_count_rate = ISNULL(@low_accident_rate, accident_count_rate)
        and aged_care_rate = ISNULL(@very_high_more_agedcare, aged_care_rate)
        and time_to_hospital = ISNULL(@very_less_time_to_hospital, time_to_hospital)
        and crime_rate = ISNULL(@low_crime_rate, crime_rate)
        and (top_country_of_birth_1  = ISNULL(@top_country_of_birth, top_country_of_birth_1)
           or top_country_of_birth_2 = ISNULL(@top_country_of_birth, top_country_of_birth_2)
           or top_country_of_birth_3 = ISNULL(@top_country_of_birth, top_country_of_birth_3)
           or top_country_of_birth_4 = ISNULL(@top_country_of_birth, top_country_of_birth_4)
           or top_country_of_birth_5 = ISNULL(@top_country_of_birth, top_country_of_birth_5)))


      (SELECT
         suburb_id,
         suburb_id,
         suburb,
         distance_to_city_rate,
         distance_to_city,
         residential_rate,
         residential_percent,
         commercial_rate,
         commercial_percent,
         health_services,
         nearest_public_hospital,
         disability_care_rate,
         disability_care,
         aged_care_rate,
         aged_care,
         time_to_hospital,
         population_density,
         top_country_of_birth_1,
         top_country_of_birth_2,
         top_country_of_birth_3,
         top_country_of_birth_4,
         top_country_of_birth_5,
         top_language_spoken_1,
         top_language_spoken_2,
         top_language_spoken_3,
         top_language_spoken_4,
         top_language_spoken_5,
         accident_count,
         accident_count_rate,
         offence_count,
         crime_rate,
         crime_offence_count,
         crime_against_person_rate,
         burglary_offence_count,
         burglary_rate,
         theft_offence_count,
         theft_rate,
         house_median_quartile,
         house_median_quartile_string,
         unit_median_quartile,
         unit_median_quartile_string

       FROM rating_it2
       WHERE distance_to_city_rate = ISNULL(@very_near_distance_to_city, distance_to_city_rate)
             AND commercial_rate = ISNULL(@very_high_moreshops, commercial_rate)
             AND health_services = ISNULL(@very_high_health_services, health_services)
             AND accident_count_rate = ISNULL(@low_accident_rate, accident_count_rate)
             AND aged_care_rate = ISNULL(@very_high_more_agedcare, aged_care_rate)
             AND time_to_hospital = ISNULL(@very_less_time_to_hospital, time_to_hospital)
             AND crime_rate = ISNULL(@low_crime_rate, crime_rate)
             AND (top_country_of_birth_1 = ISNULL(@top_country_of_birth, top_country_of_birth_1)
                  OR top_country_of_birth_2 = ISNULL(@top_country_of_birth, top_country_of_birth_2)
                  OR top_country_of_birth_3 = ISNULL(@top_country_of_birth, top_country_of_birth_3)
                  OR top_country_of_birth_4 = ISNULL(@top_country_of_birth, top_country_of_birth_4))
       ORDER BY 1)

      --If the outcome is less than count =2, it would add more parameter value to increase the outcome

      if @v_suburb < (select count(suburb_id) from rating_it2
            where distance_to_city_rate in (ISNULL(@very_near_distance_to_city, distance_to_city_rate), 'Near')
              and commercial_rate in   (ISNULL(@very_high_moreshops,commercial_rate),'High')
              and health_services in (ISNULL(@very_high_health_services, health_services),'High')
              and accident_count_rate in (ISNULL(@low_accident_rate, accident_count_rate),'Moderate')
              and aged_care_rate in (ISNULL(@very_high_more_agedcare, aged_care_rate),'High')
              and time_to_hospital in (ISNULL(@very_less_time_to_hospital, time_to_hospital),'Less')
              and crime_rate in (ISNULL(@low_crime_rate, crime_rate), 'Moderate')
              and (top_country_of_birth_1  = ISNULL(@top_country_of_birth, top_country_of_birth_1)
               or top_country_of_birth_2 = ISNULL(@top_country_of_birth, top_country_of_birth_2)
               or top_country_of_birth_3 = ISNULL(@top_country_of_birth, top_country_of_birth_3)
               or top_country_of_birth_4 = ISNULL(@top_country_of_birth, top_country_of_birth_4)
               or top_country_of_birth_5 = ISNULL(@top_country_of_birth, top_country_of_birth_5)))



      (select suburb_id,
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
              theft_rate,
              house_median_quartile,
              house_median_quartile_string,
              unit_median_quartile,
              unit_median_quartile_string

      from rating_it2
        where distance_to_city_rate in (ISNULL(@very_near_distance_to_city, distance_to_city_rate), 'Near')
        and commercial_rate in   (ISNULL(@very_high_moreshops,commercial_rate),'High')
        and health_services in (ISNULL(@very_high_health_services, health_services),'High')
        and accident_count_rate in (ISNULL(@low_accident_rate, accident_count_rate),'Moderate')
        and aged_care_rate in (ISNULL(@very_high_more_agedcare, aged_care_rate),'High')
        and time_to_hospital in (ISNULL(@very_less_time_to_hospital, time_to_hospital),'Less')
        and crime_rate in (ISNULL(@low_crime_rate, crime_rate), 'Moderate')
        and (top_country_of_birth_1  = ISNULL(@top_country_of_birth, top_country_of_birth_1)
           or top_country_of_birth_2 = ISNULL(@top_country_of_birth, top_country_of_birth_2)
           or top_country_of_birth_3 = ISNULL(@top_country_of_birth, top_country_of_birth_3)
           or top_country_of_birth_4 = ISNULL(@top_country_of_birth, top_country_of_birth_4)
           or top_country_of_birth_5 = ISNULL(@top_country_of_birth, top_country_of_birth_5)))
--        ORDER BY
--                   CASE WHEN @very_near_distance_to_city IS NOT NULL THEN distance_to_city END,
--                   CASE WHEN @very_high_moreshops IS NOT NULL THEN commercial_percent END DESC,
--                   CASE WHEN @very_high_health_services IS NOT NULL THEN health_services END,
--                   CASE WHEN @low_accident_rate IS NOT NULL THEN accident_count END,
--                   CASE WHEN @very_high_more_agedcare IS NOT NULL THEN aged_care END DESC,
--                   CASE WHEN @very_less_time_to_hospital IS NOT NULL THEN time_to_hospital END,
--                   CASE WHEN @low_crime_rate IS NOT NULL THEN offence_count END)



    ELSE

      (select suburb_id,
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
              theft_rate,
              house_median_quartile,
              house_median_quartile_string,
              unit_median_quartile,
              unit_median_quartile_string

      from rating_it2
        where distance_to_city_rate in (ISNULL(@very_near_distance_to_city, distance_to_city_rate), 'Near','Far')
        and commercial_rate in   (ISNULL(@very_high_moreshops,commercial_rate),'High','Moderate')
        and health_services in (ISNULL(@very_high_health_services, health_services),'High','Moderate')
        and accident_count_rate in (ISNULL(@low_accident_rate, accident_count_rate),'Moderate', 'High')
        and aged_care_rate in (ISNULL(@very_high_more_agedcare, aged_care_rate),'High','Moderate')
        and time_to_hospital in (ISNULL(@very_less_time_to_hospital, time_to_hospital),'Less','Moderate')
        and crime_rate in (ISNULL(@low_crime_rate, crime_rate), 'Moderate','High')
        and (top_country_of_birth_1  = ISNULL(@top_country_of_birth, top_country_of_birth_1)
           or top_country_of_birth_2 = ISNULL(@top_country_of_birth, top_country_of_birth_2)
           or top_country_of_birth_3 = ISNULL(@top_country_of_birth, top_country_of_birth_3)
           or top_country_of_birth_4 = ISNULL(@top_country_of_birth, top_country_of_birth_4)
           or top_country_of_birth_5 = ISNULL(@top_country_of_birth, top_country_of_birth_5)))

--         ORDER BY
--                   CASE WHEN @very_near_distance_to_city IS NOT NULL THEN distance_to_city END,
--                   CASE WHEN @very_high_moreshops IS NOT NULL THEN commercial_percent END DESC,
--                   CASE WHEN @very_high_health_services IS NOT NULL THEN health_services END,
--                   CASE WHEN @low_accident_rate IS NOT NULL THEN accident_count END,
--                   CASE WHEN @very_high_more_agedcare IS NOT NULL THEN aged_care END DESC,
--                   CASE WHEN @very_less_time_to_hospital IS NOT NULL THEN time_to_hospital END,
--                   CASE WHEN @low_crime_rate IS NOT NULL THEN offence_count END)



END


-- EXECUTE sp_preference NULL, NULL, NULL,NULL, NULL, NULL, NULL, NULL;



