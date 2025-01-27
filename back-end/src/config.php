<?php
define('DB_HOST', 'localhost');
define('DB_NAME', 'estore');
define('DB_USER', 'john');
define('DB_PASS', 'john');
$test = getenv('PATH');
error_log(print_r("hit" . $test, true));
