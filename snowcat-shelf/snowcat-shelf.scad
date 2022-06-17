use <../shapes/curved-corner.scad>;

$fn =60;

bw = 50;
rw = 10;
rtl = 158;
rti = rtl-40;
rthf = 10;
rh= 8;

holeDist = rtl-21;
// shaftDiam = 11.5;
// shaftDiam = 10;

st = 2;
stl = rtl +40;
railDist = 40;

tweakDist= 2;

td = 18;
td1 = td/8;

module RailThing(){
   
    difference(){
    union(){
        translate([0,0,-37+tweakDist])
        rotate([270,180,0]){
            import("./Middle Rail - 1X.stl");
        }
        // translate([-rw/2,-rtl/2,0])
        // cube([rw, rtl, rthf]);
        // rotate([0, 90, 0]) {
        //     translate([-rthf/2+4, holeDist/2, 0]) {
        //         cylinder(r=shaftDiam/2, h=railDist*4, center=true);
        //     }
        // }
    }
    translate([-40, -rtl/2, -25]) {
        cube([bw,rtl,25]);
    }
    translate([-55, -rtl/2, 0]) {
        cube([bw,rtl,50]);
    }
    translate([-rw/2, -rtl/2, 10]) {
        cube([rw,rtl,50]);
    }
    }
    translate([-rw/2, -rti/2, ]) {
        cube([rw,rti,rthf]);
    }
}

module Holes(){
    hyp = 0;
    tdi = td1/2;
    rotate([0,0,45]){
    translate([-tdi,0,0]){
    rotate([0,270,0]){
        RoundedPrism(40,td,td,3);
    }
    }
    translate([td+tdi,td,0]){
        rotate([0,270,90]){
        RoundedPrism(40,td,td,3);
    }
    }
    translate([tdi,td*2+tdi,0]){
        rotate([0,270,180]){
            RoundedPrism(40,td,td,3);
        }
    }
    translate([-td-tdi,td+tdi,0]){
        rotate([0,270,270]){
            RoundedPrism(40,td,td,3);
        }
    }
    }
}

module shelfThing(){
    holeRadius = 2.5;
    zipDist = 8;
    translate([-railDist/2,0]){
        RailThing();
    }
    translate([railDist/2,0]){
        RailThing();
    }
    difference(){
        translate([-railDist/2-rw/2, -rtl/2,rthf-st+tweakDist]){
            cube([railDist+rw, stl, st]);
        
        }
        translate([0,holeDist/2-zipDist/2,0]){
            cylinder(r=holeRadius, h=30);
            translate([0,zipDist,0]){
                cylinder(r=holeRadius, h=30);
            }
        }
        translate([0,-holeDist/2-zipDist/2,0]){
            cylinder(r=holeRadius, h=30);
            translate([0,zipDist,0]){
                cylinder(r=holeRadius, h=30);
            }
        }
    translate([0,-2,0]){
    translate([railDist/2-td/2+td1,td1*2,0]){
        Holes();
    }

    translate([railDist/2-td/2+td1,td *2-td1,0]){
        Holes();
    }

    translate([railDist/2-td/2+td1,-td *2+td1*5,0]){
        Holes();
    }
    translate([railDist/2-td/2+td1,-td *4+td1*8,0]){
        Holes();
    }
    }
    }
    
}

shelfThing();




// RailThing();
    