$fn = 360; // Circle/sphere resolution

// Front
//    -----------PORTS-----------
// L  ---------------------------
// E  -A----------------------C--
// F  ---------------------------
// T  --B---------------------D--
//    ---------------------------
// Back

// Generic config
mode = 0; // 0-> DriverBoardHolder, 1-> Feet
cutFront = true;
tapeWidth = 26;

// plate
width = 139.2;
length = 58.2;
desired_thickness = 2;

// hole config
pin_height = 2.5;
pin_foot_height = 3;
pinhole_diam = 3;

// printer
printer_width = 120;
printer_length = 120;

// A
a_2_front = 21;
a_2_right = 125.3;
a_2_back = 37.2;
a_2_left = 13.8;

// C
c_2_front = 21;
c_2_right = 13.6;
c_2_back = 37.2;
c_2_left = 125.6;

// B
b_2_front = 49.3;
b_2_right = 119.3;
b_2_back = 9.2;
b_2_left = 19.6;

// D
d_2_front = 49;
d_2_right = 14.5;
d_2_back = 9.2;
d_2_left = 124.7;

dist = 28.5;
offset_dist = 27.75;

pin_to_back = 7.4;
pin_to_front = 19.5;

module pin(front, right, height, foot_height, diam, board_thickness) {
    z_foot = (board_thickness - 0.1);
    z_pin = (foot_height);
    translate([ right, front, z_foot ]) {
        cylinder(r = diam, h = foot_height + 0.1); // Foot
        translate([ 0, 0, z_pin ]) {               // Pin
            cylinder(r = (diam - 0.4) / 2, h = height + 0.1);
        }
    }
}

module basePlate(width, length, thickness) {
    cube([ width, length, thickness ]);
}

module driverBoard() {
    basePlate(width, length, desired_thickness);
    pin(a_2_front, a_2_right, pin_height, pin_foot_height, pinhole_diam,
        desired_thickness);
    pin(b_2_front, b_2_right, pin_height, pin_foot_height, pinhole_diam,
        desired_thickness);
    pin(c_2_front, c_2_right, pin_height, pin_foot_height, pinhole_diam,
        desired_thickness);
    pin(d_2_front, d_2_right, pin_height, pin_foot_height, pinhole_diam,
        desired_thickness);
}

module printableV2(printer_width, printer_length) {
    intersection() {
        driverBoard();
        dist_x = max(0, (width - printer_width) / 2);
        dist_y = max(0, (length - printer_length) / 2);
        translate([ dist_x, dist_y, -25 ]) {
            cube([ printer_width, printer_length, 50 ]);
        }
    }
}

module prism(width, length, height) {
    polyhedron(points =
                   [
                       [ 0, 0, 0 ], [ width, 0, 0 ], [ width, length, 0 ],
                       [ 0, length, 0 ], [ 0, length, height ],
                       [ width, length, height ]
                   ],
               faces = [
                   [ 0, 1, 2, 3 ], [ 5, 4, 3, 2 ], [ 0, 4, 5, 1 ], [ 0, 3, 4 ],
                   [ 5, 2, 1 ]
               ]);
}

module feet(pos = 0) {
    feetWidth = tapeWidth + 1;
    translate([ feetWidth * pos, 0, 0 ]) {
        , min_length = max(a_2_back, c_2_back);
        prism(feetWidth, 15, min_length);
        cube([ feetWidth, 34, 2 ]);
    }
}

if (mode == 0) {
    if (cutFront) {
        difference() {
            printableV2(printer_width, printer_length);
            translate([ 0, -0.05, -0.05 ]) {
                min_length = min,(a_2_front, c_2_front) - pinhole_diam - 0.5;
                cube([ width, min_length, desired_thickness * 2 ]);
            }
        }
    } else {
        printableV2(printer_width, printer_length);
    }
} else {
    feet();
}























