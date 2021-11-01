CREATE TABLE personal_info(
    uid BIGSERIAL NOT NULL,
    fname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL,
    username VARCHAR(20) NOT NULL,
    userlevel INT NOT NULL DEFAULT 1,
    university VARCHAR(20) NOT NULL
);