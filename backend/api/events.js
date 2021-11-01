const db = require('../database');
const router = require('express').Router();
const axios = require('axios');

router.post('/createpublic', async (req, res) => {
	try {
		const {
			location_name,
			event_date,
			description,
			name,
			start_time,
			category,
			phone,
			email,
		} = req.body;

		const location = await db.query(
			'select * from event_locations where name = $1',
			[location_name]
		);
		if (location.rows.length == 0) {
			if (location_name == 'virtual') {
				await db.query(
					'insert into event_locations (name, latitude, longitude) values ($1, $2, $3)',
					[location_name, 0, 0]
				);
			} else {
				const result = await axios.get(
					`http://api.positionstack.com/v1/forward?access_key=b9a1bade57710bc837c4ef6bee604578&query=${location_name}`
				);

				const { latitude, longitude } = result.data.data[0];
				await db.query(
					'insert into event_locations (name, latitude, longitude) values ($1, $2, $3)',
					[location_name, latitude, longitude]
				);
			}
		}

		const time = await db.query(
			'insert into eventtimes(start_time, location_name, event_date) values ($1, $2, $3)',
			[start_time, location_name, event_date]
		);

		const event = await db.query(
			'insert into publicevents(name, description, phone, email, category, start_time, location_name, event_date) values ($1, $2, $3, $4, $5, $6, $7, $8) returning eid',
			[
				name,
				description,
				phone,
				email,
				category,
				start_time,
				location_name,
				event_date,
			]
		);

		return res.json({
			event: {
				start_time,
				event_date,
				description,
				eid: event.rows[0].eid,
				location_name,
				name,
			},
		});
	} catch (e) {
		console.log(e);
		return res.json({
			errors:
				'Time conflicts with another event. Select a different location or change time.',
		});
	}
});

router.post('/createprivate', async (req, res) => {
	try {
		const {
			location_name,
			event_date,
			description,
			name,
			start_time,
			category,
			phone,
			email,
			university,
		} = req.body;

		const location = await db.query(
			'select * from event_locations where name = $1',
			[location_name]
		);
		if (location.rows.length == 0) {
			if (location_name == 'virtual') {
				await db.query(
					'insert into event_locations (name, latitude, longitude) values ($1, $2, $3)',
					[location_name, 0, 0]
				);
			} else {
				const result = await axios.get(
					`http://api.positionstack.com/v1/forward?access_key=b9a1bade57710bc837c4ef6bee604578&query=${location_name}`
				);

				const { latitude, longitude } = result.data.data[0];
				await db.query(
					'insert into event_locations (name, latitude, longitude) values ($1, $2, $3)',
					[location_name, latitude, longitude]
				);
			}
		}

		const time = await db.query(
			'insert into eventtimes(start_time, location_name, event_date) values ($1, $2, $3)',
			[start_time, location_name, event_date]
		);

		const event = await db.query(
			'insert into privateevents(university, name, description, phone, email, category, start_time, location_name, event_date) values ($1, $2, $3, $4, $5, $6, $7, $8, $9) returning eid',
			[
				university,
				name,
				description,
				phone,
				email,
				category,
				start_time,
				location_name,
				event_date,
			]
		);

		return res.json({
			event: {
				start_time,
				event_date,
				description,
				eid: event.rows[0].eid,
				location_name,
				name,
				university,
			},
		});
	} catch (e) {
		console.log(e);
		return res.json({
			errors:
				'Time conflicts with another event. Select a different location or change time.',
		});
	}
});

router.post('/creatersoevent', async (req, res) => {
	try {
		const {
			location_name,
			event_date,
			description,
			name,
			start_time,
			category,
			phone,
			email,
			rsoid,
			uid,
		} = req.body;

		const location = await db.query(
			'select * from event_locations where name = $1',
			[location_name]
		);
		if (location.rows.length == 0 && location == 'virtual') {
			if (location_name == 'virtual') {
				await db.query(
					'insert into event_locations (name, latitude, longitude) values ($1, $2, $3)',
					[location_name, 0, 0]
				);
			} else {
				const result = await axios.get(
					`http://api.positionstack.com/v1/forward?access_key=b9a1bade57710bc837c4ef6bee604578&query=${location_name}`
				);

				const { latitude, longitude } = result.data.data[0];
				await db.query(
					'insert into event_locations (name, latitude, longitude) values ($1, $2, $3)',
					[location_name, latitude, longitude]
				);
			}
		}

		const rso = await db.query('select admin from rsos where rsoid = $1', [
			rsoid,
		]);
		if (uid != rso.rows[0].admin) {
			return res.json({ errors: 'you are not the admin of this rso' });
		}

		const time = await db.query(
			'insert into eventtimes(start_time, location_name, event_date) values ($1, $2, $3)',
			[start_time, location_name, event_date]
		);

		const event = await db.query(
			'insert into revents(rsoid, name, description, phone, email, category, start_time, location_name, event_date) values ($1, $2, $3, $4, $5, $6, $7, $8, $9) returning eid',
			[
				rsoid,
				name,
				description,
				phone,
				email,
				category,
				start_time,
				location_name,
				event_date,
			]
		);

		return res.json({
			event: {
				start_time,
				event_date,
				description,
				eid: event.rows[0].eid,
				location_name,
				name,
			},
		});
	} catch (e) {
		console.log(e);
		return res.json({
			errors:
				'Time conflicts with another event. Select a different location or change time.',
		});
	}
});

router.get('/public_events', async (req, res) => {
	try {
		const events = await db.query('select * from publicevents');
		return res.json({ events: events.rows });
	} catch (error) {
		console.log(error);
		return res.json({ errors: error });
	}
});

router.get('/private_events/:university', async (req, res) => {
	try {
		const events = await db.query(
			'select * from privateevents where university = $1',
			[req.params.university]
		);
		return res.json({ events: events.rows });
	} catch (error) {
		console.log(error);
		return res.json({ errors: error });
	}
});

router.get('/rso_events/:rsoid', async (req, res) => {
	try {
		const events = await db.query('select * from revents where rsoid = $1', [
			req.params.rsoid,
		]);
		return res.json({ events: events.rows });
	} catch (error) {
		return res.json({ errors: error });
	}
});

router.get('/allrso_events/:uid', async (req, res) => {
	try {
		const events = await db.query(
			'select * from revents inner join rso_members on revents.rsoid = rso_members.rsoid and rso_members.uid = $1',
			[req.params.uid]
		);

		return res.json({ events: events.rows });
	} catch (error) {
		console.log(error);
		return res.json({ errors: error });
	}
});

router.get('/public_event/:id', async (req, res) => {
	try {
		const eventinfo = await db.query(
			'select * from publicevents where eid = $1',
			[req.params.id]
		);
		const info = {
			description: eventinfo.rows[0].description,
			active: eventinfo.rows[0].active,
			rating: eventinfo.rows[0].rating,
			phone: eventinfo.rows[0].phone,
			email: eventinfo.rows[0].email,
			category: eventinfo.rows[0].category,
		};
		const event = {
			location_name: eventinfo.rows[0].location_name,
			event_date: eventinfo.rows[0].event_date,
			name: eventinfo.rows[0].name,
			start_time: eventinfo.rows[0].start_time,
		};
		const result2 = await db.query(
			'select longitude, latitude from event_locations where name = $1',
			[eventinfo.rows[0].location_name]
		);
		return res.json({
			event,
			coord: result2.rows[0],
			info,
		});
	} catch (error) {
		console.log(error);
		return res.json({ errors: error });
	}
});

router.get('/private_event/:id', async (req, res) => {
	try {
		const eventinfo = await db.query(
			'select * from privateevents where privateevents.eid = $1',
			[req.params.id]
		);
		const info = {
			description: eventinfo.rows[0].description,
			active: eventinfo.rows[0].active,
			rating: eventinfo.rows[0].rating,
			phone: eventinfo.rows[0].phone,
			email: eventinfo.rows[0].email,
			category: eventinfo.rows[0].category,
		};
		const event = {
			university: eventinfo.rows[0].university,
			location_name: eventinfo.rows[0].location_name,
			event_date: eventinfo.rows[0].event_date,
			name: eventinfo.rows[0].name,
			start_time: eventinfo.rows[0].start_time,
		};
		const result2 = await db.query(
			'select longitude, latitude from event_locations where name = $1',
			[eventinfo.rows[0].location_name]
		);
		return res.json({
			event,
			coord: result2.rows[0],
			info,
		});
	} catch (error) {
		console.log(error);
		return res.json({ errors: error });
	}
});
router.get('/revents/:id', async (req, res) => {
	try {
		const eventinfo = await db.query(
			'select * from revents where revents.eid = $1',
			[req.params.id]
		);
		const info = {
			description: eventinfo.rows[0].description,
			rating: eventinfo.rows[0].rating,
			phone: eventinfo.rows[0].phone,
			email: eventinfo.rows[0].email,
			category: eventinfo.rows[0].category,
		};
		const event = {
			rsoid: eventinfo.rows[0].rsoid,
			location_name: eventinfo.rows[0].location_name,
			event_date: eventinfo.rows[0].event_date,
			name: eventinfo.rows[0].name,
			start_time: eventinfo.rows[0].start_time,
		};
		const result2 = await db.query(
			'select longitude, latitude from event_locations where name = $1',
			[eventinfo.rows[0].location_name]
		);
		return res.json({
			event,
			coord: result2.rows[0],
			info,
		});
	} catch (error) {
		console.log(error);
		return res.json({ errors: error });
	}
});

router.post('/approvepublic', async (req, res) => {
	try {
		const { id } = req.body;
		const approve = await db.query(
			'update publicevents set active = TRUE where eid = $1',
			[id]
		);
		return res.json({ success: 'this event is now approved' });
	} catch (error) {
		res.json({ errors: error });
	}
});
router.post('/approveprivate', async (req, res) => {
	try {
		const { id } = req.body;
		const approve = await db.query(
			'update privateevents set active = TRUE where eid = $1',
			[id]
		);
		return res.json({ success: 'this event is now approved' });
	} catch (error) {
		res.json({ errors: error });
	}
});

router.get('/search/:search', async (req, res) => {
	try {
		const result = await db.query(
			'select * from publicevents where publicevents.location_name like $1',
			[`%${req.params.search}%`]
		);
		return res.json({ events: result.rows });
	} catch (error) {
		console.log(error);
		return res.json({ errors: error });
	}
});

router.post('/public_rating', async (req, res) => {
	try {
		const { id, rating } = req.body;
		const result = await db.query(
			'update publicevents set rating = $1 where eid = $2',
			[rating, id]
		);
		return res.json({ success: 'updated rating' });
	} catch (error) {
		return res.json({ errors: 'invalid rating' });
	}
});

router.post('/private_rating', async (req, res) => {
	try {
		const { id, rating } = req.body;
		const result = await db.query(
			'update privateevents set rating = $1 where eid = $2',
			[rating, id]
		);
		return res.json({ success: 'updated rating' });
	} catch (error) {
		return res.json({ errors: 'invalid rating' });
	}
});
router.post('/revent_rating', async (req, res) => {
	try {
		const { id, rating } = req.body;
		const result = await db.query(
			'update revents set rating = $1 where eid = $2',
			[rating, id]
		);
		return res.json({ success: 'updated rating' });
	} catch (error) {
		return res.json({ errors: 'invalid rating' });
	}
});

router.get('/location/:location', async (req, res) => {
	try {
		const location = await db.query(
			'select * from event_locations where name = $1',
			[req.params.location]
		);

		if (location.rows.length == 0) {
			const result = await axios.get(
				`http://api.positionstack.com/v1/forward?access_key=b9a1bade57710bc837c4ef6bee604578&query=${req.params.location}`
			);

			const { latitude, longitude } = result.data.data[0];
			const newlocation = await db.query(
				'insert into event_locations (name, latitude, longitude) values ($1, $2, $3)',
				[req.params.location, latitude, longitude]
			);
			return res.json({ lat: latitude, lng: longitude });
		} else {
			return res.json({
				lat: location.rows[0].latitude,
				lng: location.rows[0].longitude,
			});
		}
	} catch (error) {
		console.log(error);
		return res.json({ errors: 'unable to find location' });
	}
});

module.exports = router;
