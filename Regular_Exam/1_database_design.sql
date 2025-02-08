CREATE TABLE IF NOT EXISTS brands (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS classifications (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS customers (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    first_name VARCHAR(30) NOT NULL ,
    last_name VARCHAR(30) NOT NULL,
    address VARCHAR(150) NOT NULL,
    phone VARCHAR(30) UNIQUE NOT NULL,
    loyalty_card BOOLEAN DEFAULT FALSE NOT NULL
);

CREATE TABLE IF NOT EXISTS items (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL,
    quantity INT NOT NULL , --CHECK >= 0
    price DECIMAL(12, 2) NOT NULL, --CHECK > 0.00
    description TEXT,
    brand_id INT NOT NULL, -- CONSTR FK
    classification_id INT NOT NULL --FK

    CHECK ( quantity >= 0 ),
    CHECK ( price > 0.00 ),

    CONSTRAINT fk_items_brands
        FOREIGN KEY (brand_id) REFERENCES brands(id)
            ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT fk_items_classifications
        FOREIGN KEY (classification_id) REFERENCES classifications(id)
            ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    customer_id INT NOT NULL,

    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id) REFERENCES customers(id)
            ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS reviews (
    customer_id INT NOT NULL, --FK
    item_id INT NOT NULL , -- FK -- PK COMP
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    rating DECIMAL(3, 1) DEFAULT 0.0 NOT NULL,

    CHECK ( rating <= 10.0 ),

    CONSTRAINT pk_reviews
        PRIMARY KEY (customer_id, item_id),

    CONSTRAINT fk_reviews_customers
        FOREIGN KEY (customer_id) REFERENCES customers(id)
            ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT fk_reviews_items
        FOREIGN KEY (item_id) REFERENCES items(id)
            ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS orders_items (
    order_id INT NOT NULL ,
    item_id INT NOT NULL,
    quantity INT NOT NULL,

    CONSTRAINT pk_orders_items PRIMARY KEY (order_id, item_id),

    CHECK ( quantity >= 0 ),

    CONSTRAINT fk_orders_items_orders
        FOREIGN KEY (order_id) REFERENCES orders(id)
            ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT fk_orders_items_items
        FOREIGN KEY (item_id) REFERENCES items(id)
            ON DELETE CASCADE ON UPDATE CASCADE
);