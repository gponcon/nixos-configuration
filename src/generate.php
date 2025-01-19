<?php

use Darkone\Generator;
use Darkone\NixGenerator\NixException;

define('NIX_PROJECT_ROOT', realpath(__DIR__ . '/..'));

require __DIR__ . '/vendor/autoload.php';

try {
    $generator = new Generator(__DIR__ . '/../usr/config.yaml');
    echo $generator->generate($_SERVER['argv'][1] ?? '');
} catch (NixException $e) {
    echo "ERR: " . $e->getMessage() . PHP_EOL;
    exit(1);
}
