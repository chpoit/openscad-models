
wingHeight = 45.55;

wingLength = 160;
wingThickness = 3.85;

wingTopFront = 38.5;
wingTopBack = 39.2;
zero = wingTopFront;

wingFrontY = wingTopFront / 2 - zero;
wingBackY = wingTopFront / 2 - zero;

wingBottomFront = 24.5;
wingBottomBack = 51.5;

wingTop = 0;
wingFrontOffset = -(wingTopFront - wingBottomFront) / 2;
wingbackOffset = -(wingTopBack - wingBottomBack) / 2;

centerFrontTop = wingTopFront / 2;
centerFrontBottom = wingBottomFront / 2;

centerBackTop = wingTopBack / 2;
centerBackBottom = wingBottomBack / 2;

ft1x = centerFrontTop - wingThickness / 2;
ft1y = wingHeight;
ft2x = centerFrontTop + wingThickness / 2;
ft2y = wingHeight;

fb3x = centerFrontBottom - wingThickness / 2;
fb3y = 0;
fb4x = centerFrontBottom + wingThickness / 2;
fb4y = 0;

bt1x = centerBackTop - wingThickness / 2;
bt1y = wingHeight;
bt2x = centerBackTop + wingThickness / 2;
bt2y = wingHeight;
bb3x = centerBackBottom - wingThickness / 2;
bb3y = 0;
bb4x = centerBackBottom + wingThickness / 2;
bb4y = 0;

module wing() {
    $fn=360;
    hull(){
    translate([0,0,wingLength])
    linear_extrude(height = 0.1) polygon(points = [
        [ ft1x, ft1y ],
        [ ft2x, ft2y ],
        [ fb4x, fb4y ],
        [ fb3x, fb3y ],
    ]);
    linear_extrude(height = 0.1) polygon(points = [
        [ bt1x, bt1y ],
        [ bt2x, bt2y ],
        [ bb4x, bb4y ],
        [ bb3x, bb3y ],
    ]);
    }
    
}

// module wingv2() {
//     $fn=360;
//     hull(){
//     translate([0,0,wingHeight])
//     linear_extrude(height = 0.1) polygon(points = [
//         [ ft1x2, ft1y2 ],
//         [ ft2x2, ft2y2 ],
//         [ fb4x2, fb4y2 ],
//         [ fb3x2, fb3y2 ],
//     ]);;
//     linear_extrude(height = 0.1) polygon(points = [
//         [ bt1x2, bt1y2 ],
//         [ bt2x2, bt2y2 ],
//         [ bb4x2, bb4y2 ], 
//         [ bb3x2, bb3y2 ],
//     ]);
//     }
    
// }

// ft1x2 = centerFrontTop - wingThickness / 2;
// ft1y2 = wingLength;
// ft2x2 = centerFrontTop + wingThickness / 2;
// ft2y2 = wingLength;
// fb3x2 = centerBackBottom - wingThickness / 2;
// fb3y2 = 0;
// fb4x2 = centerBackBottom + wingThickness / 2;
// fb4y2 = 0;

// bt1x2 = centerBackTop - wingThickness / 2;
// bt1y2 = wingLength;
// bt2x2 = centerBackTop + wingThickness / 2;
// bt2y2 = wingLength;
// bb3x2 = centerFrontTop - wingThickness / 2;
// bb3y2 = 0;
// bb4x2 = centerFrontTop + wingThickness / 2;
// bb4y2 = 0;

// polygon(points = [
//         [ ft1x2, ft1y2 ],
//         [ ft2x2, ft2y2 ],
//         [ fb4x2, fb4y2 ],
//         [ fb3x2, fb3y2 ],
//     ]);

// polygon(points = [
//         [ bt1x2, bt1y2 ],
//         [ bt2x2, bt2y2 ],
//         [ bb4x2, bb4y2 ], 
//         [ bb3x2, bb3y2 ],
//     ]);

// hull() {
//     translate([10,0,0]) circle(10);
//     circle(10);
// }

// hull() {
//     polygon(points = [
//         [ ft1x, ft1y ],
//         [ ft2x, ft2y ],
//         [ fb4x, fb4y ],
//         [ fb3x, fb3y ],
//     ]);

//     polygon(points = [
//         [ bt1x, bt1y ],
//         [ bt2x, bt2y ],
//         [ bb4x, bb4y ],
//         [ bb3x, bb3y ],
//     ]);
// }

translate([0,wingLength, 0]) {
wingv2();
}
