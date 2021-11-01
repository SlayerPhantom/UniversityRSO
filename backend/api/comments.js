const db = require('../database');
const router = require('express').Router();

router.post('/addpublic', async (req, res) => {
	try {
		const { eid, uid, username, description } = req.body;

		const result = await db.query(
			`INSERT INTO publiccomments (eid, uid, username, description) VALUES ($1, $2, $3, $4) RETURNING cid`,
			[eid, uid, username, description]
		);
		const cid = result.rows[0].cid;
		const result2 = await db.query(
			'select * from publiccomments where cid = $1',
			[cid]
		);
		if (cid) {
			return res.json({ comment: result2.rows[0] });
		} else return res.json({ errors: 'unable to add event' });
	} catch (err) {
		return res.json({ errors: err });
	}
});
router.post('/addprivate', async (req, res) => {
	try {
		const { eid, uid, username, description } = req.body;

		const result = await db.query(
			`INSERT INTO privatecomments (eid, uid, username, description) VALUES ($1, $2, $3, $4) RETURNING cid`,
			[eid, uid, username, description]
		);
		const cid = result.rows[0].cid;
		const result2 = await db.query(
			'select * from privatecomments where cid = $1',
			[cid]
		);
		if (cid) {
			return res.json({ comment: result2.rows[0] });
		} else return res.json({ errors: 'unable to add event' });
	} catch (err) {
		return res.json({ errors: err });
	}
});
router.post('/addrso', async (req, res) => {
	try {
		const { eid, uid, username, description } = req.body;

		const result = await db.query(
			`INSERT INTO rsocomments (eid, uid, username, description) VALUES ($1, $2, $3, $4) RETURNING cid`,
			[eid, uid, username, description]
		);
		const cid = result.rows[0].cid;
		const result2 = await db.query('select * from rsocomments where cid = $1', [
			cid,
		]);
		if (cid) {
			return res.json({ comment: result2.rows[0] });
		} else return res.json({ errors: 'unable to add event' });
	} catch (err) {
		return res.json({ errors: err });
	}
});

router.post('/updatepublic', async (req, res) => {
	try {
		const { cid, description } = req.body;
		console.log(new Date().getTime());
		const result = await db.query(
			`UPDATE publiccomments set description = '${description}' WHERE cid = ${cid}`
		);
		return res.json({ success: 'successfully updated comment' });
	} catch (err) {
		return res.json({ errors: err });
	}
});
router.post('/updateprivate', async (req, res) => {
	try {
		const { cid, description } = req.body;
		console.log(new Date().getTime());
		const result = await db.query(
			`UPDATE privatecomments set description = '${description}' WHERE cid = ${cid}`
		);
		return res.json({ success: 'successfully updated comment' });
	} catch (err) {
		return res.json({ errors: err });
	}
});
router.post('/updaterso', async (req, res) => {
	try {
		const { cid, description } = req.body;
		console.log(new Date().getTime());
		const result = await db.query(
			`UPDATE rsocomments set description = '${description}' WHERE cid = ${cid}`
		);
		return res.json({ success: 'successfully updated comment' });
	} catch (err) {
		return res.json({ errors: err });
	}
});
router.post('/deletepublic', async (req, res) => {
	try {
		const { cid } = req.body;
		const result = await db.query(`DELETE FROM publiccomments WHERE cid = $1`, [
			cid,
		]);
		return res.json({ success: 'successfully deleted comment' });
	} catch (err) {
		console.error(err);
		return res.json({ errors: 'unable to delete comment' });
	}
});
router.post('/deleteprivate', async (req, res) => {
	try {
		const { cid } = req.body;
		const result = await db.query(
			`DELETE FROM privatecomments WHERE cid = $1`,
			[cid]
		);
		return res.json({ success: 'successfully deleted comment' });
	} catch (err) {
		console.error(err);
		return res.json({ errors: 'unable to delete comment' });
	}
});
router.post('/deleterso', async (req, res) => {
	try {
		const { cid } = req.body;
		const result = await db.query(`DELETE FROM rsocomments WHERE cid = $1`, [
			cid,
		]);
		return res.json({ success: 'successfully deleted comment' });
	} catch (err) {
		console.error(err);
		return res.json({ errors: 'unable to delete comment' });
	}
});

router.get('/public/:eid', async (req, res) => {
	try {
		const result = await db.query(
			'SELECT * FROM publiccomments WHERE eid = $1',
			[req.params.eid]
		);
		return res.json({ comments: result.rows });
	} catch (error) {
		return res.json({ errors: 'unable to load comments' });
	}
});
router.get('/private/:eid', async (req, res) => {
	try {
		const result = await db.query(
			'SELECT * FROM privatecomments WHERE eid = $1',
			[req.params.eid]
		);
		return res.json({ comments: result.rows });
	} catch (error) {
		return res.json({ errors: 'unable to load comments' });
	}
});
router.get('/rso/:eid', async (req, res) => {
	try {
		const result = await db.query('SELECT * FROM rsocomments WHERE eid = $1', [
			req.params.eid,
		]);
		return res.json({ comments: result.rows });
	} catch (error) {
		return res.json({ errors: 'unable to load comments' });
	}
});

module.exports = router;
