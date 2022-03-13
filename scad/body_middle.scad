/************************************************************************

    body_middle.scad
    
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

module acrylic_sheet1()
{
    cuboid([81,1,140]);
}

module acrylic_sheet2()
{
    cuboid([1,81,140]);
}

module acrylic_sheet3()
{
    cuboid([1.5,81,140]);

    // Original hexagon pattern interior
    // - causes friction against the filament motion
    // difference() {
    //     cuboid([1,81,140]);
    //     cuboid([2,81 - 4,140 - 4]);
    // }

    // difference() {
    //     cuboid([1,81,140]);

    //     // Cut hexagon pattern
    //     move([0,-8,-27]) for (ypos=[0: 20: 20*6]) {
    //         for (xpos=[0: 12: 12*7]) {
    //             move([0,xpos - 28,ypos - 28]) yrot(90) cyl(h=4, d=12, $fn=6);
    //         }

    //         for (xpos=[0: 12: 12*7]) {
    //             move([0,xpos - 28 - 6,ypos - 28 - 10]) yrot(90) cyl(h=4, d=12, $fn=6);
    //         }
    //     }
    // }
}

module body_middle()
{
    // Perpendicular to spool
    move([0,41,0]) acrylic_sheet1();
    move([0,-41,0]) acrylic_sheet1();

    // Parallel with spool
    move([(-8) * 5,0,0]) acrylic_sheet2();
    move([(+8) * 5,0,0]) acrylic_sheet2();

    // Spool dividers
    move([(-8) * 3,0,0]) acrylic_sheet3();
    move([-8,0,0]) acrylic_sheet3();
    move([+8,0,0]) acrylic_sheet3();
    move([(+8) * 3,0,0]) acrylic_sheet3();

    // Top Joiner 72.5
    move([0,0,-68]) {
        difference() {
            cuboid([84 - 1, 86 - 1,4]);
            cuboid([84-3,86 - 3,6]);

            // Clip recesses
            move([0,0,-3.5]) {
                move([0,42,0]) body_clip_inverse();
                move([0,-42,0]) zrot(180) body_clip_inverse();
            }
        }
    }

    // Base Joiner
    move([0,0,67 + 3]) {
        difference() {
            cuboid([84 + 2,86 + 2,8], chamfer=2.5, edges=EDGES_BOTTOM);
            move([0,0,0]) cuboid([84-3,86-3,10]);
            move([0,0,5.01]) cuboid([84 - 1,86 - 1,10]);
        }

        // Clips
        move([0,0,-1.5]) {
            move([0,42,0]) body_clip();
            move([0,-42,0]) zrot(180) body_clip();
        }
    }
}

module body_middle_upper()
{
    body_middle();

    // Bracket mounts
    move([45.5,39.5,57]) {
        difference() {
            hull() {
                move([0,0,0]) cuboid([10,4,10], chamfer=0.5, edges=EDGES_X_ALL+EDGE_TOP_RT+EDGE_BK_RT+EDGE_FR_RT);
                move([-5.5,0,-10]) cuboid([1,4,10], chamfer=0.5, edges=EDGES_X_ALL+EDGE_TOP_RT+EDGE_BK_RT+EDGE_FR_RT);
            }

            // Nut recess
            move([0,1,0]) ycyl(h=8, d=3.25);
            move([0,1,0]) yrot(90) ycyl(h=4, d=6.25, $fn=6);
        }
    }

    move([45.5,39.5,17]) {
        difference() {
            hull() {
                move([0,0,0]) cuboid([10,4,10], chamfer=0.5, edges=EDGES_X_ALL+EDGE_TOP_RT+EDGE_BK_RT+EDGE_FR_RT);
                move([-5.5,0,-10]) cuboid([1,4,10], chamfer=0.5, edges=EDGES_X_ALL+EDGE_TOP_RT+EDGE_BK_RT+EDGE_FR_RT);
            }

            // Nut recess
            move([0,1,0]) ycyl(h=8, d=3.25);
            move([0,1,0]) yrot(90) ycyl(h=4, d=6.25, $fn=6);
        }
    }
}

module body_middle_lower()
{
    body_middle();
}

module render_body_middle_upper(crend, toPrint)
{
    if (!toPrint) {
        if (crend) color([0.2,0.2,0.2]) move([0,0,225]) body_middle_upper();
        else move([0,0,225]) body_middle_upper();
    } else {
        move([0,0,70]) body_middle_upper();
    }
}

module render_body_middle_lower(crend, toPrint)
{
    if (!toPrint) {
        if (crend) color([0.2,0.2,0.2]) move([0,0,82+3]) body_middle_lower();
        else move([0,0,82+3]) body_middle_lower();
    } else {
        move([0,0,70]) body_middle_lower();
    }
}