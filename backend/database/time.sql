create table eventtimes(
     timeid bigserial not null primary key,
     starttime time not null,
     location varchar(60) not null references event_locations(name),
     event_date date not null,
     unique(starttime, location, event_date)
);