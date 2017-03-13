#### Style Guidelines

We don't currently follow many SQL style guidelines, here are the few that we
do:

* Always specify the schema
* Reserved words should be uppercase.
* Flyway migrations follow this convention YYYYMMDDXX where XX is 01 based
* pkey_: Primary Keys
* fkey_: Foreign Keys
* idx_: Secondary Indexes
* udx_: Unique Indexes
* seq_: Sequences

#### Changelog

The changelog should be updated when doing a release and should contain the following:

* The version the release will be.
* Description of the release.
* List of notable pull requests.

Example:

```
#### Version

What this is?

* This PR is important PR#1
```

#### A great pull request contains

* Minimal changes.
* Only submit code relevant to the current issue. Other changes should go in new pull requests.
* Minimal commits.
* No conflicts. Please rebase off the latest master before submitting.
* Code conforming to the existing conventions and formats. i.e. Please don't reformat whitespace.
* Passing tests in `mvn clean install` / build. Use existing tests as a reference.
* Relevant documentation.
