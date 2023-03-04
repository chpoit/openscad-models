$fn = 360;

// all = true;
// show_tr = true;
// show_tl = true;
// show_br = true;
show_bl = true;
// show_rad = true;
// show_deletion_cubes=true;

// holder space
space_on_top = 24;
space_on_bottom = 14;
extra_thickness = 15;

internal_case_height = 440;

radiator_height = 400;
radiator_width = 130;
radiator_thickness = 38.5;

top_2_hole = 35;
bottom_2_hole = 20.5;
side_2_holde = 13;
long_fan_dist = 105.5;
short_fan_dist = 15.5;

// port
port_diameter = 20;
port_radius = port_diameter / 2;
port_height = 15;
port_top_2_top = 4.5;
port_bottom_2_top = 24.5;
port_center_2_side = 44.3;
port_outer_2_side = 24.3;

// fitting
fitting_diam = 22;
fitting_radius = fitting_diam / 2;
dist_from_rad = 5.5;
fitting_height = 13.5;

// logo
logo_diam = 16.75;
logo_radius = logo_diam / 2;
logo_thick = 1.5;
logo_2_side = 5.5;

free_space = internal_case_height - radiator_height;

module fitting(x = 0, y = 0, z = dist_from_rad) {
    translate([ x, y, z ]) {
        color([ 0.5, 0.9, 0.9 ])
            cylinder(r = fitting_radius, h = fitting_height);
    }
}

module port(x = 0, y = 0, z = 0, substraction_cube = false) {
    translate([ x, y, z ]) {
        color([ 0.7, 0.7, 0.7 ]) cylinder(r = port_radius, h = port_height);

        if (substraction_cube) {
            translate([ 0, port_radius, port_height / 2 ]) {
                color([ 0.7, 0, 0 ])
                    cube([ port_diameter, port_diameter, port_height * 1.5 ],
                         center = true);
            }
        }

        fitting();
    }
}

module ek_logo(x, y, z, substraction_cube = false) {
    translate([ x, y, z ]) {
        color([ 0.5, 0.2, 0.3 ]) cylinder(r = logo_radius, h = logo_thick);

        if (substraction_cube) {
            translate([ 0, logo_radius, logo_thick / 2 ]) {
                color([ 0.7, 0, 0 ])
                    cube([ logo_diam, logo_diam, logo_thick ], center = true);
            }
        }
    }
}

module radiator(substraction_cube = false) {
    color([ 0.15, 0.15, 0.15 ])
        cube([ radiator_width, radiator_height, radiator_thickness ]);
    x = port_outer_2_side + port_radius;
    y = port_top_2_top + port_radius;
    z = radiator_thickness;
    port(x, y, z, substraction_cube);
    x_2 = radiator_width - port_radius - port_outer_2_side;
    port(x_2, y, z, substraction_cube);

    x_3 = radiator_width - logo_2_side - logo_radius;
    ek_logo(x_3, y, z, substraction_cube);

    if (substraction_cube){
        translate([0, radiator_height-30,radiator_thickness]){
            color([ 0.7, 0, 0])
                cube([ radiator_width, 30, 20 ]);
        }
    }
}

module holder(extra_thickness = 10, x, y) {
    translate([ x, y, -extra_thickness / 2 ]) {
        cube([
            70, space_on_top + free_space / 2, radiator_thickness +
            extra_thickness
        ]);
    }
}

module bottom_holder(extra_thickness = 10, x, y) {
    translate([ x, y, -extra_thickness / 2 ]) {
        cube([
            70, space_on_bottom + free_space / 2, radiator_thickness +
            extra_thickness
        ]);
    }
}

module topleft_holder(extra_thickness = 10) {
    difference() {
        x = -10;
        y = -free_space / 2;
        holder(extra_thickness, x, y);
        radiator(substraction_cube = true);
    }
}

module topright_holder(extra_thickness = 10) {
    difference() {
        x = radiator_width / 2 + 5;
        y = -free_space / 2;
        holder(extra_thickness, x, y);
        radiator(substraction_cube = true);
    }
}

module bottomright_holder(extra_thickness = 10) {
    difference() {
        x = radiator_width / 2 + 5;
        y = radiator_height - space_on_bottom;
        bottom_holder(extra_thickness, x, y);
        radiator(substraction_cube = true);
    }
}
module bottomleft_holder(extra_thickness = 10) {
    difference() {
        x = -10;
        y = radiator_height - space_on_bottom;
        bottom_holder(extra_thickness, x, y);
        radiator(substraction_cube = true);
    }
}

if (all) {
    topright_holder();
    topleft_holder();
    bottomright_holder();
    bottomleft_holder();
}

if (show_tr) {
    topright_holder();
}
if (show_tl) {
    topleft_holder();
}
if (show_br) {
    bottomright_holder();
}
if (show_bl) {
    bottomleft_holder();
}

if (show_rad) {
    radiator(show_deletion_cubes);
}











































