--
-- Creates the original schema for the drunken lizard database.

CREATE SCHEMA drunken_lizard;

/**
 * The user account table stores the credentials for a given user.
 *
 * user_account_id: The generated id for a user.
 * username: The user name which a user may login as.
 * email: The users email address.
 * password: The hash password for the user.
 * algorithm: The algorithm used to hash the password.
 * salt: The salt used to hash the password.
 * disabled: If the account has been manually disabled.
 * created_dtm: The day this record was created in UTC.
 * last_modified_dtm: The day this record was last modified in UTC.
 * last_accessed_dtm: The day that this record was last accessed in UTC.
 */
CREATE TABLE drunken_lizard.user_account (
  user_account_id BIGINT NOT NULL,
  username CHARACTER VARYING(1024) NOT NULL,
  email CHARACTER VARYING(1024) NOT NULL,
  password CHARACTER VARYING(1024) NOT NULL,
  algorithm CHARACTER VARYING(50) NOT NULL,
  salt CHARACTER VARYING(1024) NOT NULL,
  disabled BOOLEAN NOT NULL,
  created_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  last_modified_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  last_accessed_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

ALTER TABLE drunken_lizard.user_account
  ADD CONSTRAINT pkey_user_account
  PRIMARY KEY (user_account_id);

CREATE SEQUENCE drunken_lizard.seq_user_account_id
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE drunken_lizard.seq_user_account_id
  OWNED BY drunken_lizard.user_account.user_account_id;

ALTER TABLE drunken_lizard.user_account
  ALTER COLUMN user_account_id
  SET DEFAULT nextval('drunken_lizard.seq_user_account_id'::regclass);

/**
 * The user account details table stores additional information that may be
 * used to describe a user though it not required for authentication.
 *
 * user_account_details_id: The generated id for a user details record.
 * user_account_id: The user these details belongs to.
 * full_name: The raw name that a user may enter.
 * first_name: The users first name.
 * last_name: The users last name.
 * created_dtm: The day this record was created in UTC.
 * last_modified_dtm: The day this record was last modified in UTC.
 * last_accessed_dtm: The day that this record was last accessed in UTC.
 */
CREATE TABLE drunken_lizard.user_account_details (
  user_account_details_id BIGINT NOT NULL,
  user_account_id BIGINT NOT NULL,
  full_name CHARACTER VARYING(2048) NOT NULL,
  first_name CHARACTER VARYING(1024) NOT NULL,
  last_name CHARACTER VARYING(1024) NOT NULL,
  created_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  last_modified_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  last_accessed_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

ALTER TABLE drunken_lizard.user_account_details
  ADD CONSTRAINT pkey_user_account_details
  PRIMARY KEY (user_account_details_id);

-- Each user has one detail record.
CREATE UNIQUE INDEX udx_user_account_id
  ON drunken_lizard.user_account_details USING btree (user_account_id);

CREATE SEQUENCE drunken_lizard.seq_user_account_details_id
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE drunken_lizard.seq_user_account_details_id
  OWNED BY drunken_lizard.user_account_details.user_account_details_id;

ALTER TABLE drunken_lizard.user_account_details
  ALTER COLUMN user_account_details_id
  SET DEFAULT nextval('drunken_lizard.seq_user_account_details_id'::regclass);

/**
 * The user account scope table contains the different access scopes that a
 * user is currently assigned to.
 *
 * user_account_scope_id: The generated id for the user account scope record.
 * user_account_id: The user account the scope applies to.
 * user_account_scope_type_id: The user account scope type.
 * created_dtm: The day this record was created in UTC.
 * last_accessed_dtm: The day that this record was last accessed in UTC.
 */
CREATE TABLE drunken_lizard.user_account_scope (
  user_account_scope_id BIGINT NOT NULL,
  user_account_id BIGINT NOT NULL,
  user_account_scope_type_id INT NOT NULL,
  created_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  last_accessed_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

ALTER TABLE drunken_lizard.user_account_scope
  ADD CONSTRAINT pkey_user_account_scope
  PRIMARY KEY (user_account_scope_id);

-- Each user has unique scopes.
CREATE UNIQUE INDEX udx_user_account_id_user_account_scope_type_id_scope_signature
  ON drunken_lizard.user_account_scope USING btree (
    user_account_id,
    user_account_scope_type_id
  );

CREATE SEQUENCE drunken_lizard.seq_user_account_scope_id
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE drunken_lizard.seq_user_account_scope_id
  OWNED BY drunken_lizard.user_account_scope.user_account_scope_id;

ALTER TABLE drunken_lizard.user_account_scope
  ALTER COLUMN user_account_scope_id
  SET DEFAULT nextval('drunken_lizard.seq_user_account_scope_id'::regclass);

/**
 * The user account scope type table stores the current system scopes and their
 * display names.
 *
 * user_account_scope_type_id:
 * name: The display name for a scope.
 * short_name: The two character short scope code.
 */
CREATE TABLE drunken_lizard.user_account_scope_type (
  user_account_scope_type_id INT NOT NULL,
  name CHARACTER VARYING (255) NOT NULL,
  short_name CHARACTER(2) NOT NULL
);

ALTER TABLE drunken_lizard.user_account_scope_type
  ADD CONSTRAINT pkey_user_account_scope_type
  PRIMARY KEY (user_account_scope_type_id);

CREATE SEQUENCE drunken_lizard.seq_user_account_scope_type_id
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE drunken_lizard.seq_user_account_scope_type_id
    OWNED BY drunken_lizard.user_account_scope_type.user_account_scope_type_id;

ALTER TABLE drunken_lizard.user_account_scope_type
  ALTER COLUMN user_account_scope_type_id
  SET DEFAULT nextval('drunken_lizard.seq_user_account_scope_type_id'::regclass);

-- Initial scopes
INSERT INTO drunken_lizard.user_account_scope_type (name, short_name)
  VALUES ('APP_ADMIN', 'AA');
INSERT INTO drunken_lizard.user_account_scope_type (name, short_name)
  VALUES ('APP_LOGIN', 'AL');

-- Foreign Keys

ALTER TABLE drunken_lizard.user_account_details
  ADD CONSTRAINT fkey_user_account_details_user_account_id
  FOREIGN KEY (user_account_id)
  REFERENCES drunken_lizard.user_account (user_account_id);

ALTER TABLE drunken_lizard.user_account_scope
  ADD CONSTRAINT fkey_user_account_scope_user_account_id
  FOREIGN KEY (user_account_id)
  REFERENCES drunken_lizard.user_account (user_account_id);

ALTER TABLE drunken_lizard.user_account_scope
  ADD CONSTRAINT fkey_user_account_scope_scope_type_id
  FOREIGN KEY (user_account_scope_type_id)
  REFERENCES drunken_lizard.user_account_scope_type (user_account_scope_type_id);
