#!/bin/bash
max_x=5;
max_y=5;

rm -rf output/*
mkdir -p output/grids
mkdir -p output/boxes

for ((i = 1; i<=max_x; i++))
do
    for ((j = i; j<=max_y; j++))
    do
        openscad -o output/grids/grid$i\_$j.stl -D grid_x=$i -D grid_y=$j -D is_single_unit=false ./grid_printer.scad &
        openscad -o output/boxes/box$i\_$j.stl -D box_x=$i -D box_y=$j -D is_single_unit=false ./box_printer.scad &
    done
done
