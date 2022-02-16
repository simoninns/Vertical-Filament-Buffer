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
    move([0,0,-2.75]) {
        difference() {
            union() {
                difference() {
                    cuboid([70 + 2,74,0.5]);
                    move([0,0,0]) cyl(h=2,d=66, center=true, $fn=100);
                }

                // Spokes
                cyl(h=0.5,d=14, center=true, $fn=100);
                move([0,0,0]) {
                    //zrot(000) cuboid([68,2,0.5]);
                    zrot(045) cuboid([68,3,0.5]);
                    zrot(090) cuboid([68,3,0.5]);
                    zrot(135) cuboid([68,3,0.5]);
                }

                move([0,0,0.5]) cyl(h=0.5, d1=8, d2=6);
            }

            move([0,0,1]) cyl(h=10,d=4.2);
            
            // Connector clearance
            move([34,33 + 2,2.75]) ycyl(h=10,d=12.75);
            move([-34,33 + 2,2.75]) ycyl(h=10,d=12.75);
        }
    }

    // Nut holder
    difference() {
        move([0,0,-4]) cyl(h=2, d1=8, d2=12, $fn=6);
        move([0,0,-5.25]) metric_nut(size=3.25, hole=false);
    }
}

module spool_holder_top()
{
    move([0,0,2.75]) {
        difference() {
            union() {
                difference() {
                    cuboid([70 + 2,74,0.5]);
                    move([0,0,0]) cyl(h=2,d=66, center=true, $fn=100);
                }

                // Spokes
                cyl(h=0.5,d=14, center=true, $fn=100);
                move([0,0,0]) {
                    //zrot(000) cuboid([68,2,0.5]);
                    zrot(045) cuboid([68,3,0.5]);
                    zrot(090) cuboid([68,3,0.5]);
                    zrot(135) cuboid([68,3,0.5]);
                }

                move([0,0,-0.5]) cyl(h=0.5, d1=6, d2=8);
            }

            move([0,0,-2]) cyl(h=6,d=4.2);
            
            // Connector clearance
            move([34,33 + 2,-2.75]) ycyl(h=10,d=12.75);
            move([-34,33 + 2,-2.75]) ycyl(h=10,d=12.75);
        }
    }
}

module spool_holder_sides()
{
    difference() {
        union() {
            // Left
            move([(72/2 - 0.25),0,0]) {
                cuboid([0.5,74,5.5]);
            }

            // Right
            move([(-72/2 + 0.25),0,0]) {
                cuboid([0.5,74,5.5]);
            }

            // Top
            move([0,(75/2) - 0.75,0]) {
                cuboid([72,0.5,5.5]);
            }
        }

        // Connector clearance
        move([34,33 + 2,0]) ycyl(h=10,d=12.75);
        move([-34,33 + 2,0]) ycyl(h=10,d=12.75);
    }
}

module spool_holder_hardware()
{
    move([0,0,3]) metric_bolt(headtype="round", size=3, l=8, details=false, pitch=0, phillips="#2");
    move([0,0,-5.25]) metric_nut(size=3, hole=true);
}

module spool_holder_connectors()
{
    move([34,33,0]) {
        difference() {
            ycyl(h=8,d=13);
            move([0,2,0]) xrot(90) threaded_rod(d=10, l=8, pitch=1, internal=true);
            move([0,-3,0]) ycyl(h=20,d=2.5);
        }
    }

    move([-34,33,0]) {
        difference() {
            ycyl(h=8,d=13);
            move([0,2,0]) xrot(90) threaded_rod(d=10, l=8, pitch=1, internal=true);
            move([0,-3,0]) ycyl(h=20,d=2.5);
        }
    }
}

module render_spool_holder(crend, toPrint)
{
    spool_holder_base();
    spool_holder_top();
    spool_holder_sides();
    spool_holder_connectors();
    //spool_holder_hardware();
}
