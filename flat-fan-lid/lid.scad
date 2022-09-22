use <../shapes/curved-corner.scad>

$fn = 60;

x = 60;
y = 60;
t = 2;

corner_radius = 2;

hole_diam = 4.5;
hole_offset=2.5;

module lid(x, y, t, corner_radius, hole_diam, hole_offset) {

    difference() {
        cube([ x, y, t ]);
        CurvedInsideCorner(corner_radius, t);
        translate([ x, 0, 0 ]) {
            rotate([ 0, 0, 90 ]) { CurvedInsideCorner(corner_radius, t); }
        }
        translate([ x, y, 0 ]) {
            rotate([ 0, 0, 180 ]) { CurvedInsideCorner(corner_radius, t); }
        }
        translate([ 0, y, 0 ]) {
            rotate([ 0, 0, 270 ]) { CurvedInsideCorner(corner_radius, t); }
        }
        translate([hole_offset*2, hole_offset*2, 0]){
            cylinder(h=t, r=hole_diam/2);
        }
        translate([x-hole_offset*2, hole_offset*2, 0]){
            cylinder(h=t, r=hole_diam/2);
        }
        translate([hole_offset*2, y-hole_offset*2, 0]){
            cylinder(h=t, r=hole_diam/2);
        }
        translate([x-hole_offset*2, y-hole_offset*2, 0]){
            cylinder(h=t, r=hole_diam/2);
        }
    }
}

lid(x, y, t, corner_radius, hole_diam, hole_offset);
// CurvedCorner(corner_radius, t);