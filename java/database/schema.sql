BEGIN TRANSACTION;

DROP TABLE IF EXISTS users;
-- BEER, BREWERY, EVENT, REVIEW TABLE SETUP
DROP TABLE IF EXISTS hours CASCADE;
DROP TABLE IF EXISTS day CASCADE;
DROP TABLE IF EXISTS image CASCADE;
DROP TABLE IF EXISTS event CASCADE;
DROP TABLE IF EXISTS brewery CASCADE;
DROP TABLE IF EXISTS beer_review CASCADE;
DROP TABLE IF EXISTS beer CASCADE;
DROP TABLE IF EXISTS beer_type CASCADE;

DROP SEQUENCE IF EXISTS seq_user_id;

CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE users (
	user_id int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
    CONSTRAINT PK_user PRIMARY KEY (user_id)
);

INSERT INTO users (username,password_hash,role) VALUES ('beerlover','$2a$10$3lj0Vir8PQ6JrqTEJGZ7yOqvMJpnXwtLeC3bLJ0fj7J6WCS.eBO6.','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$10$NSK6TgA2wZbAklD2gOU0tuxc4KsJ0v.gigTk2L.moWKleYyy8cykW','ROLE_ADMIN');

INSERT INTO users (username,password_hash,role) VALUES ('brewer1', '$2a$10$P8ZVDSMln4OYRrHzgDlTVuf80PlDwe5.z5bAIA6GcZ8LQvBfcEf46', 'ROLE_BREWER');
INSERT INTO users (username,password_hash,role) VALUES ('brewer2', '$2a$10$P8ZVDSMln4OYRrHzgDlTVuf80PlDwe5.z5bAIA6GcZ8LQvBfcEf46', 'ROLE_BREWER');
INSERT INTO users (username,password_hash,role) VALUES ('brewer3', '$2a$10$P8ZVDSMln4OYRrHzgDlTVuf80PlDwe5.z5bAIA6GcZ8LQvBfcEf46', 'ROLE_BREWER');
INSERT INTO users (username,password_hash,role) VALUES ('brewer4', '$2a$10$P8ZVDSMln4OYRrHzgDlTVuf80PlDwe5.z5bAIA6GcZ8LQvBfcEf46', 'ROLE_BREWER');
INSERT INTO users (username,password_hash,role) VALUES ('jollyBrewer','$2a$10$NSK6TgA2wZbAklD2gOU0tuxc4KsJ0v.gigTk2L.moWKleYyy8cykW','ROLE_BREWER');
INSERT INTO users (username,password_hash,role) VALUES ('brewDetroit','$2a$10$NSK6TgA2wZbAklD2gOU0tuxc4KsJ0v.gigTk2L.moWKleYyy8cykW','ROLE_BREWER');

CREATE TABLE brewery (
	brewery_id serial,
	name varchar(50) UNIQUE NOT NULL,
	email varchar(50) UNIQUE,
	website_url varchar (150),
	phone varchar(12) UNIQUE,
	street_address varchar(50) UNIQUE,
	city varchar(25),
	state char(2),
	zipcode char(5),
	history varchar(2000),
	logo_img varchar(150),
	is_active bool DEFAULT 'true',
	has_food bool,
	owner_id int UNIQUE NOT NULL,

	CONSTRAINT PK_brewery PRIMARY KEY (brewery_id),
	CONSTRAINT FK_owner FOREIGN KEY (owner_id) REFERENCES users(user_id)
);

INSERT INTO brewery (name, email, phone, street_address, city, state, zipcode, history, logo_img, has_food, owner_id, website_url)
VALUES ('Cigar City Brewery', 'smokybrews@gmail.com', '813-348-6363', '3924 W Spruce St.', 'Tampa', 'FL', '33607',
		'Our home since 2009, the Spruce Street Brewery & Taproom offers 24 Cigar City Brewing beers poured inside the same facility where the very first batches of Jai Alai IPA and other CCB favorites were brewed. A full-service kitchen offers Tampa-inspired cuisine seven days a week, with each menu item designed to complement an offering of CCB ales and lagers which includes many beers only available in our Spruce Street Taproom. Family-friendly and inviting, the Spruce Street Taproom offers an immersive beer experience with flights, pints, growler fills, and packaged beer to go poured by Cicerone Certified Beer Servers alongside CCB apparel, barwear, and merchandise.',
		'https://www.cigarcitybrewing.com/wp-content/themes/cigarcity/assets/images/Full-Color-CCb-Logo.svg', 'true',
		(SELECT user_id FROM users WHERE username = 'brewer1'), 'https://www.cigarcitybrewing.com/');
INSERT INTO brewery (name, email, phone, street_address, city, state, zipcode, history, logo_img, has_food, owner_id, website_url)
VALUES('Triple G-ddess Tap Room', 'info@unityvibrationkombucha.com','734-277-4063', '93 Ecorce Rd', 'Ypsilanti', 'MI', '48197',
	   'At Unity Vibration Kombucha, we produce the best tasting and highest quality Kombucha Beer and Tea in the world. We transform the way people think about Kombucha, while always staying true to its Authenticity, and innovate to improve the lives of beverage consumers, our employees, our community and the planet.',
	    'https://unityvibrationkombucha.com/wp-content/uploads/2019/09/cropped-Unity_Vibration_Graphic_Asset_singing_Bowl_Kombucha-2.png', 'false',
	   (SELECT user_id FROM users WHERE username = 'brewer2'), 'https://unityvibrationkombucha.com/');
INSERT INTO brewery(name, email, phone, street_address, city, state, zipcode, history, logo_img, has_food, owner_id, website_url)
VALUES('Flying Dog Brewery', 'jim@flyingdogbrewery.com', '890-277-4063', '4607 Wedgewood Blvd', 'Frederick', 'MD', '21703',
	   E'More than 30 years ago, a group of oxygen- and alcohol-deprived amatuer hikers convened in a Pakistan hotel room after summiting the world\'s deadliest mountain. There, Flying Dog was born.',
	   'https://www.flyingdog.com/static/images/global/fd-logo-text.png', 'true',
	   (SELECT user_id FROM users WHERE username = 'brewer3'), 'https://www.flyingdog.com/#');
INSERT INTO brewery(name, email, phone, street_address, city, state, zipcode, history, logo_img, has_food, owner_id, website_url)
VALUES('New Holland Brewing', 'banquets@newhollandbrew.com', '616-345-5642', '417 Bridge St. NW', 'Grand Rapids', 'MI', '49504',
	   'We are proud to call Holland home. Situated along the shores of Lake Michigan and Lake Macatawa, Holland attracts a diverse group of residents, vacationers, and tourists. We welcome them all at our "Pub on 8th" with warm hospitality and remarkable service.',
	   'https://images.getbento.com/accounts/bbddcd7e12722442009c524ed3c016b9/media/images/82401new-holland-logo.png',
	   'true', (SELECT user_id FROM users WHERE username = 'brewer4'), 'https://www.newhollandbrew.com/');


INSERT INTO brewery (name, email, phone, street_address, city, state, zipcode, history, logo_img, has_food, owner_id, website_url) VALUES ('Jolly Pumpkin','manager.aa@jollypumpkin.com','313-262-6115','441 W Canfield St','Detroit','MI','48201','Located in the historic Corktown District of Detroit, Michigan, Brew Detroit operates in a 68,000-square-foot facility. Brew Detroit was incorporated in September 2012 and installed its BrewHouse and its canning and bottling lines in 2013, with the initial brewing and packaging beginning in early 2014. Brew Detroit’s 100-barrel brews are fermented in fifteen 400 barrel fermentation tanks and two 200-barrel fermentation tanks. The 200-barrel tanks are primarily used for our customers’ seasonal brands throughout the year. After the centrifuge, the beer is moved to our 400- and 200- barrel brite tanks. Customers have the option of pasteurization and packaging into cans, bottles and kegs. Our facility consists of a keg cooler for kegs and a temperature controlled section for finished cases of bottles and cans.','https://detroit.jollypumpkin.com/wp-content/uploads/2021/06/jp-db.png','TRUE',(SELECT user_id FROM users WHERE username = 'jollyBrewer'),'https://www.jollypumpkin.com/');
INSERT INTO brewery (name, email, phone, street_address, city, state, zipcode, history, logo_img, has_food, owner_id, website_url) VALUES ('Brew Detroit','info@brewdetroit.com','313-974-7366','1401 Abbott Street','Detroit','MI','48216','Located in the historic Corktown District of Detroit, Michigan, Brew Detroit operates in a 68,000-square-foot facility. Brew Detroit was incorporated in September 2012 and installed its BrewHouse and its canning and bottling lines in 2013, with the initial brewing and packaging beginning in early 2014. Brew Detroit’s 100-barrel brews are fermented in fifteen 400 barrel fermentation tanks and two 200-barrel fermentation tanks. The 200-barrel tanks are primarily used for our customers’ seasonal brands throughout the year. After the centrifuge, the beer is moved to our 400- and 200- barrel brite tanks. Customers have the option of pasteurization and packaging into cans, bottles and kegs. Our facility consists of a keg cooler for kegs and a temperature controlled section for finished cases of bottles and cans.','https://www.brewdetroit.com/wp-content/themes/brewdetroit/images/logo.png','FALSE',(SELECT user_id FROM users WHERE username = 'brewDetroit'),'https://www.brewdetroit.com/');


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

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Triple G-ddess Tap Room'),
		(SELECT day_id FROM day WHERE abbreviation = 'Sun'),
		'00:00:00', '00:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'New Holland Brewing'),
		(SELECT day_id FROM day WHERE abbreviation = 'Mon'),
		'00:00:00', '00:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'New Holland Brewing'),
		(SELECT day_id FROM day WHERE abbreviation = 'Tue'),
		'00:00:00', '00:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'New Holland Brewing'),
		(SELECT day_id FROM day WHERE abbreviation = 'Wed'),
		'00:00:00', '00:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'New Holland Brewing'),
		(SELECT day_id FROM day WHERE abbreviation = 'Thu'),
		'00:00:00', '00:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'New Holland Brewing'),
		(SELECT day_id FROM day WHERE abbreviation = 'Fri'),
		'09:00:00', '23:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'New Holland Brewing'),
		(SELECT day_id FROM day WHERE abbreviation = 'Sat'),
		'17:00:00', '23:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'New Holland Brewing'),
		(SELECT day_id FROM day WHERE abbreviation = 'Sun'),
		'17:00:00', '23:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Flying Dog Brewery'),
		(SELECT day_id FROM day WHERE abbreviation = 'Mon'),
		'09:00:00', '16:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Flying Dog Brewery'),
		(SELECT day_id FROM day WHERE abbreviation = 'Tue'),
		'09:00:00', '16:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Flying Dog Brewery'),
		(SELECT day_id FROM day WHERE abbreviation = 'Wed'),
		'09:00:00', '16:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Flying Dog Brewery'),
		(SELECT day_id FROM day WHERE abbreviation = 'Thu'),
		'09:00:00', '20:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Flying Dog Brewery'),
		(SELECT day_id FROM day WHERE abbreviation = 'Fri'),
		'09:00:00', '23:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Flying Dog Brewery'),
		(SELECT day_id FROM day WHERE abbreviation = 'Sat'),
		'17:00:00', '23:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Flying Dog Brewery'),
		(SELECT day_id FROM day WHERE abbreviation = 'Sun'),
		'00:00:00', '00:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Cigar City Brewery'),
		(SELECT day_id FROM day WHERE abbreviation = 'Mon'),
		'00:00:00', '00:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Cigar City Brewery'),
		(SELECT day_id FROM day WHERE abbreviation = 'Tue'),
		'00:00:00', '00:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Cigar City Brewery'),
		(SELECT day_id FROM day WHERE abbreviation = 'Wed'),
		'00:00:00', '00:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Cigar City Brewery'),
		(SELECT day_id FROM day WHERE abbreviation = 'Thu'),
		'09:00:00', '20:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Cigar City Brewery'),
		(SELECT day_id FROM day WHERE abbreviation = 'Fri'),
		'09:00:00', '23:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Cigar City Brewery'),
		(SELECT day_id FROM day WHERE abbreviation = 'Sat'),
		'17:00:00', '23:00:00');

INSERT INTO hours (brewery_id, day_id, open, close)
VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Cigar City Brewery'),
		(SELECT day_id FROM day WHERE abbreviation = 'Sun'),
		'00:00:00', '00:00:00');


INSERT INTO hours (brewery_id, day_id, open, close) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),(SELECT day_id FROM day WHERE abbreviation = 'Mon'),'9:00:00','16:00:00');
INSERT INTO hours (brewery_id, day_id, open, close) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),(SELECT day_id FROM day WHERE abbreviation = 'Tues'),'9:00:00','16:00:00');
INSERT INTO hours (brewery_id, day_id, open, close) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),(SELECT day_id FROM day WHERE abbreviation = 'Wed'),'9:00:00','16:00:00');
INSERT INTO hours (brewery_id, day_id, open, close) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),(SELECT day_id FROM day WHERE abbreviation = 'Thur'),'9:00:00','16:00:00');
INSERT INTO hours (brewery_id, day_id, open, close) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),(SELECT day_id FROM day WHERE abbreviation = 'Fri'),'9:00:00','16:00:00');
INSERT INTO hours (brewery_id, day_id, open, close) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),(SELECT day_id FROM day WHERE abbreviation = 'Sat'),'9:00:00','16:00:00');
INSERT INTO hours (brewery_id, day_id, open, close) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),(SELECT day_id FROM day WHERE abbreviation = 'Sun'),'9:00:00','16:00:00');
INSERT INTO hours (brewery_id, day_id, open, close) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Brew Detroit'),(SELECT day_id FROM day WHERE abbreviation = 'Mon'),'0:00:00','0:00:00');
INSERT INTO hours (brewery_id, day_id, open, close) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Brew Detroit'),(SELECT day_id FROM day WHERE abbreviation = 'Tues'),'9:00:00','21:00:00');
INSERT INTO hours (brewery_id, day_id, open, close) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Brew Detroit'),(SELECT day_id FROM day WHERE abbreviation = 'Wed'),'9:00:00','21:00:00');
INSERT INTO hours (brewery_id, day_id, open, close) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Brew Detroit'),(SELECT day_id FROM day WHERE abbreviation = 'Thur'),'9:00:00','22:00:00');
INSERT INTO hours (brewery_id, day_id, open, close) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Brew Detroit'),(SELECT day_id FROM day WHERE abbreviation = 'Fri'),'16:00:00','24:00:00');
INSERT INTO hours (brewery_id, day_id, open, close) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Brew Detroit'),(SELECT day_id FROM day WHERE abbreviation = 'Sat'),'13:00:00','24:00:00');
INSERT INTO hours (brewery_id, day_id, open, close) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Brew Detroit'),(SELECT day_id FROM day WHERE abbreviation = 'Sun'),'13:00:00','18:00:00');












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
	price numeric (5,2) NOT NULL,
	abv decimal(3,1) NOT NULL,
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
	user_id int NOT NULL,

	CONSTRAINT PK_review PRIMARY KEY (review_id),
	CONSTRAINT FK_beer FOREIGN KEY (beer_id) REFERENCES beer(beer_id),
	CONSTRAINT FK_review_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);


CREATE TABLE event (
	event_id serial,
	brewery_id int NOT NULL,
	name varchar(100) NOT NULL,
	event_description varchar(1000),

	CONSTRAINT PK_event PRIMARY KEY (event_id),
	CONSTRAINT FK_brewery_id FOREIGN KEY (brewery_id) REFERENCES brewery(brewery_id)

);


INSERT INTO beer_type (type_name) VALUES ('American Pale Ale');
INSERT INTO beer_type (type_name) VALUES ('India Pale Ale (IPA)');
INSERT INTO beer_type (type_name) VALUES ('Stout');
INSERT INTO beer_type (type_name) VALUES ('Wheat Beer');
INSERT INTO beer_type (type_name) VALUES ('Lager');
INSERT INTO beer_type (type_name) VALUES ('Pilsner');
INSERT INTO beer_type (type_name) VALUES ('Amber Ale');
INSERT INTO beer_type (type_name) VALUES ('English Pale Ale');
INSERT INTO beer_type (type_name) VALUES ('Porter');
INSERT INTO beer_type (type_name) VALUES ('Hefeweizen');
INSERT INTO beer_type (type_name) VALUES ('American Wheat Beer');
INSERT INTO beer_type (type_name) VALUES ('Sour Beer');
INSERT INTO beer_type (type_name) VALUES ('American Brown Ale');
INSERT INTO beer_type (type_name) VALUES ('Barleywine');
INSERT INTO beer_type (type_name) VALUES ('Gose');
INSERT INTO beer_type (type_name) VALUES ('Dunkle');
INSERT INTO beer_type (type_name) VALUES ('Kombucha');
INSERT INTO beer_type (type_name) VALUES ('Dubbel');
INSERT INTO beer_type (type_name) VALUES ('Tripel');

INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name like 'Triple G-ddess Tap Room'),'Bourbon Peach','https://craftpeak-commerce-images.imgix.net/2020/06/UV_Can_Bourbon_Peach_Highres.png?auto=compress%2Cformat&fit=crop&h=324&ixlib=php-1.2.1&w=324&wpsize=shop_catalog','Our best selling kombucha beer! Made with bourbon chips, peaches and Michigan hops,','4.99','8.2',(SELECT beer_type_id FROM beer_type WHERE type_name like 'Kombucha'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name like 'Triple G-ddess Tap Room'),'Tart Raspberry','https://craftpeak-commerce-images.imgix.net/2020/06/UV_Can_Tart_Raspberry_Highres.png?auto=compress%2Cformat&fit=crop&h=324&ixlib=php-1.2.1&w=324&wpsize=shop_catalog','This Kombucha beer’s brilliant red hue and creamy white-head makes this tangy ambrosia look almost as good as it tastes!','4.99','8.2',(SELECT beer_type_id FROM beer_type WHERE type_name like 'Kombucha'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name like 'Cigar City Brewery'),'Jai Alai','https://www.cigarcitybrewing.com/wp-content/uploads/2019/03/Jai-Alai-Art-Mock-copy.png','An intense bouquet of tangerine and candied orange peel entices the nose while flavors of clementines, Valencia orange, and subtle caramel provide counterpoint to an assertive bitterness and rich malt character. Bold hop flavor and aroma from six different hop varietals is front and center in this flavorful American IPA.','3.5','5.5',(SELECT beer_type_id FROM beer_type WHERE type_name like 'India Pale Ale (IPA)'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name like 'Flying Dog Brewery'),'Snake Dog','https://www.flyingdog.com/media/CACHE/images/beers/cans/SnakeDog_12oz_Can/650053de99891d84e1d5ec7e50f20803.png','A potent snakebite of 5 different hops gives Snake Dog its citrus-forward superpower. Orange and tropical fruit aromas temper slightly-piney crispness, turning Snake Dog into a more complex breed of West Coast IPA.','7.5','7.1',(SELECT beer_type_id FROM beer_type WHERE type_name like 'India Pale Ale (IPA)'));

INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),'Bam Biere','https://beer.untappd.com/labels/395','An artisan farmhouse ale that is golden, naturally cloudy, bottle conditioned and dry hopped for a perfectly refreshing balance of spicy malts, hops and yeast.','4.5','4.5',(SELECT beer_type_id FROM beer_type WHERE type_name like 'Amber Ale'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),'Baudelaire Beer iO Saison','https://beer.untappd.com/labels/35297','Ale Brewed with Rose Hips, Rose Petals, and Hibiscus. Lets face it, Beer is an art form that excites our senses and stirs our imagination. This truth gave Jolly Pumpkin an idea. Wed create a limited series of beer by throwing caution to the wind and following our creative muse no matter where it leads. This is how we discovered Baudelaire Beer. A romantic world, dimly lit by distant memory, yet alive and inspiring us to pursue beauty at any cost. In the world of Baudelaire, label and beer come together in character and art influencing the drinker to take upon the spirit of creativity and fun. Let the muse guide you. ""A breath of air from the wings of madness."" ~Baudelaire','5.5','6.8',(SELECT beer_type_id FROM beer_type WHERE type_name like 'Amber Ale'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),'Calabaza Blanca','https://beer.untappd.com/labels/45','Calabaza Blanca is a low-calorie farmhouse white ale brewed in Belgiums bière blanche tradition. Spiced with orange peel and coriander, youll find it refreshingly tart, with a wonderfully dry finish. A year-round favorite for sure!','3.5','4.8',(SELECT beer_type_id FROM beer_type WHERE type_name like 'Amber Ale'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),'Bam Noire','https://beer.untappd.com/labels/4892','Dark, smooth, delicious. Aromas of worn leather and cool autumn nights. Notes of sweet plum and toasted raisin, hints of coffee and cacao. Lingering tart and refreshing finish. Only available for a few short months. Not to be missed.','3.5','4.5',(SELECT beer_type_id FROM beer_type WHERE type_name like 'Amber Ale'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),'La Roja','https://beer.untappd.com/labels/409','An artisan amber ale brewed in the Flanders tradition. Deep amber with earthy caramel, spice, and sour fruit notes developed through natural barrel aging. Unfiltered, unpasteurized and blended from barrels ranging in age from two to ten months.','9.5','7.2',(SELECT beer_type_id FROM beer_type WHERE type_name like 'Amber Ale'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),'Bière de Mars','https://beer.untappd.com/labels/157','A sustaining beer that is brewed to comfort in the gusty ides of March and welcome in a wealth of warmer weather.','9.2','7',(SELECT beer_type_id FROM beer_type WHERE type_name like 'Amber Ale'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),'Clementina','https://beer.untappd.com/labels/1031770','Rich yellow gold color. Highly effervescent. Citrus and bready wheat aroma. Tart and refreshing with notes of citrus, and in particular, clementine in the finish.','6.3','5.5',(SELECT beer_type_id FROM beer_type WHERE type_name like 'Amber Ale'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),'Madrugada','https://beer.untappd.com/labels/4893','A Belgian inspired stout that is as dark as a moonless midnight, brimming of roasted malts and bitter hops. It will keep you good company in all places, be thay light or dark.','8.2','8.1',(SELECT beer_type_id FROM beer_type WHERE type_name like 'Amber Ale'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Jolly Pumpkin'),'Oro de Calabaza','https://beer.untappd.com/labels/408','Brewed in the Franco-Belgian tradition of strong golden ales. Spicy and peppery with a gentle hop bouquet and the beguiling influence of wild yeast.','3.5','8',(SELECT beer_type_id FROM beer_type WHERE type_name like 'Amber Ale'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Brew Detroit'),'CERVEZA DELRAY','https://w7.pngwing.com/pngs/265/949/png-transparent-beer-can-house-beer-can-museum-beverage-can-filling-beer-market-label-beer-bottle-material.png','Mexican-Style Lager','4','4.2',(SELECT beer_type_id FROM beer_type WHERE type_name like 'Lager'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Brew Detroit'),'CITRUS BLONDE','https://w7.pngwing.com/pngs/265/949/png-transparent-beer-can-house-beer-can-museum-beverage-can-filling-beer-market-label-beer-bottle-material.png','Blonde Ale','5','4.7',(SELECT beer_type_id FROM beer_type WHERE type_name like 'English Pale Ale'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Brew Detroit'),'BISHOP LANE','https://w7.pngwing.com/pngs/265/949/png-transparent-beer-can-house-beer-can-museum-beverage-can-filling-beer-market-label-beer-bottle-material.png','Honeysuckle Wheat Ale','6','4',(SELECT beer_type_id FROM beer_type WHERE type_name like 'Wheat Beer'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Brew Detroit'),'SWEET BIG BABY BELMA','https://w7.pngwing.com/pngs/265/949/png-transparent-beer-can-house-beer-can-museum-beverage-can-filling-beer-market-label-beer-bottle-material.png','American Pale Ale','6','5.5',(SELECT beer_type_id FROM beer_type WHERE type_name like 'American Pale Ale'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Brew Detroit'),'CLOUD 19','https://w7.pngwing.com/pngs/265/949/png-transparent-beer-can-house-beer-can-museum-beverage-can-filling-beer-market-label-beer-bottle-material.png','DDH New England','7','7',(SELECT beer_type_id FROM beer_type WHERE type_name like 'India Pale Ale (IPA)'));
INSERT INTO beer (brewery_id, name, img_path, description, price, abv, beer_type_id) VALUES ((SELECT brewery_id FROM brewery WHERE name = 'Brew Detroit'),'LIQUID MITTENS','https://w7.pngwing.com/pngs/265/949/png-transparent-beer-can-house-beer-can-museum-beverage-can-filling-beer-market-label-beer-bottle-material.png','Rye-Bourbon Barrel Aged Barleywine','8','11.7',(SELECT beer_type_id FROM beer_type WHERE type_name like 'Barleywine'));





INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES (1, 'Great beer', 5, 1);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES (2, 'Awesome beer', 3, 1);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES (1, 'Fair beer', 1, 2);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES (3, 'Drinkable beer', 2, 2);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES (1, 'The BEST beer', 5, 1);

INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES ((select beer_id from beer where name = 'Bam Biere'),'Wow I cant believe is such beer.',4,1);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES ((select beer_id from beer where name = 'Baudelaire Beer iO Saison'),'Meh. Okay but my mom makes better beer.',2,2);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES ((select beer_id from beer where name = 'Calabaza Blanca'),'Bad bad leroy brown.',1,3);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES ((select beer_id from beer where name = 'La Roja'),'Pretty good!',3,2);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES ((select beer_id from beer where name = 'Bière de Mars'),'The best god has to give us.',5,1);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES ((select beer_id from beer where name = 'Clementina'),'Amazing!!!',4,3);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES ((select beer_id from beer where name = 'Madrugada'),'Okay...',2,4);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES ((select beer_id from beer where name = 'Oro de Calabaza'),'Alright!!!',3,5);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES ((select beer_id from beer where name = 'CERVEZA DELRAY'),'Im giving it a 4 because my car had a flat today.',4,5);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES ((select beer_id from beer where name = 'CITRUS BLONDE'),'Okay!',3,5);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES ((select beer_id from beer where name = 'BISHOP LANE'),'THE BEST IVE EVER HAD',5,5);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES ((select beer_id from beer where name = 'SWEET BIG BABY BELMA'),'WOW',4,5);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES ((select beer_id from beer where name = 'CLOUD 19'),'Meh.. Okay.',2,6);
INSERT INTO beer_review (beer_id, review_message, score, user_id) VALUES ((select beer_id from beer where name = 'LIQUID MITTENS'),'Super.',4,4);



COMMIT TRANSACTION;
