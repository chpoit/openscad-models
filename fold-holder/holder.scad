use <GoPro_Mount.scad>
use <../wiki-yoinks/prism.scad>

phoneCaseThickness = 10.55;
usableHeight = 65;
phoneLength = 160.9;
phoneWidth = 130;

holderThickness = 2.4;
flapWidth = 2.4;

module Phone() {
    color([ 75 / 255, 0 / 255, 0 / 255 ]) {
        cube(size = [ phoneLength, phoneWidth, phoneCaseThickness ], center = true);
    }
}

module Holder() {
    dim = [ phoneLength + holderThickness, usableHeight + holderThickness, phoneCaseThickness + holderThickness ];
    color([ 75 / 255, 75 / 255, 75 / 255 ]) {
        difference() {
            cube(dim, center = true);

            translate([ 0, -holderThickness - 3, phoneCaseThickness / 2 ]) {
                cube(size = [ phoneLength - holderThickness * 3, usableHeight + holderThickness, phoneCaseThickness ],
                     center = true);
            }
            translate([ 0, -usableHeight / 2, 0 ]) {
                Phone();
            }
        }
    }

    l = 30;
    h=15;
    translate([0,-5,0]){
    difference(){
    rotate([270,180,00])
    translate([-l/2, -31, holderThickness]) {
        translate([0, h, 0]) {
        cube(size=[l, l/3, l]);
        }
        prism(l,h,30);
        
    }
    translate([-50,0,-50])
    cube([100,15,100]);
    }
    translate([ 5.75, 5+usableHeight / 2 - 8, -12-phoneCaseThickness * 1.5 ]) {
        rotate([ 0, -116.565, 90 ]) mount2(flapWidth);
    }
    }
}

rotate([ -90, 0, 0 ]) {

    Holder();
    
}
    // translate([-6,17,-phoneCaseThickness*0.7])
    // cube(size=[12, 15, 3]);
    // translate([ 5.75, usableHeight/2-8, -phoneCaseThickness * 1.5 ]){
    //     rotate([ 0, -90, 90 ]) mount2();








