create table revents(
    eid BIGSERIAL NOT NULL PRIMARY KEY,
    rsoid bigserial not null references rsos(rsoid),
    location_name VARCHAR(60) NOT NULL REFERENCES event_locations(name),
    event_date date NOT NULL,
    name VARCHAR(60) NOT NULL,
    start_time TIME NOT NULL,
    description text,
    rating float default 0 check (rating <= 5 and rating >= 0),
    phone varchar(12),
    email varchar(30),
    category varchar(30)
);