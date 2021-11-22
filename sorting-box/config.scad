
$fn = 60;

grid_size = 60;
grid_height = 5;

// Box height in mm, recommended to be slightly smaller than
box_height = 68;
// pitch of the slope in mm
slope_pitch = 1;
// wall thickness in mm
wall_size = 1.2;

///////////// Overridden by the generator. Only change if you are generating one
/// offs /////////////
// They are the ratios based on the grid_size, so a ratio of 2 will give you
// 2*60=120mm if grid_size=60
grid_x = 2;
grid_y = 2;
// Supports partial sizes if you want a 1.8 * 2.73 box, for example
// Goin
box_x = 1.88;
box_y = 5;
// box_x = 1;
// box_y = 1;

// Lip Configuration
with_lip = true;
label_pos = "center"; // Center, corner, opposite
label_side = "A";       // 1 or 2

