
file_name = "button-deck-keys-B_Paste.svg";

s_y=140;
s_x=100;
thickness = 0.2;

difference(){
    translate([0,0,thickness/2]){
cube([s_y, s_x, thickness], center= true);
    }
linear_extrude(15){
import(file_name, center=true);
}
}