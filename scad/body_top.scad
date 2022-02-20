/************************************************************************

    body_top.scad
    
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

include <body_middle.scad>

module holder_slot()
{
    // Connector clearance
    move([34,33,0]) {
        ycyl(h=8,d=13.5);
        //move([0,-10,0]) ycyl(h=20,d=4.75);
    }

    move([-34,33,0]) {
        ycyl(h=8,d=13.5);
        //move([0,-10,0]) ycyl(h=20,d=4.75);
    }

    // Left
    hull() {
        move([(72/2 + 0.5),3,0]) {
            cuboid([1,72,12]);
        }

        // Right
        move([(-72/2 +-0.5),3,0]) {
            cuboid([1,72,12]);
        }
    }

    // // Spindle supports
    move([0,0,0]) cuboid([20,74.25,15]);

    // Guides

    // Left
    move([(72/2 + 1.5),24,0]) {
        cuboid([3.5,20,3.5], chamfer=1);
    }

    // Right
    move([(-72/2 - 1.5),24,0]) {
        cuboid([3.5,20,3.5], chamfer=1);
    }
}

module body_top()
{
    // Top slots for spool holders
    difference() {
        move([0,25,0]) cuboid([85,20,83], chamfer=1, edges=EDGES_BACK);

        // Slots
        move([0,-1,0]) {
            move([0,0,+32]) holder_slot();
            move([0,0,+16]) holder_slot();
            move([0,0,  0]) holder_slot();
            move([0,0,-16]) holder_slot();
            move([0,0,-32]) holder_slot();
        }

        // Remove more material
        move([0,26,0]) cuboid([80 - 10,40,76 - 10], chamfer=1);

        // Clip recesses
        move([0,13.5,0]) yrot(90) xrot(-90) {
            move([0,42,0]) scale(1.01) body_clip();
            move([0,-42,0]) zrot(180) scale(1.01) body_clip();
        }

        // Clip mounting peg recesses
        move([-44.5 + 3,26,0]) {
            move([0,0,30]) xcyl(h=4,d=3);
            xcyl(h=4,d=3);
            move([0,0,-30]) xcyl(h=4,d=3);
        }
    } 
}

module render_body_top(crend, toPrint)
{   
    if (toPrint) {
        xrot(90) move([0,-15,0]) body_top();
    } else {
        body_top();
    }
}