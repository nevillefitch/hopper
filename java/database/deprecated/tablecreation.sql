

DROP TABLE IF EXISTS hours CASCADE;
DROP TABLE IF EXISTS day CASCADE;
DROP TABLE IF EXISTS image CASCADE;
DROP TABLE IF EXISTS event CASCADE;
DROP TABLE IF EXISTS brewery CASCADE;
DROP TABLE IF EXISTS beer_review CASCADE;
DROP TABLE IF EXISTS beer CASCADE;
DROP TABLE IF EXISTS beer_type CASCADE;







CREATE TABLE brewery (
	brewery_id serial,
	name varchar(50) UNIQUE NOT NULL, 
	email varchar(50) UNIQUE,
	phone varchar(10) UNIQUE,
	street_address varchar(50) UNIQUE,
	city varchar(25),
	state char(2),
	zipcode char(5),
	history varchar(2000),
	logo_img varchar(150),
	is_active bool DEFAULT 'true',
	has_food bool,
	owner_id int NOT NULL,
	CONSTRAINT PK_brewery PRIMARY KEY (brewery_id),
	CONSTRAINT FK_owner FOREIGN KEY (owner_id) REFERENCES users(user_id) 
);

INSERT INTO brewery (name, email, phone, street_address, city, state, zipcode, history, logo_img, has_food, owner_id)
VALUES ('Cigar City Brewery', 'smokybrews@gmail.com', '8133486363', '3924 W Spruce St.', 'Tampa', 'FL', '33607', 
		'Our home since 2009, the Spruce Street Brewery & Taproom offers 24 Cigar City Brewing beers poured inside the same facility where the very first batches of Jai Alai IPA and other CCB favorites were brewed. A full-service kitchen offers Tampa-inspired cuisine seven days a week, with each menu item designed to complement an offering of CCB ales and lagers which includes many beers only available in our Spruce Street Taproom. Family-friendly and inviting, the Spruce Street Taproom offers an immersive beer experience with flights, pints, growler fills, and packaged beer to go poured by Cicerone Certified Beer Servers alongside CCB apparel, barwear, and merchandise.',
		'https://www.cigarcitybrewing.com/wp-content/themes/cigarcity/assets/images/Full-Color-CCb-Logo.svg', 'true',
		(SELECT user_id FROM users WHERE username = 'user'));
INSERT INTO brewery (name, email, phone, street_address, city, state, zipcode, history, logo_img, has_food, owner_id)
VALUES('Triple G-ddess Tap Room', 'info@unityvibrationkombucha.com','7342774063', '93 Ecorce Rd', 'Ypsilanti', 'MI', '48197', 
	   'At Unity Vibration Kombucha, we produce the best tasting and highest quality Kombucha Beer and Tea in the world. We transform the way people think about Kombucha, while always staying true to its Authenticity, and innovate to improve the lives of beverage consumers, our employees, our community and the planet.',
	    'https://unityvibrationkombucha.com/wp-content/uploads/2019/09/cropped-Unity_Vibration_Graphic_Asset_singing_Bowl_Kombucha-2.png', 'false', 
	   (SELECT user_id FROM users WHERE username = 'user'));
INSERT INTO brewery(name, email, phone, street_address, city, state, zipcode, history, logo_img, has_food, owner_id)
VALUES('Flying Dog Brewery', 'jim@flyingdogbrewery.com', '8902774063', '4607 Wedgewood Blvd', 'Frederick', 'MD', '21703', 
	   E'More than 30 years ago, a group of oxygen- and alcohol-deprived amatuer hikers convened in a Pakistan hotel room after summiting the world\'s deadliest mountain. There, Flying Dog was born.', 
	   'https://www.flyingdog.com/static/images/global/fd-logo-text.png', 'true', 
	   (SELECT user_id FROM users WHERE username = 'user'));
INSERT INTO brewery(name, email, phone, street_address, city, state, zipcode, history, logo_img, has_food, owner_id)
VALUES('New Holland Brewing', 'banquets@newhollandbrew.com', '6163455642', '417 Bridge St. NW', 'Grand Rapids', 'MI', '49504', 
	   'We are proud to call Holland home. Situated along the shores of Lake Michigan and Lake Macatawa, Holland attracts a diverse group of residents, vacationers, and tourists. We welcome them all at our "Pub on 8th" with warm hospitality and remarkable service.', 
	   'https://images.getbento.com/accounts/bbddcd7e12722442009c524ed3c016b9/media/images/82401new-holland-logo.png', 
	   'true', (SELECT user_id FROM users WHERE username = 'user'));
	
CREATE TABLE image (
	img_id serial,
	brewery_id int,
	image_path varchar(150),
	CONSTRAINT PK_image PRIMARY KEY (img_id),
	CONSTRAINT FK_brewery_image FOREIGN KEY (brewery_id) REFERENCES brewery(brewery_id)
);

INSERT INTO image (brewery_id, image_path)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Triple G-ddess Tap Room'),
	   'https://unityvibrationkombucha.com/wp-content/uploads/2022/01/taproom.png');
INSERT INTO image (brewery_id, image_path)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Cigar City Brewery'),
	   'https://www.cigarcitybrewing.com/wp-content/uploads/2020/01/new-taps-2-scaled.jpg');
	   
CREATE TABLE day (
	day_id serial,
	name varchar(10),
	abbreviation varchar(3),
	CONSTRAINT PK_day PRIMARY KEY (day_id)
);

INSERT INTO day (name, abbreviation) VALUES ('Monday', 'Mon');
INSERT INTO day (name, abbreviation) VALUES ('Tuesday', 'Tue');
INSERT INTO day (name, abbreviation) VALUES ('Wednesday', 'Wed');
INSERT INTO day (name, abbreviation) VALUES ('Thursday', 'Thu');
INSERT INTO day (name, abbreviation) VALUES ('Friday', 'Fri');
INSERT INTO day (name, abbreviation) VALUES ('Saturday', 'Sat');
INSERT INTO day (name, abbreviation) VALUES ('Sunday', 'Sun');
	   
CREATE TABLE hours (
	hours_id serial,
	brewery_id int,
	day_id int,
	open time,
	close time,
	CONSTRAINT PK_hours PRIMARY KEY (hours_id),
	CONSTRAINT FK_hours_day FOREIGN KEY (day_id) REFERENCES day(day_id)
);

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Triple G-ddess Tap Room'), 
		(SELECT day_id FROM day WHERE abbreviation = 'Mon'),
		'09:00:00', '16:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Triple G-ddess Tap Room'), 
		(SELECT day_id FROM day WHERE abbreviation = 'Tue'),
		'09:00:00', '16:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Triple G-ddess Tap Room'), 
		(SELECT day_id FROM day WHERE abbreviation = 'Wed'),
		'09:00:00', '16:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Triple G-ddess Tap Room'), 
		(SELECT day_id FROM day WHERE abbreviation = 'Thu'),
		'09:00:00', '20:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Triple G-ddess Tap Room'), 
		(SELECT day_id FROM day WHERE abbreviation = 'Fri'),
		'09:00:00', '23:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Triple G-ddess Tap Room'), 
		(SELECT day_id FROM day WHERE abbreviation = 'Sat'),
		'17:00:00', '23:00:00');	
	

CREATE TABLE beer_type (
	beer_type_id serial,
	type_name varchar(50),
	
	CONSTRAINT PK_beer_type PRIMARY KEY (beer_type_id)
	
);

CREATE TABLE beer (
	beer_id serial,
	brewery_id int NOT NULL, 
	name varchar(100) NOT NULL,
	img_path varchar(500),
	description varchar(1000),
	abv decimal(2,1) NOT NULL,
	is_active bool DEFAULT 'true', 
	beer_type_id int,
	
	CONSTRAINT PK_beer PRIMARY KEY (beer_id),
	CONSTRAINT FK_beer_type FOREIGN KEY (beer_type_id) REFERENCES beer_type(beer_type_id)
		
);


CREATE TABLE beer_review (
	review_id serial,
	beer_id int NOT NULL, 
	review_message varchar(1000) NOT NULL,
	score int CHECK (score <=  5 AND score >= 0) NOT NULL,
	
	CONSTRAINT PK_review PRIMARY KEY (review_id),
	CONSTRAINT FK_beer FOREIGN KEY (beer_id) REFERENCES beer(beer_id)
);


CREATE TABLE event (
	event_id serial,
	brewery_id int NOT NULL,
	name varchar(100) NOT NULL,
	event_description varchar(1000),
	
	CONSTRAINT PK_event PRIMARY KEY (event_id),
	CONSTRAINT FK_brewery_id FOREIGN KEY (brewery_id) REFERENCES brewery(brewery_id)
	
);











