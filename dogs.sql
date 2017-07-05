CREATE TABLE dogs (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  owner_id INTEGER,

  FOREIGN KEY(owner_id) REFERENCES human(id)
);

CREATE TABLE humans (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL,
  house_id INTEGER,

  FOREIGN KEY(house_id) REFERENCES human(id)
);

CREATE TABLE houses (
  id INTEGER PRIMARY KEY,
  address VARCHAR(255) NOT NULL
);

INSERT INTO
  houses (id, address)
VALUES
  (1, "18th and Cecil B Moore"), (2, "15th and Girard");

INSERT INTO
  humans (id, fname, lname, house_id)
VALUES
  (1, "Martin", "Chung", 1),
  (2, "Calvin", "Chung", 1),
  (3, "Hanna", "Ryoo", 2),
  (4, "Zenas", "Pak", NULL);

INSERT INTO
  dogs (id, name, owner_id)
VALUES
  (1, "Jaxon", 1),
  (2, "Zora", 2),
  (3, "Charlie", 3),
  (4, "Happy", 3),
  (5, "Max", NULL);
