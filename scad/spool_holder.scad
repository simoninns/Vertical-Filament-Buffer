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
    move([0,0,-4.5]) {
        difference() {
            union() {
                difference() {
                    cuboid([70 + 4,74,1]);
                    move([0,0,0]) cyl(h=2,d=66, center=true, $fn=100);
                }

                // Spokes
                cyl(h=1,d=14, center=true, $fn=100);
                move([0,0,0]) {
                    //zrot(000) cuboid([68,2,1]);
                    zrot(045) cuboid([68,3,1]);
                    zrot(090) cuboid([68,3,1]);
                    zrot(135) cuboid([68,3,1]);
                }

                move([0,0,1.5]) cyl(h=2, d1=12, d2=6);
            }

            move([0,0,1]) cyl(h=10,d=5);
            
            // Connector clearance
            move([34,33 + 2,4.5]) ycyl(h=10,d=12.75);
            move([-34,33 + 2,4.5]) ycyl(h=10,d=12.75);
        }
    }

    // Nut holder
    move([0,0,-2]) difference() {
        move([0,0,-4]) cyl(h=2, d1=8, d2=12, $fn=6);
        move([0,0,-5.25]) metric_nut(size=3.25, hole=false);
    }
}

module spool_holder_top()
{
    move([0,0,4.5]) {
        difference() {
            union() {
                difference() {
                    cuboid([70 + 4,74,1]);
                    move([0,0,0]) cyl(h=2,d=66, center=true, $fn=100);
                }

                // Spokes
                cyl(h=1,d=14, center=true, $fn=100);
                move([0,0,0]) {
                    //zrot(000) cuboid([68,2,1]);
                    zrot(045) cuboid([68,3,1]);
                    zrot(090) cuboid([68,3,1]);
                    zrot(135) cuboid([68,3,1]);
                }

                move([0,0,-1]) cyl(h=1, d1=6, d2=12);
            }

            move([0,0,-2]) cyl(h=6,d=5);
            
            // Connector clearance
            move([34,33 + 2,-4.55]) ycyl(h=10,d=12.75);
            move([-34,33 + 2,-4.5]) ycyl(h=10,d=12.75);
        }
    }
}

module spool_holder_sides()
{
    difference() {
        union() {
            // Left
            move([(72/2 + 0.5),0,0]) {
                cuboid([1,74,8]);
            }

            // Right
            move([(-72/2 +-0.5),0,0]) {
                cuboid([1,74,8]);
            }

            // Top
            move([0,(75/2) - 1,0]) {
                cuboid([72,1,8]);
            }
        }

        // Connector clearance
        move([34,33 + 2,0]) ycyl(h=10,d=12.75);
        move([-34,33 + 2,0]) ycyl(h=10,d=12.75);
    }
}

module spool_holder_hardware()
{
    move([0,0,5]) metric_bolt(headtype="round", size=3, l=12, details=false, pitch=0, phillips="#2");
    move([0,0,-7.5]) metric_nut(size=3, hole=true);
}

module spool_holder_connectors()
{
    move([34,33,0]) {
        difference() {
            ycyl(h=8,d=13);
            move([0,2,0]) xrot(90) threaded_rod(d=10, l=8, pitch=0.9, internal=true);
            move([0,-3,0]) ycyl(h=20,d=2.5);
        }
    }

    move([-34,33,0]) {
        difference() {
            ycyl(h=8,d=13);
            move([0,2,0]) xrot(90) threaded_rod(d=10, l=8, pitch=0.9, internal=true);
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

module render_spool_holder_support(crend, toPrint)
{
    move([34,34.5]) {
        ycyl(h=5,d=5);
    }

    move([-34,34.5,0]) {
        ycyl(h=5,d=5);
    }
}