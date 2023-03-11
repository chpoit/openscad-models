use <../wiki-yoinks/prism.scad> // prism(l, w, h)

$fn = 60;

WT = 2;

fan_l = 140;
fan_w = 25;
fan_r = (fan_l - 5) / 2;

pipe_r = 40 / 2;
pipe_conn = 50;

dist = 115;

fan_hole_dist = 7.5;
screw_radius = 2.15;

flats = 25;

carbon_thickness = 3.175;

module fanlike() {
    cube([ fan_l, fan_w, fan_l ]);
}

module screwHole(screw_radius = screw_radius) {
    rotate([ -90, 0, 0 ]) cylinder(r = screw_radius, h = 15);
}

module pinLayout(screw_radius = screw_radius, screw_offset = 0) {
    translate([ fan_hole_dist - screw_offset, 0, fan_hole_dist - screw_offset ]) {
        screwHole(screw_radius);
    }
    translate([ fan_l - fan_hole_dist + screw_offset, 0, fan_hole_dist - screw_offset ]) {
        screwHole(screw_radius);
    }
    translate([ fan_l - fan_hole_dist + screw_offset, 0, fan_l - fan_hole_dist + screw_offset ]) {
        screwHole(screw_radius);
    }
    translate([ fan_hole_dist - screw_offset, 0, fan_l - fan_hole_dist + screw_offset ]) {
        screwHole(screw_radius);
    }
}

module fanMount(screw_radius = screw_radius) {
    difference() {
        cube([ fan_l, WT, fan_l ]);
        translate([ 0, -0.5, 0 ]) { // For z-fighting
            pinLayout(screw_radius);
            translate([ fan_l / 2, 0, fan_l / 2 ]) {
                rotate([ -90, 0, 0 ]) {
                    cylinder(r = fan_r, 10);
                }
            }
        }
    }
}

module pipeThing(r1, r2) {
    color([ r1 / 255, r1 / 255, r1 / 255 ]) {

        hull() {
            translate([ fan_l / 2, -WT / 2, fan_l / 2 ]) {
                rotate([ -90, 0, 0 ]) difference() {
                    cylinder(r = r1 + 2, h = 5, center = true);
                    cylinder(r = r1, h = 5 + 5, center = true);
                }
            }

            translate([ fan_l / 2 - pipe_conn / 2, -dist + flats, 0 ]) {
                translate([ pipe_conn / 2, 0, pipe_conn / 2 ]) {
                    rotate([ -90, 0, 0 ]) difference() {
                        cylinder(r = r2 + WT, h = 1, center = true);
                        cylinder(r = r2, h = 1 + 5, center = true);
                    }
                }
            }
        }
    }
    color([ r2 / 255, r2 / 255, r2 / 255 ]) {
        translate([ fan_l / 2 - pipe_conn / 2, -dist + flats / 2, 0 ]) {
            translate([ pipe_conn / 2, 0, pipe_conn / 2 ]) {
                rotate([ -90, 0, 0 ]) difference() {
                    cylinder(r = r2 + WT, h = flats, center = true);
                    cylinder(r = r2, h = flats + 5, center = true);
                }
            }
        }
    }
}

module pipeConnector() {
    color([ 75 / 255, 255 / 255, 40 / 255 ]) {

        difference() {
            cube([ pipe_conn, WT, pipe_conn ]);
            translate([ 0, -0.5, 0 ]) {
                translate([ pipe_conn / 2, 0, pipe_conn / 2 ]) {
                    rotate([ -90, 0, 0 ]) {
                        cylinder(r = pipe_r, h = 15);
                    }
                }
            }
        }
    }
}

module funnel() {
    fanMount();
    difference() {
        pipeThing(fan_r, pipe_r);
        pipeThing(fan_r - WT, pipe_r - WT);
    }
    translate([ fan_l / 2 - pipe_conn / 2, -dist, 0 ]) {
        pipeConnector();
    }
}

module foot() {
    translate([ 0, -WT, 0 ]) {
        fanMount();
    }

    cube([ WT, carbon_thickness + WT, fan_l ]);
    translate([ fan_l - WT, 0, 0 ]) {
        cube([ WT, carbon_thickness + WT, fan_l ]);
    }
    cube([ fan_l, carbon_thickness + WT, WT ]);
    translate([ 0, carbon_thickness + WT, 0 ]) {
        fanMount(screw_radius * 2.5);
    }
    cube([ fan_l, 75, WT ]);
    color([ 78 / 255, 11 / 255, 87 / 255 ]) {
        translate([ WT, fan_l / 2, 0 ]) {
            rotate([ 0, 0, 180 ]) {
                prism(WT, fan_l / 2, fan_l / 2);
            }
        }

        translate([ fan_l, fan_l / 2, 0 ]) {
            rotate([ 0, 0, 180 ]) {
                prism(WT, fan_l / 2, fan_l / 2);
            }
        }
    }
}

// translate([ 0, -fan_w, 0 ]) {
//     funnel();
// }

foot();
