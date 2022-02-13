/************************************************************************

    t-nut.scad
    
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

module tnut()
{
    difference() {
        union() {
            // Insert
            move([0,0,4.5]) {
                cyl(h=2,d=8, center=false);
                cuboid([4,4,2], center=false);
                move([-4, -4, 0]) cuboid([4,4,2], center=false);
            }

            hull() {
                // Top surface
                move([0,0,2]) hull() {
                    move([-8, -4, 0]) cuboid([12,4,3], center=false);
                    move([-4, 0, 0]) cuboid([12,4,3], center=false);
                    move([-6 + 12, -2, 0]) cyl(h=3,d=4, center=false);
                    move([-6, 2, 0]) cyl(h=3,d=4, center=false);
                }

                // Bottom surface
                move([0,0,0]) hull() {
                    move([-6, -4, 0]) cuboid([12 - 4,4,0.25], center=false);
                    move([-2, 0, 0]) cuboid([12 - 4,4,0.25], center=false);
                    move([-8 + 12, -2, 0]) cyl(h=0.25,d=4, center=false);
                    move([-4, 2, 0]) cyl(h=0.25,d=4, center=false);
                }
            }

            for(ofs=[0: 1: 5]) {
                move([0,ofs - 2.5,5]) xcyl(h=15,d=0.5);
            }
        }

        // Screw hole
        cyl(h=18,d=3.25, center=true);

        // Nut recess
        move([0,0,0.5]) cyl(h=4,d=6, center=true, $fn=6);
    }
}

module tnuts()
{
    move([53,65.5 + 2,9]) xrot(90) tnut();
    move([76,65.5 + 2,9]) xrot(90) tnut();
}

module render_tnuts(crend, toPrint)
{ 
    if (!toPrint) {
        if (crend) color([1,0.65,0]) tnuts();
        else tnuts();
    } else {
        tnut();
    }
}