-- Remove conflicting tables
DROP TABLE IF EXISTS european_countries_by_area CASCADE;
DROP TABLE IF EXISTS target_airlines CASCADE;
DROP TABLE IF EXISTS target_airports CASCADE;
DROP TABLE IF EXISTS target_countries CASCADE;
DROP TABLE IF EXISTS target_routes CASCADE;
-- End of removing

-- Warning: Missing primary key. It is recommended to explicitly define a primary key.
CREATE TABLE european_countries_by_area (
    -- Primary key was automatically generated because it is needed by some foreign key.
                                            id_european_countries_by_area SERIAL NOT NULL,
                                            total VARCHAR(256) NOT NULL,
                                            country_or_dependency VARCHAR(256) NOT NULL,
                                            europe_area_km2 DOUBLE PRECISION NOT NULL,
                                            europe_area_mi2 DOUBLE PRECISION NOT NULL
);
ALTER TABLE european_countries_by_area ADD CONSTRAINT pk_european_countries_by_area PRIMARY KEY (id_european_countries_by_area);

CREATE TABLE target_airlines (
                                 id SERIAL NOT NULL,
                                 target_countries_id INTEGER,
                                 active BOOLEAN NOT NULL,
                                 airline_code_iata VARCHAR(256) NOT NULL,
                                 airline_code_icao VARCHAR(256) NOT NULL,
                                 alias VARCHAR(256) NOT NULL,
                                 callsign VARCHAR(256) NOT NULL,
                                 country_of_origin VARCHAR(256) NOT NULL,
                                 name VARCHAR(256) NOT NULL
);
ALTER TABLE target_airlines ADD CONSTRAINT pk_target_airlines PRIMARY KEY (id);

CREATE TABLE target_airports (
                                 id SERIAL NOT NULL,
                                 target_countries_id INTEGER,
                                 country VARCHAR(256) NOT NULL,
                                 elevation_ft INTEGER NOT NULL,
                                 gmt_time_dif INTEGER NOT NULL,
                                 iata_code VARCHAR(256) NOT NULL,
                                 icao_code VARCHAR(256) NOT NULL,
                                 latitude DOUBLE PRECISION NOT NULL,
                                 longtitude DOUBLE PRECISION NOT NULL,
                                 municipality VARCHAR(256) NOT NULL,
                                 name VARCHAR(256) NOT NULL,
                                 timezone___ VARCHAR(256) NOT NULL,
                                 uenaso___ VARCHAR(256) NOT NULL,
                                 airport_route_count VARCHAR(256) NOT NULL
);
ALTER TABLE target_airports ADD CONSTRAINT pk_target_airports PRIMARY KEY (id);

CREATE TABLE target_countries (
                                  id SERIAL NOT NULL,
                                  id_european_countries_by_area INTEGER,
                                  airport_density DOUBLE PRECISION NOT NULL,
                                  area DOUBLE PRECISION NOT NULL,
                                  code VARCHAR(256) NOT NULL,
                                  continent VARCHAR(256) NOT NULL,
                                  keywords VARCHAR(256) NOT NULL,
                                  name VARCHAR(256) NOT NULL,
                                  route_density DOUBLE PRECISION NOT NULL,
                                  wikipedia_link VARCHAR(256) NOT NULL
);
ALTER TABLE target_countries ADD CONSTRAINT pk_target_countries PRIMARY KEY (id);
ALTER TABLE target_countries ADD CONSTRAINT u_fk_target_countries_european_ UNIQUE (id_european_countries_by_area);

CREATE TABLE target_routes (
                               tech_key SERIAL NOT NULL,
                               id INTEGER,
                               target_airports_id INTEGER,
                               airine_code VARCHAR(256) NOT NULL,
                               airline_id INTEGER NOT NULL,
                               codeshare VARCHAR(256) NOT NULL,
                               dest_lat DOUBLE PRECISION NOT NULL,
                               dest_long DOUBLE PRECISION NOT NULL,
                               dest_name VARCHAR(256) NOT NULL,
                               dest_airport VARCHAR(256) NOT NULL,
                               dest_airport_id INTEGER NOT NULL,
                               no_stops INTEGER NOT NULL,
                               plane VARCHAR(256) NOT NULL,
                               route_length DOUBLE PRECISION NOT NULL,
                               source_airport VARCHAR(256) NOT NULL,
                               source_airport_id INTEGER NOT NULL,
                               src_lat DOUBLE PRECISION NOT NULL,
                               src_long DOUBLE PRECISION NOT NULL,
                               src_name VARCHAR(256) NOT NULL
);
ALTER TABLE target_routes ADD CONSTRAINT pk_target_routes PRIMARY KEY (tech_key);

ALTER TABLE target_airlines ADD CONSTRAINT fk_target_airlines_target_count FOREIGN KEY (target_countries_id) REFERENCES target_countries (id) ON DELETE CASCADE;

ALTER TABLE target_airports ADD CONSTRAINT fk_target_airports_target_count FOREIGN KEY (target_countries_id) REFERENCES target_countries (id) ON DELETE CASCADE;

ALTER TABLE target_countries ADD CONSTRAINT fk_target_countries_european_co FOREIGN KEY (id_european_countries_by_area) REFERENCES european_countries_by_area (id_european_countries_by_area) ON DELETE CASCADE;

ALTER TABLE target_routes ADD CONSTRAINT fk_target_routes_target_airport FOREIGN KEY (id) REFERENCES target_airports (id) ON DELETE CASCADE;
ALTER TABLE target_routes ADD CONSTRAINT fk_target_routes_target_airpo_1 FOREIGN KEY (target_airports_id) REFERENCES target_airports (id) ON DELETE CASCADE;