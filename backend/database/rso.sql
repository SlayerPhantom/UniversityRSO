CREATE TABLE rsos (
    rsoid BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    email VARCHAR(60) NOT NULL,
    description VARCHAR(255) NOT NULL,
    admin BIGSERIAL REFERENCES users(uid),
    active BOOLEAN NOT NULL DEFAULT FALSE
);


CREATE TABLE rsos (
    rsoid BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    email VARCHAR(60) NOT NULL,
    description VARCHAR(255) NOT NULL,
    admin BIGSERIAL REFERENCES users(uid),
    active int default 0
);

INSERT INTO rsos(rso_name, email, university, description, admin) values
('1st rso', 'rso1@email.com', 'UCF', '1st description', 1);