
fast = false;
// fast = true;
nozzleSize = 0.4;

innardsLength = 146;
innerLowerWidth1 = 19.3;
innerLowerWidth2 = 35.81;

innardsLengthMid = 140;
innerMidWidth = 28;
innerMidHeight = 29.6;
innardsLengthMidOffset = (innardsLength - innardsLengthMid) / 2;

innardsLengthTop = 132.6;
innerUpperWidth = 23.4;
innardsLengthTopOffset = (innardsLength - innardsLengthTop) / 2;

innardsHeight = 51.7;

bonderDistance = 4;
bonderLongDistance = 6;

module Innards() {

    iLP1 = innerLowerWidth1 / 2;
    iLP2 = innerLowerWidth2 / 2;
    mid = innerMidWidth / 2;
    top = innerUpperWidth / 2;

    module Bonder() {
        topDiff = 3;
        blockHeight = 5.87 - 3.85;
        topWidth = 28;
        topHeight = 32;
        color([ 10 / 255, 75 / 255, 75 / 255 ]) {
            rotate([ 90, 0, 90 ])
                polyhedron(points =
                               [
                                   [ 0, 0, 0 ],                                                        // 0
                                   [ innardsLength, 0, 0 ],                                            // 1
                                   [ innardsLength, innerMidHeight, 0 ],                               // 2
                                   [ 0, innerMidHeight, 0 ],                                           // 3
                                   [ topDiff, topDiff, blockHeight ],                                  // 4
                                   [ innardsLength - topDiff, topDiff, blockHeight ],                  // 5
                                   [ innardsLength - topDiff, innerMidHeight - topDiff, blockHeight ], // 6
                                   [ topDiff, innerMidHeight - topDiff, blockHeight ]                  // 7
                               ],
                           faces = [
                               [ 0, 1, 2, 3 ], // bottom
                               [ 4, 5, 1, 0 ], // front
                               [ 7, 6, 5, 4 ], // top
                               [ 5, 6, 2, 1 ], // right
                               [ 6, 7, 3, 2 ], // back
                               [ 7, 4, 0, 3 ]  // left
                           ]);
        }
    }
    module rotatedBonder() {
        translate([ mid - 1, 0, 0 ]) rotate([ 0, 1.5, -1.5 ]) Bonder();
    }

    hull() {

        linear_extrude(height = 0.01) polygon(points = [
            [ -iLP1, 0 ],
            [ iLP1, 0 ],
            [ iLP2, innardsLength ],
            [ -iLP2, innardsLength ],
        ]);
        translate([ 0, 0, innerMidHeight ])

            linear_extrude(height = 0.01) polygon(points = [
                [ -mid, innardsLengthMidOffset ],
                [ mid, innardsLengthMidOffset ],
                [ mid, innardsLengthMid ],
                [ -mid, innardsLengthMid ],
            ]);

        translate([ 0, 0, innardsHeight ]) linear_extrude(height = 0.01) polygon(points = [
            [ -top, innardsLengthTopOffset ],
            [ top, innardsLengthTopOffset ],
            [ top, innardsLengthTop ],
            [ -top, innardsLengthTop ],
        ]);

        rotatedBonder();
        mirror([ 1, 0, 0 ]) rotatedBonder();
    }
}
