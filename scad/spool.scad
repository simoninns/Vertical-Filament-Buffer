/************************************************************************

    spool.scad
    
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

module spool()
{
    difference() {
        union() {
            // Outer edge
            move([0,0,-0.75]) {
                difference() {
                    union() {
                        // Top and bottom lip
                        move([0,0,-2.5]) cyl(h=0.5,d=70, center=true, $fn=100);
                        move([0,0,3.5]) cyl(h=0.5,d=70, center=true, $fn=100);

                        // Top and bottom slopes
                        move([0,0,-1.25]) cyl(h=2,d1=70, d2=65, center=true, $fn=100);
                        move([0,0,2.25]) cyl(h=2,d1=65, d2=70, center=true, $fn=100);

                        // Middle fill
                        move([0,0,0.5]) cyl(h=6,d=67, center=true, $fn=100);
                    }

                    // Remove the middle
                    move([0,0,0]) cyl(h=10, d=64, center=true, $fn=100);
                }
            }

            // Middle support
            move([0,0,-2.5]) {
                difference() {
                    cyl(h=2,d=40, center=true, $fn=100);
                    cyl(h=3,d=36, center=true, $fn=100);
                }
            }

            // Spokes
            move([0,0,-2.5]) {
                zrot(000) cuboid([66,2,2]);
                zrot(045) cuboid([66,2,2]);
                zrot(090) cuboid([66,2,2]);
                zrot(135) cuboid([66,2,2]);
            }

            // Bearing holder
            move([0,0,-0.5]) cyl(h=6, d=16);
        }

        // Bearing slot
        move([0,0,1.5]) cyl(h=8, d=14.125);
        move([0,0,0]) cyl(h=8, d=11);
    }
}

module render_spool(crend, toPrint)
{
    if (toPrint) {
        move([0,0,3.5]) spool();
    } else {
        move([0,0,0.5]) {
            move([0,0,+32]) spool();
            move([0,0,+16]) spool();
            move([0,0,  0]) spool();
            move([0,0,-16]) spool();
            move([0,0,-32]) spool();
        }
    }
}
