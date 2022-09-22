module prism(l, w, h) {
    // from wiki
    // https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids#polyhedron
    // Falls under Attribution-ShareAlike 3.0 Unported https://creativecommons.org/licenses/by-sa/3.0/ 
    // as specified on the user manual https://en.wikibooks.org/wiki/OpenSCAD_User_Manual
    polyhedron(points =
                   [
                       [ 0, 0, 0 ], [ l, 0, 0 ], [ l, w, 0 ], [ 0, w, 0 ],
                       [ 0, w, h ], [ l, w, h ]
                   ],
               faces = [
                   [ 0, 1, 2, 3 ], [ 5, 4, 3, 2 ], [ 0, 4, 5, 1 ], [ 0, 3, 4 ],
                   [ 5, 2, 1 ]
               ]);
}
