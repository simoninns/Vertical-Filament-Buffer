/************************************************************************

    spools.scad
    
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

module render_spool()
{
    // Main spool body
    difference() {
        union() {
            move([0,0,0]) cyl(h=1,d=70, center=false, $fn=100); // top rim
            move([0,0,10]) cyl(h=1,d=70, center=false, $fn=100); // bottom rim

            move([0,0,1]) cyl(h=3,d1=70,d2=61, center=false, $fn=100); // top slope
            move([0,0,7]) cyl(h=3,d1=61,d2=70, center=false, $fn=100); // bottom slope

            cyl(h=11,d=61, center=false, $fn=100); // Centre
        }

        move([0,0,2]) cyl(h=10,d=59, center=false, $fn=100);
        move([0,0,-1]) cyl(h=14,d=14 + 1, center=false, $fn=100);

        // Remove material to form spokes
        for(rota=[0: 360/8: 360]) {
            rotate([0,0,rota]) move([21.5,0,-1]) cyl(h=6,d=15, center=false, $fn=30); // $fn=6 if you like more hexagons...
        }
    }

    // Bearing holder (bearing is 608zz)
    difference() {
        move([0,0,2]) cyl(h=7,d=22 + 4, center=false, $fn=50);
        move([0,0,1.5]) cyl(h=8,d=22, center=false, $fn=50);
    }
}

module render_spool_inverse()
{
    cyl(h=13,d=72, center=false, $fn=100);
}

module render_spools_inverse()
{ 
    move([0,0,305 + 2]) {
        move([-6.5,0,0]) yrot(90) {
            move([0,0,-29]) render_spool_inverse();
            move([0,0,-14.5]) render_spool_inverse();
            render_spool_inverse();
            move([0,0,+14.5]) render_spool_inverse();
            move([0,0,+29]) render_spool_inverse();
        }
    }
}

module spools()
{
    move([0,0,305 + 2]) {
        move([-5.5,0,0]) yrot(90) {
            move([0,0,-29]) render_spool();
            move([0,0,-14.5]) render_spool();
            render_spool();
            move([0,0,+14.5]) render_spool();
            move([0,0,+29]) render_spool();
        }
    }
}

module render_spools(crend, toPrint)
{
    if (!toPrint) {
        if (crend) color([1,0.65,0]) spools();
        else spools();
    } else {
        render_spool();
    }
}

// Bearing type: 608zz (id=8mm x od=22mm x h=7mm) 
module bearing()
{
    // Outer ring
    difference() {
        color([0.6,0.6,0.6]) cyl(h=7, d=22);
        cyl(h=8, d=18);
    }

    // Inner ring
    difference() {
        color([0.6,0.6,0.6]) cyl(h=7, d=12);
        cyl(h=8, d=8);
    }

    // Body
    difference() {
        color([0.8,0.8,0.8]) cyl(h=6, d=20);
        cyl(h=8, d=8);
    }
}

module render_bearings(crend, toPrint)
{
    if (!toPrint) {
        move([0,0,305 + 2]) {
            yrot(90) {
                move([0,0,-29]) bearing();
                move([0,0,-14.5]) bearing();
                bearing();
                move([0,0,+14.5]) bearing();
                move([0,0,+29]) bearing();
            }
        }
    }
}