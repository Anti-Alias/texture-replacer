CREATE TABLE asset (
    id serial PRIMARY KEY,
    path varchar(128) NOT NULL,
    type asset_type NOT NULL,
    created timestamptz NOT NULL,
    updated timestamptz NOT NULL
);
COMMENT ON TABLE asset IS 'Represents a texture, audio file, etc from a video game.';
COMMENT ON COLUMN asset.path IS 'Relative path to the asset. Typically part of a URL accessible over HTTP(s).';