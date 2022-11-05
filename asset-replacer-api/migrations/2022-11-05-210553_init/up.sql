---------------- DDL ----------------

CREATE TYPE region AS ENUM('NA', 'EU', 'JP');
COMMENT ON TYPE region IS 'Region of the world where platforms and titles are released.';

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




---------------- DML ----------------

-- NES --
INSERT INTO platform (
    name,
    short_name,
    image_path
) VALUES (
    'Nintendo Entertainment System',
    'NES',
    '/images/platforms/nes.png'
    --TO_TIMESTAMP('YYYY-MM-DD', '1986-09-27')
);

-- SNES --
INSERT INTO platform (
    name,
    short_name,
    image_path
) VALUES (
    'Super Nintendo',
    'SNES',
    '/images/platforms/snes.png'
    --TO_TIMESTAMP('YYYY-MM-DD', '1990-11-21')
);

-- N64 --
INSERT INTO platform (
    name,
    short_name,
    image_path
) VALUES (
    'Nintendo 64',
    'N64',
    '/images/platforms/n64.png'
    --TO_TIMESTAMP('YYYY-MM-DD', '1996-09-29')
);

-- GameCube --
INSERT INTO platform (
    name,
    short_name,
    image_path
) VALUES (
    'GameCube',
    'GC',
    '/images/platforms/gc.png'
    --TO_TIMESTAMP('YYYY-MM-DD', '2001-09-14')
);

-- Wii --
INSERT INTO platform (
    name,
    image_path
) VALUES (
    'Wii',
    '/images/platforms/wii.png'
    --TO_TIMESTAMP('YYYY-MM-DD', '2012-11-18')
);

-- Wii U --
INSERT INTO platform (
    name,
    image_path
) VALUES (
    'Wii U',
    '/images/platforms/wii_u.png'
    --TO_TIMESTAMP('YYYY-MM-DD', '2012-11-18')
);

-- Switch --
INSERT INTO platform (
    name,
    short_name,
    image_path
) VALUES (
    'Nintendo Switch',
    'Switch',
    '/images/platforms/switch.png'
    --TO_TIMESTAMP('YYYY-MM-DD', '2017-03-03')
);

-- Genesis --
INSERT INTO platform (
    name,
    alt_name,
    short_name,
    image_path
) VALUES (
    'Sega Genesis',
    'Genesis',
    'Mega Drive',
    '/images/platforms/genesis.png'
);