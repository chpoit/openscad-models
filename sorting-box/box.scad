use <../wiki-yoinks/prism.scad>
include <config.scad>
use <grid.scad>

module Slope(slope_x, slope_y, slope_pitch) {
    translate([ 0, slope_y - slope_pitch, 0 ]) {
        prism(slope_x, slope_pitch, box_height);
    }
    translate([ slope_pitch, 0, 0 ]) {
        rotate([ 0, 0, 90 ]) { prism(slope_y, slope_pitch, box_height); }
    }
    translate([ slope_x, slope_pitch, 0 ]) {
        rotate([ 0, 0, 180 ]) { prism(slope_x, slope_pitch, box_height); }
    }
    translate([ slope_x - slope_pitch, slope_y, 0 ]) {
        rotate([ 0, 0, 270 ]) { prism(slope_y, slope_pitch, box_height); }
    }
}

module InnerBox(box_size_x, box_size_y, wall_size) {
    wall_offset = (wall_size + slope_pitch * 2);
    inner_x = box_size_x - wall_offset;
    inner_y = box_size_y - wall_offset;
    translate([ 0, 0, wall_offset/2 ]) {
        difference() {
            translate([ wall_offset / 2, wall_offset / 2, 0 ]) {
                cube([ inner_x, inner_y, box_height ]);
            }
            translate([ wall_offset / 2, wall_offset / 2, 0 ]) {
                Slope(inner_x, inner_y, slope_pitch);
            }
            MultiGrid(grid_size, grid_height, ceil(box_x), ceil(box_y));
        }
    }
}

module Container(box_height, grid_size, grid_height, slope_pitch, wall_size,
                 box_x, box_y) {

    box_size_x = grid_size * box_x;
    box_size_y = grid_size * box_y;

    difference() {
        cube(size = [ grid_size * box_x, grid_size * box_y, box_height ]);
        MultiGrid(grid_size, grid_height, ceil(box_x), ceil(box_y));
        Slope(box_size_x, box_size_y, slope_pitch);
        InnerBox(box_size_x, box_size_y, wall_size);
    }
}

if (is_single_unit) {
    Container(box_height, grid_size, grid_height, slope_pitch, wall_size, box_x,
          box_y);
}




