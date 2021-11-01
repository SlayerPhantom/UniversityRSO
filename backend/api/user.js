const db = require('../database');
const router = require('express').Router();
const bcrypt = require('bcryptjs');

router.post('/login', async (req, res) => {
	try {
		const { email, password } = req.body;
		const result = await db.query(`SELECT * FROM users WHERE email = $1 `, [
			email,
		]);
		if (result.rows.length == 0)
			return res.json({ errors: 'No user with these credentials' });
		const match = await bcrypt.compare(password, result.rows[0].password);
		if (!match) return res.json({ errors: 'wrong credentials' });
		const uid = result.rows[0].uid;
		const result2 = await db.query(
			'select * from personal_info where uid = $1',
			[uid]
		);
		const { fname, lname, username, userlevel, university } = result2.rows[0];
		return res.json({ uid, fname, lname, userlevel, university, username });
	} catch (err) {
		return res.json({ errors: err });
	}
});

router.post('/register', async (req, res) => {
	try {
		const {
			email,
			password,
			confirmPassword,
			fname,
			lname,
			username,
			university,
		} = req.body;

		const user = await db.query(`SELECT * FROM users WHERE email = $1`, [
			email,
		]);
		if (user.rows.length > 0)
			return res.json({ errors: 'this email is taken' });
		if (password != confirmPassword) {
			return res.json({ errors: 'passwords do not match' });
		}
		const hashedpwd = await bcrypt.hash(password, 12);
		const result = await db.query(
			'INSERT INTO users (email, password) VALUES ($1, $2) RETURNING uid',
			[email, hashedpwd]
		);
		const uid = result.rows[0].uid;

		db.query(
			'INSERT INTO personal_info (uid, fname, lname, username, university) VALUES ($1, $2, $3, $4, $5)',
			[uid, fname, lname, username, university]
		);

		return res.json({ uid, fname, lname, username, university });
	} catch (err) {
		return res.json({ errors: err });
	}
});

module.exports = router;
