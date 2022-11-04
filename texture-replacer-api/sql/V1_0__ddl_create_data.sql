-------- RAW DATA --------
CREATE TABLE platform (
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL UNIQUE,
    image_path VARCHAR,
    released timestamptz NOT NULL
);
COMMENT ON TABLE platform IS 'Computer hardware + software that games are designed to run on (PC, macOS NES, PSX, etc)';
COMMENT ON COLUMN platform.released IS 'Date that the platform was released';
COMMENT ON COLUMN platform.image_path IS 'Relative path to the platform''s image. Typically part of a URL accessible over HTTP(s).';
CREATE INDEX ON platform(name);
CREATE INDEX ON platform(released);


CREATE TABLE title (
    id serial PRIMARY KEY,
    platform_id integer NOT NULL REFERENCES platform(id),
    name varchar(128) NOT NULL,
    image_path varchar,
    released timestamptz NOT NULL
);
COMMENT ON TABLE title IS 'Game / software released for a single or multiple platforms.';
CREATE INDEX ON title(name);


CREATE TABLE title_platform (
    title_id integer NOT NULL REFERENCES title(id),
    platform_id integer NOT NULL REFERENCES platform(id),
    UNIQUE (title_id, platform_id)
);
COMMENT ON TABLE title_platform IS 'Determines which titles belong to which platforms';
CREATE INDEX ON title_platform(title_id);
CREATE INDEX ON title_platform(platform_id);


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



-------- USER DATA --------
CREATE TABLE "user" (
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL UNIQUE,
    email varchar(128) NOT NULL UNIQUE,
    password_hash varchar NOT NULL,
    salt bytea NOT NULL
);
COMMENT ON TABLE "user" IS 'User that is capable of creating asset packs and assigning assets to them.';