// This is for the secondary driver board that has the buttons

$fn = 360;

tape_width = 26;

//pin
hole_diam = 2.75; //I went a bit smaller so I wouldn't thread into the board itself, and I had matching screws
actual_hole_diam = 3;
pin_foot_height = 4;

//Board
board_thickness = 2;
board_length = 105;
board_width = 22;

hole_dist_in = 81.7; 
hole_dist_out = 87.6;
hole_center_dist = hole_dist_out - hole_diam;

module pin(x = 0) {
    z_foot = (board_thickness - 0.1);
    z_pin = (foot_height);
    translate([ x, 0, 0 ]) {
        difference() {
            color([ 0.5, 0.1, 0.1 ]) cylinder(r = hole_diam + 1, h = pin_foot_height);
            cylinder(r = hole_diam / 2, h = pin_foot_height);
        }
    }
}

module controller_board() {
    final_width = max(board_width, tape_width);
    color([0.5,0.5,0.5]) cube([ board_length, final_width, board_thickness ], center = true);
    translate([ 0, 0, board_thickness / 2 ]) {
        pin_x = hole_center_dist / 2;
        pin(pin_x);
        pin(-pin_x);
    }
}

controller_board();