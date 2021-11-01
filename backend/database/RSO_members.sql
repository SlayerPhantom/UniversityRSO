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
