-- Categories
insert into categories(name)
values
("all"),
("clothes"),
("tech");

-- Currencies
insert into currencies(label, symbol)
values ("USD", "$");

-- Colors
insert into colors(name, value)
values
("Green", "44FF03"),
("Cyan", "03FFF7"),
("Blue", "030BFF"),
("Black", "000000"),
("White", "FFFFFF");

-- Sizes
insert into sizes(name, value)
values
("Small", "S"),
("Medium", "M"),
("Large", "L"),
("Extra Large", "XL"),
("40", "40"),
("41", "41"),
("42", "42"),
("43", "43");

-- Capacities
insert into capacities(name, value)
values
("256G", "256G"),
("512G", "512G"),
("1T", "1T");

-- Product 1
insert into products(product_id, name, in_stock, description, brand, category_id)
values
(
	"huarache-x-stussy-le",
	"Nike Air Huarache Le",
	true,
	"<p>Great sneakers for everyday use!</p>",
	"Nike x Stussy",
	(select id from categories where categories.name="clothes")
);

set @ProductID = (
	select id from products where products.product_id="huarache-x-stussy-le"
);

insert into product_size(product_id, size_id)
values
(
	(select @ProductID),
	(select id from sizes where sizes.name="40")
),
(
	(select @ProductID),
	(select id from sizes where sizes.name="41")
),
(
	(select @ProductID),
	(select id from sizes where sizes.name="42")
),
(
	(select @ProductID),
	(select id from sizes where sizes.name="43")
);

insert into gallery(product_id, url)
values
(
	(select @ProductID),
	"https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_2_720x.jpg?v=1612816087"
),
(
	(select @ProductID),
	"https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_1_720x.jpg?v=1612816087"
),
(
	(select @ProductID),
	"https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_3_720x.jpg?v=1612816087"
),
(
	(select @ProductID),
	"https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_5_720x.jpg?v=1612816087"
),
(
	(select @ProductID),
	"https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_4_720x.jpg?v=1612816087"
);

insert into prices(product_id, amount, currency_id)
values
(
	(select id from products where products.product_id="huarache-x-stussy-le"),
	144.69,
	(select id from currencies where currencies.label="USD")
);

-- product 2
insert into products(product_id, name, in_stock, description, brand, category_id)
values
(
	"jacket-canada-goosee",
	"Jacket",
	true,
	"<p>Awesome winter jacket</p>",
	"Canada Goose",
	(select id from categories where categories.name="clothes")
);

set @ProductID = (
	select id from products where products.product_id="jacket-canada-goosee"
);

insert into product_size(product_id, size_id)
values
(
	(select @ProductID),
	(select id from sizes where sizes.name="Small")
),
(
	(select @ProductID),
	(select id from sizes where sizes.name="Medium")
),
(
	(select @ProductID),
	(select id from sizes where sizes.name="Large")
),
(
	(select @ProductID),
	(select id from sizes where sizes.name="Extra Large")
);

insert into gallery(product_id, url)
values
(
	(select @ProductID),
	"https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016105/product-image/2409L_61.jpg"
),
(
	(select @ProductID),
	"https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016107/product-image/2409L_61_a.jpg"
),
(
	(select @ProductID),
	"https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016108/product-image/2409L_61_b.jpg"
),
(
	(select @ProductID),
	"https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016109/product-image/2409L_61_c.jpg"
),
(
	(select @ProductID),
	"https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016110/product-image/2409L_61_d.jpg"
),
(
	(select @ProductID),
	"https://images.canadagoose.com/image/upload/w_1333,c_scale,f_auto,q_auto:best/v1634058169/product-image/2409L_61_o.png"
),
(
	(select @ProductID),
	"https://images.canadagoose.com/image/upload/w_1333,c_scale,f_auto,q_auto:best/v1634058159/product-image/2409L_61_p.png"
);

insert into prices(product_id, amount, currency_id)
values
(
	(select id from products where products.product_id="jacket-canada-goosee"),
	518.47,
	(select id from currencies where currencies.label="USD")
);

-- product 3
insert into products(product_id, name, in_stock, description, brand, category_id)
values
(
	"ps-5",
	"PlayStation 5",
	true,
	"<p>A good gaming console. Plays games of PS4! Enjoy if you can buy it mwahahahaha</p>",
	"Sony",
	(select id from categories where categories.name="tech")
);

set @ProductID = (
	select id from products where products.product_id="ps-5"
);

insert into product_color(product_id, color_id)
values
(
	(select @ProductID),
	(select id from colors where colors.name="Green")
),
(
	(select @ProductID),
	(select id from colors where colors.name="Cyan")
),
(
	(select @ProductID),
	(select id from colors where colors.name="Blue")
),
(
	(select @ProductID),
	(select id from colors where colors.name="Black")
),
(
	(select @ProductID),
	(select id from colors where colors.name="White")
);

insert into product_capacity(product_id, capacity_id)
values
(
	(select @ProductID),
	(select id from capacities where capacities.name="512G")
),
(
	(select @ProductID),
	(select id from capacities where capacities.name="1T")
);

insert into gallery(product_id, url)
values
(
	(select @ProductID),
	"https://images-na.ssl-images-amazon.com/images/I/510VSJ9mWDL._SL1262_.jpg"
),
(
	(select @ProductID),
	"https://images-na.ssl-images-amazon.com/images/I/610%2B69ZsKCL._SL1500_.jpg"
),
(
	(select @ProductID),
	"https://images-na.ssl-images-amazon.com/images/I/51iPoFwQT3L._SL1230_.jpg"
),
(
	(select @ProductID),
	"https://images-na.ssl-images-amazon.com/images/I/61qbqFcvoNL._SL1500_.jpg"
),
(
	(select @ProductID),
	"https://images-na.ssl-images-amazon.com/images/I/51HCjA3rqYL._SL1230_.jpg"
);

insert into prices(product_id, amount, currency_id)
values
(
	(select id from products where products.product_id="ps-5"),
	844.02,
	(select id from currencies where currencies.label="USD")
);

-- Product 4
insert into products(product_id, name, in_stock, description, brand, category_id)
values
(
	"xbox-series-s",
	"Xbox Series S 512GB",
	false,
	"\n<div>\n    <ul>\n        <li><span>Hardware-beschleunigtes Raytracing macht dein Spiel noch realistischer</span></li>\n        <li><span>Spiele Games mit bis zu 120 Bilder pro Sekunde</span></li>\n        <li><span>Minimiere Ladezeiten mit einer speziell entwickelten 512GB NVMe SSD und wechsle mit Quick Resume nahtlos zwischen mehreren Spielen.</span></li>\n        <li><span>Xbox Smart Delivery stellt sicher, dass du die beste Version deines Spiels spielst, egal, auf welcher Konsole du spielst</span></li>\n        <li><span>Spiele deine Xbox One-Spiele auf deiner Xbox Series S weiter. Deine Fortschritte, Erfolge und Freundesliste werden automatisch auf das neue System übertragen.</span></li>\n        <li><span>Erwecke deine Spiele und Filme mit innovativem 3D Raumklang zum Leben</span></li>\n        <li><span>Der brandneue Xbox Wireless Controller zeichnet sich durch höchste Präzision, eine neue Share-Taste und verbesserte Ergonomie aus</span></li>\n        <li><span>Ultra-niedrige Latenz verbessert die Reaktionszeit von Controller zum Fernseher</span></li>\n        <li><span>Verwende dein Xbox One-Gaming-Zubehör -einschließlich Controller, Headsets und mehr</span></li>\n        <li><span>Erweitere deinen Speicher mit der Seagate 1 TB-Erweiterungskarte für Xbox Series X (separat erhältlich) und streame 4K-Videos von Disney+, Netflix, Amazon, Microsoft Movies &amp; TV und mehr</span></li>\n    </ul>\n</div>",
	"Microsoft",
	(select id from categories where categories.name="tech")
);

set @ProductID = (
	select id from products where products.product_id="xbox-series-s"
);

insert into product_color(product_id, color_id)
values
(
	(select @ProductID),
	(select id from colors where colors.name="Green")
),
(
	(select @ProductID),
	(select id from colors where colors.name="Cyan")
),
(
	(select @ProductID),
	(select id from colors where colors.name="Blue")
),
(
	(select @ProductID),
	(select id from colors where colors.name="Black")
),
(
	(select @ProductID),
	(select id from colors where colors.name="White")
);

insert into product_capacity(product_id, capacity_id)
values
(
	(select @ProductID),
	(select id from capacities where capacities.name="512G")
),
(
	(select @ProductID),
	(select id from capacities where capacities.name="1T")
);

insert into gallery(product_id, url)
values
(
	(select @ProductID),
	"https://images-na.ssl-images-amazon.com/images/I/71vPCX0bS-L._SL1500_.jpg"
),
(
	(select @ProductID),
	"https://images-na.ssl-images-amazon.com/images/I/71q7JTbRTpL._SL1500_.jpg"
),
(
	(select @ProductID),
	"https://images-na.ssl-images-amazon.com/images/I/71iQ4HGHtsL._SL1500_.jpg"
),
(
	(select @ProductID),
	"https://images-na.ssl-images-amazon.com/images/I/61IYrCrBzxL._SL1500_.jpg"
),
(
	(select @ProductID),
	"https://images-na.ssl-images-amazon.com/images/I/61RnXmpAmIL._SL1500_.jpg"
);

insert into prices(product_id, amount, currency_id)
values
(
	(select id from products where products.product_id="xbox-series-s"),
	333.99,
	(select id from currencies where currencies.label="USD")
);

-- Product 5
insert into products(product_id, name, in_stock, description, brand, category_id)
values
(
	"apple-imac-2021",
	"iMac 2021",
	true,
	"The new iMac!",
	"Apple",
	(select id from categories where categories.name="tech")
);

set @ProductID = (
	select id from products where products.product_id="apple-imac-2021"
);

insert into product_usb3(product_id)
values
((select @ProductID));

insert into product_touchID(product_id)
values
((select @ProductID));

insert into product_capacity(product_id, capacity_id)
values
(
	(select @ProductID),
	(select id from capacities where capacities.name="256G")
),
(
	(select @ProductID),
	(select id from capacities where capacities.name="512G")
);

insert into gallery(product_id, url)
values
(
	(select @ProductID),
	"https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/imac-24-blue-selection-hero-202104?wid=904&hei=840&fmt=jpeg&qlt=80&.v=1617492405000"
);

insert into prices(product_id, amount, currency_id)
values
(
	(select id from products where products.product_id="apple-imac-2021"),
	1688.03,
	(select id from currencies where currencies.label="USD")
);

-- Product 6
insert into products(product_id, name, in_stock, description, brand, category_id)
values
(
	"apple-iphone-12-pro",
	"iPhone 12 Pro",
	true,
	"This is iPhone 12. Nothing else to say.",
	"Apple",
	(select id from categories where categories.name="tech")
);

set @ProductID = (
	select id from products where products.product_id="apple-iphone-12-pro"
);

insert into gallery(product_id, url)
values
(
	(select @ProductID),
	"https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-12-pro-family-hero?wid=940&amp;hei=1112&amp;fmt=jpeg&amp;qlt=80&amp;.v=1604021663000"
);

insert into product_color(product_id, color_id)
values
(
	(select @ProductID),
	(select id from colors where colors.name="Green")
),
(
	(select @ProductID),
	(select id from colors where colors.name="Cyan")
),
(
	(select @ProductID),
	(select id from colors where colors.name="Blue")
),
(
	(select @ProductID),
	(select id from colors where colors.name="Black")
),
(
	(select @ProductID),
	(select id from colors where colors.name="White")
);

insert into product_capacity(product_id, capacity_id)
values
(
	(select @ProductID),
	(select id from capacities where capacities.name="512G")
),
(
	(select @ProductID),
	(select id from capacities where capacities.name="1T")
);

insert into prices(product_id, amount, currency_id)
values
(
	(select id from products where products.product_id="apple-iphone-12-pro"),
	1000.76,
	(select id from currencies where currencies.label="USD")
);

-- Product 7
insert into products(product_id, name, in_stock, description, brand, category_id)
values
(
	"apple-airpods-pro",
	"AirPods Pro",
	false,
	"\n<h3>Magic like you’ve never heard</h3>\n<p>AirPods Pro have been designed to deliver Active Noise Cancellation for immersive sound, Transparency mode so you can hear your surroundings, and a customizable fit for all-day comfort. Just like AirPods, AirPods Pro connect magically to your iPhone or Apple Watch. And they’re ready to use right out of the case.\n\n<h3>Active Noise Cancellation</h3>\n<p>Incredibly light noise-cancelling headphones, AirPods Pro block out your environment so you can focus on what you’re listening to. AirPods Pro use two microphones, an outward-facing microphone and an inward-facing microphone, to create superior noise cancellation. By continuously adapting to the geometry of your ear and the fit of the ear tips, Active Noise Cancellation silences the world to keep you fully tuned in to your music, podcasts, and calls.\n\n<h3>Transparency mode</h3>\n<p>Switch to Transparency mode and AirPods Pro let the outside sound in, allowing you to hear and connect to your surroundings. Outward- and inward-facing microphones enable AirPods Pro to undo the sound-isolating effect of the silicone tips so things sound and feel natural, like when you’re talking to people around you.</p>\n\n<h3>All-new design</h3>\n<p>AirPods Pro offer a more customizable fit with three sizes of flexible silicone tips to choose from. With an internal taper, they conform to the shape of your ear, securing your AirPods Pro in place and creating an exceptional seal for superior noise cancellation.</p>\n\n<h3>Amazing audio quality</h3>\n<p>A custom-built high-excursion, low-distortion driver delivers powerful bass. A superefficient high dynamic range amplifier produces pure, incredibly clear sound while also extending battery life. And Adaptive EQ automatically tunes music to suit the shape of your ear for a rich, consistent listening experience.</p>\n\n<h3>Even more magical</h3>\n<p>The Apple-designed H1 chip delivers incredibly low audio latency. A force sensor on the stem makes it easy to control music and calls and switch between Active Noise Cancellation and Transparency mode. Announce Messages with Siri gives you the option to have Siri read your messages through your AirPods. And with Audio Sharing, you and a friend can share the same audio stream on two sets of AirPods — so you can play a game, watch a movie, or listen to a song together.</p>\n",
	"Apple",
	(select id from categories where categories.name="tech")
);

set @ProductID = (
	select id from products where products.product_id="apple-airpods-pro"
);

insert into gallery(product_id, url)
values
(
	(select @ProductID),
	"https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MWP22?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1591634795000"
);

insert into prices(product_id, amount, currency_id)
values
(
	(select id from products where products.product_id="apple-airpods-pro"),
	300.23,
	(select id from currencies where currencies.label="USD")
);

-- Product 8
insert into products(product_id, name, in_stock, description, brand, category_id)
values
(
	"apple-airtag",
	"AirTag",
	true,
	"\n<h1>Lose your knack for losing things.</h1>\n<p>AirTag is an easy way to keep track of your stuff. Attach one to your keys, slip another one in your backpack. And just like that, they’re on your radar in the Find My app. AirTag has your back.</p>\n",
	"Apple",
	(select id from categories where categories.name="tech")
);

set @ProductID = (
	select id from products where products.product_id="apple-airtag"
);

insert into gallery(product_id, url)
values
(
	(select @ProductID),
	"https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/airtag-double-select-202104?wid=445&hei=370&fmt=jpeg&qlt=95&.v=1617761672000"
);

insert into prices(product_id, amount, currency_id)
values
(
	(select id from products where products.product_id="apple-airtag"),
	120.57,
	(select id from currencies where currencies.label="USD")
);
