CREATE TYPE region AS ENUM('NA', 'EU', 'JP');
COMMENT ON TYPE region IS 'Region of the world where platforms and titles are released.';