
wingHeight = 45.55;

wingLength = 164;
wingThickness = 3.85;

wingTopFront = 38.5;
wingTopBack = 39.2;

middle = wingTopFront / 2 + wingTopBack / 2;
wingHalfLength = wingLength / 2;
middleZerod = middle / 2;

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


module Wing() {
    $fn = 360;
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
