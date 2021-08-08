$fn = 360;

brick_width = 90;
brick_height = 31.5;

wire_height = 9;
wire_width = 11;
wire_start = 48;

plug_width = 26;
plug_height = 23;

wall_thickness = 4.2;

holder_x = brick_width + wall_thickness * 2;
holder_y = brick_width - 15;
holder_z = brick_height + wall_thickness;

flap_length = 15;
flap_width = holder_y;

screw_diam = 3;

module prism(l, w, h) {
    // from wiki
    // https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids#polyhedron
    polyhedron(points =
                   [
                       [ 0, 0, 0 ], [ l, 0, 0 ], [ l, w, 0 ], [ 0, w, 0 ],
                       [ 0, w, h ], [ l, w, h ]
                   ],
               faces = [
                   [ 0, 1, 2, 3 ], [ 5, 4, 3, 2 ], [ 0, 4, 5, 1 ], [ 0, 3, 4 ],
                   [ 5, 2, 1 ]
               ]);
}

module plug(size_x, size_z) {
    color([ 255 / 255, 0 / 255, 0 / 255 ]) { cube([ size_x, 30, size_z ]); }
}

module cable(wire_width, wire_height) {
    color([ 30 / 255, 30 / 255, 30 / 255 ]) { cube([ wire_width, 75, wire_height ]); }
}

module brick(size_x, size_z, plug_width, plug_height, wire_width, wire_height,
             wire_start) {
    translate([ size_x - plug_width - 16, -10, 5.25 ]) {
        plug(plug_width, plug_height);
    }
    translate([ -wire_width, wire_start-10, size_z/2  -wire_height/2]) {
        cable(wire_width, wire_height);
    }
    color([ 205 / 255, 205 / 255, 205 / 255 ]) {
        cube([ size_x, size_x, size_z ]);
    }
}

module flap(length, width, screw_diam) {
    difference() {
        color([ 0 / 255, 205 / 255, 130 / 255 ]) {
            cube([ length, width, 4 ]);
            translate([ 0, width, 4 ]) {
                rotate([ 0, 0, 270 ]) { prism(5, length, holder_z - 4); }
            }
            translate([ 0, 5, 4 ]) {
                rotate([ 0, 0, 270 ]) { prism(5, length, holder_z - 4); }
            }
        }
        translate(
            [ length / 2 - screw_diam / 4, width / 2 + screw_diam / 4, -1 ])
            cylinder(r = screw_diam / 2, h = 75);
    }
}

module holder(size_x, size_y, size_z) {
    translate([ -wall_thickness, -wall_thickness ]) {
        color([
            0 / 255,
            205 / 2,
            55,
            205 / 255,
        ]) {
            cube([ size_x, size_y, size_z ]);
        }
        translate([ -flap_length, 0, 0 ]) {
            flap(flap_length, flap_width, screw_diam);
        }
        translate([ size_x + flap_length, flap_width, 0 ]) {
            rotate([ 0, 00, 180 ]) {
                flap(flap_length, flap_width, screw_diam);
            }
        }
    }
}
difference() {
holder(holder_x, holder_y, holder_z);
brick(brick_width, brick_height, plug_width, plug_height, wire_width,
      wire_height, wire_start);
}
