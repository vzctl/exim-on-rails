CREATE TABLE 'users' (
	'id' INTEGER PRIMARY KEY NOT NULL,
	'login' varchar(32),
	'hashed_password' varchar(255),
	'salt' varchar(32),
	'created_at' datetime,
	'updated_at' datetime
);

CREATE TABLE 'empty' (
	'id' INTEGER PRIMARY KEY NOT NULL,
	'created_at' datetime,
	'updated_at' datetime
);