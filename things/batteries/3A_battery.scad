use <./base-battery.scad>
include <./battery-dimensions.scad> 

module AAABattery(showTerminal = true) {


    CylindricalBattery(AAAdiam, AAAheight, AAAterminalDiameter, AAAterminalHeight, showTerminal);
}