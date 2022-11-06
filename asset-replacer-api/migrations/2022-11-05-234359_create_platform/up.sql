CREATE TABLE platform (
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL UNIQUE,
    alt_name varchar(128),
    short_name varchar(128),
    image_path varchar
);
COMMENT ON TABLE platform IS 'Computer hardware + software that games are designed to run on (PC, macOS NES, PSX, etc)';
COMMENT ON COLUMN platform.name IS 'Full name of the platform. (Nintendo Entertainment System, PlayStation, etc)';
COMMENT ON COLUMN platform.short_name IS 'Short name of the system (NES, PS1, etc)';
COMMENT ON COLUMN platform.image_path IS 'Relative path to the platform''s image. Typically part of a URL accessible over HTTP(s).';
CREATE INDEX ON platform(name);
CREATE INDEX ON platform(short_name);