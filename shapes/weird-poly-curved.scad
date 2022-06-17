
// defaulCubeFaces = [
//     [ 0, 1, 2, 3 ], // bottom
//     [ 4, 5, 1, 0 ], // front
//     [ 7, 6, 5, 4 ], // top
//     [ 5, 6, 2, 1 ], // right
//     [ 6, 7, 3, 2 ], // back
//     [ 7, 4, 0, 3 ]  // left
// ];

// module CurvedCube(points, faces=defaulCubeFaces, subSteps = 5, steps = 160) {
//     LE = 0.01;
//     stepSize = wingLength / steps;
//     toTravelTop = (wingTopBack - wingTopFront) / 2;
//     toTravelBottom = (wingBottomBack - wingBottomFront) / 2;

//     topStep = toTravelTop / wingLength;
//     bottomStep = toTravelBottom / wingLength;
//     for (x = [0:stepSize * subSteps:wingLength - stepSize * subSteps]) {
//         hull() {

//             for (y = [0:subSteps]) {

//                 if ((x + y) * stepSize < wingLength) {
//                     rotate([ 90, 0, 0 ]) translate([ 0, 0, (x + y) + LE / 2 ]) {
//                         linear_extrude(height = LE) polygon(points = [
//                             [ centerBackTop - (x + y) * topStep - wingThickness / 2, wingHeight ],
//                             [ centerBackTop - (x + y) * topStep + wingThickness / 2, wingHeight ],
//                             [ centerBackBottom - (x + y) * bottomStep + wingThickness / 2, 0 ],
//                             [ centerBackBottom - (x + y) * bottomStep - wingThickness / 2, 0 ],
//                         ]);
//                     }
//                 }
//             }
//         }
//     }
// }

// module CurvedCube2(points, faces=defaulCubeFaces, subSteps = 5, steps = 160) {
//     LE = 0.01;
//     stepSize = wingLength / steps;
//     toTravelTop = (wingTopBack - wingTopFront) / 2;
//     toTravelBottom = (wingBottomBack - wingBottomFront) / 2;

//     topStep = toTravelTop / wingLength;
//     bottomStep = toTravelBottom / wingLength;
//     for (x = [0:stepSize * subSteps:wingLength - stepSize * subSteps]) {
//         hull() {

//             for (y = [0:subSteps]) {

//                 if ((x + y) * stepSize < wingLength) {
//                     rotate([ 90, 0, 0 ]) translate([ 0, 0, (x + y) + LE / 2 ]) {
//                         linear_extrude(height = LE) polygon(points = [
//                             [ centerBackTop - (x + y) * topStep - wingThickness / 2, wingHeight ],
//                             [ centerBackTop - (x + y) * topStep + wingThickness / 2, wingHeight ],
//                             [ centerBackBottom - (x + y) * bottomStep + wingThickness / 2, 0 ],
//                             [ centerBackBottom - (x + y) * bottomStep - wingThickness / 2, 0 ],
//                         ]);
//                     }
//                 }
//             }
//         }
//     }
// }

// wingHeight = 45.55;

// wingLength = 160;
// wingThickness = 3.85;

// wingTopFront = 38.5;
// wingTopBack = 39.2;

// middle = wingTopFront / 2 + wingTopBack / 2;
// wingHalfLength = wingLength / 2;
// middleZerod = middle / 2;

// wingBottomFront = 24.5;
// wingBottomBack = 51.5;

// wingTop = 0;
// wingFrontOffset = -(wingTopFront - wingBottomFront) / 2;
// wingbackOffset = -(wingTopBack - wingBottomBack) / 2;

// centerFrontTop = wingTopFront / 2;
// centerFrontBottom = wingBottomFront / 2;

// centerBackTop = wingTopBack / 2;
// centerBackBottom = wingBottomBack / 2;

// ft1x = centerFrontTop - wingThickness / 2;
// ft1y = wingHeight;
// ft2x = centerFrontTop + wingThickness / 2;
// ft2y = wingHeight;
// fb3x = centerFrontBottom - wingThickness / 2;
// fb3y = 0;
// fb4x = centerFrontBottom + wingThickness / 2;
// fb4y = 0;

// bt1x = centerBackTop - wingThickness / 2;
// bt1y = wingHeight;
// bt2x = centerBackTop + wingThickness / 2;
// bt2y = wingHeight;
// bb3x = centerBackBottom - wingThickness / 2;
// bb3y = 0;
// bb4x = centerBackBottom + wingThickness / 2;
// bb4y = 0;

// p1 = [
//     [0,0,0],
//     [0,0,wingHeight]
// ]

// CurvedCube2(points = [
//     [ 0, 0, 0 ],                                                        // 0
//     [ innardsLength, 0, 0 ],                                            // 1
//     [ innardsLength, innerMidHeight, 0 ],                               // 2
//     [ 0, innerMidHeight, 0 ],                                           // 3
//     [ topDiff, topDiff, blockHeight ],                                  // 4
//     [ innardsLength - topDiff, topDiff, blockHeight ],                  // 5
//     [ innardsLength - topDiff, innerMidHeight - topDiff, blockHeight ], // 6
//     [ topDiff, innerMidHeight - topDiff, blockHeight ]                  // 7
// ]);
