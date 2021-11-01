CREATE TABLE publicevents(
    eid BIGSERIAL NOT NULL PRIMARY KEY,
    location_name VARCHAR(60) NOT NULL REFERENCES event_locations(name),
    name VARCHAR(60) NOT NULL,
    description text,
    active boolean default FALSE,
    rating float default 0 check (rating <= 5 and rating >= 0),
    phone varchar(12),
    email varchar(30),
    category varchar(30)
);