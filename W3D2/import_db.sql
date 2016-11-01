DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR NOT NULL,
  lname VARCHAR NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author INTEGER NOT NULL,

  FOREIGN KEY (author) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question INTEGER NOT NULL,
  user INTEGER NOT NULL,

  FOREIGN KEY (question) REFERENCES questions(id)
  FOREIGN KEY (user) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question INTEGER NOT NULL,
  parent INTEGER,
  user INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (question) REFERENCES questions(id)
  FOREIGN KEY (parent) REFERENCES replies(id)
  FOREIGN KEY (user) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question INTEGER NOT NULL,
  user INTEGER NOT NULL,


  FOREIGN KEY (user) REFERENCES users(id)
  FOREIGN KEY (question) REFERENCES questions(id)
);

INSERT INTO users (fname, lname) VALUES
  ('Max', 'Hempfling'),
  ('Eitan', 'Akman'),
  ('Christian', 'Cho');

INSERT INTO questions (title, body, author) VALUES
  ("How do I do X", "I need X done and idk how", (SELECT id FROM users WHERE fname='Max')),
  ("How do I do Y", "I need Y done and idk how", (SELECT id FROM users WHERE fname='Max')),
  ("How do I do Z", "I need Z done and idk how", (SELECT id FROM users WHERE fname='Eitan')),
  ("How do I do A", "I need A done and idk how", (SELECT id FROM users WHERE fname='Christian'));

INSERT INTO question_follows (question, user) VALUES
  (1, (SELECT id FROM users WHERE fname='Max')),
  (2, (SELECT id FROM users WHERE fname='Max')),
  (3, (SELECT id FROM users WHERE fname='Max')),
  (3, (SELECT id FROM users WHERE fname='Christian'));

INSERT INTO replies (question, parent, user, body) VALUES
  (1, NULL, (SELECT id FROM users WHERE fname='Christian'), 'This is a reply'),
  (1, 1, (SELECT id FROM users WHERE fname='Max'), 'This is a reply');

INSERT INTO question_likes (question, user) VALUES
  (1, (SELECT id FROM users WHERE fname='Max'));
