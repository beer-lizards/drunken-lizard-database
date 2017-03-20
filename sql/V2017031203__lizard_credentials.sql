--
-- Creates the tables for storing winking lizard credentials

/**
 * The winking lizard table stores the credentials for authenticating with the
 * winking lizard web apis.
 *
 * winking_lizard_id:
 * user_account_id:
 * tour_year: The winking lizard tour year.
 * credentials: A json object containing the winking lizard credentials.
 * password_rotation: Auto rotate the winking lizard credentials.
 * created_dtm: The day this record was created in UTC.
 * last_modified_dtm: The day this record was last modified in UTC.
 * last_accessed_dtm: The day that this record was last accessed in UTC.
 */
CREATE TABLE drunken_lizard.winking_lizard (
  winking_lizard_id BIGINT NOT NULL,
  user_account_id BIGINT NOT NULL,
  tour_year INT NOT NULL,
  credentials JSONB NOT NULL,
  password_rotation BOOLEAN NOT NULL,
  created_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  last_modified_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  last_accessed_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

ALTER TABLE drunken_lizard.winking_lizard
  ADD CONSTRAINT pkey_winking_lizard
  PRIMARY KEY (winking_lizard_id);

CREATE SEQUENCE drunken_lizard.seq_winking_lizard_id
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE drunken_lizard.seq_winking_lizard_id
  OWNED BY drunken_lizard.winking_lizard.winking_lizard_id;

ALTER TABLE drunken_lizard.winking_lizard
  ALTER COLUMN winking_lizard_id
  SET DEFAULT nextval('drunken_lizard.seq_winking_lizard_id'::regclass);

-- Foreign Keys

ALTER TABLE drunken_lizard.winking_lizard
  ADD CONSTRAINT fkey_winking_lizard_user_account_id
  FOREIGN KEY (user_account_id)
  REFERENCES drunken_lizard.user_account (user_account_id);
