create table rinfo(
    eid bigserial references revents(eid),
    description text,
    rating float default 0 check (rating <= 5 and rating >= 0),
    phone varchar(12),
    email varchar(30),
    category varchar(30)
);