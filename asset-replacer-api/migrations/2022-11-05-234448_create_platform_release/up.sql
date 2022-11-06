CREATE TABLE platform_release(
    platform_id integer NOT NULL REFERENCES platform(id),
    region region NOT NULL,
    released timestamptz NOT NULL,
    PRIMARY KEY (platform_id, region)
);