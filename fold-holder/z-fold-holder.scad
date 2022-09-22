use <GoPro_Mount.scad>
use <../wiki-yoinks/prism.scad>

phoneCaseThickness = 10.65;
usableHeight = 65;
phoneLength = 161.2;
phoneWidth = 130;

buttonStart = 40;
buttonArea = 48;

holderThickness = 2.4;
flapWidth = 2.4;

module Phone() {
    color([ 75 / 255, 0 / 255, 0 / 255 ]) {
        cube(size = [ phoneLength, phoneWidth, phoneCaseThickness ], center = true);

    }
    color([0/255, 75/255, 75/255]) {
        translate([-phoneLength/2 + buttonArea/2+buttonStart,phoneWidth/2,0])
        {
            cube([buttonArea,15,phoneCaseThickness],center=true);
        }
    }
}

module ZFoldHolder() {
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
    h = 15;
    cDist= l/2;
    translate([0,-3.4,-cDist+10]){
        difference(){
            rotate([270,180,00])
            translate([-l/2, -31, holderThickness]) {
                translate([0, h, 0]) {
                cube(size=[l, cDist, l]);
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
    ZFoldHolder();
}


//Test prints for the joints

// translate([0,6,-10])
// cube(size=[15, 10, 3], center= true);
// rotate([ 0, 90, 0 ]) mount2();

// translate([0, 0, -10]) 
// cube(size=[15, 21, 2], center = true);
// rotate([ 0, 90, 0 ]) mount3(3);
        





