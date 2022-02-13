/************************************************************************

    mounting_bracket.scad
    
    Vertical Filament Buffer
    Copyright (C) 2022 Simon Inns
    
    This is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
	
    Email: simon.inns@gmail.com
    
************************************************************************/

include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

module render_mounting_screws_lower()
{
    move([68 + 8,54 + 1.5,9]) xrot(90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);
    move([45 + 8,54 + 1.5,9]) xrot(90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);

    move([42.5,32.5,30]) xrot(90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);
    move([42.5,32.5,52]) xrot(90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);

    // Nuts
    move([42.5,46 - 2,30]) xrot(90) metric_nut(size=3, hole=true);
    move([42.5,46 - 2,52]) xrot(90) metric_nut(size=3, hole=true);

    move([68 + 8,54 + 13.25,9]) xrot(90) metric_nut(size=3, hole=true);
    move([45 + 8,54 + 13.25,9]) xrot(90) metric_nut(size=3, hole=true);
}

module render_mounting_screws_upper()
{
    move([134.5,26 + 1.5,283]) yrot(-90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);
    move([134.5,26 + 1.5,240]) yrot(-90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);

    move([42.5,27.5,242]) xrot(90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);
    move([42.5,27.5,282]) xrot(90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);

    // Nuts
    move([42.5,39.5,242]) xrot(90) metric_nut(size=3, hole=true);
    move([42.5,39.5,282]) xrot(90) metric_nut(size=3, hole=true);
}

module mounting_bracket_upper()
{
    // Frame mount
    difference() {
        union() {
            move([137.25,27.5,262]) cuboid([8,10,53], chamfer=1);

            // Thickness of Prusa frame is 6mm, so we need to raise
            // the 12mm screws to stop them poking out the other side
            move([132.5,27.5,283]) xcyl(h=2, d1=7, d2=9); // Top screw hole
            move([132.5,27.5,240]) xcyl(h=2, d1=7, d2=9); // Bottom screw hole
        }

        move([137,27.5,283]) xcyl(h=20, d=3.25); // Top screw hole
        move([137,27.5,240]) xcyl(h=20, d=3.25); // Bottom screw hole

        // Screw recess
        move([132.5,27.5,283]) xcyl(h=4, d=6); // Top screw hole
        move([132.5,27.5,240]) xcyl(h=4, d=6); // Bottom screw hole
    }

    // Arm
    difference() {
        move([87,28.5,262]) cuboid([98,8,53/2], chamfer=1);

        // Cut-outs
        move([87 + 24,28.5,262]) cuboid([(98/2) - 12,16,(53/2) - 12], chamfer=1);
        move([87 - 18,28.5,262]) cuboid([(98/2) - 12,16,(53/2) - 12], chamfer=1);

        // Decoration
        move([87 + 24,28.5 - 7,262]) cuboid([(98/2) - 10,8,(53/2) - 10], chamfer=1);
        move([87 - 18,28.5 - 7,262]) cuboid([(98/2) - 10,8,(53/2) - 10], chamfer=1);
    }

    // Buffer mount
    difference() {
        move([42.5,28.5,262]) cuboid([10,8,53], chamfer=1);

        // Screw holes
        move([42.5,41.5,242]) ycyl(h=40, d=3.25);
        move([42.5,41.5,282]) ycyl(h=40, d=3.25);

        // Screw recess
        move([42.5,25.5,242]) ycyl(h=4, d=6);
        move([42.5,25.5,282]) ycyl(h=4, d=6);
    }
}

module render_mounting_bracket_upper(crend, toPrint)
{
    if (!toPrint) {
        if (crend) color([1,0.65,0]) mounting_bracket_upper();
        else mounting_bracket_upper();

        color([0.7,0.7,0.7]) render_mounting_screws_upper();
    } else {
        xrot(-90) move([-90,-32.5,-262]) mounting_bracket_upper();
    }
}

module mounting_bracket_lower()
{
    // Frame mount
    difference() {
        move([60,58 - 2.5,9]) cuboid([45,10,18], chamfer=1);
        move([68 + 8,54 + 1.5,9]) ycyl(h=20, d=3);
        move([45 + 8,54 + 1.5,9]) ycyl(h=20, d=3);

        // Screw recess
        move([68 + 8,52,9]) ycyl(h=8, d=6);
        move([45 + 8,52,9]) ycyl(h=8, d=6);
    }

    // Arm
    move([42.5,50,9]) cuboid([10,20,18], chamfer=1);
    
    difference() {
        move([42.5,41.5,30.25]) cuboid([10,8,53 + 7.5], chamfer=1);

        // Screw holes
        move([42.5,41.5,30]) ycyl(h=40, d=3.25);
        move([42.5,41.5,52]) ycyl(h=40, d=3.25);

        // Nut recess
        move([42.5,46,30]) xrot(90) metric_nut(size=3, hole=true);
        move([42.5,46 - 2,30]) xrot(90) metric_nut(size=3, hole=true);

        move([42.5,46,52]) xrot(90) metric_nut(size=3, hole=true);
        move([42.5,46 - 2,52]) xrot(90) metric_nut(size=3, hole=true);
    }
}

module render_mounting_bracket_lower(crend, toPrint)
{
    if (!toPrint) {
        if (crend) color([1,0.65,0]) mounting_bracket_lower();
        else mounting_bracket_lower();

        color([0.7,0.7,0.7]) render_mounting_screws_lower();
    } else {
        move([-60,-58,0]) mounting_bracket_lower();
    }
}