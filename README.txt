============================================================================
masterbizor - Turn an image into a gigantic rasterized poster.  A
shameless clone of the rasterbator: http://homokaasu.org/rasterbator/
Copyright (C) 2004 Thomas Schumm <phong@phong.org>
----------------------------------------------------------------------------
This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option)
any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
more details.

You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 59 Temple
Place, Suite 330, Boston, MA 02111-1307 USA
============================================================================

The masterbizor is a dirty little tool for generating giant posters from
relatively small images.  The output (in multi-page PDF format) resembles
giant blown-up newsprint or a "rasterized" look.

I say it's dirty because I coded 95% of the functionality in about 3 hours
one evening when I had drank too much coffee.  It's entirely python's fault
that it was so damn easy to write this.  Of course, since it's dirty, it
has lots of rough edges and possibly some bugs.  It probably won't behave
if you give it bad input.  There might even be speeling errors in this
document.

You'll need a couple python libraries to run this, both are free and easy to
find.  The first is reportlab (used to generate PDFs).  The second is the
python Imaging library, which opens all kinds of image file formats.  If you
get time, send some cookies to the authors of these excellent libraries.

A couple options could use a little bit more verbose explanation than is
provided by --help.

--units
This sets the default units to use in subsequent options that involve
dimensions.  Your choices are "cm". "in", "mm", "pt" and "pica".  The
default is inches.  Any parameter can override this by specifying the
units explicitly (see examples below).

--page-size
This specifies the size of paper you're going to be using.  The default is
"letter", but you can choose lots of other things like "a4", etc.  You could
also specify a width and height (e.g. "8.5inx11in").  Check out
reportlab.lib.pagesizes for a full list.

--portrait, --landscape
This will set the paeg orientation in the output PDF file.

--width, --height, --width-pages, --height-pages
These set the dimensions of the output.  You usually only want to specify one
of them, e.g. if you have a space to fill 60" wide, you should use
--width=60in.  Actually, you might want to leave yourself a little wiggle room
so you don't end up falling 1/4" short because your printer is off by 0.5%.
The --width-pages and --height-pages let you specify the width or height in
terms of pages consumed.  For example, if you say --width-pages=3, the
resulting poster will be exactly 3 pages wide.

If you specify both a width and a height, you'll probably screw up the aspect
ratio of the image.  If you specify only one, masterbizor will automatically
set the other to keep the aspect ratio the same.  Screwing up the aspect ratio
makes your poster look really stupid (unless it's done in an exaggerated way
for some artistic effect, but then you probably ought to do that in the Gimp
or something beforehand), so don't do it.  It's bad enough that your the sort
of jackass that doesn't realize it looks stupid, don't advertise it 6 feet
high on a wall somewhere.

--dot-size
This is sorta self-explanatory.  The default is 1cm.  Make it smaller to have
a finer screen.  Be warned though that the size of the PDF will increase with
the inverse square of this setting (e.g. halve the size of the dots, the size
of the pdf file will increase by a factor of four).  You usually won't want to
get much smaller than about 0.5cm unless the poster is very small.

Also, this is the "maximum" dot size, i.e. the size used in areas of solid
black.  In areas of gray, it will be proportionally smaller.  Also, it's only
approximate, internally masterbizor will fudge this ever-so-slightly so that
the dots fit on the poster more nicely...  You won't notice, it's a very
slight fudge factor.

--overlap
This makes it so that the image content overlaps a little on adjacent pages so
that your cutting and whatnot doesn't have to be perfectly precise to get your
pages to look right.  The default is zero, but you may want to set it to 1cm
or 0.5in or something.  Some calculation is done to make sure that the
resulting poster size is still what you specified.

Notice that dots on adjacent pages on the Rasterbator don't line up - the grid
resets with each page.  Not so in the Masterbizor - you can create a truly
seamless image!

--margin=LEFT RIGHT TOP BOTTOM
Very few printers can print to the edge of the page, so you'll want to give
your printer margins here.  The output PDF file will have pages reduced by
exactly this amount, so that when you print (be sure to choose "fit to page")
the dimensions come out exactly as expected.  Or, at least, that's the hope.

--screen
The Rasterbator only has one sort of screen - a square grid.  The Masterbizor
lets you choose a square grid or a triangular grid (packed like a honeycomb).
I think the triangular grid looks nicer, but if your image has a lot of
horizontal and vertical elements, it might make them look funny.  Your three
choices are "square", "triv" and "trih".  "triv" is the default.  "trih" is
the same as "triv" but rotated 90 degrees.

One caveat is that the appropriate dot size for the triangular screen is
smaller than the equivalent square screen because the dots are packed more
efficiently with less overlap.  To get "equivalent" sizes if you want to do a
side-by-side comparison, multiply the dot-size for a square grid by
cos(45)/cos(30) to get the appropriate dot-size for a triangular grid.  This
will give you outputs with similar resolutions and total numbers of dots.
Also, the square grid will produce a much darker looking image because dots
overlap more.  I may add some functionality to correct for this in the future.

--resample, --no-resample
Normally you want to leave resampling on.  Otherwise you could get aliasing or
moire.

--marks, --no-marks
This prints registration marks on the printed pages to make trimming easier.
You can turn this off if you don't want them.  Notice that the right and
bottom edges of the poster are overprinted - the registration marks will help
you find where the exact edges should be.


--scale-method=, --log-scale=
This provides control over how dots are sized to create the impression of 
darker colors.  By default, dots are not scaled.  Options currently include:
"e" and "log".  When supplying "log", you should also supply a scaling factor
which results in dots scaled according to: size = log(size)/log_scale + 1
Higher values have a greater impact to lighter colors.
"e" scales dots according to: size = exp(size)/exp(1)

--invert-dot-size, --no-invert-dot-size
Normally, dots are sized in relation with their intensity; light is small, 
dark is large.  Inverting this calculation produces large, light colored dots 
and small dark colors.

--invert, --no-invert
This inverts the color of the dot.

--wireframe, --no-wireframe
If enabled, this draws a circle without filling it in for each dot.

--color=
The default coloring is "natural" which uses the colors from the original image 
to color each dots.  --color allows the use of the following, named colors:
white, black, red, orange, yellow, green, blue, indigo, violet

--rgb-color=
Similar to --color, this option allows specifying a color to override the 
original image colors with a comma separated RGB value.

--shade
The default behavior is to shade dots according to their color in the original 
image.  If a color has been specified by --color or --rgb-color, the dots will 
be shaded according to their intensity, but use the specified color as a base.

--solid
Rather than shading the dots according to their original color, this colors the
dots as a solid color as in the original image or as specified with --color 
or --rgb-color.

--background-color=, --background-rgb-color=
As in the case of the --color override, these allow specifying a named or RGB 
color to use for the background instead of the default of white.
