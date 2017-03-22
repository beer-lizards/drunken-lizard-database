--
-- Creates the tables for storing beer.


/**
 * Stores the beers that have been fetched from the api.
 *
 * TODO: Need the store?
 *
 * beer_id: The generated id for a beer.
 * description: The cleaned up beer description.
 * name: The cleaned up beer name.
 * tour_beer_number: The winking lizard tour beer number.
 * tour_data: The raw tour data.
 * tour_description: The raw description provided by the winking lizard tour.
 * tour_item_id: The identifier that the winking lizard tour uses to identify
 *   a beer.
 * tour_name: The raw description provided by the winking lizard tour.
 * tour_year: The winking lizard tour year this beer was on.
 * created_dtm: The day this record was created in UTC.
 * last_modified_dtm: The day this record was last modified in UTC.
 * last_accessed_dtm: The day that this record was last accessed in UTC.
 */
CREATE TABLE drunken_lizard.beer (
  beer_id BIGINT NOT NULL,
  description TEXT NOT NULL,
  name TEXT NOT NULL,
  tour_beer_number BIGINT NOT NULL,
  tour_data JSONB NOT NULL,
  tour_description TEXT NOT NULL,
  tour_item_id BIGINT NOT NULL,
  tour_name TEXT NOT NULL,
  tour_year INT NOT NULL,
  created_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  last_modified_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  last_accessed_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

ALTER TABLE drunken_lizard.beer
  ADD CONSTRAINT pkey_beer_id
  PRIMARY KEY (beer_id);

CREATE SEQUENCE drunken_lizard.seq_beer_id
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE drunken_lizard.seq_beer_id
  OWNED BY drunken_lizard.beer.beer_id;

ALTER TABLE drunken_lizard.beer
  ALTER COLUMN beer_id
  SET DEFAULT nextval('drunken_lizard.seq_beer_id'::regclass);

-- Each beer only appears once per year.
CREATE UNIQUE INDEX udx_beer_tour_item_id_tour_year
  ON drunken_lizard.beer USING btree (tour_item_id, tour_year);

/**
 * Stores the beers that a user has consumed.
 *
 * consumed_beer_id: The generated id for a beer.
 * beer_id: The beer that the user had.
 * user_account_id: The user account that had this beer.
 * tour_added_dtm: The date this beer was added on the tour.
 * created_dtm: The day this record was created in UTC.
 * last_accessed_dtm: The day that this record was last accessed in UTC.
 */
CREATE TABLE drunken_lizard.consumed_beer (
  consumed_beer_id BIGINT NOT NULL,
  beer_id BIGINT NOT NULL,
  user_account_id BIGINT NOT NULL,
  tour_added_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  created_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  last_accessed_dtm TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

ALTER TABLE drunken_lizard.consumed_beer
  ADD CONSTRAINT pkey_consumed_beer_id
  PRIMARY KEY (consumed_beer_id);

CREATE SEQUENCE drunken_lizard.seq_consumed_beer_id
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

ALTER SEQUENCE drunken_lizard.seq_consumed_beer_id
  OWNED BY drunken_lizard.consumed_beer.consumed_beer_id;

ALTER TABLE drunken_lizard.consumed_beer
  ALTER COLUMN consumed_beer_id
  SET DEFAULT nextval('drunken_lizard.seq_consumed_beer_id'::regclass);

-- Each beer should only be consumed once.
CREATE UNIQUE INDEX udx_consumed_beer_beer_id_user_account_id
  ON drunken_lizard.consumed_beer USING btree (beer_id, user_account_id);

-- Foreign Keys

ALTER TABLE drunken_lizard.consumed_beer
  ADD CONSTRAINT fkey_consumed_beer_beer_id
  FOREIGN KEY (beer_id)
  REFERENCES drunken_lizard.beer (beer_id);

ALTER TABLE drunken_lizard.consumed_beer
  ADD CONSTRAINT fkey_consumed_beer_user_account_id
  FOREIGN KEY (user_account_id)
  REFERENCES drunken_lizard.user_account (user_account_id);
