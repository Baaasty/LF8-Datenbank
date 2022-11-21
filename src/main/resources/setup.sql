DROP SCHEMA shop;
CREATE SCHEMA IF NOT EXISTS shop;

CREATE TABLE IF NOT EXISTS shop.location_country
(
    id   SMALLINT AUTO_INCREMENT,
    name TINYTEXT NOT NULL,

    CONSTRAINT location_country_id_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS shop.location_city
(
    id         BIGINT AUTO_INCREMENT,
    name       TINYTEXT NOT NULL,
    country_id SMALLINT NOT NULL,

    CONSTRAINT location_city_id_pk PRIMARY KEY (id),
    CONSTRAINT location_city_location_country_id_fk FOREIGN KEY (country_id) REFERENCES shop.location_country (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shop.location_postal_code
(
    postal_code VARCHAR(5) NOT NULL,
    city_id     BIGINT     NOT NULL,

    CONSTRAINT location_postal_code_pk PRIMARY KEY (postal_code),
    CONSTRAINT location_postal_code_location_city_id_fk FOREIGN KEY (city_id) REFERENCES shop.location_city (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shop.location_street
(
    id          BIGINT AUTO_INCREMENT,
    street      TINYTEXT   NOT NULL,
    postal_code VARCHAR(5) NOT NULL,

    CONSTRAINT location_street_id_pk PRIMARY KEY (id),
    CONSTRAINT location_street_location_postal_code_fk FOREIGN KEY (postal_code) REFERENCES shop.location_postal_code (postal_code) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shop.manufacturer
(
    id   BIGINT AUTO_INCREMENT,
    name TINYTEXT NOT NULL,

    CONSTRAINT manufacturer_id_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS shop.product
(
    id              BIGINT AUTO_INCREMENT,
    name            TINYTEXT NOT NULL,
    price           INT      NOT NULL,
    manufacturer_id BIGINT   NOT NULL,
    country_id      SMALLINT NOT NULL,

    CONSTRAINT product_id_pk PRIMARY KEY (id),
    CONSTRAINT product_manufacturer_id_fk FOREIGN KEY (manufacturer_id) REFERENCES shop.manufacturer (id) ON DELETE CASCADE,
    CONSTRAINT product_location_country_id_fk FOREIGN KEY (country_id) REFERENCES shop.location_country (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shop.customer
(
    id           BIGINT AUTO_INCREMENT,
    first_name   TINYTEXT  NOT NULL,
    last_name    TINYTEXT  NOT NULL,
    street_id    BIGINT    NOT NULL,
    house_number TINYTEXT  NOT NULL,
    birthdate    TIMESTAMP NOT NULL,

    CONSTRAINT customer_id_pk PRIMARY KEY (id),
    CONSTRAINT customer_location_street_id_fk FOREIGN KEY (street_id) REFERENCES shop.location_street (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shop.seller
(
    id         BIGINT AUTO_INCREMENT,
    first_name TINYTEXT NOT NULL,
    last_name  TINYTEXT NOT NULL,
    country_id SMALLINT NOT NULL,

    CONSTRAINT customer_id_pk PRIMARY KEY (id),
    CONSTRAINT seller_location_country_id_fk FOREIGN KEY (country_id) REFERENCES shop.location_country (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shop.payment
(
    id         BIGINT AUTO_INCREMENT,
    customer_id BIGINT NOT NULL,
    seller_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,

    CONSTRAINT customer_id_pk PRIMARY KEY (id),
    CONSTRAINT payment_customer_id_fk FOREIGN KEY (customer_id) REFERENCES shop.customer (id) ON DELETE CASCADE,
    CONSTRAINT payment_seller_id_fk FOREIGN KEY (seller_id) REFERENCES shop.seller (id) ON DELETE CASCADE,
    CONSTRAINT payment_product_id_fk FOREIGN KEY (product_id) REFERENCES shop.product (id) ON DELETE CASCADE
);
