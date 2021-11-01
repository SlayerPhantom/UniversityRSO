const db = require('../database');
const router = require('express').Router();

router.post('/create_rso', async (req, res) => {
	try {
		const { name, email, description, admin, university } = req.body;
		const results = await db.query(
			`INSERT INTO rsos(rso_name, email, description, admin, university) VALUES($1, $2, $3, $4, $5) RETURNING rsoid`,
			[name, email, description, admin, university]
		);
		const results2 = await db.query(
			`INSERT INTO rso_members(rsoid, uid) VALUES($1, $2)`,
			[results.rows[0].rsoid, admin]
		);
		const user = await db.query(
			'select userlevel from personal_info where uid = $1',
			[admin]
		);
		if (user.rows[0].userlevel == 1) {
			const result3 = await db.query(
				`UPDATE personal_info set userlevel = 2 WHERE uid = $1`,
				[admin]
			);
		}
		const result4 = await db.query('select * from rsos where rsoid = $1', [
			results.rows[0].rsoid,
		]);
		return res.json({ rso: result4.rows[0] });
	} catch (err) {
		return res.json({ errors: err });
	}
});

router.post('/addmember', async (req, res) => {
	try {
		const { rsoid, id } = req.body;
		const result = await db.query(
			`INSERT INTO rso_members(rsoid, uid) VALUES($1, $2)`,
			[rsoid, id]
		);
		return res.json({ success: 'successfully added member' });
	} catch (err) {
		return res.json({ errors: err });
	}
});

router.post('/removemember', async (req, res) => {
	try {
		const { rsoid, id } = req.body;
		const result = await db.query(
			`DELETE FROM rso_members WHERE (rsoid = $1 AND uid = $2)`,
			[rsoid, id]
		);
		return res.json({ success: 'successfully removed member' });
	} catch (err) {
		return res.json({ errors: err });
	}
});

router.post('/getmember', async (req, res) => {
	try {
		const { uid, rsoid } = req.body;
		const result = await db.query(
			'select * from rso_members where uid = $1 and rsoid = $2',
			[uid, rsoid]
		);
		if (result.rows.length == 0) return res.json({ ismember: false });
		else return res.json({ ismember: true });
	} catch (error) {
		return res.json({ errors: error });
	}
});

router.post('/getrsos', async (req, res) => {
	try {
		const { id } = req.body;
		const result = await db.query(
			'select rsos.rsoid, rso_name, email, description, admin, active, university from rsos, rso_members where rsos.rsoid = rso_members.rsoid and rso_members.uid = $1;',
			[id]
		);
		return res.json({ rsos: result.rows });
	} catch (error) {
		return res.json({ errors: error });
	}
});

router.get('/getrso/:id', async (req, res) => {
	try {
		const result = await db.query('select * from rsos where rsoid = $1', [
			req.params.id,
		]);
		return res.json({ rso: result.rows[0] });
	} catch (error) {
		return res.json({ errors: 'cannot retrieve rsos' });
	}
});

router.post('/search', async (req, res) => {
	try {
		const { name, university } = req.body;
		const result = await db.query(
			'select * from rsos where rso_name like $1 and university = $2',
			[`%${name}%`, university]
		);
		return res.json({ groups: result.rows });
	} catch (error) {
		return res.json({ errors: error });
	}
});

module.exports = router;
