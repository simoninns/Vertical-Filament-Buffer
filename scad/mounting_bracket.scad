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

module render_mounting_screws_upper()
{
    move([0,5,0]) {
        move([4,0,0]) {
            move([134.5,26 + 1.5,283]) yrot(-90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);
            move([134.5,26 + 1.5,240]) yrot(-90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);
        }
        
        move([45.5,27.5,242]) xrot(90) metric_bolt(headtype="socket", size=3, l=10, details=false, phillips="#2", pitch=0);
        move([45.5,27.5,282]) xrot(90) metric_bolt(headtype="socket", size=3, l=10, details=false, phillips="#2", pitch=0);

        // Nuts
        move([45.5,37,242]) xrot(90) metric_nut(size=3, hole=true);
        move([45.5,37,282]) xrot(90) metric_nut(size=3, hole=true);
    }
}

module mounting_bracket_upper()
{
    move([0,5,0]) {
        // Frame mount
        move([4,0,0]) difference() {
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
            move([91,28.5,262]) cuboid([98,8,53/2], chamfer=1);

            // Cut-outs
            move([90 + 24,28.5,262]) cuboid([(98/2) - 12,16,(53/2) - 12], chamfer=0);
            move([90 - 18,28.5,262]) cuboid([(98/2) - 12,16,(53/2) - 12], chamfer=0);

            // Decoration
            move([90 + 24,28.5 - 7,262]) cuboid([(98/2) - 10,8,(53/2) - 10], chamfer=1);
            move([90 - 18,28.5 - 7,262]) cuboid([(98/2) - 10,8,(53/2) - 10], chamfer=1);
        }

        // Buffer mount
        difference() {
            move([45.5,28.5,262]) cuboid([10,8,53], chamfer=1);

            // Screw holes
            move([45.5,41.5,242]) ycyl(h=40, d=3.25);
            move([45.5,41.5,282]) ycyl(h=40, d=3.25);

            // Screw recess
            move([45.5,25.5,242]) ycyl(h=4, d=6);
            move([45.5,25.5,282]) ycyl(h=4, d=6);
        }
    }
}

module render_upper_mounting_bracket(crend, toPrint)
{
    if (!toPrint) {
        mounting_bracket_upper();

        color([0.7,0.7,0.7]) render_mounting_screws_upper();
    } else {
        xrot(-90) move([-90,-32.5,-262]) mounting_bracket_upper();
    }
}