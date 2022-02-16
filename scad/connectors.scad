/************************************************************************

    connectors.scad
    
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
use <BOSL/metric_screws.scad>
use <BOSL/threading.scad>

// Note: This model is just to assist design - it is not 
// an accurate representation of the connector
module pc4_m10_connector()
{
    pitch1 = 0.9;

    difference() {
        move([0,0,-2.5]) {
            color([0.7,0.7,0.7]) move([0,0,6]) cyl(h=7,d=11.5, $fn=6);
            color([0.7,0.7,0.7]) cyl(h=6, d=10);
            color([0.7,0.7,0.7]) move([0,0,10]) cyl(h=2, d1=10, d2=7);

            color([0.0,0.2,0.7]) move([0,0,12]) cyl(h=2, d=6);
            color([0.0,0.2,0.7]) move([0,0,14]) cyl(h=2, d=10);
        }

        move([0,0,18/2]) cyl(h=20, d=4.5); 
    }

    // Render some filament to help alignment visualization
    move([0,0,0]) color([0.7,0.2,0.7]) cyl(h=100, d=1.75);

    // Render PFTE tube
    move([0,0,25]) color([0.9,0.9,0.9]) cyl(h=30, d=4);
}

module render_connectors(crend, toPrint)
{
    move([+((67/2) + (1.75 / 4)),37,0]) {
        xrot(-90) pc4_m10_connector();
    }

    move([-((67/2) + (1.75 / 4)),37,0]) {
        xrot(-90) pc4_m10_connector();
    }
}

// module contact_mount_inverse(toPrint)
// {
//     ren_pitch = 0.9;
//     ren_det = 30;

//     // Threads for connectors
//     move([0,0,1.5 + 2]) {
//         // Thread are slow to render, so replace if just displaying
//         if (!toPrint) {
//             move([-29,0,0]) cyl(h=8,d=10);
//             move([-14.5,0,0]) cyl(h=8,d=10);
//             move([  0,0,0]) cyl(h=8,d=10);
//             move([+14.5,0,0]) cyl(h=8,d=10);
//             move([+29,0,0]) cyl(h=8,d=10);
//         } else {
//             move([-29,0,0]) threaded_rod(d=10, l=8, pitch=ren_pitch, internal=true, $fn=ren_det);
//             move([-14.5,0,0]) threaded_rod(d=10, l=8, pitch=ren_pitch, internal=true, $fn=ren_det);
//             move([  0,0,0]) threaded_rod(d=10, l=8, pitch=ren_pitch, internal=true, $fn=ren_det);
//             move([+14.5,0,0]) threaded_rod(d=10, l=8, pitch=ren_pitch, internal=true, $fn=ren_det);
//             move([+29,0,0]) threaded_rod(d=10, l=8, pitch=ren_pitch, internal=true, $fn=ren_det);
//         }
//     }

//     // Pipe holes
//     move([-29,0,0]) cyl(h=14, d=4.5);
//     move([-14.5,0,0]) cyl(h=14, d=4.5);
//     move([  0,0,0]) cyl(h=14, d=4.5);
//     move([+14.5,0,0]) cyl(h=14, d=4.5);
//     move([+29,0,0]) cyl(h=14, d=4.5);

//     // Fillament holes
//     move([0,0,-14]) {
//         move([-29,0,0]) cyl(h=16, d=2.5);
//         move([-14.5,0,0]) cyl(h=16, d=2.5);
//         move([  0,0,0]) cyl(h=16, d=2.5);
//         move([+14.5,0,0]) cyl(h=16, d=2.5);
//         move([+29,0,0]) cyl(h=16, d=2.5);
//     }
// }
