/************************************************************************

    spool_holder_clip.scad
    
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

include <body_middle.scad>

module clip()
{
    move([0,-43.5,315]) {
        move([0,0,-2.5]) cuboid([8,2,15], chamfer=0.5); // Body
        move([0,2,2]) cuboid([8,5,2], chamfer=0.5); // Tab
        move([0,-0.5,5])cuboid([8,1,10], chamfer=0.5); // Additional height for easier operation
    }
}

module spool_holder_clip()
{
    move([+32,0,0]) clip();
    move([+16,0,0]) clip();
    move([0,0,0]) clip();
    move([-16,0,0]) clip();
    move([-32,0,0]) clip();

    move([0,-43.5,306.25]) cuboid([76,2,7.5], chamfer=0.5);

    // Mounting clip
    move([0,-42,303]) zrot(180) body_clip();
}

module render_spool_holder_clip(crend, toPrint)
{
    if (toPrint) {
        xrot(90) move([0,44.5,-306])  spool_holder_clip();
    } else {
        move([0,0,0]) spool_holder_clip();
    }
}