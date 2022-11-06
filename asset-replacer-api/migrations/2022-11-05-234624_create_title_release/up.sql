CREATE TABLE title_release (
    title_id integer NOT NULL REFERENCES title(id),
    platform_id integer NOT NULL REFERENCES platform(id),
    released timestamptz NOT NULL,
    PRIMARY KEY (title_id, platform_id)
);
COMMENT ON TABLE title_release IS 'The release of a title for a specific platform.';
CREATE INDEX ON title_release(title_id);
CREATE INDEX ON title_release(platform_id);