include <config.scad>

module Wing() {
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

    hull() {
        translate([ 0, 0, wingLength ]) linear_extrude(height = 0.01) polygon(points = [
            [ ft1x, ft1y ],
            [ ft2x, ft2y ],
            [ fb4x, fb4y ],
            [ fb3x, fb3y ],
        ]);
        linear_extrude(height = 0.01) polygon(points = [
            [ bt1x, bt1y ],
            [ bt2x, bt2y ],
            [ bb4x, bb4y ],
            [ bb3x, bb3y ],
        ]);
    }
}

module Bottom() {
    polygon(points = [
        [ centerFrontBottom + wingThickness / 2, 0 ],
        [ -centerFrontBottom - wingThickness / 2, 0 ],
        [ -centerBackBottom - wingThickness / 2, wingLength ],
        [ centerBackBottom + wingThickness / 2, wingLength ],
    ]);
}
module Top() {
    polygon(points = [
        [ centerFrontTop + wingThickness / 2, 0 ],
        [ -centerFrontTop - wingThickness / 2, 0 ],
        [ -centerBackTop - wingThickness / 2, wingLength ],
        [ centerBackTop + wingThickness / 2, wingLength ],
    ]);
}

translate([ 75, 0 ]) hull() {
    linear_extrude(height = 0.01) Bottom();
    translate([ 0, 0, wingHeight ]) linear_extrude(height = 0.01) Top();
}

module Curved(height, thickness,
              pointsA =
                  [
                      [ 0, 0 ],
                      [ 0, 1 ],
                      [ 1, 1 ],
                      [ 1, 0 ],
                  ],
              pointsB =
                  [
                      [ 0, 2 ],
                      [ 0, 2 ],
                      [ 2, 2 ],
                      [ 2, 0 ],
                  ],
              subSteps = 5, steps = 160, LE = 0.01) {

    a1x = pointsA[0][0];
    a1y = pointsA[0][1];
    a2x = pointsA[1][0];
    a2y = pointsA[1][1];
    a3x = pointsA[2][0];
    a3y = pointsA[2][1];
    a4x = pointsA[3][0];
    a4y = pointsA[3][1];

    b1x = pointsB[0][0];
    b1y = pointsB[0][1];
    b2x = pointsB[1][0];
    b2y = pointsB[1][1];
    b3x = pointsB[2][0];
    b3y = pointsB[2][1];
    b4x = pointsB[3][0];
    b4y = pointsB[3][1];

    stepSize =  steps * subSteps;


    p1xStepSize = (a1x - b1x) / stepSize;
    p1yStepSize = (a1y - b1y) / stepSize;
    p2xStepSize = (a2x - b2x) / stepSize;
    p2yStepSize = (a2y - b2y) / stepSize;
    p3xStepSize = (a3x - b3x) / stepSize;
    p3yStepSize = (a3y - b3y) / stepSize;
    p4xStepSize = (a4x - b4x) / stepSize;
    p4yStepSize = (a4y - b4y) / stepSize;

    stepSize =  steps * subSteps;
    toTravelTop = (wingTopBack - wingTopFront) / 2;
    toTravelBottom = (wingBottomBack - wingBottomFront) / 2;

    topLength = 0;

    topStep = toTravelTop / wingLength;
    bottomStep = toTravelBottom / wingLength;
    color([ 20 / 255, 97 / 255, 79 / 255 ]) {
        linear_extrude(height = LE) polygon(points = pointsA);
    }
    color([ 20 / 255, 97 / 255, 179 / 255 ]) {
        linear_extrude(height = LE) polygon(points = pointsB);
    }

    // color([124/255, 50/255, 200/255]) {
    for (x = [0:p1yStepSize*subSteps:b1x]) {
    // for (x = [0:stepSize * subSteps:wingLength - stepSize * subSteps]) {
        // hull() {

        for (y = [0:subSteps - 1]) {

            color([ (x + y) * (255 / steps/subSteps) / 255, 0.4, (x + y) * (255 / steps) ])
                // if ((x + y) * stepSize < wingLength) {
                rotate([ 90, 0, 0 ]) 
                translate([ 0, 0, (x+y)*p1yStepSize + LE / 2 ]) 
                linear_extrude(height = LE) polygon(points = [
                    [ a1x - (x + y) * p1xStepSize, a1y - (x + y) * p1yStepSize ],
                    [ a2x - (x + y) * p2xStepSize, a2y - (x + y) * p2yStepSize ],
                    [ a3x - (x + y) * p3xStepSize, a3y - (x + y) * p3yStepSize ],
                    [ a4x - (x + y) * p4xStepSize, a4y - (x + y) * p4yStepSize ],
                ]);
                // linear_extrude(height = LE) polygon(points = pointsA);
            
            // }
        }
        // }
    }
    // }
}
Curved(wingHeight, wingThickness,
       pointsA =
           [
               [ centerFrontTop - wingThickness / 2, wingHeight ],
               [ centerFrontTop + wingThickness / 2, wingHeight ],
               [ centerFrontBottom + wingThickness / 2, 0 ],
               [ centerFrontBottom - wingThickness / 2, 0 ],
           ],
       pointsB =
           [
               [ centerBackTop - wingThickness / 2, wingHeight ],
               [ centerBackTop + wingThickness / 2, wingHeight ],
               [ centerBackBottom + wingThickness / 2, 0 ],
               [ centerBackBottom - wingThickness / 2, 0 ],
           ],
       subSteps = 15, steps = 160);

// color([125/255,0,0])
SteppedWing(subSteps = 5, steps = 160);

module SteppedWing(subSteps = 5, steps = 160) {

    LE = 0.01;
    stepSize = wingLength / steps;
    toTravelTop = (wingTopBack - wingTopFront) / 2;
    toTravelBottom = (wingBottomBack - wingBottomFront) / 2;

    topStep = toTravelTop / wingLength;
    bottomStep = toTravelBottom / wingLength;
    for (x = [0:stepSize * subSteps:wingLength - stepSize * subSteps]) {
        hull() {

            for (y = [0:subSteps]) {

                if ((x + y) * stepSize < wingLength) {
                    rotate([ 90, 0, 0 ]) translate([ 0, 0, (x + y) + LE / 2 ]) {
                        linear_extrude(height = LE) polygon(points = [
                            [ centerBackTop - (x + y) * topStep - wingThickness / 2, wingHeight ],
                            [ centerBackTop - (x + y) * topStep + wingThickness / 2, wingHeight ],
                            [ centerBackBottom - (x + y) * bottomStep + wingThickness / 2, 0 ],
                            [ centerBackBottom - (x + y) * bottomStep - wingThickness / 2, 0 ],
                        ]);
                    }
                }
            }
        }
    }
}
// mirror()
// SteppedWing(subSteps = 5, steps = 160);
