
file_name = "button-deck-keys-B_Paste.svg";

s_y=120;
s_x=75;
thickness = 0.3;

rotate([0, 0, 0]) {
    difference(){
        translate([0,0,thickness/2]){
            cube([s_y, s_x, thickness], center = true);
        }
        linear_extrude(15){
            import(file_name, center=true);
        }
    }
    
}
