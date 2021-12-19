use <./base-battery.scad>
include <./battery-dimensions.scad> 

module AABattery(showTerminal = true) {
    CylindricalBattery(AAdiam, AAheight, AAterminalDiameter, AAterminalHeight, showTerminal);
}
