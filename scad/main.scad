/************************************************************************

    main.scad
    
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

// Local includes
include <bearing.scad>
include <spool.scad>
include <connectors.scad>
include <spool_holder.scad>
include <bearing_holder.scad>

// include <body_top.scad>
// include <body_middle.scad>
// include <body_base.scad>
// include <hinge.scad>
// include <mounting_bracket.scad>
// include <t-nut.scad>
// include <desiccant_container.scad>

// Rendering resolution
$fn=30;

// Select rendering parameters
use_colour = "Colour"; // [Colour, No colour]
for_printing = "Display"; // [Display, Printing]

display_spool_holder = "No"; // [Yes, No]
display_spool_holder_support = "No"; // [Yes, No]
display_spool = "No"; // [Yes, No]
display_bearing_holder = "No"; // [Yes, No]
display_bearing = "No"; // [Yes, No]
display_connectors = "No"; // [Yes, No]

// Render the required items
module main()
{
    // Main options
    crend = (use_colour == "Colour") ? true:false;
    toPrint = (for_printing == "Printing") ? true:false;

    // Display selections
    d_spool_holder = (display_spool_holder == "Yes") ? true:false;
    d_spool_holder_support = (display_spool_holder_support == "Yes") ? true:false;
    d_spool = (display_spool == "Yes") ? true:false;
    d_bearing_holder = (display_bearing_holder == "Yes") ? true:false;
    d_bearing = (display_bearing == "Yes") ? true:false;
    d_connectors = (display_connectors == "Yes") ? true:false;

    // Render the required parts
    if (d_spool_holder) render_spool_holder(crend, toPrint);
    if (d_spool_holder_support) render_spool_holder_support(crend, toPrint);
    if (d_spool) render_spool(crend, toPrint);
    if (d_bearing_holder) render_bearing_holder(crend, toPrint);
    if (d_bearing) render_bearing(crend, toPrint);
    if (d_connectors) render_connectors(crend, toPrint);
}

main();