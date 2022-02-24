/************************************************************************

    spool_holder.scad
    
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

use <BOSL/metric_screws.scad>

module spool_holder_base()
{
    difference() {
        move([0,0,-4.5]) {
            difference() {
                union() {
                    difference() {
                        move([0,0,-0.25]) cuboid([70 + 4,74,1.5]);
                        
                        // Cut hexagon pattern
                        move([-2,-2,0]) for (ypos=[0: 20: 20*3]) {
                            for (xpos=[0: 12: 12*5]) {
                                if (ypos !=20*3) move([xpos - 28,ypos - 28,0]) zrot(90) cyl(h=3, d=12, $fn=6);
                            }
                            
                            for (xpos=[0: 12: 12*6]) {
                                if (ypos != 0) move([xpos - 28 - 6,ypos - 28 - 10,0]) zrot(90) cyl(h=3, d=12, $fn=6);
                            }
                        }
                    }

                    // Fill centre
                    move([0,0,0]) zrot(90) cyl(h=1, d=12, $fn=6);

                    // Bearing washer to keep in place
                    move([0,0,1.5]) cyl(h=2, d1=12, d2=6);
                }

                // Hub hole
                move([0,0,1]) cyl(h=10,d=5);
            }
        }
    }

    // Nut holder
    move([0,0,-2]) difference() {
        move([0,0,-4]) zrot(90) cyl(h=2, d1=8, d2=12, $fn=6);
        move([0,0,-5.25]) zrot(90) metric_nut(size=3.25, hole=false);
    }
}

module spool_holder_top()
{
    difference() {
        move([0,0,4.5]) {
            difference() {
                union() {
                    difference() {
                        move([0,0,0.25]) cuboid([70 + 4,74,1.5]);

                        // Cut hexagon pattern
                        move([-2,-2,0]) for (ypos=[0: 20: 20*3]) {
                            for (xpos=[0: 12: 12*5]) {
                                if (ypos !=20*3) move([xpos - 28,ypos - 28,0]) zrot(90) cyl(h=3, d=12, $fn=6);
                            }

                            for (xpos=[0: 12: 12*6]) {
                                if (ypos != 0) move([xpos - 28 - 6,ypos - 28 - 10,0]) zrot(90) cyl(h=3, d=12, $fn=6);
                            }
                        }
                    }

                    // Fill centre
                    move([0,0,0]) zrot(90) cyl(h=1, d=12, $fn=6);

                    // Bearing washer to keep in place
                    move([0,0,-1]) cyl(h=1, d1=6, d2=12);
                }

                // Hub hole
                move([0,0,-2]) cyl(h=6,d=5);   
            }
        }
    }

    // Screw holder
    move([0,0,6]) difference() {
        move([0,0,0]) zrot(90) cyl(h=2, d1=12, d2=8, $fn=6);
        move([0,0,0]) cyl(h=4, d=6);
    } 
}

module spool_holder_sides()
{
    difference() {
        union() {
            // Left
            move([(72/2 + 0.5),0,0]) {
                cuboid([1,74,11]);
            }

            // Right
            move([(-72/2 +-0.5),0,0]) {
                cuboid([1,74,11]);
            }

            // Top
            move([0,(75/2) - 1,0]) {
                difference() {
                    cuboid([83,1,15.75], chamfer=1, edges=EDGES_Y_ALL);

                    // Handle recesses
                    move([-20,0,0]) cuboid([3.6,3,3.6], chamfer=0.5);
                    move([+20,0,0]) cuboid([3.6,3,3.6], chamfer=0.5);
                }
            }

            // Guides
            spool_holder_guides();
        }
    }
}

module spool_holder_hardware()
{
    move([0,0,5.5]) metric_bolt(headtype="round", size=3, l=12, details=false, pitch=0, phillips="#2");
    move([0,0,-7.5]) zrot(90) metric_nut(size=3, hole=true);
}

module spool_holder_connectors(toPrint)
{
    // Right
    move([34,33,0]) {
        difference() {
            ycyl(h=8,d=13);
            if (toPrint) {
                move([0,2,0]) xrot(90) threaded_rod(d=9.5, l=8, pitch=0.9, internal=true);
                move([0,-3.49,0]) xrot(90) cyl(h=3, d=10);
            } else {
                move([0,2,0]) xrot(90) cyl(h=8, d=9.5);
                move([0,-3.49,0]) xrot(90) cyl(h=3, d=10);
            }

            move([0,-3,0]) ycyl(h=20,d=4.25);
        }

        difference() {
            union() {
                move([0,-10,0]) ycyl(h=12,d=5.25);
                move([0,-6,0]) ycyl(h=4,d2=13, d1=5.25);
            }
            move([0,-5.99,0]) ycyl(h=4,d2=13 - 3, d1=5.25 - 2.5);
            move([0,-8,0]) ycyl(h=11,d=4.25);
            move([0,-14,0]) ycyl(h=2,d2=4.25, d1=2.5);
            move([0,-10,0]) ycyl(h=14,d=2.5);
        }
    }

    // Left
    move([-34,33,0]) {
        difference() {
            ycyl(h=8,d=13);
            if (toPrint) {
                move([0,2,0]) xrot(90) threaded_rod(d=9.5, l=8, pitch=0.9, internal=true);
                move([0,-3.49,0]) xrot(90) cyl(h=3, d=10);
            } else {
                move([0,2,0]) xrot(90) cyl(h=8, d=9.5);
                move([0,-3.49,0]) xrot(90) cyl(h=3, d=10);
            }

            move([0,-3,0]) ycyl(h=20,d=4.25);
        }

        difference() {
            union() {
                move([0,-10,0]) ycyl(h=12,d=5.25);
                move([0,-6,0]) ycyl(h=4,d2=13, d1=5.25);
            }
            move([0,-5.99,0]) ycyl(h=4,d2=13 - 3, d1=5.25 - 2.5);
            move([0,-8,0]) ycyl(h=11,d=4.25);
            move([0,-14,0]) ycyl(h=2,d2=4.25, d1=2.5);
            move([0,-10,0]) ycyl(h=14,d=2.5);
        }
    }
}

module spool_holder_guides()
{
    difference() {
        union() {
            // Left
            move([(72/2 + 1.5),24,0]) {
                cuboid([3,15,3], chamfer=1);
            }

            // Right
            move([(-72/2 - 1.5),24,0]) {
                cuboid([3,15,3], chamfer=1);
            }
        }
    }
}

module spool_holder(toPrint)
{
    difference() {
        union() {
            spool_holder_base();
            spool_holder_top();
            spool_holder_sides();
        }

        // Connector clearance
        move([34,33 + 3,0]) ycyl(h=14,d=12.75);
        move([34,33-5.99,0]) ycyl(h=4,d2=13, d1=5.25);

        move([-34,33 + 3,0]) ycyl(h=14,d=12.75);
        move([-34,33-5.99,0]) ycyl(h=4,d2=13, d1=5.25);

        move([34,23.51,0]) ycyl(h=13,d=5.25);
        move([-34,23.51,0]) ycyl(h=13,d=5.25);
    }

    spool_holder_connectors(toPrint);
}

module render_spool_holder(crend, toPrint)
{
    if (toPrint) {
        move([0,0,37]) xrot(-90) {
            spool_holder(toPrint);
        }
    } else {
        move([0,-1,32]) {
            if (crend) color([0.2,0.2,0.2]) spool_holder(toPrint);
            else spool_holder(toPrint);
            spool_holder_hardware();
        }

        move([0,-1,16]) {
            if (crend) color([0.2,0.2,0.2]) spool_holder(toPrint);
            else spool_holder(toPrint);
            spool_holder_hardware();
        }

        move([0,-1,0]) {
            if (crend) color([0.2,0.2,0.2]) spool_holder(toPrint);
            else spool_holder(toPrint);
            spool_holder_hardware();
        }

        move([0,-1,-16]) {
            if (crend) color([0.2,0.2,0.2]) spool_holder(toPrint);
            else spool_holder(toPrint);
            spool_holder_hardware();
        }

        move([0,-1,-32]) {
            if (crend) color([0.2,0.2,0.2]) spool_holder(toPrint);
            else spool_holder(toPrint);
            spool_holder_hardware();
        }
    }
}