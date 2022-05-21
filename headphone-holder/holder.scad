use <../wiki-yoinks/prism.scad>
use <../shapes/oval-tube.scad>

$fn=360;

drawerGap = 5;
drawerThickness = 16.65;
drawerTolerance = 0.1;

drawerNegative = drawerThickness+drawerTolerance;

holderHeight = 30;
holderLength = 90;
holderInner = 78;
holderBackLength = 7;
holderTriangleLength = 13;
holderTriangleHeight = 13;
holderWidth = 20;
holderMinThickness = 8;

holderDiff = (holderLength-holderInner)/2;
buttLength = drawerNegative + holderBackLength;

elipseEccentricity = 4;
elipseRadius = holderInner / elipseEccentricity / 2;


module drawerEdge(){
    translate([-100,0,0]){
        color([0/255, 0/255, 255/255]) {
            cube([200, drawerNegative, holderHeight-drawerGap+drawerTolerance]);
        }
    }
}

module buttAngle(){
    translate([0, buttLength*1.9, holderHeight-1.5]){
        rotate([117, 0, 0]){
            prism(holderWidth, buttLength + holderTriangleLength, holderTriangleHeight*5);
        }
    }
}

module butt(){
    cube([holderWidth, buttLength, holderHeight]);
    translate([0, buttLength*1.54, holderHeight]){
        rotate([180, 0, 0]){
            prism(holderWidth, holderTriangleLength, holderTriangleHeight);
        }
    }
    
}



module holder(){
    color([157/255, 48/255, 0/255]) {
        difference(){       
            butt();
            buttAngle();
        }
    }
    translate([0,-holderLength,0]){
        difference(){
            cube([holderWidth, holderLength, holderHeight]);
            translate([0,0,elipseRadius+holderMinThickness/3*2]){
                translate([0,holderLength/2,0]){
                    rotate([0,90,0]){
                        OvalTube(holderWidth, elipseRadius, elipseEccentricity);
                    }
                }
                translate([0,holderDiff,0]){
                    cube([holderWidth, holderInner, holderHeight]);
                }
            }
        }
    }

}

module smoother(length, height, width){
    id = length*0.9;
    mt = 1;
    el = length /8;
    difference(){
        cube([width, length, el]);
        translate([0,0,el]){
            translate([0,length/2,0]){
                rotate([0,90,0]){
                    OvalTube(width, el, 4);
                }
            }
        }
    }
}
module bottomSmoother(){
    rotate([0,0,90]){
        translate([-250,-holderWidth,0]){
            smoother(holderWidth,10,500);
        }
    }
}
module topSmoother(){
    translate([0, 0, holderHeight]) {
        rotate([180,0,0])
            bottomSmoother();
    }
}

difference() {
    holder();
    drawerEdge();
    bottomSmoother();
    topSmoother();
}
