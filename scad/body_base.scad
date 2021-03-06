/************************************************************************

    body_base.scad
    
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

include <body_clips.scad>

module body_base_bracket()
{
    // Frame mount
    difference() {
        union() {
            move([58,58 - 2.5,9 - 5]) cuboid([50,10,28], chamfer=2);
            move([36.5,49,9 - 5]) cuboid([10,23,28], chamfer=2);
        }
        move([68 + 5,54 + 1.5,9]) ycyl(h=20, d=3.5);
        move([45 + 5,54 + 1.5,9]) ycyl(h=20, d=3.5);

        // Screw recess
        move([68 + 5,52,9]) ycyl(h=8, d=6);
        move([45 + 5,52,9]) ycyl(h=8, d=6);
    }
}

module body_base()
{
    // Joiner
    move([0,0,15]) {
        difference() {
            union() {
                cuboid([84 + 2,86 + 2,8], chamfer=2.5, edges=EDGES_BOTTOM);
                move([0,0,-15]) body_base_bracket();
            }
            move([0,0,0]) cuboid([84-3,86-3,10]);
            move([0,0,5.01]) cuboid([84 - 1,86 - 1,10]);
            move([0,0,1.5 + 1 - 15]) cuboid([83 - 2,85 - 2,25], chamfer=2, edges=EDGES_BOTTOM);
        }

        // Clips
        move([0,0,-1.5]) {
            move([0,42.25,0]) body_clip();
            move([0,-42.25,0]) zrot(180) body_clip();
        }
    }

    // Box
    difference() {
        move([0,0,1.5]) cuboid([83,85,23], chamfer=2, edges=EDGES_BOTTOM);
        move([0,0,1.5 + 2]) cuboid([83 - 2,85 - 2,23], chamfer=2, edges=EDGES_BOTTOM);
    }
}

module mounting_screws_lower()
{
    // Screws
    move([68 + 5,54 + 1.5,9]) xrot(90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);
    move([45 + 5,54 + 1.5,9]) xrot(90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);

    // Nuts
    move([68 + 5,54 + 13.25,9]) xrot(90) metric_nut(size=3, hole=true);
    move([45 + 5,54 + 13.25,9]) xrot(90) metric_nut(size=3, hole=true);
}

module render_body_base(crend, toPrint)
{
    if (!toPrint) {
        if (crend) color([1,0.65,0]) body_base();
        else body_base();
        mounting_screws_lower();
    } else {
        body_base();
    }
}

