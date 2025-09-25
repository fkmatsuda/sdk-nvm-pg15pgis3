CREATE EXTENSION postgis;
-- enable raster support (for 3+)
CREATE EXTENSION postgis_raster;
-- Enable Topology
CREATE EXTENSION postgis_topology;
-- Enable PostGIS Advanced 3D
-- and other geoprocessing algorithms
-- sfcgal not available with all distributions
CREATE EXTENSION postgis_sfcgal;
-- fuzzy matching needed for Tiger
CREATE EXTENSION fuzzystrmatch;
-- unaccent
CREATE EXTENSION unaccent;
-- Enable PL/Python3U
CREATE EXTENSION plpython3u;
-- Enable PL/Perl
CREATE EXTENSION plperl;
