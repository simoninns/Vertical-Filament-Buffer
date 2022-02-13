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

module hex_row()
{
    move([0,-40,0]) yrot(90) cyl(h=4,d=19,$fn=6);
    move([0,-20,0]) yrot(90) cyl(h=4,d=19,$fn=6);
    yrot(90) cyl(h=4,d=20,$fn=6);
    move([0,+20,0]) yrot(90) cyl(h=4,d=19,$fn=6);
    move([0,+40,0]) yrot(90) cyl(h=4,d=19,$fn=6);
}

module base_dividing_wall()
{
    difference() {
        cuboid([1.2,74,199], chamfer=2, edges=EDGE_BOT_FR+EDGE_BOT_BK);

        difference() {
            union() {
                move([0,0,-98]) {
                    for(raise=[0: 18 * 2: 180]) {
                        move([0,0,raise]) {
                            hex_row();
                            move([0,10,18]) hex_row();
                        }
                    }
                }
            }

            difference() {
                cuboid([6,75 + 80,200 + 40]);
                move([-1,0,0]) cuboid([4,75 - 7,200 - 7]);
            }
        }
    }
}

module lower_mounts()
{
    difference() {
        union() {
            move([40.5,35,30.25]) cuboid([14,5,53 + 7.5], chamfer=1, edges=EDGES_Y_ALL+EDGES_Z_ALL);

            // Screw recess
            difference() {
                union() {
                    move([42.5,31.5,30]) ycyl(h=4, d1=7, d2=12); // Top screw hole
                    move([42.5,31.5,52]) ycyl(h=4, d1=7, d2=12); // Bottom screw hole
                }
                move([50,34,40]) cuboid([5,5,40]);
            }
        }

        // Screw heads
        move([42.5,31,30]) ycyl(h=4, d=6);
        move([42.5,31,52]) ycyl(h=4, d=6);

        // Screw holes
        move([42.5,41.5,30]) ycyl(h=40, d=3.25);
        move([42.5,41.5,52]) ycyl(h=40, d=3.25);
    }
}

module render_base_nuts()
{
    move([0,0,198]) {
        zrot(45) {
            // Screw holes
            move([-58,0,-4]) metric_nut(size=3, hole=true);
            move([+58,0,-4]) metric_nut(size=3, hole=true);
        }

        zrot(-45) {
            // Screw holes
            move([-58,0,-4]) metric_nut(size=3, hole=true);
            move([+58,0,-4]) metric_nut(size=3, hole=true);
        }
    }
}

module base_desiccant_holder()
{
    move([-59.5,-15.5,0]) {
        difference() {
            union() {
                move([0,-22,0]) cuboid([24,44,80], center=false, chamfer=2, edges=EDGES_X_BOT+EDGES_X_TOP);

                move([0,0,0]) cyl(h=2, d1=40, d2=44, center=false, $fn=100); // Bottom
                move([0,0,2]) cyl(h=76, d=44, center=false, $fn=100); // Middle
                move([0,0,78]) cyl(h=2, d1=44, d2=40, center=false, $fn=100); // Top

                // Thread for lid
                move([0,0,80 + (12/2)]) metric_trapezoidal_threaded_rod(d=37.5, l=12, pitch=2.1, bevel2=true);
            }

            // Remove inner material
            move([5,-17,2]) cuboid([26,34,76], center=false);
            move([0,0,2]) cyl(h=100, d=34, center=false, $fn=100);
        }

        difference() {
            move([24, -18, 78]) yrot(180) right_triangle([26, 36, 30]);
            move([0,0,2]) cyl(h=100, d=34, center=false, $fn=100);
        }
    }
}

module body_base()
{
    wt=1.2; // 0.3 * 4 and 0.4 * 3
    difference() {
        union() {
            move([0,0,200/2]) cuboid([75,75,200], chamfer=2, edges=EDGE_BOT_FR+EDGE_BOT_BK+EDGE_BOT_LF+EDGE_BOT_RT+EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
            lower_mounts();
            base_desiccant_holder();

            // Upper lip
            move([0,0,200-3]) cuboid([75 + 4.8,75 + 4.8, 6], chamfer=2.25 + 0.125, edges=EDGE_BOT_FR+EDGE_BOT_BK+EDGE_BOT_LF+EDGE_BOT_RT+EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT, trimcorners=false);

            // Add joiners
            move([0,0,198]) {
                zrot(45) {
                    difference() {
                        hull() {
                            cuboid([125,10,4], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
                            move([0,0,-15]) cuboid([100,10,4], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
                        }

                        // Screw holes
                        move([-58,0,0]) cyl(h=25, d=3.25);
                        move([+58,0,0]) cyl(h=25, d=3.25);

                        // Nut recess
                        move([-58,0,-12]) {
                            move([0,0,0]) metric_nut(size=3, hole=false);
                            move([0,0,2]) metric_nut(size=3, hole=false);
                            move([0,0,4]) metric_nut(size=3, hole=false);
                            move([0,0,6]) metric_nut(size=3, hole=false);
                            move([0,0,8]) metric_nut(size=3, hole=false);
                        }

                        move([+58,0,-12]) {
                            move([0,0,0]) metric_nut(size=3, hole=false);
                            move([0,0,2]) metric_nut(size=3, hole=false);
                            move([0,0,4]) metric_nut(size=3, hole=false);
                            move([0,0,6]) metric_nut(size=3, hole=false);
                            move([0,0,8]) metric_nut(size=3, hole=false);
                        }
                    }
                }

                zrot(-45) {
                    difference() {
                        hull() {
                            cuboid([125,10,4], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
                            move([0,0,-15]) cuboid([100,10,4], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
                        }

                        // Screw holes
                        move([-58,0,0]) cyl(h=25, d=3.25);
                        move([+58,0,0]) cyl(h=25, d=3.25);

                        // Nut recess
                        move([-58,0,-12]) {
                            move([0,0,0]) metric_nut(size=3, hole=false);
                            move([0,0,2]) metric_nut(size=3, hole=false);
                            move([0,0,4]) metric_nut(size=3, hole=false);
                            move([0,0,6]) metric_nut(size=3, hole=false);
                            move([0,0,8]) metric_nut(size=3, hole=false);
                        }

                        move([+58,0,-12]) {
                            move([0,0,0]) metric_nut(size=3, hole=false);
                            move([0,0,2]) metric_nut(size=3, hole=false);
                            move([0,0,4]) metric_nut(size=3, hole=false);
                            move([0,0,6]) metric_nut(size=3, hole=false);
                            move([0,0,8]) metric_nut(size=3, hole=false);
                        }
                    }
                }
            }
        }
        move([0,0,200/2 + wt]) cuboid([75 - (wt * 2),75 - (wt * 2),200], chamfer=1.5, edges=EDGE_BOT_FR+EDGE_BOT_BK+EDGE_BOT_LF+EDGE_BOT_RT+EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);

        // Seal recess
        move([0,0,200]) {
            difference() {
                cuboid([75 + 2.6,75 + 2.6, 6], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
                cuboid([75 - 0.4,75 - 0.4, 8], chamfer=2, edges=EDGE_FR_LF+EDGE_FR_RT+EDGE_BK_LF+EDGE_BK_RT);
            }
        }

        // Vents for desiccant holder
        move([-59.5,-15.5,0]) {
            move([15,-17,2]) cuboid([26,4,46], center=false);
            move([15,-9.5,2]) cuboid([26,4,46], center=false);
            move([15,  0 - 2,2]) cuboid([26,4,46], center=false);
            move([15, 9.5 - 4,2]) cuboid([26,4,46], center=false);
            move([15, 17 - 4,2]) cuboid([26,4,46], center=false);
        }
    }

    // Add buffer dividers
    move([- 14 - 7.75,0,200/2]) base_dividing_wall();
    move([- 7.25,0,200/2]) base_dividing_wall();
    move([+ 7.25,0,200/2]) base_dividing_wall();
    move([+ 14 + 7.75,0,200/2]) base_dividing_wall();
}

module render_body_base(crend, toPrint)
{
    if (!toPrint) {
        if (crend) color([0.2,0.2,0.2]) body_base();
        else body_base();

        color([0.7,0.7,0.7]) render_base_nuts();
    } else {
        body_base();
    }
}

