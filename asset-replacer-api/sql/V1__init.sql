CREATE TYPE region AS ENUM('NA', 'EU', 'JP');
COMMENT ON TYPE region IS 'Region of the world where platforms and titles are released.';


CREATE TABLE platform (
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL UNIQUE,
    short_name varchar(128),
    image_path varchar
);
COMMENT ON TABLE platform IS 'Computer hardware + software that games are designed to run on (PC, macOS NES, PSX, etc)';
COMMENT ON COLUMN platform.name IS 'Full name of the platform. (Nintendo Entertainment System, PlayStation, etc)';
COMMENT ON COLUMN platform.short_name IS 'Short name of the system (NES, PS1, etc)';
COMMENT ON COLUMN platform.image_path IS 'Relative path to the platform''s image. Typically part of a URL accessible over HTTP(s).';
CREATE INDEX ON platform(name);
CREATE INDEX ON platform(short_name);


CREATE TABLE platform_release(
    platform_id integer NOT NULL REFERENCES platform(id),
    region region NOT NULL,
    released timestamptz NOT NULL,
    PRIMARY KEY (platform_id, region)
);


CREATE TABLE title (
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL,
    image_path varchar
);
COMMENT ON TABLE title IS 'Game / software released for at least one platform.';
CREATE INDEX ON title(name);


CREATE TABLE title_release (
    title_id integer NOT NULL REFERENCES title(id),
    platform_id integer NOT NULL REFERENCES platform(id),
    released timestamptz NOT NULL,
    PRIMARY KEY (title_id, platform_id)
);
COMMENT ON TABLE title_release IS 'The release of a title for a specific platform.';
CREATE INDEX ON title_release(title_id);
CREATE INDEX ON title_release(platform_id);


CREATE TYPE asset_type AS ENUM ('texture', 'audio_file');


CREATE TABLE asset (
    id serial PRIMARY KEY,
    path varchar(128) NOT NULL,
    type asset_type NOT NULL,
    created timestamptz NOT NULL,
    updated timestamptz NOT NULL
);
COMMENT ON TABLE asset IS 'Represents a texture, audio file, etc from a video game.';
COMMENT ON COLUMN asset.path IS 'Relative path to the asset. Typically part of a URL accessible over HTTP(s).';


CREATE TYPE role AS ENUM ('basic', 'admin');
COMMENT ON TYPE role IS 'Determines what privileges a user has.';


CREATE TABLE "user" (
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL UNIQUE,
    email varchar(128) NOT NULL UNIQUE,
    password_hash varchar NOT NULL,
    salt bytea NOT NULL
);
COMMENT ON TABLE "user" IS 'User that is capable of creating asset packs and assigning assets to them.';


INSERT INTO platform (id, name, short_name, image_path) VALUES
    (1, 'Nintendo Entertainment System', 'NES', '/images/platforms/nes.png'),
    (2, 'Super Nintendo', 'SNES', '/images/platforms/snes.png'),
    (3, 'Nintendo 64', 'N64', '/images/platforms/n64.png'),
    (4, 'GameCube', 'GC', '/images/platforms/gc.png'),
    (5, 'Wii', null, '/images/platforms/wii.png'),
    (6, 'Wii U', null, '/images/platforms/wii_u.png'),
    (7, 'Nintendo Switch', 'Switch', '/images/platforms/switch.png'),
    (8, 'Sega Genesis', 'Genesis', '/images/platforms/genesis.png');

INSERT INTO platform_release (platform_id, region, released) VALUES
    (1, 'NA', TO_TIMESTAMP('1986-09-27', 'YYYY-MM-DD')),    -- NES NA
    (2, 'NA', TO_TIMESTAMP('1991-08-23', 'YYYY-MM-DD')),    -- SNES NA
    (3, 'NA', TO_TIMESTAMP('1996-09-29', 'YYYY-MM-DD')),    -- N64 NA
    (4, 'NA', TO_TIMESTAMP('2001-11-18', 'YYYY-MM-DD')),    -- GameCube NA
    (5, 'NA', TO_TIMESTAMP('2006-11-19', 'YYYY-MM-DD')),    -- Wii NA
    (6, 'NA', TO_TIMESTAMP('2012-11-18', 'YYYY-MM-DD')),    -- Wii U NA
    (7, 'NA', TO_TIMESTAMP('2017-03-03', 'YYYY-MM-DD')),    -- Switch NA
    (8, 'NA', TO_TIMESTAMP('1988-10-29', 'YYYY-MM-DD'));    -- Genesis NA