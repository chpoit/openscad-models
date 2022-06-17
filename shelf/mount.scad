use <../shapes/oval-tube.scad>
use <../shapes/curved-corner.scad>
use <../wiki-yoinks/prism.scad> //prism(l, w, h)

display = true;
$fn=60;

deskPlankThickness = 55-38;
deskPlankEmptySpace = 254;
backPlankHeight = 82;

deskLegWidth = 55;
deskLegDistanceSide = 14.5;

deskWidth = 503;
deskBaseWidth=470;
deskTopThickness = 17.25;
deskHeight = 778;
deskLength = 1205;

deskLegHeight = deskHeight-deskLegWidth;
deskPlankHeight = deskLegHeight-deskPlankEmptySpace;
backPlankLength = deskLength-deskLegDistanceSide*2-1;
deskLegDistanceFront = (deskWidth-deskBaseWidth)/2;

mountWidth = deskLegWidth/3*2;


module Desk(){
    module Top(){
        color([249/255, 228/255, 183/255]) {

        cube([deskWidth, deskLength,  deskTopThickness]);
    }

    }
    module Leg(){
        color([15/255, 15/255, 128/255]) {
            cube([deskLegWidth, deskLegWidth, deskLegHeight]);
            
        }
    }
    module PlankThing(){
        color([15/255, 15/255, 75/255]) {
            cube([ deskBaseWidth-1, deskPlankThickness, deskPlankHeight]);
        }
    }
    module BackPlank(){
        color([15/255, 15/255, 75/255]) {
            cube([deskPlankThickness, backPlankLength, backPlankHeight]);
        }
    }

        
    translate([0,0,deskLegHeight]){
        Top();
    }
    translate([deskLegWidth/2-deskPlankThickness/2+deskLegDistanceFront,deskLegDistanceSide,deskPlankEmptySpace]){
        BackPlank();
    }
        
    translate([deskLegDistanceFront, deskLegDistanceSide, 0]) {
        Leg();
        translate([deskWidth-deskLegDistanceFront*2-deskLegWidth, 0, 0]) {
            Leg();
        }
        translate([0.5,deskLegWidth/2-deskPlankThickness/2,deskPlankEmptySpace]){       
             PlankThing();
        }

    }
    translate([deskLegDistanceFront, deskLength-deskLegDistanceSide-deskLegWidth, 0]) {
        Leg();
        translate([deskWidth-deskLegDistanceFront*2-deskLegWidth, 0, 0]) {
            Leg();
        }
        translate([0.5,deskLegWidth/2-deskPlankThickness/2,deskPlankEmptySpace]){       
             PlankThing();
        }
    }
}


module Mount(w){
    SD = 4.1;
    ScrewOffset = 13;
    l=120;
    l2=140;
    h = 10;
    r = w/3;

    thing = l/5;
    triangleWidth = 15;
    triangleDim = l-h;
    triangleDim2 = triangleDim-h*2;

    module FlatPart(l){
        RoundedRectangle(l,w,h,r);
    }

    module TriangularPart(){
        difference(){
            prism(triangleWidth, triangleDim, triangleDim);
            translate([-h/2,thing/6*4,thing/3]){
                RoundedPrism(triangleWidth*2, triangleDim2, triangleDim2,5);
            }
        }
    }

    module ScrewHole(){
        translate([0, 0,-0.1]){
            cylinder(r=SD/2, h=l*2);
        }
        translate([0, 0,ScrewOffset]){
            cylinder(r=SD*1.1, h=h*2);
        }
    }
    
    difference() {
        union() {
            FlatPart(l);

            translate([0,0,h]){
                rotate([0, 270, 0]) {
                    FlatPart(l2);
                }
            }

            translate([triangleDim,w/2-triangleWidth/2,h]){
                rotate([0, 0, 90]) {
                    TriangularPart();
                }
            }
        }
        translate([l/4-h/2, w/2, 0]) {
            ScrewHole();
                translate([l/4, 0, 0]) {
                    ScrewHole();
            }
        }
        translate([-h, w/2, l/2+h/2]) {
            rotate([0,90,0]){
                ScrewHole();
                    translate([l/4, 0, 0]) {
                        ScrewHole();
                }

            }
        }
    }
    
    
}

module SpacedMounts(){
    rotate([0, 90, 270]) {
        Mount(mountWidth);
        translate([0,deskWidth-deskLegDistanceFront*2-deskLegWidth,0]){
            Mount(mountWidth);
        }
    }
}

if (display)
{
    Desk();
    translate([deskLegWidth/2+deskLegDistanceFront- mountWidth/2,deskLegDistanceSide,deskLegHeight-15]){
        SpacedMounts();
    }
} else {
    Mount(mountWidth);
}