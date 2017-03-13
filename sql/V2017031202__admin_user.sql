--
-- Creates the admin user account.

-- Default user account
INSERT INTO drunken_lizard.user_account (
  username,
  email,
  password,
  algorithm,
  salt,
  disabled,
  created_dtm,
  last_modified_dtm,
  last_accessed_dtm
) VALUES (
  '${admin_user}',
  '${admin_email}',
  '${admin_password_hash}',
  '${admin_password_algorithm}',
  '${admin_password_salt}',
  false,
  now() at time zone 'utc',
  now() at time zone 'utc',
  now() at time zone 'utc'
);

-- Scopes
INSERT INTO drunken_lizard.user_account_scope (
  user_account_id,
  user_account_scope_type_id,
  created_dtm,
  last_accessed_dtm
) VALUES (
  1,
  1,
  now() at time zone 'utc',
  now() at time zone 'utc'
);
