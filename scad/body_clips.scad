/************************************************************************

    body_base.scad
    
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

module body_clip()
{
    move([0,0,3.5]) cuboid([40,1,1], chamfer=0.25, edges=EDGES_Y_TOP+EDGE_TOP_FR+EDGE_BOT_FR);
    move([20,0.5,3.25]) zrot(90) yrot(180) right_triangle([1, 40, 1]);
}

module body_clip_inverse()
{
    scale(1.001) {
        move([20,0.5,3.75]) zrot(90) yrot(270) right_triangle([1, 40, 1]);
        move([0,0,3.5]) cuboid([40,1,1], chamfer=0.25, edges=EDGES_Y_TOP+EDGE_TOP_FR+EDGE_BOT_FR);
        move([20,0.5,3.25]) zrot(90) yrot(180) right_triangle([1, 40, 1]);
    }
}