module CylindricalBattery(diameter, height, terminalDiameter, terminalHeight, showTerminal) {

    if (showTerminal) {
        color([ 50 / 255, 50 / 255, 50 / 255 ]) {
            cylinder(r = diameter / 2, h = (height - terminalHeight));
        }

        translate([ 0, 0, height - terminalHeight ]) {
            color([ 74 / 255, 48 / 255, 97 / 255 ]) {
                cylinder(r = terminalDiameter / 2, h = terminalHeight);
            }
        }

    } else {
        color([ 50 / 255, 50 / 255, 50 / 255 ]) {
            cylinder(r = diameter / 2, h = height);
        }
    }
}


