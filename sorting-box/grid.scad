include <config.scad>
use <../wiki-yoinks/prism.scad>

module GridSquare(grid_size, grid_height) {
    color([ 99 / 255, 30 / 255, 30 / 255 ]) {
        translate([ 0, grid_size - grid_height, 0 ]) {
            prism(grid_size, grid_height, grid_height);
        }
        translate([ grid_height, 0, 0 ]) {
            rotate([ 0, 0, 90 ]) { prism(grid_size, grid_height, grid_height); }
        }
        translate([ grid_size, grid_height, 0 ]) {
            rotate([ 0, 0, 180 ]) { prism(grid_size, grid_height, grid_height); }
        }
        translate([
            grid_size - grid_height,
            grid_size,
            0
        ]) {
            rotate([ 0, 0, 270 ]) { prism(grid_size, grid_height, grid_height); }
        }
    }
}

module MultiGrid(grid_size, grid_height, grid_x, grid_y){
    for (i = [0:grid_x-1]) {
        for (j = [0:grid_y-1]) {
            translate([i*grid_size,j*grid_size,0]){
                GridSquare(grid_size, grid_height);
            }
        }
    }
}

if (is_single_unit) {
    MultiGrid(grid_size, grid_height, 1, 1);
}