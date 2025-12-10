Jeff Groves challenges go here

Languages: Julia, GRASS GIS, client-side JavaScript

Notes:

Maps should be overlayable on OpenStreetMaps (openstreetmaps.org), meaning they should be tiled rasters or polygons

Challenges:

  - create spherical Voronoi diagrams for countries/regions that show where you are closer to (for example) USA vs UK vs Australia for example, ideally on the fly using JavaScript but server-side rendering is also acceptable

  - determine the shortest water-only path between two given cities

  - create a more accurate version of https://tjukanovt.github.io/neighbors/ which shows which foreign country you're closest to

  - create signed contour maps for a given country/region

  - determine the earliest and latest daily sunrise/set/twilight times for a given region (eg, for mainland USA, earliest sunrise is in eastern Maine at [time], latest sunrise is in southern California at [time])

  - determine the number of people in sunlight/twilight/night at any given time

  - find the hemisphere of the Earth with the least amount of land (this will be centered near Hawaii)

  - find and map the minimum and maximum distances between any two regions/countries and the maximum distance within a given region

  - find the shortest path that touches (for example) all 48 of the lower United States

Resources:

  - https://www.naturalearthdata.com/ has a lot of good data at lower resolution, good for initial testing

  - Shapes of countries:

    - https://gadm.org/
    - https://www.geoboundaries.org/globalDownloads.html

  - Population:

    - https://www.earthdata.nasa.gov/data/projects/gpw

    - https://www.worldpop.org/

  - Astronomical data incl sunrise/set/twilight/etc:

    - https://naif.jpl.nasa.gov/naif/ for general overview
    - https://juliaastro.org/SPICE/stable/ is a Julia wrapper

