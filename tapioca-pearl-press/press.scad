$fn = 10;

module base_plate(size_x, size_y, plate_thickness) {
    color([ 205 / 255, 205 / 255, 205 / 255 ]) {
        cube([ size_x, size_y, plate_thickness ]);
    }
}

module pearl(diameter) {
    color([ 155 / 255, 0 / 255, 0 / 255 ]) { sphere(diameter / 2); };
}

module channel(length, diameter, is_x_axis) {
    translate([ 0, 0, 10 ]) {
        if (is_x_axis) {
            rotate([ 270, 0, 0 ]) { cylinder(r = diameter / 2, h = length); }
        } else {
            rotate([ 0, 90, 0 ]) { cylinder(r = diameter / 2, h = length); }
        }
    }
}

module plate_elements() {
    lower_bound = min_border;
    upper_bound_x = floor(size_x / (pearl_spacing)-min_border * 2);
    upper_bound_y = floor(size_y / (pearl_spacing)-min_border * 2);

    for (i = [lower_bound:upper_bound_x]) {
        x_pos = pearl_diameter / 2 + i * pearl_spacing;
        for (j = [lower_bound:upper_bound_y]) {
            {
                if (with_channels && i == j) {
                    channel_size = pearl_diameter / 4;
                    translate(
                        [ pearl_diameter / 2 + i * pearl_spacing, 0, 0 ]) {
                        channel(size_x, channel_size, true);
                    }
                    translate(
                        [ 0, pearl_diameter / 2 + j * pearl_spacing, 0 ]) {
                        channel(size_y, channel_size, false);
                    }

                    color([ 99 / 255, 99 / 255, 0 / 255 ]) {
                        translate([
                            pearl_diameter / 2 + i * pearl_spacing +
                                pearl_spacing / 2,
                            0, 0
                        ]) {
                            channel(size_x, channel_size, true);
                        }
                        translate([
                            0,
                            pearl_diameter / 2 + j * pearl_spacing +
                                pearl_spacing / 2,
                            0
                        ]) {
                            channel(size_y, channel_size, false);
                        }
                    }
                }
                y_pos = pearl_diameter / 2 + j * pearl_spacing;
                translate([ x_pos, y_pos, 10 ]) { pearl(pearl_diameter); }
                color([ 0 / 255, 0 / 255, 0 / 255 ]) {
                    translate([
                        x_pos + pearl_spacing / 2, y_pos + pearl_spacing / 2, 10
                    ]) {
                        pearl(pearl_diameter);
                    }
                }
            }
        }
    }
}

module alignment_holes() { cylinder(); }

module full_plate(size_x, size_y, plate_thickness, pearl_diameter,
                  with_channels, bottom_plate) {
    difference() {
        min_border = 0.3;

        if (bottom_plate) {
            base_plate(size_x, size_y, plate_thickness);
        } else {
            translate([ 0, 0, plate_thickness ]) {
                base_plate(size_x, size_y, plate_thickness);
            }
        }
        pearl_spacing = pearl_diameter + pearl_diameter / 2;
        plate_elements();
    }
}

// base_plate(90,90);

// pearl(5);

full_plate(60, 60, 10, 5, true, false);
// channel(100, 2, true);
