include <config.scad>
use <grid.scad>

for (i = [0:grid_x-1]) {
    for (j = [0:grid_y-1]) {
        translate([i*grid_size,j*grid_size,0]){
            GridSquare(grid_size, grid_height);
        }
    }
}

