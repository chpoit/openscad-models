use <../wiki-yoinks/prism.scad> //prism(l, w, h)


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


module RoundedRectangle(l,w,h, radius=0.5){
    difference(){
        cube(size=[l, w, h]);
        translate([-0.05,-0.05,-h/2]){
            CurvedInsideCorner(radius+0.1, h*2);
        }
        translate([-0.05,w+0.05,-h/2]){
            rotate([0, 0, 270]) {
                CurvedInsideCorner(radius+0.1, h*2);
                
            }
            
            translate([l+0.1,0,0]){
                rotate([0, 0, 180]) {
                    CurvedInsideCorner(radius+0.1, h*2);
                }
            }
        }
        translate([l+0.05,-0.05,-h/2]){
            rotate([0, 0, 90]) {
                CurvedInsideCorner(radius+0.1, h*2);
            }
        }
    }
}


module RoundedPrism(l,w,h, radius=0.5){
    hyp = sqrt(w*w+h*h); 
    difference(){
        prism(l, w, h);
        translate([-l/2,0,0]){
            rotate([0, 90, 0]) {
                rotate([0, 0, acos(w/hyp)]) {
                    CurvedInsideCorner(radius+0.1, l*2);
                    rotate([0, 0, acos(w/hyp)/2]) {
                         CurvedInsideCorner(radius+0.1, l*2);
                         rotate([0, 0, acos(w/hyp)/4]) {
                         CurvedInsideCorner(radius+0.1, l*2);
                    }
                    }
                }
            }
        }
        translate([-l/2+0.05,w+0.05,0]){
            rotate([90, 270, 90]) {
                CurvedInsideCorner(radius+0.1, l*2);
            }
        }
        translate([-l/2,w,h]){
            rotate([90, 180-asin(h/hyp), 90]) {
                CurvedInsideCorner(radius+0.1, l*2);
                rotate([0, 0, -asin(h/hyp)/2]) {
                    CurvedInsideCorner(radius+0.1, l*2);
                    rotate([0, 0, -asin(h/hyp)/4]) {
                    CurvedInsideCorner(radius+0.1, l*2);
                }
                }
            }
        }
    }
}

