include <config.scad>
use <ps5-charger-innards.scad>
use <ps5-charger-wing.scad>

// fast = false;
fast = false;
nozzleSize = 0.4;

module RightWing() {
    color([ 250 / 255, 240 / 255, 240 / 255 ]) {
        translate([ 0, wingLength, 0 ]) {
             if (fast) {
                 rotate([ 90, 0, 0 ])
                Wing();
            }
            else {
                SteppedWing(5, steps = 160);
            }
        }
    }
}

module LeftWing() {
    mirror([ 1, 0, 0 ]) {
        RightWing();
    }
}

module body() {
    LeftWing();
    RightWing();
    translate([ 0, 5.35, 10.2 ]) {
        Innards();
    }
}

module Footprint(){
    // hull()
    
    body();
}

module LazyFootprint(){
linear_extrude(height = 15) Bottom();
}

body();
gap = 2;
wGap = 5;
boxW = wingBottomBack+wGap;
boxL = wingLength+gap;
difference(){
translate([-boxW/2,-gap/2, 0])
    cube([boxW,boxL, 15]);
    // translate([0,-1, 0])
    // scale([1.1,1.02,1])
    // Footprint();

    translate([-boxW/2,-30, 15])
    cube([boxW*2,boxL*2, 150]);

    translate([0,0, 1])
    Footprint();

}

// difference(){
//     // translate([-boxW/2,-gap/2, 0])
//     // cube([boxW,boxL, 15]);

//     translate([0,-1, 0])
//     scale([1.1,1.02,1])
//     LazyFootprint();

//     translate([0,0, 1])
//     LazyFootprint();

// }
