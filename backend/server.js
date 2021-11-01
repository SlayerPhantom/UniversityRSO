require('dotenv').config();
const express = require('express');
const cors = require('cors');

const app = express();
// const db = require('./database');
app.use(express.json());

app.use(cors());
app.use((req, res, next) => {
	res.setHeader('Access-Control-Allow-Origin', '*');
	res.setHeader(
		'Access-Control-Allow-Headers',
		'Origin, X-Requested-With, Content-Type, Accept, Authorization'
	);
	res.setHeader(
		'Access-Control-Allow-Methods',
		'GET, POST, PATCH, DELETE, OPTIONS'
	);
	next();
});

app.use('/api', require('./api/user'));
app.use('/api/rso', require('./api/RSO'));
app.use('/api/events', require('./api/events'));
app.use('/api/comments', require('./api/comments'));

PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
	console.log(`server running on port ${PORT}`);
});
