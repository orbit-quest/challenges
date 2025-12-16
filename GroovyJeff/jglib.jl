# this library combines functions I've written and described in other files

# from subsolar-point.jl

import SPICE

function sub_solar_point(t)
 radii = SPICE.bodvrd("EARTH", "RADII")
 rad2deg.(SPICE.recgeo(SPICE.subslr("NEAR POINT/ELLIPSOID", "EARTH", SPICE.utc2et(t), "ITRF93", "CN+S", "EARTH")[1], radii[1], 1- radii[1]/radii[3])[1:2])
end
