-- NES --
INSERT INTO platform (
    id,
    name,
    short_name,
    image_path
) VALUES (
    1,
    'Nintendo Entertainment System',
    'NES',
    '/images/platforms/nes.png'
    --TO_TIMESTAMP('YYYY-MM-DD', '1986-09-27')
);

-- SNES --
INSERT INTO platform (
    id,
    name,
    short_name,
    image_path
) VALUES (
    2,
    'Super Nintendo',
    'SNES',
    '/images/platforms/snes.png'
    --TO_TIMESTAMP('YYYY-MM-DD', '1990-11-21')
);

-- N64 --
INSERT INTO platform (
    id,
    name,
    short_name,
    image_path
) VALUES (
    3,
    'Nintendo 64',
    'N64',
    '/images/platforms/n64.png'
    --TO_TIMESTAMP('YYYY-MM-DD', '1996-09-29')
);

-- GameCube --
INSERT INTO platform (
    id,
    name,
    short_name,
    image_path
) VALUES (
    5,
    'GameCube',
    'GC',
    '/images/platforms/gc.png'
    --TO_TIMESTAMP('YYYY-MM-DD', '2001-09-14')
);

-- Wii --
INSERT INTO platform (
    id,
    name,
    image_path
) VALUES (
    6,
    'Wii',
    '/images/platforms/wii.png'
    --TO_TIMESTAMP('YYYY-MM-DD', '2012-11-18')
);

-- Wii U --
INSERT INTO platform (
    id,
    name,
    image_path
) VALUES (
    7,
    'Wii U',
    '/images/platforms/wii_u.png'
    --TO_TIMESTAMP('YYYY-MM-DD', '2012-11-18')
);

-- Switch --
INSERT INTO platform (
    id,
    name,
    short_name,
    image_path
) VALUES (
    8,
    'Nintendo Switch',
    'Switch',
    '/images/platforms/switch.png'
    --TO_TIMESTAMP('YYYY-MM-DD', '2017-03-03')
);

-- Genesis --
INSERT INTO platform (
    id,
    name,
    alt_name,
    short_name,
    image_path
) VALUES (
    9,
    'Sega Genesis',
    'Genesis',
    'Mega Drive',
    '/images/platforms/genesis.png'
);