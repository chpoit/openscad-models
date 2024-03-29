// slightly modified version of https://www.thingiverse.com/thing:3088912/files

// Associated BSD License
// Copyright 2022 Julietta
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
// 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


$fa = 2;
$fs = 0.25;
Extra_Mount_Depth = 3;

module flap(Width) {
    rotate([ 90, 0, 0 ]) {
        translate([ 3.5, (-7.5), 0 ]) cube([ 4 + Extra_Mount_Depth, 15, Width ]);

        translate([ 0, (-7.5), 0 ]) cube([ 7.5 + Extra_Mount_Depth, 4, Width ]);

        translate([ 0, 3.5, 0 ]) cube([ 7.5 + Extra_Mount_Depth, 4, Width ]);

        difference() {
            cylinder(h = Width, d = 15);

            translate([ 0, 0, (-1) ]) cylinder(h = Width + 2, d = 6);
        }
    }
}

module mount2(flapWidth = 3) {
    translate([ 0, 4, 0 ]) flap(flapWidth);
    translate([ 0, 10.5, 0 ]) flap(flapWidth);
}

module mount3(flapWidth = 3)
{
    
    module nut_hole()
    {
        rotate([0, 90, 0]) // (Un)comment to rotate nut hole
        rotate([90, 0, 0])
            for(i = [0:(360 / 3):359])
            {
                rotate([0, 0, i])
                    cube([4.6765, 8.1, 5], center = true);
            }
    }

    difference()
    {
        translate([0, (-2.5), 0])
            flap(8);

        translate([0, (-8.5), 0])
            nut_hole();
    }

    mount2(flapWidth);
}














