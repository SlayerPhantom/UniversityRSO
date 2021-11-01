CREATE DATABASE mock;

create table eventtimes(
    timeid bigserial PRIMARY KEY,
    starttime time not null,
    location varchar(60) not null references event_locations(name),
    event_date date not null,
    unique key(starttime, location, event_date)
);

CREATE TABLE users(
    uid BIGSERIAL NOT NULL PRIMARY KEY,
    email VARCHAR(60) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE personal_info(
    uid BIGSERIAL NOT NULL,
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL,
    username VARCHAR(20) NOT NULL,
    userlevel INT NOT NULL DEFAULT 1,
    university VARCHAR(20) NOT NULL
);

CREATE TABLE event_locations(
    name VARCHAR(20) PRIMARY KEY,
    longitude FLOAT NOT NULL,
    latitude FLOAT NOT NULL
);

CREATE TABLE university(
    name varchar(20) PRIMARY KEY,
    address varchar(60),
    num_students int,
    super_admin bigserial references users(uid),
    description text
);

CREATE TABLE publicevents(
    eid BIGSERIAL NOT NULL PRIMARY KEY,
    location_name VARCHAR(60) NOT NULL REFERENCES event_locations(name),
    event_date date NOT NULL,
    name VARCHAR(60) NOT NULL,
    start_time TIME NOT NULL,
    description text,
    active boolean default FALSE,
    rating float default 0 check (rating <= 5 and rating >= 0),
    phone varchar(12),
    email varchar(30),
    category varchar(30)
);

CREATE TABLE publiccomments (
    cid BIGSERIAL NOT NULL PRIMARY KEY,
    eid BIGSERIAL NOT NULL REFERENCES publicevents(eid),
    username VARCHAR(20) NOT NULL,
    uid BIGSERIAL NOT NULL REFERENCES users(uid),
    description text,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE privateevents(
    eid BIGSERIAL NOT NULL PRIMARY KEY,
    location_name VARCHAR(60) NOT NULL REFERENCES event_locations(name),
    event_date date NOT NULL,
    name VARCHAR(60) NOT NULL,
    university varchar(20),
    start_time TIME NOT NULL,
    description text,
    active boolean default FALSE,
    rating float default 0 check (rating <= 5 and rating >= 0),
    phone varchar(12),
    email varchar(30),
    category varchar(30)
);

CREATE TABLE privatecomments (
    cid BIGSERIAL NOT NULL PRIMARY KEY,
    eid BIGSERIAL NOT NULL REFERENCES privateevents(eid),
    username VARCHAR(20) NOT NULL,
    uid BIGSERIAL NOT NULL REFERENCES users(uid),
    description text,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE rsos (
    rsoid BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    email VARCHAR(60) NOT NULL,
    description VARCHAR(255) NOT NULL,
    admin BIGSERIAL REFERENCES users(uid),
    active BOOLEAN NOT NULL DEFAULT FALSE
);

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

CREATE TABLE rsocomments (
    cid BIGSERIAL NOT NULL PRIMARY KEY,
    eid BIGSERIAL NOT NULL REFERENCES revents(eid),
    username VARCHAR(20) NOT NULL,
    uid BIGSERIAL NOT NULL REFERENCES users(uid),
    description text,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE rso_members(
    rsoid BIGSERIAL NOT NULL REFERENCES rsos(rsoid),
    uid BIGSERIAL NOT NULL REFERENCES users(uid),
    PRIMARY KEY(RSOid, uid)
);

CREATE OR REPLACE FUNCTION rso_active_update() RETURNS TRIGGER AS $rso_members$
BEGIN
    if ((SELECT COUNT(*) FROM rso_members where rsoid = new.rsoid) > 4) then
        update rsos set active = TRUE where rsos.rsoid = new.rsoid;
    end if;
    RETURN new;
END;
$rso_members$ LANGUAGE plpgsql;

CREATE TRIGGER update_rso AFTER INSERT on rso_members
FOR EACH ROW EXECUTE PROCEDURE rso_active_update();

CREATE OR REPLACE FUNCTION rso_inactive_update() RETURNS TRIGGER AS $rso_members$
BEGIN
    if ((SELECT COUNT(*) FROM rso_members where rsoid = old.rsoid) = 4) then
        update rsos set active = FALSE where rsos.rsoid = old.rsoid;
    end if;
    RETURN new;
END;
$rso_members$ LANGUAGE plpgsql;

CREATE TRIGGER update_inactivity_rso AFTER Delete on rso_members
FOR EACH ROW EXECUTE PROCEDURE rso_inactive_update();
