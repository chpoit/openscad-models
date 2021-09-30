# Sorting Boxes

This is a set of sorting boxes with grid registrations that shouldn't move around when you open and close drawers.


Heavily inspired by what Alexandre Chappel offers [here](https://www.alch.shop/shop/assortment). Show him some support if you're interested in more complex offerings.


# Generating the models

- OpenScad must be installed and in path.
- You need to have a form of bash available on your system. Powershell might work

From within the "sorting-box" directory, run the following:
```bash
sh generator.sh
```

Your computer might die for a few seconds as it's set up to generate everything at once.

Once done, everything will be available in the "outputs" directory.

# Configuration
By default, "units" are 60\*60\*68 mm, and both the grids and boxes are generated in a range from 1\*1 to 5\*5 units.

## Units
Unit dimensions and other simple things can be changed from within the [config.scad](./config.scad) file.

It is possible to create boxes with fractional units by settings the `box_x` and `box_y` values to what you want. Going under 1 unit defeats the purpose however.

It is recommended to have a slight slope to the walls to make insertion and removal of the boxes easier.

## Generated units
The amount of units generated can be altered by changing the `max_x` and `max_y` values in the [generator.sh](./generator.sh) file.


# Printing

There should be no need for supports and infill as everything *should* print in one piece.

The only area with infills is the bottom of the containers with a couple layers only. I personally use gyroid, but if should not matter.

# Notes

Cura appears to add some random geometry in some of the larger models.