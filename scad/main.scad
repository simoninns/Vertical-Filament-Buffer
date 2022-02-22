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
include <spool_holder_handle.scad>
include <bearing_holder.scad>
include <body_top.scad>
include <body_middle.scad>
include <body_base.scad>
include <mounting_bracket.scad>
include <spool_holder_clip.scad>
include <t-nut.scad>

// Rendering resolution
$fn=30;

// Select rendering parameters
use_colour = "Colour"; // [Colour, No colour]
for_printing = "Display"; // [Display, Printing]

// Spool and holder parameters
display_spool_holder = "No"; // [Yes, No]
display_spool_holder_handle = "No"; // [Yes, No]
display_spool_holder_clip = "No"; // [Yes, No]
display_spool = "No"; // [Yes, No]
display_bearing_holder = "No"; // [Yes, No]
display_bearing = "No"; // [Yes, No]
display_connectors = "No"; // [Yes, No]

// Body parameters
display_body_top = "No"; // [Yes, No]
display_body_middle_upper = "No"; // [Yes, No]
display_body_middle_lower = "No"; // [Yes, No]
display_body_base = "No"; // [Yes, No]

// Mounting parameters
display_upper_mounting_bracket = "No"; // [Yes, No]
display_t_nut = "No"; // [Yes, No]

// Render the required items
module main()
{
    // Main options
    crend = (use_colour == "Colour") ? true:false;
    toPrint = (for_printing == "Printing") ? true:false;

    // Display selections
    d_spool_holder = (display_spool_holder == "Yes") ? true:false;
    d_spool_holder_handle = (display_spool_holder_handle == "Yes") ? true:false;
    d_spool_holder_clip = (display_spool_holder_clip == "Yes") ? true:false;
    d_spool = (display_spool == "Yes") ? true:false;
    d_bearing_holder = (display_bearing_holder == "Yes") ? true:false;
    d_bearing = (display_bearing == "Yes") ? true:false;
    d_connectors = (display_connectors == "Yes") ? true:false;

    d_body_top = (display_body_top == "Yes") ? true:false;
    d_body_middle_upper = (display_body_middle_upper == "Yes") ? true:false;
    d_body_middle_lower = (display_body_middle_lower == "Yes") ? true:false;
    d_body_base = (display_body_base == "Yes") ? true:false;

    d_upper_mounting_bracket = (display_upper_mounting_bracket == "Yes") ? true:false;
    d_t_nut = (display_t_nut == "Yes") ? true:false;

    // Spool and spool holder rendering:
    spolr = (toPrint) ? 0 : 90;
    spoly = (toPrint) ? 0 : 280;
    move([0,0,spoly]) xrot(spolr) yrot(spolr) {
        if (d_spool_holder) render_spool_holder(crend, toPrint);
        if (d_spool_holder_handle) render_spool_holder_handle(crend, toPrint);
        if (d_spool) render_spool(crend, toPrint);
        if (d_bearing_holder) render_bearing_holder(crend, toPrint);
        if (d_bearing) render_bearing(crend, toPrint);
        if (d_connectors) render_connectors(crend, toPrint);
    }

    if (d_spool_holder_clip) render_spool_holder_clip(crend, toPrint);

    // Body rendering
    bodr = (toPrint) ? 0 : 90;
    body = (toPrint) ? 0 : 280;
    move([0,0,body]) xrot(bodr) yrot(bodr) {
        if (d_body_top) render_body_top(crend, toPrint);
    }
    if (d_body_middle_upper) render_body_middle_upper(crend, toPrint);
    if (d_body_middle_lower) render_body_middle_lower(crend, toPrint);
    if (d_body_base) render_body_base(crend, toPrint);

    // Bracket rendering
    if (d_upper_mounting_bracket) render_upper_mounting_bracket(crend, toPrint);
    if (d_t_nut) render_t_nut(crend, toPrint);
}

main();