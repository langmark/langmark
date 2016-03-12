<?php

$matrix = array();
$seed = 42;
$sum = 0;

for ($i = 0; $i < 3; $i++) {
    $matrix[$i] = array();
    for ($j = 0; $j < 512; $j++)
        $matrix[$i][$j] = array();
}

for ($i = 0; $i < 2; $i++)
    for ($j = 0; $j < 512; $j++)
        for ($k = 0; $k < 512; $k++) {
            $matrix[$i][$j][$k] = $seed;
            $seed *= 25189;
            $seed %= 32749;
        }

for ($j = 0; $j < 512; $j++)
    for ($k = 0; $k < 512; $k++)
        $matrix[2][$j][$k] = 0;

for ($i = 0; $i < 512; $i++)
    for ($j = 0; $j < 512; $j++) {
        for ($k = 0; $k < 512; $k++) {
            $matrix[2][$i][$j] += $matrix[0][$i][$k] * $matrix[1][$k][$j];
            $matrix[2][$i][$j] &= 0xFFFF;
        }
        $sum += (($i * $j) & 0xFF) * $matrix[2][$i][$j];
        $sum &= 0xFFFF;
    }

if (count($argv) > 1)
    echo $sum;
