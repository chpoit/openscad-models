module OvalTube(height, radius, eccentricity){
    linear_extrude(height=height){
        scale([1,eccentricity]){
            circle(r=radius);
        }
    }
}
