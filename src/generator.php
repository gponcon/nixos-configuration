<?php

$tomlConfigFile = __DIR__ . '/../usr/config.toml';

$generator = new \Dnf\Generator($tomlConfigFile);
$generator->generate();
