use <../shapes/cone.scad>
use <../wiki-yoinks/prism.scad>
include <config.scad>
use <grid.scad>

module Lip(lip_width, lip_length, lip_thickness, angle = 48) {
    color([ 255 / 255, 125 / 255, 125 / 255 ]) {
        cube([ lip_width, lip_length, lip_thickness ]);
    }
    color([ 255 / 255, 125 / 255, 255 / 255 ]) {
        opposite = tan(angle) * lip_length;

        translate([ lip_width, 0, 0 ]) rotate([ -90, -90, 0 ]) {
            QuarterCone(lip_length, opposite);
        }

        translate([ 0, 0, 0 ]) rotate([ -90, 180, 0 ]) {
            QuarterCone(lip_length, opposite);
        }
    }
    // QuarterCone(lip_length, opposite);
}

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
    translate([ 0, 0, wall_offset / 2 ]) {
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

module LipPosPrinter(box_height, box_side_dimension, lip_width, lip_length,
                     lip_thickness, slope_adjust, label_pos) {
    if (label_pos == "center") {
        x_translate = (box_side_dimension - lip_width) / 2;
        translate([ x_translate, slope_adjust, box_height - lip_thickness ]) {
            Lip(lip_width, lip_length, lip_thickness);
        }
    } else if (label_pos == "opposite") {
        x_translate = box_side_dimension - lip_width - slope_adjust;
        translate([ x_translate, slope_adjust, box_height - lip_thickness ]) {
            Lip(lip_width, lip_length, lip_thickness);
        }

    } else {
        translate([ slope_adjust, slope_adjust, box_height - lip_thickness ]) {
            Lip(lip_width, lip_length, lip_thickness);
        }
    }
}

module LipBuilder(box_height, grid_size, box_size_x, box_size_y, wall_size,
                  label_pos, label_side) {
    lip_width = grid_size / 3 * 2;
    lip_length = 12;
    lip_thickness = wall_size;
    slope_adjust = wall_size;
    // x_translate = (box_size_x-lip_width)/2;

    if (label_side == "A") {
        LipPosPrinter(box_height, box_size_x, lip_width, lip_length,
                      lip_thickness, slope_adjust, label_pos);
    } else if (label_side == "B") {
        translate([ 0, box_size_y, 0 ]) {
            rotate([ 0, 0, -90 ]) {
                LipPosPrinter(box_height, box_size_y, lip_width, lip_length,
                              lip_thickness, slope_adjust, label_pos);
            }
        }
    }
}

module Container(box_height, grid_size, grid_height, slope_pitch, wall_size,
                 box_x, box_y, with_lip = true, label_pos = "center",
                 label_side = "A") {

    box_size_x = grid_size * box_x;
    box_size_y = grid_size * box_y;

    difference() {
        union() {
            difference() {
                color([ 75 / 255, 75 / 255, 75 / 255 ]) {
                    cube(size = [
                        grid_size * box_x, grid_size * box_y,
                        box_height
                    ]);
                }
                Slope(box_size_x, box_size_y, slope_pitch);
                InnerBox(box_size_x, box_size_y, wall_size);
            }
            if (with_lip) {
                LipBuilder(box_height, grid_size, box_size_x, box_size_y,
                           wall_size, label_pos, label_side);
            }
        }
        MultiGrid(grid_size, grid_height, ceil(box_x), ceil(box_y));
    }
}

Container(box_height, grid_size, grid_height, slope_pitch, wall_size, box_x,          box_y, with_lip, label_pos, label_side);