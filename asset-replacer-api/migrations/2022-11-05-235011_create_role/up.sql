CREATE TYPE role AS ENUM ('basic', 'admin');
COMMENT ON TYPE role IS 'Determines what privileges a user has.';