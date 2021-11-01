CREATE TABLE privatecomments (
    cid BIGSERIAL NOT NULL PRIMARY KEY,
    eid BIGSERIAL NOT NULL REFERENCES privateevents(eid),
    username VARCHAR(20) NOT NULL,
    uid BIGSERIAL NOT NULL REFERENCES users(uid),
    description text,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);