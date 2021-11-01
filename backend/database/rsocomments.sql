CREATE TABLE rsocomments (
    cid BIGSERIAL NOT NULL PRIMARY KEY,
    eid BIGSERIAL NOT NULL REFERENCES revents(eid),
    username VARCHAR(20) NOT NULL,
    uid BIGSERIAL NOT NULL REFERENCES users(uid),
    description text,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);