# determine the latitude and longitude of the subsolar point, the point on Earth where the Sun is directly overhead at a given time

import SPICE

#=

You will need to have the files below installed in a directory called SPICE/KERNELS. You can get them from:

naif0012.tls in https://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/

de430.bsp in https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/planets/

pck00011.tpc in https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/

earth_1962_250826_2125_combined.bpc in https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/

Note that these links are intentionally to virtual directories so you can see the size of the file before downloading and read more about these files if you wish

=#

SPICE.furnsh("SPICE/KERNELS/naif0012.tls")
SPICE.furnsh("SPICE/KERNELS/de430.bsp")
SPICE.furnsh("SPICE/KERNELS/pck00011.tpc")
SPICE.furnsh("SPICE/KERNELS/earth_1962_250826_2125_combined.bpc")

# let's use 2026-01-01T00:00:00 as an example; we first convert to ephemeris time, the time used by the SPICE library

# TODO: should this be taken from the command line and defaulted instead?

my_utc = "2026-01-01T00:00:00"
my_time = SPICE.utc2et(my_utc)

# The SPICE library (documented at https://naif.jpl.nasa.gov/naif/ and https://juliaastro.org/SPICE/stable/) does most of the work

subsolar_point = SPICE.subslr("NEAR POINT/ELLIPSOID", "EARTH", my_time, "ITRF93", "CN+S", "EARTH")

# the first element of subsolar_point gives us the Cartesian position on Earth where the subsolar point lies

sub_solar_cart = subsolar_point[1]

# we now need to convert these Cartesian coordinates to latitude and longitude; if the Earth were a perfect sphere, this would be trivial; since it's not, we need a few additional steps

# find the Earth's equitorial and polar radius and compute the "flattening coefficient"

radii = SPICE.bodvrd("EARTH", "RADII");
equ = radii[1]
plr = radii[3]
fln = (equ-plr)/equ

# we now convert the Cartesian coordinates to latitude and longitude using another SPICE function

my_spherical = SPICE.recgeo(sub_solar_cart, equ, fln)

# the result is a tuple containing longitude, latitude in radians, and elevation (which will be 0 in our case; let's convert these to degrees for printing)

my_lng = rad2deg(my_spherical[1])
my_lat = rad2deg(my_spherical[2])

println("The subsolar point at $my_utc is longitude $my_lng and latitude $my_lat")

#=

The above was done in several steps for instructive purposes. Here's a much shorter version that does ALMOST the same thing for reference

function sub_solar_point(t)
 radii = SPICE.bodvrd("EARTH", "RADII")
 rad2deg.(SPICE.recgeo(SPICE.subslr("NEAR POINT/ELLIPSOID", "EARTH", SPICE.utc2et(t), "ITRF93", "CN+S", "EARTH")[1], radii[1], 1- radii[1]/radii[3])[1:2])
end

Usage: sub_solar_point("2025-12-10T16:00:00")

=#

#=

NOTES:

  - there are other, less accurate, ways to compute the subsolar point that you may want to use for testing

  - as a warning, do not use SPICE.subslr("INTERCEPT/ELLIPSOID", ...); it gives an inaccurate result because we measure latitude on ellipsoidal Earth geodesically, not from the center point

=#
