-- This script should be updated with every feature that changes database.

DROP SCHEMA IF EXISTS blog;
DROP SCHEMA IF EXISTS stakeholders;
DROP SCHEMA IF EXISTS tours;

CREATE SCHEMA IF NOT EXISTS blog
    AUTHORIZATION postgres;
CREATE SCHEMA IF NOT EXISTS stakeholders
    AUTHORIZATION postgres;
CREATE SCHEMA IF NOT EXISTS tours
    AUTHORIZATION postgres;

---------------------------------------------------------------------------
-- blog
---------------------------------------------------------------------------
-- Blog table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS blog."Blogs"
(
    "Id"           bigint                            NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "Title"        text COLLATE pg_catalog."default" NOT NULL,
    "Description"  text COLLATE pg_catalog."default" NOT NULL,
    "CreationDate" timestamp with time zone          NOT NULL,
    "ImageLinks"   text COLLATE pg_catalog."default" NOT NULL,
    "Status"       integer                           NOT NULL,
    CONSTRAINT "PK_Blogs" PRIMARY KEY ("Id")
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS blog."Blogs"
    OWNER to postgres;

---------------------------------------------------------------------------
-- stakeholders
---------------------------------------------------------------------------
-- ApplicationRatings table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS stakeholders."ApplicationRatings"
(
    "Id"           bigint                            NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "Rating"       integer                           NOT NULL,
    "Comment"      text COLLATE pg_catalog."default" NOT NULL,
    "UserId"       integer                           NOT NULL,
    "LastModified" timestamp with time zone          NOT NULL,
    "IsRated"      boolean                           NOT NULL,
    CONSTRAINT "PK_ApplicationRatings" PRIMARY KEY ("Id")
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS stakeholders."ApplicationRatings"
    OWNER to postgres;

--ClubInvitations table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS stakeholders."ClubInvitations"
(
    "Id"     bigint  NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "ClubId" bigint  NOT NULL,
    "UserId" bigint  NOT NULL,
    "Status" integer NOT NULL,
    CONSTRAINT "PK_ClubInvitations" PRIMARY KEY ("Id")
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS stakeholders."ClubInvitations"
    OWNER to postgres;

-- ClubJoinRequests table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS stakeholders."ClubJoinRequests"
(
    "Id"     bigint  NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "UserId" bigint  NOT NULL,
    "ClubId" bigint  NOT NULL,
    "Status" integer NOT NULL,
    CONSTRAINT "PK_ClubJoinRequests" PRIMARY KEY ("Id")
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS stakeholders."ClubJoinRequests"
    OWNER to postgres;

-- Clubs table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS stakeholders."Clubs"
(
    "Id"          bigint                            NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "Name"        text COLLATE pg_catalog."default" NOT NULL,
    "Description" text COLLATE pg_catalog."default",
    "Image"       text COLLATE pg_catalog."default",
    "UserId"      integer                           NOT NULL,
    "MemberIds"   integer[]                         NOT NULL,
    CONSTRAINT "PK_Clubs" PRIMARY KEY ("Id")
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS stakeholders."Clubs"
    OWNER to postgres;

-- Users table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS stakeholders."Users"
(
    "Id"        bigint                            NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "Username"  text COLLATE pg_catalog."default" NOT NULL,
    "Password"  text COLLATE pg_catalog."default" NOT NULL,
    "Role"      integer                           NOT NULL,
    "IsActive"  boolean                           NOT NULL,
    "Email"     text COLLATE pg_catalog."default" NOT NULL,
    "IsBlocked" boolean                           NOT NULL,
    CONSTRAINT "PK_Users" PRIMARY KEY ("Id")
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS stakeholders."Users"
    OWNER to postgres;

CREATE UNIQUE INDEX IF NOT EXISTS "IX_Users_Username"
    ON stakeholders."Users" USING btree
        ("Username" COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- People table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS stakeholders."People"
(
    "Id"           bigint                            NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "UserId"       bigint                            NOT NULL,
    "Name"         text COLLATE pg_catalog."default" NOT NULL,
    "Surname"      text COLLATE pg_catalog."default" NOT NULL,
    "Email"        text COLLATE pg_catalog."default" NOT NULL,
    "ProfileImage" text COLLATE pg_catalog."default" NOT NULL,
    "Biography"    text COLLATE pg_catalog."default" NOT NULL,
    "Quote"        text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PK_People" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_People_Users_UserId" FOREIGN KEY ("UserId")
        REFERENCES stakeholders."Users" ("Id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS stakeholders."People"
    OWNER to postgres;

CREATE UNIQUE INDEX IF NOT EXISTS "IX_People_UserId"
    ON stakeholders."People" USING btree
        ("UserId" ASC NULLS LAST)
    TABLESPACE pg_default;

---------------------------------------------------------------------------
-- tours
---------------------------------------------------------------------------
-- Equipement table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS tours."Equipment"
(
    "Id"          bigint                            NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "Name"        text COLLATE pg_catalog."default" NOT NULL,
    "Description" text COLLATE pg_catalog."default",
    CONSTRAINT "PK_Equipment" PRIMARY KEY ("Id")
)
    TABLESPACE pg_default;
ALTER TABLE IF EXISTS tours."Equipment"
    OWNER to postgres;

-- Keypoints table: UPDATE IF ALTERED
-- Table: tours.Keypoints

-- DROP TABLE IF EXISTS tours."Keypoints";

CREATE TABLE IF NOT EXISTS tours."Keypoints"
(
    "Id"          bigint                            NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "TourId"      bigint                            NOT NULL,
    "Name"        text COLLATE pg_catalog."default" NOT NULL,
    "Latitude"    double precision                  NOT NULL,
    "Longitude"   double precision                  NOT NULL,
    "Description" text COLLATE pg_catalog."default",
    "Position"    integer,
    "Image"       text COLLATE pg_catalog."default",
    CONSTRAINT "PK_Keypoints" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Keypoints_Tours_TourId" FOREIGN KEY ("TourId")
        REFERENCES tours."Tours" ("Id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS tours."Keypoints"
    OWNER to postgres;
-- Index: IX_Keypoints_TourId

-- DROP INDEX IF EXISTS tours."IX_Keypoints_TourId";

CREATE INDEX IF NOT EXISTS "IX_Keypoints_TourId"
    ON tours."Keypoints" USING btree
        ("TourId" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Objects table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS tours."Objects"
(
    "Id"          bigint                            NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "Name"        text COLLATE pg_catalog."default" NOT NULL,
    "Description" text COLLATE pg_catalog."default" NOT NULL,
    "Image"       text COLLATE pg_catalog."default",
    "Latitude"    double precision                  NOT NULL,
    "Longitude"   double precision                  NOT NULL,
    "Category"    integer                           NOT NULL,
    "Status"      integer                           NOT NULL,
    CONSTRAINT "PK_Objects" PRIMARY KEY ("Id")
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS tours."Objects"
    OWNER to postgres;

-- TourIssue table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS tours."TourIssue"
(
    "Id"          bigint                            NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "Category"    text COLLATE pg_catalog."default" NOT NULL,
    "Priority"    bigint                            NOT NULL,
    "Description" text COLLATE pg_catalog."default" NOT NULL,
    "DateTime"    timestamp with time zone          NOT NULL,
    CONSTRAINT "PK_TourIssue" PRIMARY KEY ("Id")
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS tours."TourIssue"
    OWNER to postgres;

-- TourPreference table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS tours."TourPreference"
(
    "Id"            bigint                              NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "UserId"        bigint                              NOT NULL,
    "Difficulty"    integer,
    "TransportType" integer,
    "Tags"          text[] COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PK_TourPreference" PRIMARY KEY ("Id")
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS tours."TourPreference"
    OWNER to postgres;

-- TourReviews table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS tours."TourReviews"
(
    "Id"         bigint                              NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "Rating"     integer                             NOT NULL,
    "Comment"    text COLLATE pg_catalog."default"   NOT NULL,
    "VisitDate"  timestamp with time zone            NOT NULL,
    "RatingDate" timestamp with time zone            NOT NULL,
    "ImageLinks" text[] COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PK_TourReviews" PRIMARY KEY ("Id")
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS tours."TourReviews"
    OWNER to postgres;

-- TouristEquipment table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS tours."TouristEquipment"
(
    "Id"          bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "TouristId"   bigint NOT NULL,
    "EquipmentId" bigint NOT NULL,
    CONSTRAINT "PK_TouristEquipment" PRIMARY KEY ("Id")
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS tours."TouristEquipment"
    OWNER to postgres;

-- Tours table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS tours."Tours"
(
    "Id"            bigint                              NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "UserId"        integer                             NOT NULL,
    "Name"          text COLLATE pg_catalog."default"   NOT NULL,
    "Description"   text COLLATE pg_catalog."default"   NOT NULL,
    "Price"         double precision                    NOT NULL,
    "Difficulty"    integer,
    "TransportType" integer,
    "Status"        integer,
    "Tags"          text[] COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PK_Tours" PRIMARY KEY ("Id")
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS tours."Tours"
    OWNER to postgres;

-- TouristPositions table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS tours."TouristPositions"
(
    "Id"        bigint                   NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "UserId"    bigint                   NOT NULL,
    "Latitude"  double precision         NOT NULL,
    "Longitude" double precision         NOT NULL,
    "UpdatedAt" timestamp with time zone NOT NULL,
    CONSTRAINT "PK_TouristPositions" PRIMARY KEY ("Id")
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS tours."TouristPositions"
    OWNER to postgres;

-- TourProgresses table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS tours."TourProgresses"
(
    "Id"                bigint                   NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "TouristPositionId" bigint                   NOT NULL,
    "TourId"            bigint                   NOT NULL,
    "Status"            integer                  NOT NULL,
    "StartTime"         timestamp with time zone NOT NULL,
    "LastActivity"      timestamp with time zone NOT NULL,
    "CurrentKeyPoint"   integer                  NOT NULL,
    CONSTRAINT "PK_TourProgresses" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_TourProgresses_TouristPositions_TouristPositionId" FOREIGN KEY ("TouristPositionId")
        REFERENCES tours."TouristPositions" ("Id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT "FK_TourProgresses_Tours_TourId" FOREIGN KEY ("TourId")
        REFERENCES tours."Tours" ("Id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS tours."TourProgresses"
    OWNER to postgres;

CREATE INDEX IF NOT EXISTS "IX_TourProgresses_TourId"
    ON tours."TourProgresses" USING btree
        ("TourId" ASC NULLS LAST)
    TABLESPACE pg_default;

CREATE INDEX IF NOT EXISTS "IX_TourProgresses_TouristPositionId"
    ON tours."TourProgresses" USING btree
        ("TouristPositionId" ASC NULLS LAST)
    TABLESPACE pg_default;

---------------------------------------------------------------------------
-- encounters
---------------------------------------------------------------------------
-- Encounters table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS encounters."Encounters"
(
    "Id" bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "UserId" integer NOT NULL,
    "Name" text COLLATE pg_catalog."default" NOT NULL,
    "Description" text COLLATE pg_catalog."default" NOT NULL,
    "Latitude" double precision NOT NULL,
    "Longitude" double precision NOT NULL,
    "Xp" integer NOT NULL,
    "Status" integer NOT NULL,
    "Type" integer NOT NULL,
    CONSTRAINT "PK_Encounters" PRIMARY KEY ("Id")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS encounters."Encounters"
    OWNER to postgres;

-- EncounterCompletions table: UPDATE IF ALTERED
CREATE TABLE IF NOT EXISTS encounters."EncounterCompletions"
(
    "Id" bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "UserId" bigint NOT NULL,
    "CompletionTime" timestamp with time zone NOT NULL,
    "EncounterId" bigint NOT NULL,
    "Xp" integer NOT NULL,
    "Status" integer NOT NULL,
    CONSTRAINT "PK_EncounterCompletions" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_EncounterCompletions_Encounters_EncounterId" FOREIGN KEY ("EncounterId")
        REFERENCES encounters."Encounters" ("Id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS encounters."EncounterCompletions"
    OWNER to postgres;

CREATE INDEX IF NOT EXISTS "IX_EncounterCompletions_EncounterId"
    ON encounters."EncounterCompletions" USING btree
    ("EncounterId" ASC NULLS LAST)
    TABLESPACE pg_default;