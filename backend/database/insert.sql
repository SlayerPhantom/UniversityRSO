-- Dumping locations
insert into event_locations(name, latitude, longitude) values
('Gainesville, FL 32611', 29.6516, -82.3248),
('4000 Central Florida Blvd, Orlando, FL 32816', 28.6024274, -81.20005),
('12777 Gemini Blvd N. Orlando, Florida 32816.', 28.6081, -81.1969),
('virtual', 0, 0),
('4365 Andromeda Loop N, Orlando, FL 32816', 28.599085, -81.2022);

-- Dumping users
INSERT INTO users(email, password) values
('unravelphantom@gmail.com', '9029Gods'),
('ocularskills@gmail.com', 'somepassword'),
('ucfuser@knights.ucf.edu', 'ucfuser'),
('ufuser@uf.edu', 'ufuser'),
('slayerphantom@knights.ucf.edu', 'slayer'),
('hello@gmail.com', 'hello'),
('byebye@gmail.com', 'byebye'),
('enterhere@knights.ucf.edu', 'enter'),
('something@gmail.com', 'something'),
('another@knights.uf.edu', 'anotherone'),
('sunravelphantom@gmail.com', '9029Gods'),
('socularskills@gmail.com', 'somepassword'),
('sucfuser@knights.ucf.edu', 'ucfuser'),
('sufuser@uf.edu', 'ufuser'),
('sslayerphantom@knights.ucf.edu', 'slayer'),
('shello@gmail.com', 'hello'),
('sbyebye@gmail.com', 'byebye'),
('senterhere@knights.ucf.edu', 'enter'),
('ssomething@gmail.com', 'something'),
('sanother@knights.uf.edu', 'anotherone');

INSERT INTO personal_info(uid, fname, lname, username, userlevel, university) values
(1, 'John', 'Smith', 'unravelphantom', 3, 'UCF'),
(2, 'John', 'Doe', 'ocularskill', 3, 'UF'),
(3, 'Ben', 'Jammin', 'Benjammin', 1, 'UCF'),
(4, 'Tyler', 'Woods', 'Prof. Golf', 2, 'UCF'),
(5, 'Nice', 'Job', 'nicejob', 2, 'UF'),
(6, 'Alice', 'Watson', 'neverland', 2, 'UF'),
(7, 'Serious', 'Black', 'Wizard101', 1, 'UCF'),
(8, 'Brandon', 'Deng', 'Sorceror', 1, 'UCF'),
(9, 'Kevin', 'Leng', 'Magic', 1, 'UCF'),
(10, 'Harry', 'Potter', 'Wizard King', 2, 'UF'),
(11, 'John', 'Doe', 'ocularskill', 2, 'UF'),
(12, 'Ben', 'Jammin', 'Benjammin', 1, 'UCF'),
(13, 'Tyler', 'Woods', 'Prof. Golf', 2, 'UCF'),
(14, 'Nice', 'Job', 'nicejob', 2, 'UF'),
(15, 'Alice', 'Watson', 'neverland', 2, 'UF'),
(16, 'Serious', 'Black', 'Wizard101', 1, 'UCF'),
(17, 'Brandon', 'Deng', 'Sorceror', 1, 'UCF'),
(18, 'Kevin', 'Leng', 'Magic', 1, 'UCF'),
(19, 'Harry', 'Potter', 'Wizard King', 2, 'UF'),
(20, 'John', 'Smith', 'unravelphantom', 2, 'UCF');

-- Dumping university
insert into university values
('UCF', '4000 Central Florida Blvd, Orlando, FL 32816', 100, 1, 'you cant finish'),
('UF', 'Gainesville, FL 32611', 150, 2, 'you finished');

-- Dumping public events
insert into eventtimes(start_time, location_name, event_date) values
('11:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-09-22'),
('12:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-09-26'),
('13:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-09-26'),
('12:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-04-26'),
('13:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-04-26');
insert into publicevents(name, description, phone, email, category, start_time, location_name, event_date) values
('1 public', '1st public event', '111-111-1111', 'mail@email.com', 'Social', '11:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-09-22'),
('2 public', '2nd public event', '111-111-1111', 'somethingl@email.com', 'Social', '12:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-09-26'),
('3 public', '3rd public event', '111-111-1111', 'emhave@email.com', 'Social', '13:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-09-22'),
('5 public', '5th public event', '111-111-1111', 'somethingl@email.com', 'Social', '12:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-04-26'),
('4 public', '4th public event', '111-111-1111', 'emhave@email.com', 'Social', '13:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-04-26');

insert into eventtimes(start_time, location_name, event_date) values
('11:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-09-22');
insert into publicevents(name, description, phone, email, category, start_time, location_name, event_date) values
('1 public', '1st public event', '111-111-1111', 'mail@email.com', 'Social', '11:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-09-22');

-- Dumping private events
insert into eventtimes(start_time, location_name, event_date) values
('11:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-08-22'),
('12:00:00', 'virtual', '2001-08-26'),
('13:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-08-22');
insert into privateevents(university, name, description, phone, email, category, start_time, location_name, event_date) values
('UCF', '1 private', '1st private event', '111-111-1111', 'thingsl@email.com', 'Social', '11:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-08-22'),
('UF', '2 private', '2nd private event', '111-321-1111', 'yesl@email.com', 'Social', '12:00:00', 'virtual', '2001-08-26'),
('UCF', '3 private', '3rd private event', '111-143-1111', 'hello@email.com', 'Social', '13:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2001-08-22');

-- Dumping Rsos
insert into rsos(rso_name, email, university, description, admin, active) values
('1st rso', 'rso1@email.com', 'UCF', '1st description', 1, FALSE),
('2nd rso', 'rso2@email.com', 'UF', '2nd description', 2, FALSE),
('3rd rso', 'rso3@email.com', 'UCF', '3rd description', 3, FALSE);

-- Dumping Rso_members
insert into rso_members(rsoid, uid) values
(1, 1),
(1, 2),
(1, 12),
(1, 13),
(1, 4),
(2, 8),
(3, 7),
(2, 12),
(1, 14),
(1, 9);

-- Dumping RSO events
insert into eventtimes(start_time, location_name, event_date) values
('15:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2021-02-22'),
('16:00:00', 'virtual', '2031-03-26'),
('17:00:00', '4365 Andromeda Loop N, Orlando, FL 32816', '2051-08-26');
insert into revents(rsoid, name, description, phone, email, category, start_time, location_name, event_date) values
(1, '1 private', '1st rso event', '111-132-2111', 'email@email.com', 'Social','15:00:00', '4000 Central Florida Blvd, Orlando, FL 32816', '2021-02-22'),
(1, '2 private', '2nd rso event', '123-111-1221', 'email@email.com', 'Social','16:00:00', 'virtual', '2031-03-26'),
(2, '3 private', '3rd rso event', '111-121-1421', 'rso@email.com', 'Dinner Event','17:00:00', '4365 Andromeda Loop N, Orlando, FL 32816', '2051-08-26');


-- Dumping public comments
insert into publiccomments(eid, username, uid, description) values
(1, 'ocularskills', 2, '2nd comment'),
(1, 'Benjammin', 3, '3rd comment'),
(1, 'unravelphantom', 1, '1st comment');

-- Dumping private comments
insert into privatecomments(eid, username, uid, description) values
(1, 'ocularskills', 2, '2nd private comment'),
(2, 'Benjammin', 3, '3rd private comment'),
(3, 'unravelphantom', 1, '1s private comment');

-- Dumpting rso comments
insert into rsocomments(eid, username, uid, description) values
(1, 'ocularskills', 2, '2nd rso comment'),
(1, 'Benjammin', 3, '3rd rso comment'),
(1, 'unravelphantom', 1, '1st rso comment');

-- Example update public comment
update publiccomments set description = 'updated public comment' where cid = 1;

-- Example update private comment
update privatecomments set description = 'updated private comment' where cid = 1;

-- Example update RSO comment
update rsocomments set description = 'updated RSO comment' where cid = 1;

-- Retrieving public events
SELECT * FROM publicevents;

-- Retrieving private events affiliated with UCF
SELECT * FROM privateevents WHERE university = 'UCF';

-- Retrieving events that belong to the rso with rsoid = 1
SELECT * FROM revents where rsoid = 1;

-- Retrieving public comments from public event with eid = 1
SELECT * from publiccomments where eid = 1;
-- Retrieving private comments from private event with eid = 1
SELECT * from privatecomments where eid = 1;
-- Retrieving rso comments from RSO event with eid = 1
SELECT * from rsocomments where eid = 1;