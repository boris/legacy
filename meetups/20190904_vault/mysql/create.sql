CREATE DATABASE IF NOT EXISTS meetup;

CREATE TABLE IF NOT EXISTS meetup.participantes (
    id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    PRIMARY KEY (id)
);

INSERT INTO meetup.participantes (name, email) VALUES ('Batman', 'bruce@wayne.com');
INSERT INTO meetup.participantes (name, email) VALUES ('Superman', 'clark@daily-planet.com');
INSERT INTO meetup.participantes (name, email) VALUES ('Spiderman', 'peter@daily-bugle.com');
INSERT INTO meetup.participantes (name, email) VALUES ('Ironman', 'tony@stark.com');
