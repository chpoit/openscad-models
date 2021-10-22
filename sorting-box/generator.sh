#!/bin/bash
max_x=5;
max_y=5;

rm -rf output/*
mkdir -p output/grids
mkdir -p output/boxes
declare -a SideArray=("A" "B");
declare -a PositionArray=("center" "left" "right");

for ((i = 1; i<=max_x; i++))
do
    for ((j = i; j<=max_y; j++))
    do
        openscad -q  -o output/grids/grid_$i\x$j.stl -D grid_x=$i -D grid_y=$j ./grid_printer.scad &
        
        mkdir -p output/boxes/box_$i\x$j
        
        openscad -q  -o output/boxes/box_$i\x$j/box_$i\x$j.stl -D box_x=$i -D box_y=$j -D with_lip=false ./box_printer.scad &
        for pos in ${PositionArray[@]};
        do
            if [ $i != $j ]; then
                for side in ${SideArray[@]};
                do
                    openscad -q  -o output/boxes/box_$i\x$j/box_$i\x$j\_lip_$pos\_$side.stl -D box_x=$i -D box_y=$j \
                    -D "label_side=\"$side\"" -D "label_pos=\"${pos}\"" ./box_printer.scad &
                done
            else
                openscad -q  -o output/boxes/box_$i\x$j/box_$i\x$j\_lip_$pos.stl -D box_x=$i -D box_y=$j \
                -D "label_side=\"A\"" -D "label_pos=\"${pos}\"" ./box_printer.scad &
            fi
        done
    done
done
