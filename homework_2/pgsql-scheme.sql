-- product_category
CREATE TABLE "product_category"
(
    "id"                bigserial                                NOT NULL,
    "name"              VARCHAR(128)                             NOT NULL,
    "category_discount" smallint CHECK (category_discount < 100) NULL,
    "created"           TIMESTAMP(6) WITH TIME zone              NOT NULL,
    "updated"           TIMESTAMP(6) WITH TIME zone              NULL
);

COMMENT ON TABLE "product_category" IS 'Таблица для хранения категорий продуктов';

ALTER TABLE
    "product_category"
    ADD PRIMARY KEY ("id");

CREATE INDEX "product_category_name_index" ON
    "product_category" ("name");

-- order

CREATE TABLE "order"
(
    "id"          bigserial                   NOT NULL,
    "buyer_id"    bigserial                   NOT NULL,
    "total_price" DOUBLE PRECISION            NOT NULL,
    "is_paid"     BOOLEAN                     NOT NULL DEFAULT '0',
    "created"     TIMESTAMP(6) WITH TIME zone NOT NULL,
    "updated"     TIMESTAMP(6) WITH TIME zone NULL,
    "delivered"   TIMESTAMP(6) WITH TIME zone NULL
);

COMMENT ON TABLE "order" IS 'Таблица для хранения данных заказов';

ALTER TABLE
    "order"
    ADD PRIMARY KEY ("id");

CREATE INDEX "order_buyer_id_index" ON
    "order" ("buyer_id");

-- producer

CREATE TABLE "producer"
(
    "id"      bigserial                   NOT NULL,
    "name"    VARCHAR(128)                NOT NULL,
    "created" TIMESTAMP(6) WITH TIME zone NOT NULL,
    "updated" TIMESTAMP(6) WITH TIME zone NULL
);

COMMENT ON TABLE "producer" IS 'Таблица для хранения данных производителей продуктов';

ALTER TABLE
    "producer"
    ADD PRIMARY KEY ("id");

CREATE INDEX "producer_name_index" ON
    "producer" ("name");

-- product

CREATE TABLE "product"
(
    "id"          bigserial                   NOT NULL,
    "name"        VARCHAR(128)                NOT NULL,
    "category_id" bigserial                   NOT NULL,
    "provider_id" bigserial                   NOT NULL,
    "producer_id" bigserial                   NOT NULL,
    "created"     TIMESTAMP(6) WITH TIME zone NOT NULL,
    "updated"     TIMESTAMP(6) WITH TIME zone NULL
);

COMMENT ON TABLE "product" IS 'Таблица для хранения данных продуктов';

ALTER TABLE
    "product"
    ADD PRIMARY KEY ("id");

CREATE INDEX "product_name_index" ON
    "product" ("name");

-- order_products

CREATE TABLE "order_products"
(
    "order_id"      bigserial                                NOT NULL,
    "product_id"    bigserial                                NOT NULL,
    "product_count" DOUBLE PRECISION CHECK (product_count > 0) NOT NULL,
    "final_price"   DOUBLE PRECISION CHECK (final_price > 0) NOT NULL,
    "created"       TIMESTAMP(6) WITH TIME zone              NOT NULL,
    "updated"       TIMESTAMP(6) WITH TIME zone              NULL
);
COMMENT ON TABLE "order_products" IS 'Таблица для хранения списка продуктов в заказах';

CREATE INDEX "order_products_index"
    ON order_products (order_id, product_id);

-- prices

CREATE TABLE "prices"
(
    "id"          bigserial                                NOT NULL,
    "product_id"  bigserial                                NOT NULL,
    "price_value" DOUBLE PRECISION CHECK (price_value > 0) NOT NULL,
    "discount"    smallint CHECK (discount < 100)          NULL,
    "created"     TIMESTAMP(6) WITH TIME zone              NOT NULL,
    "updated"     TIMESTAMP(6) WITH TIME zone              NULL
);

COMMENT ON TABLE "prices" IS 'Таблица для хранения данных цен';

ALTER TABLE
    "prices"
    ADD PRIMARY KEY ("id");

CREATE INDEX "prices_product_id_index" ON
    "prices" ("product_id");

-- buyer

CREATE TABLE "buyer"
(
    "id"           bigserial                   NOT NULL,
    "phone_number" VARCHAR(20)                 NOT NULL,
    "email"        VARCHAR(100)                NULL,
    "name"         VARCHAR(100)                NOT NULL,
    "surname"      VARCHAR(100)                NULL,
    "address"      VARCHAR(255)                NOT NULL,
    "created"      TIMESTAMP(6) WITH TIME zone NOT NULL,
    "updated"      TIMESTAMP(6) WITH TIME zone NULL
);

COMMENT ON TABLE "buyer" IS 'Таблица для хранения данных покупателей';

ALTER TABLE
    "buyer"
    ADD PRIMARY KEY ("id");

CREATE INDEX "buyer_phone_number_index" ON
    "buyer" ("phone_number");

CREATE INDEX "buyer_email_index" ON
    "buyer" ("email");

-- provider

CREATE TABLE "provider"
(
    "id"      bigserial                   NOT NULL,
    "name"    VARCHAR(128)                NOT NULL,
    "created" TIMESTAMP(6) WITH TIME zone NOT NULL,
    "updated" TIMESTAMP(6) WITH TIME zone NULL
);

COMMENT ON TABLE "provider" IS 'Таблица для хранения данных поставщиков продуктов';

ALTER TABLE
    "provider"
    ADD PRIMARY KEY ("id");

CREATE INDEX "provider_name_index" ON
    "provider" ("name");

-- FK

ALTER TABLE
    "order"
    ADD CONSTRAINT "order_buyer_id_foreign" FOREIGN KEY ("buyer_id") REFERENCES "buyer" ("id");
ALTER TABLE
    "prices"
    ADD CONSTRAINT "prices_product_id_foreign" FOREIGN KEY ("product_id") REFERENCES "product" ("id");
ALTER TABLE
    "order_products"
    ADD CONSTRAINT "order_products_order_id_foreign" FOREIGN KEY ("order_id") REFERENCES "order" ("id");
ALTER TABLE
    "product"
    ADD CONSTRAINT "product_category_id_foreign" FOREIGN KEY ("category_id") REFERENCES "product_category" ("id");
ALTER TABLE
    "product"
    ADD CONSTRAINT "product_provider_id_foreign" FOREIGN KEY ("provider_id") REFERENCES "provider" ("id");
ALTER TABLE
    "order_products"
    ADD CONSTRAINT "order_products_product_id_foreign" FOREIGN KEY ("product_id") REFERENCES "product" ("id");
ALTER TABLE
    "product"
    ADD CONSTRAINT "product_producer_id_foreign" FOREIGN KEY ("producer_id") REFERENCES "producer" ("id");