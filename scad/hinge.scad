/************************************************************************

    hinge.scad
    
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

module render_hinge_screws()
{
    move([0,48,288]) {
        move([30 + 1,0,0]) yrot(90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);
        move([-(30 + 1),0,0]) yrot(-90) metric_bolt(headtype="socket", size=3, l=12, details=false, phillips="#2", pitch=0);
    }
}

module hinge_caps(showBoth)
{
    move([0,48,288]) {
        move([30 + 2,0,0]) {
            difference() {
                xcyl(h=4,d1=10, d2=8);
                xcyl(h=5,d=3.25);
                move([1,0,0]) xcyl(h=4,d=6);
            }
        }

        if (showBoth) {
            move([-(30 + 2),0,0]) {
                difference() {
                    xcyl(h=4,d1=8, d2=10);
                    xcyl(h=5,d=3.25);
                    move([-1,0,0]) xcyl(h=4,d=6);
                }
            }
        }
    }
}

module render_hinge_caps(crend, toPrint)
{
    if (!toPrint) {
        if (crend) color([1,0.65,0]) hinge_caps(true);
        else hinge_caps(true);

        color([0.7,0.7,0.7]) render_hinge_screws();
    } else {
        yrot(-90) move([-30,-48,-288]) hinge_caps(false);
    }
}

module hinge()
{
    move([0,48,288]) {
        difference() {
            union() {
                // Shaft
                xcyl(h=58,d=7.5);

                // End-caps
                move([60/2 - 0.5,0,0]) xcyl(h=1,d1=7.5, d2=6.5);
                move([-(60/2 - 0.5),0,0]) xcyl(h=1,d1=6.5, d2=7.5);
            }

            // Screw holes for M3
            move([23,0,0]) xcyl(h=16,d=3);
            move([-23,0,0]) xcyl(h=16,d=3);

            // Flatten one side to make it printable
            move([0,0,-4]) cuboid([62,10,2]);
        }
    }
}

module render_hinge(crend, toPrint)
{
    if (!toPrint) {
        if (crend) color([1,0.65,0]) hinge();
        else hinge();
    } else {
        move([0,-48,-285]) hinge();
    }
}