CREATE TABLE title (
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL,
    image_path varchar
);
COMMENT ON TABLE title IS 'Game / software released for at least one platform.';
CREATE INDEX ON title(name);