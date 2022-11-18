$fn = 360;

withHandle = true;

wadDiam = 57;
height = 140;

gap = 3;
thickness = 1.6; // 0.8mm nozzle*2

r = wadDiam / 2 + gap + thickness;
innerR = wadDiam / 2 + gap;

bt = 3;

opening = 30;

module Holder() {
    difference() {
        cylinder(r = r, h = height);
        cylinder(r = innerR, h = height);
        translate([ r / 2, -opening / 2, 0 ]) {
            cube(size = [ opening, opening, height ]);
        }
    }
    translate([ 0, 0, -bt ]) {
        cylinder(r = r, h = bt);
    }
}

module Lid(withHandle = false) {
    difference() {
        translate([ 0, 0, height + bt*2 ]) {
            union() {
                cylinder(r = r, h = 3);
                translate([ 0, 0, -bt ]) {
                    cylinder(r = innerR - 0.5, h = 3);
                }
            }
        }
        if (withHandle) {
            cylinder(r = bt, h = height * 3);
        }
    }
}

module Handle(){
    translate([0,0,height+bt*4]){
        cylinder(r=bt-0.1, h=bt*3, center=false);
        translate([0, 0, bt*4]) {
            sphere(r=bt*2);
        }
    }

}

// Holder();
// Lid(withHandle);
// if (withHandle){
Handle();
// }