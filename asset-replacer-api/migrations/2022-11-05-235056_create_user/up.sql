CREATE TABLE "user" (
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL UNIQUE,
    email varchar(128) NOT NULL UNIQUE,
    password_hash varchar NOT NULL,
    salt bytea NOT NULL
);
COMMENT ON TABLE "user" IS 'User that is capable of creating asset packs and assigning assets to them.';