
SELECT name FROM sys.key_constraints;

ALTER TABLE suburb_info DROP CONSTRAINT PK_suburb_info;


EXEC sp_rename 'suburb_info.sno', 'suburb_id', 'COLUMN';


ALTER TABLE suburb_info ADD CONSTRAINT PK_suburb_info PRIMARY KEY  (suburb_id);


select suburb_id from suburb_info;



ALTER TABLE suburb_info ALTER COLUMN suburb_id int NOT NULL;


