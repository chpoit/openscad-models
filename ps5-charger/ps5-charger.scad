include <ps5-charger-innards.scad>
include <ps5-charger-wing.scad>

fast = false;
// fast = true;
nozzleSize = 0.4;

module rightWing() {
    color([ 250 / 255, 240 / 255, 240 / 255 ]) {
        translate([ 0, wingLength, 0 ]) {
            rotate([ 0, 0, 0 ]) if (fast) {
                SteppedWing(2);
            }
            else {
                SteppedWing(2, steps = 1600);
            }
        }
    }
}

module leftWing() {
    mirror([ 1, 0, 0 ]) {
        rightWing();
    }
}

module body() {
    leftWing();
    rightWing();
    translate([ 0, 5.35, 10.2 ]) {
        Innards();
    }
}

body();
