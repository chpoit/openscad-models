$fn = 30;

gen_bottom_plate = false;
with_channels = true;

plate_thickness = 7;

// Working params
// p_d = 5, x,y=60
// p_d = 6.6, x,y=66
// p_d = 8, x,y=68
pearl_diameter = 8;

size_x = 68;
size_y = 68;

//TODO: Look into adding holes for metal rods instead of thing plastic ridges
// The code is not that clean, and is mostly in a "it works" state.

module base_plate(size_x, size_y, plate_thickness) {
    color([ 205 / 255, 205 / 255, 205 / 255 ]) {
        cube([ size_x, size_y, plate_thickness ]);
    }
}

module pearl(diameter) {
    color([ 155 / 255, 0 / 255, 0 / 255 ]) { sphere(diameter / 2); };
}

module channel(length, diameter, plate_thickness, is_x_axis) {
    translate([ 0, 0, plate_thickness ]) {
        if (is_x_axis) {
            rotate([ 270, 0, 0 ]) { cylinder(r = diameter / 2, h = length); }
        } else {
            rotate([ 0, 90, 0 ]) { cylinder(r = diameter / 2, h = length); }
        }
    }
}

module plate_elements(size_x, size_y, pearl_diameter, pearl_spacing, plate_thickness,
                      with_channels) {
    lower_bound = 0;
    upper_bound_x = floor(size_x / pearl_spacing);
    upper_bound_y = floor(size_y / pearl_spacing);

    for (i = [lower_bound:upper_bound_x]) {
        x_pos = pearl_diameter / 2 + i * pearl_spacing;
        for (j = [lower_bound:upper_bound_y]) {
            {
                if (with_channels && i == j) {
                    channel_size = pearl_diameter / 4;
                    translate(
                        [ pearl_diameter / 2 + i * pearl_spacing, 0, 0 ]) {
                        channel(size_x, channel_size, plate_thickness, true);
                    }
                    translate(
                        [ 0, pearl_diameter / 2 + j * pearl_spacing, 0 ]) {
                        channel(size_y, channel_size, plate_thickness, false);
                    }

                    color([ 99 / 255, 99 / 255, 0 / 255 ]) {
                        translate([
                            pearl_diameter / 2 + i * pearl_spacing +
                                pearl_spacing / 2,
                            0, 0
                        ]) {
                            channel(size_x, channel_size, plate_thickness, true);
                        }
                        translate([
                            0,
                            pearl_diameter / 2 + j * pearl_spacing +
                                pearl_spacing / 2,
                            0
                        ]) {
                            channel(size_y, channel_size, plate_thickness, false);
                        }
                    }
                }
                y_pos = pearl_diameter / 2 + j * pearl_spacing;
                translate([ x_pos, y_pos, plate_thickness ]) { pearl(pearl_diameter); }
                color([ 0 / 255, 0 / 255, 0 / 255 ]) {
                    translate([
                        x_pos + pearl_spacing / 2, y_pos + pearl_spacing / 2, plate_thickness
                    ]) {
                        pearl(pearl_diameter);
                    }
                }
            }
        }
    }
}

module single_ridge(length, diameter, plate_thickness, pearl_diameter, is_x_axis) {
    module ridge(length, diameter, plate_thickness, pearl_diameter) {
        translate([0,0,length/6]){
        translate([ 0, -diameter / 2]) {
            cube([ plate_thickness, diameter, length/3*2 ]);
        }
        cylinder(r = diameter / 2, h = length/3*2);
        }
    }
    translate([ 0, 0, plate_thickness * 1.1 ]) {
        if (is_x_axis) {
            rotate([ 270, 90, 0 ]) { ridge(length, diameter, plate_thickness); }
        } else {
            rotate([ 0, 90, 0 ]) { ridge(length, diameter, plate_thickness); }
        }
    }
}

module ridges(size_x, size_y, ridge_x, ridge_y, ridge_thickness,
                  plate_thickness, pearl_diameter, min_border) {
        translate([ size_x - min_border / 5 * 3, min_border, 0 ]) {
            single_ridge(ridge_x, ridge_thickness, plate_thickness, pearl_diameter,true);
        }
        translate([ min_border, size_y - min_border / 5 * 3, 0 ]) {
            single_ridge(ridge_y, ridge_thickness, plate_thickness, pearl_diameter,false);
        }
    }

module full_plate(size_x, size_y, plate_thickness, pearl_diameter,
                  with_channels, bottom_plate) {
    
    min_border = 5; // milimeters, will actually be double for the ridges
    ridge_thickness = 3;
    sub_x = size_x - min_border * 2;
    sub_y = size_y - min_border * 2;

    difference() {

        if (bottom_plate) {
            base_plate(size_x, size_y, plate_thickness);
        } else {
            difference() {
                translate([ 0, 0, plate_thickness ]) {
                    base_plate(size_x, size_y, plate_thickness);
                }
                ridges(size_x, size_y, sub_x+0.5, sub_y+0.5, ridge_thickness + 0.5,
                       plate_thickness*4, pearl_diameter, min_border);
            }
        }

        pearl_spacing = pearl_diameter + pearl_diameter / 2;
        plate_elements(sub_x, sub_y, pearl_diameter, pearl_spacing, plate_thickness,
                       with_channels);
    }
    if (bottom_plate) {
        ridges(size_x, size_y, sub_x, sub_y, ridge_thickness, plate_thickness, pearl_diameter,
               min_border);
    }
}

full_plate(size_x, size_y, plate_thickness, pearl_diameter, with_channels, gen_bottom_plate);

