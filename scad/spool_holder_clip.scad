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

module clip()
{
    move([0,-43.5,315]) {
        move([0,0,-2.5]) cuboid([6,2,15], chamfer=0.5);
        move([0,1,2]) cuboid([6,4,2], chamfer=0.5);
        move([0,-0.5,3])cuboid([6,1,10], chamfer=0.5);
    }
}

module spool_holder_clip()
{
    move([+32,0,0]) clip();
    move([+16,0,0]) clip();
    move([0,0,0]) clip();
    move([-16,0,0]) clip();
    move([-32,0,0]) clip();

    move([0,-43.5,306]) cuboid([80,2,10], chamfer=0.5);

    // Mounting pegs
    move([30,-41.5,306]) ycyl(h=2,d=3);
    move([30,-40.25,306]) ycyl(h=0.5,d1=3, d2=1);

    move([0,-41.5,306]) ycyl(h=2,d=3);
    move([0,-40.25,306]) ycyl(h=0.5,d1=3, d2=1);

    move([-30,-41.5,306]) ycyl(h=2,d=3);
    move([-30,-40.25,306]) ycyl(h=0.5,d1=3, d2=1);
}

module render_spool_holder_clip(crend, toPrint)
{
    if (toPrint) {
        xrot(90) move([0,44.5,-306])  spool_holder_clip();
    } else {
        spool_holder_clip();
    }
}