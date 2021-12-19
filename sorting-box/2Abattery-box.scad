use <../things/batteries/2A_battery.scad>
use <../things/batteries/3A_battery.scad>
include <../things/batteries/battery-dimensions.scad>
use <box.scad>
include <config.scad>


remove_top_distance=40;
battery_scale_offset = 105;
x_space = box_x * grid_size - wall_size * 2;
y_space = box_y * grid_size - wall_size * 2;
battery_effective_width = AAdiam * battery_scale_offset / 100;
battery_effective_height = AAheight * battery_scale_offset / 100;

battery_z = box_height - battery_effective_height / 2 * 2;

x_count = floor(x_space / battery_effective_width);
y_count = floor(y_space / battery_effective_width);

battery_gap = 0.2;
battery_wall_offset = wall_size + battery_effective_width / 2;

difference(){
FullContainer(box_height, grid_size, grid_height, slope_pitch, wall_size, box_x, box_y, remove_top_distance);
for (i = [0:x_count - 1]) {
    x_pos = battery_wall_offset + (battery_effective_width + battery_gap) * i;
    for (j = [0:y_count]) {
        y_pos =
            battery_wall_offset + (battery_effective_width + battery_gap) * j - (j * (battery_effective_width / 7));

        scale([ battery_scale_offset / 100, battery_scale_offset / 100, 1 ]) {
            if (j % 2 == 1) {
                translate([ battery_effective_width / 2, 0, 0 ]) {
                    translate([ x_pos, y_pos, battery_z ]) {
                        if (i<6)
                        AABattery();
                    }
                }
            } else {
                translate([ x_pos, y_pos, battery_z ]) {
                    AABattery();
                }
            }
        }
    }
}
}
