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

module middle_mounts()
{
    difference() {
        move([40.5,35,14 + (7.5/2)]) cuboid([14,5,53 + 7.5], chamfer=1, edges=EDGES_Y_ALL+EDGES_Z_ALL);

        // Screw holes
        move([42.5,41.5,242 - 248]) ycyl(h=40, d=3.25);
        move([42.5,41.5,282 - 248]) ycyl(h=40, d=3.25);
    }
}

module middle_dividing_wall()
{
    difference() {
        cuboid([1.2,74,96]);

        difference() {
            union() {
                move([0,0,-43]) {
                    for(raise=[0: 18 * 2: 96]) {
                        move([0,0,raise]) {
                            hex_row();
                            move([0,10,18]) hex_row();
                        }
                    }
                }
            }

            difference() {
                cuboid([6,75 + 80,96 + 40]);
                move([-1,0,0]) cuboid([4,75 - 7,96 - 7]);
            }
        }
    }
}

module body_middle_hinge()
{
    difference() {
        union() {
            hull(){
                move([(75-51),46 + 2,-34]) xcyl(h=12,d=14);
                move([(75-51),46 + 2 - 11,-34 - 18 + 8]) cuboid([12,4,30], chamfer = 2);
            }
            move([(75-51),46 + 2 - 1,-34 + 4]) cuboid([12,16,8]);

            hull() {
                move([-(75-51),46 + 2,-34]) xcyl(h=12,d=14);
                move([-(75-51),46 + 2 - 11,-34 - 18 + 8]) cuboid([12,4,30], chamfer = 2);
            }
            move([-(75-51),46 + 2 - 1,-34 + 4]) cuboid([12,16,8]);
        }

        move([0,46 + 2,-34]) xcyl(h=80, d=8); // Hole for shaft
        move([0,46 + 5,-34 + 10.5]) xrot(41) cuboid([80,4,24]); // Chamfer
    }
}

module render_middle_screws()
{
    move([0,0,248]) {
        move([0,0,-46]) {
            zrot(45) {
                move([-58,0,3.5]) zrot(90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);
                move([+58,0,3.5]) zrot(90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);
            }

            zrot(-45) {
                move([-58,0,3.5]) zrot(90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);
                move([+58,0,3.5]) zrot(90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);
            }
        }
    }
}

module body_middle()
{
    wt=1.2; // 0.3 * 4 and 0.4 * 3
    move([0,0,248]) {
        difference() {
            union() {
                cuboid([75,75,96], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);

                // Mounts
                middle_mounts();

                // Hinge
                move([0,0,322 - 248]) body_middle_hinge();

                // Catch for clip
                move([0,-36,37]) cuboid([40,8,8], chamfer=3);

                // Upper lip
                move([0,0,45]) cuboid([75 + 4.8,75 + 4.8, 6], chamfer=2.25 + 0.125, edges=EDGE_BOT_FR+EDGE_BOT_BK+EDGE_BOT_LF+EDGE_BOT_RT+EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT, trimcorners=false);

                // Lower lip
                move([0,0,-45]) cuboid([75 + 4.8,75 + 4.8, 6], chamfer=2.25 + 0.125, edges=EDGE_TOP_FR+EDGE_TOP_BK+EDGE_TOP_LF+EDGE_TOP_RT+EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT, trimcorners=false);

                // Add joiners
                move([0,0,-46]) {
                    zrot(45) {
                        difference() {
                            hull() {
                                cuboid([125,10,4], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
                                move([0,0,15]) cuboid([100,10,4], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
                            }

                            // Screw holes
                            move([-58,0,0]) cyl(h=25, d=3.25);
                            move([+58,0,0]) cyl(h=25, d=3.25);

                            // Screw heads
                            move([-58,0,8]) cyl(h=10, d=6);
                            move([+58,0,8]) cyl(h=10, d=6);
                        }
                    }

                    zrot(-45) {
                        difference() {
                            hull() {
                                cuboid([125,10,4], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
                                move([0,0,15]) cuboid([100,10,4], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
                            }

                            // Screw holes
                            move([-58,0,0]) cyl(h=25, d=3.25);
                            move([+58,0,0]) cyl(h=25, d=3.25);

                            // Screw heads
                            move([-58,0,8]) cyl(h=10, d=6);
                            move([+58,0,8]) cyl(h=10, d=6);
                        }
                    }
                }
            }
            cuboid([75 - (wt * 2),75 - (wt * 2),96 + 4], chamfer=1.5, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);

            // Seal recess
            move([0,0,51 - 2]) {
                difference() {
                    cuboid([75 + 2.6,75 + 2.6, 6], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
                    cuboid([75 - 0.4,75 - 0.4, 8], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
                }
            }
        } 
    }

    // Add buffer dividers
    move([0,0,248]) {
        move([- 14 - 7.75,0,0]) middle_dividing_wall();
        move([- 7.25,0,0]) middle_dividing_wall();
        move([+ 7.25,0,0]) middle_dividing_wall();
        move([+ 14 + 7.75,0,0]) middle_dividing_wall();
    }

    // Seal lip
    move([0,0,203 - 1]) {
        difference() {
            cuboid([75 + 2.4,75 + 2.4, 6], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
            cuboid([75 - 0.6,75 - 0.6, 8], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
        }
    }
}

module render_body_middle(crend, toPrint)
{
    if (!toPrint) {
        if (crend) color([0.2,0.2,0.2]) body_middle();
        else body_middle();

        color([0.7,0.7,0.7]) render_middle_screws();
    } else {
        move([0,0,296]) xrot(180) body_middle();
    }
}