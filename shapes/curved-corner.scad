

module CurvedCorner(radius, thickness) {
    difference() {
        cylinder(h = thickness, r = radius);
        translate([ -radius * 2, -radius, -0.1 ]) { cube(radius * 2); }
        translate([ -0.1, -radius * 2, -0.1 ]) { cube(radius * 2); }
    }
}

module CurvedInsideCorner(radius, thickness) {

    translate([ radius, radius, 0 ]) {
        rotate([ 0, 0, 180 ]) {
            difference() {
                cube([ radius, radius, thickness ]);
                translate([ 0, 0, -0.1 ]) {
                    cylinder(h = thickness + 0.2, r = radius);
                }
            }
        }
    }
}







