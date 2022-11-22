$fn = 100;

// Display settings (for generation)
display = true;

holder = false;
lid = false;
handleOnly = false;

withHandle = true;
handleOnePart = true;
// End display settings

wadDiam = 57;
height = 140;

gap = 3;
thickness = 1.6; // 0.8mm nozzle*2

r = wadDiam / 2 + gap + thickness;
innerR = wadDiam / 2 + gap;

bt = 3;

opening = 30;

module Holder()
{
    difference()
    {
        cylinder(r = r, h = height);
        cylinder(r = innerR, h = height);
        translate([ opening / 2, -r / 2, 0 ])
        {
            cube(size = [ opening, opening, height ]);
        }
    }
    translate([ 0, 0, -bt ])
    {
        cylinder(r = r, h = bt);
    }
}

module Lid(withHandle = false, handleOnePart = false)
{
    difference()
    {
        union()
        {
            cylinder(r = r, h = 3);
            translate([ 0, 0, -bt ])
            {
                cylinder(r = innerR - 0.5, h = 3);
            }
            if (handleOnePart)
            {
                Handle();
            }
        }
        if (withHandle && !handleOnePart)
        {
            translate([ 0, 0, -bt * 2 ]) cylinder(r = bt, h = bt * 4);
        }
    }
}

module Handle()
{
    cylinder(r = bt - 0.1, h = bt * 3, center = false);
    translate([ 0, 0, bt * 4 ])
    {
        sphere(r = bt * 2);
    }
}

if (display)
{
    Holder();
    translate([ 0, 0, height + bt * 2 ])
    {
        Lid(withHandle, handleOnePart);
    }
    if (withHandle && !handleOnePart)
    {
        translate([ 0, 0, height + bt * 4 ])
        {
            Handle();
        }
    }
}
else
{
    if (holder)
    {
        Holder();
    }
    if (lid)
    {
        Lid(withHandle, handleOnePart);
    }
    if (handleOnly)
    {
        Handle();
    }
}