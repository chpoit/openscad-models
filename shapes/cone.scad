
module Cone(height, radius, top_radius=0, center = false) {
    cylinder(h = height, r1 = radius, r2 = top_radius, center = center);
}

module HalfCone(height, radius, top_radius=0, center = false) {
    difference() {
        Cone(height, radius, top_radius, center);
        translate([-radius, 0, 0]) { cube([radius*2, radius, height]); }
    }
}

module QuarterCone(height, radius, top_radius=0, center = false) {
    difference() {
        Cone(height, radius, top_radius, center);
        translate([-radius, 0, 0]) { cube([radius*2, radius, height]); }
        translate([0, -radius, 0]) { cube([radius, radius, height]); }
    }
}