use <../shapes/oval-tube.scad>
use <../wiki-yoinks/prism.scad> //prism(l, w, h)


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
    translate([0,0,deskPlankEmptySpace]){
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




Desk();