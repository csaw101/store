<?php
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

require '../vendor/autoload.php';
require './schema.php';

use GraphQL\GraphQL as GraphQL;

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL); 

$rawInput = file_get_contents('php://input');
if (strlen($rawInput) == 0) {
	return null;
}

$input = json_decode($rawInput, true);
if (json_last_error() !== JSON_ERROR_NONE) {
    error_log('JSON decoding error: ' . json_last_error_msg());
}

$query = isset($input['query']) ? $input['query'] : null;
if (is_null($query)) {
	return null;
}

$variables = isset($input['variables']) ? $input['variables'] : null;

try {
	$result = GraphQL::executeQuery($schema, $query, null, null, $variables);
	$output = $result->toArray();
} catch (\Exception $e) {
    $output = [
        'errors' => [
            [
                'message' => $e->getMessage()
            ]
        ]
    ];
}

echo json_encode($output);
