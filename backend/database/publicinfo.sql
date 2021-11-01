create table publicinfo(
    eid bigserial references publicevents(eid),
    description text,
    active boolean default FALSE,
    rating float default 0 check (rating <= 5 and rating >= 0),
    phone varchar(12),
    email varchar(30),
    category varchar(30)
);