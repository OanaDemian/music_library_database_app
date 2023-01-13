-- -------------------------------------------------------------
-- TablePlus 5.1.2(472)
--
-- https://tableplus.com/
--
-- Database: music_library
-- Generation Time: 2023-01-12 20:29:15.7340
-- -------------------------------------------------------------


DROP TABLE IF EXISTS "public"."albums";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS albums_id_seq1;

-- Table Definition
CREATE TABLE "public"."albums" (
    "id" int4 NOT NULL DEFAULT nextval('albums_id_seq1'::regclass),
    "title" text,
    "release_year" int4,
    "artist_id" int4,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."artists";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS artists_id_seq1;

-- Table Definition
CREATE TABLE "public"."artists" (
    "id" int4 NOT NULL DEFAULT nextval('artists_id_seq1'::regclass),
    "name" text,
    "genre" text,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."albums" ("id", "title", "release_year", "artist_id") VALUES
(1, 'Doolittle', 1989, 1),
(2, 'Surfer Rosa', 1988, 1),
(3, 'Waterloo', 1974, 2),
(4, 'Super Trouper', 1980, 2),
(5, 'Bossanova', 1990, 1),
(6, 'Lover', 2019, 3),
(7, 'Folklore', 2020, 3),
(8, 'I Put a Spell on You', 1965, 4),
(9, 'Baltimore', 1978, 4),
(10, 'Here Comes the Sun', 1971, 4),
(11, 'Fodder on My Wings', 1982, 4),
(12, 'Ring Ring', 1973, 2);

INSERT INTO "public"."artists" ("id", "name", "genre") VALUES
(1, 'Pixies', 'Rock'),
(2, 'ABBA', 'Pop'),
(3, 'Taylor Swift', 'Pop'),
(4, 'Nina Simone', 'Pop');

