/************************************************************************

    bearing_holder.scad
    
    Open Filament Buffer
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

module bearing_holder()
{
    difference() {
        cyl(h=10, d=4.75);
        cyl(h=12, d=3.25);
    }
}

module render_bearing_holder(crend, toPrint)
{
    if (toPrint) {
        move([0,0,5]) bearing_holder();
    } else {
        if (crend) {
            color([0.2,0.2,0.2]) move([0,0,0.5]) {
                move([0,0,+32]) bearing_holder();
                move([0,0,+16]) bearing_holder();
                move([0,0,  0]) bearing_holder();
                move([0,0,-16]) bearing_holder();
                move([0,0,-32]) bearing_holder();
            }
        } else {
            move([0,0,0.5]) {
                move([0,0,+32]) bearing_holder();
                move([0,0,+16]) bearing_holder();
                move([0,0,  0]) bearing_holder();
                move([0,0,-16]) bearing_holder();
                move([0,0,-32]) bearing_holder();
            }
        }
    }
}