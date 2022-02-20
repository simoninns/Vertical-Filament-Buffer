/************************************************************************

    spool_holder_handle.scad
    
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

module spool_holder_handle()
{
    move([0,37.5,0]) {
        difference() {
            union() {
                move([0,2,0]) {
                    hull() {
                        move([0,-1,0]) cuboid([43.5,4,3.5], chamfer=0.5);

                        move([0, 1,-1.5]) cyl(h=0.5,d1=19.5, d2=20, $fn=60);
                        move([0, 1,1.5]) cyl(h=0.5,d1=20, d2=19.5, $fn=60);
                    }
                }
            }

            move([0,-5.5,0]) cuboid([70,10,20]);
        }

        // Mounts
        move([-20,-1.5,0]) cuboid([3.5,3,3.5], chamfer=0.5);
        move([+20,-1.5,0]) cuboid([3.5,3,3.5], chamfer=0.5);
    }
}

module render_spool_holder_handle(crend, toPrint)
{
    if (toPrint) {
        move([0,-40,1.75]) spool_holder_handle();
    } else {
        move([0,-1,0]) {
            move([0,0,+32]) spool_holder_handle();
            move([0,0,+16]) spool_holder_handle();
            move([0,0,  0]) spool_holder_handle();
            move([0,0,-16]) spool_holder_handle();
            move([0,0,-32]) spool_holder_handle();
        }
    }
}