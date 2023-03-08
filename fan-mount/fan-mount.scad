$fn=60;


fan_l = 140;
fan_w = 25;
fan_r = (fan_l-5)/2;

pipe_r = 40/2;
pipe_conn = 50;

dist = 115;

fan_hole_dist = 7.5;

thread = 2.15;
flats=25;


module fanlike(){
    cube([fan_l, fan_w, fan_l]);
}

module screwHole(){
    rotate([-90,0,0]) cylinder(r=thread, h=15);
}

module pinLayout(){
    translate([fan_hole_dist, 0, fan_hole_dist]) {screwHole();}
    translate([fan_l-fan_hole_dist,0,fan_hole_dist]){screwHole();}
    translate([fan_l-fan_hole_dist,0,fan_l-fan_hole_dist]){screwHole();}
    translate([fan_hole_dist,0,fan_l-fan_hole_dist]){screwHole();}
}

module fanMount(){
    difference(){    
        cube([fan_l, 2, fan_l]);
        translate([0, -0.5, 0]) {//For z-fighting
            pinLayout();
            translate([fan_l/2, 0, fan_l/2]) {
                rotate([-90, 0, 0]) {
                    cylinder(r=fan_r, 10);
                    
                }
            }
        }
    }
   
        
}

module pipeThing(r1, r2){
    color([r1/255, r1/255, r1/255]) {
        
    hull(){
        translate([fan_l/2, -1, fan_l/2]) {
            rotate([-90,0,0])
                difference() {
                    cylinder(r=r1+2, h=5, center=true);
                    cylinder(r=r1, h=5+5, center=true);
                }
        }

        translate([fan_l/2 -pipe_conn/2, -dist+flats, 0]) {
            translate([pipe_conn/2, 0, pipe_conn/2]) {
                rotate([-90,0,0])
                difference() {
                    cylinder(r=r2+2, h=1, center=true);
                    cylinder(r=r2, h=1+5, center=true);
                }
            }
        }
    }
    }
    color([r2/255, r2/255, r2/255]) {

    translate([fan_l/2 -pipe_conn/2, -dist+flats/2, 0]) {
        translate([pipe_conn/2, 0, pipe_conn/2]) {
            rotate([-90,0,0])
            difference() {
                cylinder(r=r2+2, h=flats, center=true);
                cylinder(r=r2, h=flats+5, center=true);
            }
        }
    }
    }
}

module pipeConnector(){
    color([75/255, 255/255, 40/255]) {
        
    difference() {
        cube([pipe_conn, 2, pipe_conn]);
        translate([0, -0.5, 0]) {
            translate([pipe_conn/2, 0, pipe_conn/2]) {
                rotate([-90, 0, 0]) {
                    cylinder(r=pipe_r, h=15);
                }                
            }
            
        }
        
    }
    }

}





fanMount();
difference(){
    pipeThing(fan_r, pipe_r);
    pipeThing(fan_r-2, pipe_r-2);
}

//    translate([fan_l/2 -pipe_conn/2, -dist+flats/2, 0]) {
//         translate([pipe_conn/2, 0, pipe_conn/2]) {
//             rotate([-90,0,0])
//             difference() {
//                 cylinder(r=pipe_r+2, h=flats, center=true);
//                 cylinder(r=pipe_r, h=flats+5, center=true);
//             }
//         }
//     }
translate([fan_l/2 -pipe_conn/2, -dist, 0]) {
    pipeConnector();   
}