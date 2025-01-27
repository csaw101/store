<?php

use GraphQL\Type\Schema;
use GraphQL\Type\Definition\Type;
use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\InputObjectType;

require './config.php';

try {
	// error_log(print_r("connecting to database... ", true));
    $pdo = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME, DB_USER, DB_PASS);
	$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
	die("Could not connect to the database: " . $e->getMessage());
}

$categoryType = new ObjectType([
	'name' => 'Category',
	'fields' => [
		'id' => ['type' => Type::int()],
		'name' => ['type' => Type::string()],
	],
]);

$Color = new ObjectType([
	'name' => 'Color',
	'fields' => [
		'name' => ['type' => Type::string()],
		'value' => ['type' => Type::string()],
	],
]);

$Size = new ObjectType([
	'name' => 'Size',
	'fields' => [
		'name' => ['type' => Type::string()],
		'value' => ['type' => Type::string()],
	],
]);

$Capacity = new ObjectType([
	'name' => 'Capacity',
	'fields' => [
		'name' => ['type' => Type::string()],
		'value' => ['type' => Type::string()],
	],
]);

$Attributes = new ObjectType([
	'name' => 'Attributes',
	'fields' => [
		'colors' => ['type' => Type::listof($Color)],
		'sizes' => ['type' => Type::listof($Size)],
		'capacities' => ['type' => Type::listof($Capacity)],
		'usb3' => ['type' => Type::boolean()],
		'touchID' => ['type' => Type::boolean()],
	],
]);

$productsType = new ObjectType([
	'name' => 'Products',
	'fields' => [
		'id' => ['type' => Type::int()],
		'name' => ['type' => Type::string()],
		'image' => ['type' => Type::string()],
		'in_stock' => ['type' => Type::boolean()],
		'price' => ['type' => Type::float()],
        'currency' => ['type' => Type::string()],
	],
]);

$productType = new ObjectType([
    'name' => 'Product',
    'fields' => [
        'id' => ['type' => Type::int()],
        'name' => ['type' => Type::string()],
        'price' => ['type' => Type::float()],
		'in_stock' => ['type' => Type::boolean()],
        'currency' => ['type' => Type::string()],
        'description' => ['type' => Type::string()],
		'images' => ['type' => Type::listof(Type::string())],
		'colors' => ['type' => Type::listof($Color)],
		'sizes' => ['type' => Type::listof($Size)],
		'capacities' => ['type' => Type::listof($Capacity)],
		'usb3' => ['type' => Type::boolean()],
		'touchID' => ['type' => Type::boolean()],
    ],
]);

$queryType = new ObjectType([
	'name' => 'Query',
	'fields' => [
		'products' => [
			'type' => Type::listof($productsType),
			'args' => [
				'id' => Type::int(),
				'page' => Type::int(),
				'products_per_page' => Type::int(),
			],
			'resolve' => function ($rootValue, array $args) use ($pdo) {
				$id = $args['id'];
				$filterCategory = "";
				if ($id == 2 || $id == 3) {
					$filterCategory = " and product.category_id={$id}";
				}
				$m = $args['products_per_page'] * ($args['page'] - 1);
				$n = $args['products_per_page'] * $args['page'];
				$newQuery = "
					with ranked_images as (
						select img.product_id, img.url, row_number() over (partition by img.product_id order by img.id) as rank from gallery img
					)
					select product.id, product.name, ranked_image.url as image, product.in_stock, price.amount as price, currency.symbol as currency
					from products product
					join prices price
					on price.product_id=product.id
					join currencies currency
					on currency.id=price.currency_id
					join ranked_images ranked_image
					on product.id=ranked_image.product_id where ranked_image.rank=1 {$filterCategory} limit {$m}, {$n}
				";

				$stmt = $pdo->query($newQuery);
				return $stmt->fetchAll(PDO::FETCH_ASSOC);
			},
		],

		'attributes' => [
			'type' => $Attributes,
			'args' => [
				'id' => Type::int(),
			],
			'resolve' => function ($rootValue, array $args) use ($pdo) {
				$colorsQuery = "
					select color.name, color.value from products product
					join product_color pc on pc.product_id=product.id
					join colors color on pc.color_id=color.id where product.id={$args['id']}
				";
				$sizesQuery = "
					select size.name, size.value from products product
					join product_size ps on ps.product_id=product.id
					join sizes size on ps.size_id=size.id where product.id={$args['id']}
				";
				$capacitiesQuery = "
					select capacity.name, capacity.value from products product
					join product_capacity pc on pc.product_id=product.id
					join capacities capacity on pc.capacity_id=capacity.id where product.id={$args['id']}
				";
				$usb3Query = "select product_id from product_usb3 where product_id={$args['id']}";
				$touchIDQuery = "select product_id from product_touchID where product_id={$args['id']}";
				$colorsStmt = $pdo->query($colorsQuery);
				$sizesStmt = $pdo->query($sizesQuery);
				$capacitiesStmt = $pdo->query($capacitiesQuery);
				$usb3Stmt = $pdo->query($usb3Query);
				$touchIDStmt = $pdo->query($touchIDQuery);

				$colors = $colorsStmt->fetchAll(PDO::FETCH_ASSOC);
				$sizes = $sizesStmt->fetchAll(PDO::FETCH_ASSOC);
				$capacities = $capacitiesStmt->fetchAll(PDO::FETCH_ASSOC);
				$usb3 = $usb3Stmt->fetch(PDO::FETCH_ASSOC);
				$touchID = $touchIDStmt->fetch(PDO::FETCH_ASSOC);

				$result['colors'] = $colors;
				$result['sizes'] = $sizes;
				$result['capacities'] = $capacities;
				$result['usb3'] = $usb3;
				$result['touchID'] = $touchID;
				return $result;
			}
		],

		'product' => [
			'type' => $productType,
			'args' => [
				'id' => Type::int(),
			],
			'resolve' => function ($rootValue, array $args) use ($pdo) {
				$id = $args['id'];
				$productQuery = "
					select product.id, product.name, product.in_stock, product.description, price.amount as price, currency.symbol as currency
					from products product
					join prices price on price.product_id=product.id
					join currencies currency on currency.id=price.currency_id
					where product.id={$id}
				";

				$imagesQuery = "select img.url from gallery img where img.product_id={$id}";
				$colorsQuery = "
					select color.name, color.value from products product
					join product_color pc on pc.product_id=product.id
					join colors color on pc.color_id=color.id where product.id={$id}
				";
				$sizesQuery = "
					select size.name, size.value from products product
					join product_size ps on ps.product_id=product.id
					join sizes size on ps.size_id=size.id where product.id={$id}
				";
				$capacitiesQuery = "
					select capacity.name, capacity.value from products product
					join product_capacity pc on pc.product_id=product.id
					join capacities capacity on pc.capacity_id=capacity.id where product.id={$args['id']}
				";
				$usb3Query = "select product_id from product_usb3 where product_id={$args['id']}";
				$touchIDQuery = "select product_id from product_touchID where product_id={$args['id']}";

				$productStmt = $pdo->query($productQuery);
				$imagesStmt = $pdo->query($imagesQuery);
				$colorsStmt = $pdo->query($colorsQuery);
				$sizesStmt = $pdo->query($sizesQuery);
				$capacitiesStmt = $pdo->query($capacitiesQuery);
				$usb3Stmt = $pdo->query($usb3Query);
				$touchIDStmt = $pdo->query($touchIDQuery);

				$productResult = $productStmt->fetch(PDO::FETCH_ASSOC);
				$imagesResult = $imagesStmt->fetchAll(PDO::FETCH_ASSOC);
				$colorsResult = $colorsStmt->fetchAll(PDO::FETCH_ASSOC);
				$sizesResult = $sizesStmt->fetchAll(PDO::FETCH_ASSOC);
				$capacitiesResult = $capacitiesStmt->fetchAll(PDO::FETCH_ASSOC);
				$usb3Result = $usb3Stmt->fetch(PDO::FETCH_ASSOC);
				$touchIDResult = $touchIDStmt->fetch(PDO::FETCH_ASSOC);

				$imgs = array();
				foreach ($imagesResult as $value) {
					array_push($imgs, $value['url']);
				}
				$colors = array();
				foreach ($colorsResult as $value) {
					array_push($colors, $value);
				}
				$sizes = array();
				foreach ($sizesResult as $value) {
					array_push($sizes, $value);
				}
				$capacities = array();
				foreach ($capacitiesResult as $value) {
					array_push($capacities, $value);
				}

				$productResult['images'] = $imgs;
				$productResult['colors'] = $colors;
				$productResult['sizes'] = $sizes;
				$productResult['capacities'] = $capacities;
				if (isset($usb3Result['product_id'])) {
					$productResult['usb3'] = true;
				} else {
					$productResult['usb3'] = false;
				}
				if (isset($touchIDResult['product_id'])) {
					$productResult['touchID'] = true;
				} else {
					$productResult['touchID'] = false;
				}

				return $productResult;
			},
		],

		'categories' => [
			'type' => Type::listof($categoryType),
			'resolve' => function () use ($pdo) {
				$stmt = $pdo->query("select category.id, category.name from categories category");
				return $stmt->fetchAll(PDO::FETCH_ASSOC);
			}
		],
	],
]);

$orderedProductType = new InputObjectType([
	'name' => 'OrderedProduct',
	'fields' => [
		'id' => ['type' => Type::int()],
		'amount' => ['type' => Type::int()],
		'color' => ['type' => Type::string()],
		'size' => ['type' => Type::string()],
		'capacity' => ['type' => Type::string()],
		'usb3' => ['type' => TYpe::boolean()],
		'touchID' => ['type' => TYpe::boolean()],
	],
]);

$orderType = new InputObjectType([
	'name' => 'Order',
	'fields' => [
		'id' => ['type' => Type::int()],
		'product_list' => ['type' => Type::listof($orderedProductType)],
	],
]);

$mutationType = new ObjectType([
	'name' => 'Mutation',
	'fields' => [
		'createOrder' => [
			'type' => $orderType,
			'args' => [
				'order' => ['type' => Type::listof($orderedProductType)],
			],
			'resolve' => function ($root, $args) use ($pdo) {
				$total = 0;
				foreach ($args['order'] as $product) {
					$priceQuery = $pdo->query("select amount from prices price where price.product_id={$product['id']}");
					$productPrice = $priceQuery->fetch(PDO::FETCH_ASSOC);
					$total += $productPrice['amount'] * $product['amount'];
				}
				$insertOrderQuery = $pdo->query("insert into orders(order_time, total) values(now(), {$total})");
				$orderId = $pdo->lastInsertId();
				foreach ($args['order'] as $product) {
					$color = isset($product['color']) && strlen($product['color']) != 0 ? "'{$product['color']}'" : "NULL";
					$size = isset($product['size']) && strlen($product['size']) != 0 ? "'{$product['size']}'" : "NULL";
					$capacity = isset($product['capacity']) && strlen($product['capacity']) != 0 ? "'{$product['capacity']}'" : "NULL";

					if (isset($product['usb3'])) {
						if ($product['usb3'] == true) $usb3 = true;
						else $usb3 = 0;
					} else {
						$usb3 = "NULL";
					}
					if (isset($product['touchID'])) {
						if ($product['touchID'] == true) $touchID = true;
						else $touchID = 0;
					} else {
						$touchID = "NULL";
					}
					$stmt = $pdo->query("
						insert into order_products(order_id, product_id, amount, color, size, capacity, usb3, touchID)
						values({$orderId}, {$product['id']}, {$product['amount']}, {$color}, {$size}, {$capacity}, {$usb3}, {$touchID})
					");
				}
			},
		],
	],
]);

$schema = new Schema([
	'query' => $queryType,
	'mutation' => $mutationType,
]);
