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
include <body_top.scad>
include <body_middle.scad>
include <body_base.scad>
include <hinge.scad>
include <spools.scad>
include <mounting_bracket.scad>
include <t-nut.scad>
include <desiccant_container.scad>

// Rendering resolution
$fn=30;

// Select rendering parameters
use_colour = "Colour"; // [Colour, No colour]
for_printing = "Display"; // [Display, Printing]
feed_configuration = "Above"; // [Above, Below]

display_body_top = "Yes"; // [Yes, No]
display_body_middle = "Yes"; // [Yes, No]
display_body_base = "Yes"; // [Yes, No]
display_desiccant_compartment_lid = "Yes"; // [Yes, No]

display_hinge = "Yes"; // [Yes, No]
display_hinge_caps = "Yes"; // [Yes, No]

display_mounting_bracket_upper = "Yes"; // [Yes, No]
display_mounting_bracket_lower = "Yes"; // [Yes, No]
display_t_nuts = "Yes"; // [Yes, No]

display_spools = "Yes"; // [Yes, No]
display_bearings = "Yes"; // [Yes, No]
display_connectors = "Yes"; // [Yes, No]

display_desiccant_holder = "Yes"; // [Yes, No]
display_desiccant_holder_lid = "Yes"; // [Yes, No]

// Render the required items
module main()
{
    crend = (use_colour == "Colour") ? true:false;
    toPrint = (for_printing == "Printing") ? true:false;

    isFeedAbove = (feed_configuration == "Above") ? true:false;

    d_body_top = (display_body_top == "Yes") ? true:false;
    d_body_middle = (display_body_middle == "Yes") ? true:false;
    d_body_base = (display_body_base == "Yes") ? true:false;
    d_desiccant_compartment_lid = (display_desiccant_compartment_lid == "Yes") ? true:false;

    d_hinge = (display_hinge == "Yes") ? true:false;
    d_hinge_caps = (display_hinge_caps == "Yes") ? true:false;

    d_mounting_bracket_upper = (display_mounting_bracket_upper == "Yes") ? true:false;
    d_mounting_bracket_lower = (display_mounting_bracket_lower == "Yes") ? true:false;
    d_t_nuts = (display_t_nuts == "Yes") ? true:false;

    d_spools = (display_spools == "Yes") ? true:false;
    d_bearings = (display_bearings == "Yes") ? true:false;
    d_connectors = (display_connectors == "Yes") ? true:false;

    d_desiccant_holder = (display_desiccant_holder == "Yes") ? true:false;
    d_desiccant_holder_lid = (display_desiccant_holder_lid == "Yes") ? true:false;

    if (d_body_top) render_body_top(crend, toPrint);
    if (d_body_middle) render_body_middle(crend, toPrint);
    if (d_body_base) render_body_base(crend, toPrint);
    if (d_desiccant_compartment_lid) render_desiccant_compartment_lid(crend, toPrint);

    if (d_hinge) render_hinge(crend, toPrint);
    if (d_hinge_caps) render_hinge_caps(crend, toPrint);

    if (d_mounting_bracket_upper) render_mounting_bracket_upper(crend, toPrint);
    if (d_mounting_bracket_lower) render_mounting_bracket_lower(crend, toPrint);
    if (d_t_nuts) render_tnuts(crend, toPrint);

    if (d_spools) render_spools(crend, toPrint);
    if (d_bearings) render_bearings(crend, toPrint);
    if (d_connectors) render_ptfe_connectors(crend, toPrint, isFeedAbove);

    if (d_desiccant_holder) render_desiccant_holder(crend, toPrint);
    if (d_desiccant_holder_lid) render_desiccant_holder_lid(crend, toPrint);
}

main();