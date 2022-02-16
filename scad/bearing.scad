/************************************************************************

    bearing.scad
    
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

// Bearing type: 604zz (id=4mm x od=12mm x h=4mm) 
module bearing604zz()
{
    // Outer ring
    difference() {
        color([0.6,0.6,0.6]) cyl(h=4, d=12);
        cyl(h=6, d=10);
    }

    // Inner ring
    difference() {
        color([0.6,0.6,0.6]) cyl(h=4, d=6);
        cyl(h=6, d=4);
    }

    // Body
    difference() {
        color([0.8,0.8,0.8]) cyl(h=3, d=10);
        cyl(h=6, d=6);
    }
}

// Bearing type: 605zz (id=5mm x od=14mm x h=5mm) 
module bearing605zz()
{
    // Outer ring
    difference() {
        color([0.6,0.6,0.6]) cyl(h=5, d=14);
        cyl(h=6, d=12);
    }

    // Inner ring
    difference() {
        color([0.6,0.6,0.6]) cyl(h=5, d=7);
        cyl(h=6, d=5);
    }

    // Body
    difference() {
        color([0.8,0.8,0.8]) cyl(h=4, d=12);
        cyl(h=6, d=7);
    }
}

module render_bearing(crend, toPrint)
{
    move([0,0,0.5]) bearing605zz();
}