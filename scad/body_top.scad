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

include <ptfe_connectors.scad>
include <spools.scad>

module connectors_inverse(toPrint)
{
    // Top connectors
    move([-1,-(62/2),20.5]) contact_mount_inverse(toPrint);
    move([-1,+(62/2),20.5]) contact_mount_inverse(toPrint);

    // Bottom connectors
    move([1,-(62/2) - 15,-16.5]) xrot(90 + 45) contact_mount_inverse(toPrint);
}

module bearing_mount()
{
    hull() {
        move([3.5,0,-15]) xcyl(h=1, d=6);
        move([7,0,-15]) xcyl(h=1, d=18);
    }

    hull() {
        move([-3.5,0,-15]) xcyl(h=1, d=6);
        move([-7,0,-15]) xcyl(h=1, d=18);
    }
}

module bearing_mounts()
{
    bearing_mount();

    move([-29,0,0]) bearing_mount();
    move([-14.5,0,0]) bearing_mount();
    bearing_mount();
    move([+14.5,0,0]) bearing_mount();
    move([+29,0,0]) bearing_mount();
}

module main_body_top(toPrint)
{
    move([0,0,322]) {
        difference() {
            union() {
                cuboid([75,75,52], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT+EDGES_TOP);
                body_top_clip();
                body_top_hinge();

                // Lower lip
                move([0,0,-23]) cuboid([75 + 4.8,75 + 4.8, 6], chamfer=2.25 + 0.125, edges=EDGE_TOP_FR+EDGE_TOP_BK+EDGE_TOP_LF+EDGE_TOP_RT+EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT, trimcorners=false);
                
                hull() {
                    move([0,-23.5,6.25]) xrot(45) move([0,-35.5,0]) cuboid([75,4,20], chamfer=2);
                    move([0,-45 + 9.5,-16 + 10]) cuboid([75,4,40], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
                }

                // Fillers to prevent overhangs
                move([37,36,-21]) rotate([45,45,45]) cuboid([4.75,4,2]);
                move([-37,36,-21]) rotate([45,-45,-45]) cuboid([4.75,4,2]);
            }

            move([0,0,-322]) render_spools_inverse();
            connectors_inverse(toPrint);
        }

        // Seal lip
        move([0,0,-23 - 1]) {
            difference() {
                cuboid([75 + 2.4,75 + 2.4, 6], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
                cuboid([75 - 0.6,75 - 0.6, 8], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
            }
        }

        bearing_mounts();
    }
}

module body_top_hinge()
{
    difference() {
        hull() {
            move([0,46 + 2,-34]) xcyl(h=75 - 40,d=14);
            move([0,46 + 2 - 11,-34 + 18]) cuboid([75-40,4,14], chamfer = 2);
        }
        move([0,46 + 2,-34]) xcyl(h=75 - 30 + 4, d=8);

        move([0,37,-36]) cuboid([75 - 40 + 4,6,20]); 
    }
}

module body_top_clip()
{
    move([0,-41.5,-35]) cuboid([40,3,22], chamfer=1);
    move([0,-41.5 + 1.5,-36 - 6]) cuboid([38,4,4]);

    move([0,-41.5 + 1.5,-38]) right_triangle([38, 4, 4], center=true, orient=ORIENT_X);

    move([0,-42.5,-46]) cuboid([40,3,10], chamfer=1);
    move([0,-42.5,-26.25]) cuboid([40,3,3], chamfer=1);
}

module render_body_top(crend, toPrint)
{   
    if (!toPrint) {
        if (crend) color([1,0.65,0]) main_body_top(toPrint);
        else main_body_top(toPrint);
    } else {
        move([0,0,348]) xrot(180) main_body_top(toPrint);
    }
}