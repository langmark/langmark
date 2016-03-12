<?php

ini_set('memory_limit', '-1');

$seed = 3;
$array = array();

for ($i = 0; $i < 4194304; $i++) {
    $array[$i] = $seed;
    $seed = $seed * 27487;
    $seed = $seed % 30491;
}

sort($array);

if (count($argv) > 1)
    echo $array[279121];
