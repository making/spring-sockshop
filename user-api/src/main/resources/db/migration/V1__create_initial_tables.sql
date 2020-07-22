CREATE TABLE IF NOT EXISTS customer
(
    customer_id VARCHAR(40)  NOT NULL,
    first_name  VARCHAR(64)  NOT NULL,
    last_name   VARCHAR(64)  NOT NULL,
    username    VARCHAR(64)  NOT NULL UNIQUE,
    email       VARCHAR(128) NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,
    PRIMARY KEY (customer_id)
);

CREATE TABLE IF NOT EXISTS customer_address
(
    address_id  VARCHAR(40) NOT NULL,
    customer_id VARCHAR(40) NOT NULL,
    number      VARCHAR(64) NOT NULL,
    street      VARCHAR(64) NOT NULL,
    city        VARCHAR(64) NOT NULL,
    postcode    VARCHAR(32) NOT NULL,
    country     VARCHAR(32) NOT NULL,
    created_at  TIMESTAMP   NOT NULL DEFAULT now(),
    PRIMARY KEY (address_id),
    INDEX (created_at),
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS customer_card
(
    card_id     VARCHAR(40) NOT NULL,
    customer_id VARCHAR(40) NOT NULL,
    long_num    VARCHAR(64) NOT NULL,
    expires     DATE        NOT NULL,
    ccv         VARCHAR(4)  NOT NULL,
    created_at  TIMESTAMP   NOT NULL DEFAULT now(),
    PRIMARY KEY (card_id),
    INDEX (created_at),
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE
);