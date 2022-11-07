---------------- Tables / Types ----------------
CREATE TYPE asset_type AS ENUM (
    'TEXTURE',
    'AUDIO_FILE'
);

CREATE TYPE role AS ENUM (
    'BASIC',
    'ADMIN'
);

CREATE TABLE platform (
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL UNIQUE,
    image_path varchar
);

CREATE TABLE title (
    id serial PRIMARY KEY,
    platform_id integer NOT NULL REFERENCES platform(id),
    name varchar(128) NOT NULL,
    version varchar(128) NOT NULL,
    released timestamptz,
    image_path varchar
);

CREATE TABLE asset (
    id serial PRIMARY KEY,
    path varchar(128) NOT NULL,
    type asset_type NOT NULL
);

CREATE TABLE "user" (
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL UNIQUE,
    email varchar(128) NOT NULL UNIQUE,
    role role NOT NULL DEFAULT 'BASIC',
    password_hash varchar NOT NULL,
    salt bytea NOT NULL
);


---------------- Indexes ----------------
CREATE INDEX ON platform(name);
CREATE INDEX ON title(platform_id);
CREATE INDEX ON title(name);
CREATE INDEX ON title(released);
CREATE INDEX ON asset(path);
CREATE INDEX ON asset(type);
CREATE INDEX ON "user"(name);
CREATE INDEX ON "user"(email);


---------------- Comments ----------------
COMMENT ON TYPE     asset_type              IS 'Type an asset is. Images, sounds, etc.';
COMMENT ON TYPE     role                    IS 'Determines what privileges a user has.';
COMMENT ON TABLE    platform                IS 'Computer hardware + software that games are designed to run on (PC, macOS NES, PSX, etc)';
COMMENT ON COLUMN   platform.name           IS 'Full name of the platform. (Nintendo Entertainment System, PlayStation, etc)';
COMMENT ON COLUMN   platform.image_path     IS 'Relative path to the platform''s image. Typically part of a URL accessible over HTTP(s).';
COMMENT ON TABLE    title                   IS 'Game / software released for a particular platform.';
COMMENT ON COLUMN   title.name              IS 'Name of the title.';
COMMENT ON COLUMN   title.version           IS 'Version of the title. This is often, but not limited to, the region it was released in. Some examples are NA, EU, JP, NTSC, NTSC-J, PAL, 1.0, 1.1, etc';
COMMENT ON COLUMN   title.released          IS 'Date at which the title was released. Optional in cases of ambiguities, IE the NA release of Super Mario Bros.';
COMMENT ON COLUMN   title.released          IS 'Relative path to the boxart of this title. Optional.';
COMMENT ON TABLE    asset                   IS 'Represents a texture, audio file, etc from a video game.';
COMMENT ON COLUMN   asset.path              IS 'Relative path to the asset. Typically part of a URL accessible over HTTP(s).';
COMMENT ON COLUMN   asset.type              IS 'Type of asset this is.';
COMMENT ON TABLE    "user"                  IS 'User that is capable of creating asset packs and assigning assets to them.';


---------------- Data ----------------
INSERT INTO platform (id, name, image_path) VALUES
    (1, 'Nintendo Entertainment System', '/images/platforms/nes.png'),
    (2, 'Super Nintendo', '/images/platforms/snes.png'),
    (3, 'Nintendo 64', '/images/platforms/n64.png'),
    (4, 'GameCube', '/images/platforms/gc.png'),
    (5, 'Wii', '/images/platforms/wii.png'),
    (6, 'Wii U', '/images/platforms/wii_u.png'),
    (7, 'Nintendo Switch', '/images/platforms/switch.png'),
    (8, 'Sega Genesis', '/images/platforms/genesis.png');

INSERT INTO title (id, platform_id, name, version, released, image_path) VALUES
    (1, 1,  'Super Mario Bros.',    'USA',  null,                                   '/images/titles/smb.png'),
    (2, 1,  'Super Mario Bros.',    'JP',   TO_DATE('1985-09-13', 'YYYY-MM-DD'),    '/images/titles/smb.png'),
    (3, 3,  'Super Mario 64.',      'USA',  TO_DATE('1996-06-23', 'YYYY-MM-DD'),    '/images/titles/sm64.png'),
    (4, 3,  'Super Mario 64.',      'EU',  TO_DATE('1996-06-23', 'YYYY-MM-DD'),     '/images/titles/sm64.png');
