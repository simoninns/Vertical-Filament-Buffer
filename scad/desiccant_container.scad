/************************************************************************

    desiccant_container.scad
    
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

module desiccant_compartment_lid()
{
    move([-59.5,-15.5,1]) {
        difference() {
            union() {
                move([0,0,80 + (12/2) - 1]) cyl(h=12,d=42, $fn=50);
                move([0,0,80 + (12/2) + 6]) cyl(h=2,d1=42, d2=40, $fn=50);
            }

            move([0,0,80 + (12/2) - 2]) metric_trapezoidal_threaded_rod(d=38, l=14, pitch=2.1, bevel2=true);

            for(rota=[0: 10: 360]) {
                zrot(rota) move([0,42/2,80 + (12/2)]) cyl(h=16,d=2);
            }
        }
    }
}

module render_desiccant_compartment_lid(crend, toPrint)
{
    if (!toPrint) {
        if (crend) color([1,0.65,0]) desiccant_compartment_lid();
        else desiccant_compartment_lid();
    } else {
        move([59.5,-15.5,94]) xrot(180) desiccant_compartment_lid();
    }
}

module desiccant_holder_lid()
{
    move([-59.5,-15.5,1]) {
        difference() {
            union() {
                move([0,0,69 + (12/2) - 1]) cyl(h=12,d=28, $fn=50);
                move([0,0,69 + (12/2) + 6]) cyl(h=2,d1=28, d2=24, $fn=50);
            }

            move([0,0,69 + (12/2) - 2]) metric_trapezoidal_threaded_rod(d=24, l=14, pitch=2.1, bevel2=true);

            for(rota=[0: 10: 360]) {
                zrot(rota) move([0,28/2,69 + (12/2)]) cyl(h=16,d=1.5);
            }
        }

        move([0,0,85]) cyl(h=6,d1=24, d2=8, $fn=50);
        move([0,0,89]) cyl(h=2,d1=8, d2=12, $fn=50);
        move([0,0,90.5]) cyl(h=1,d=12, $fn=50);
    }
}

module render_desiccant_holder_lid(crend, toPrint)
{
    if (!toPrint) {
        if (crend) color([0.2,0.2,0.2]) desiccant_holder_lid();
        else desiccant_holder_lid();
    } else {
        xrot(180) move([59.5,15.5,-92]) desiccant_holder_lid();
    }
}

module desiccant_holder()
{
    move([-59.5,-15.5,0]) {
        difference() {
            union() {
                move([0,0,2]) {
                    move([0,0, 0]) cyl(h=2, d1=31, d2=33, center=false, $fn=100); // Base

                    difference() {
                        move([0,0, 2]) cyl(h=55, d=33, center=false, $fn=100); // Body
                        move([0,0, 2]) cyl(h=55.1, d=33 - 4, center=false, $fn=100); // Body
                    }

                    difference() {
                        move([0,0,57]) cyl(h=10, d1=33, d2=24, center=false, $fn=100); // Neck
                        move([0,0,55]) cyl(h=10, d1=33, d2=24, center=false, $fn=100); // Neck
                        move([0,0,67 - 2.1]) cyl(h=3, d1=24.25, d2=18, center=false, $fn=100); // Neck
                    }

                    difference() {
                        move([0,0,67+5]) metric_trapezoidal_threaded_rod(d=23.5, l=10, pitch=2.1, bevel2=true); // Thread
                        move([0,0,67+5]) cyl(d=24 - 4, h=15); // Thread
                    }
                }
            }

            // Vents
            for(upy=[0: 4: 50]) {
                move([0,0,6.5 + upy]) {
                    move([0,0,0]) {
                        for(rota=[0: 10: 180]) {
                            zrot(rota) xcyl(h=40, d=2, $fn=6);
                        }
                    }

                    move([0,0,2]) {
                        for(rota=[0: 10: 180]) {
                            zrot(rota + 5) xcyl(h=40, d=2, $fn=6);
                        }
                    }
                }
            }
        }
    }
}

module render_desiccant_holder(crend, toPrint)
{
    if (!toPrint) {
        if (crend) color([1,0.65,0]) desiccant_holder();
        else desiccant_holder();
    } else {
        move([59.5,15.5,-2]) desiccant_holder();
    }
}