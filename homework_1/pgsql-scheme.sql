CREATE TABLE "product_category"
(
    "id"                bigserial                   NOT NULL,
    "name"              VARCHAR(128)                NOT NULL,
    "category_discount" smallint(3)                 NULL,
    "created"           TIMESTAMP(6) WITH TIME zone NOT NULL,
    "updated"           TIMESTAMP(6) WITH TIME zone NULL
);
ALTER TABLE
    "product_category"
    ADD PRIMARY KEY ("id");


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
ALTER TABLE
    "order"
    ADD PRIMARY KEY ("id");


CREATE TABLE "producer"
(
    "id"      bigserial                   NOT NULL,
    "name"    VARCHAR(128)                NOT NULL,
    "created" TIMESTAMP(6) WITH TIME zone NOT NULL,
    "updated" TIMESTAMP(6) WITH TIME zone NULL
);
ALTER TABLE
    "producer"
    ADD PRIMARY KEY ("id");


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
ALTER TABLE
    "product"
    ADD PRIMARY KEY ("id");


CREATE TABLE "order_products"
(
    "order_id"      bigserial                   NOT NULL,
    "product_id"    bigserial                   NOT NULL,
    "product_count" DOUBLE PRECISION            NOT NULL,
    "final_price"   DOUBLE PRECISION            NOT NULL,
    "created"       TIMESTAMP(6) WITH TIME zone NOT NULL,
    "updated"       TIMESTAMP(6) WITH TIME zone NULL
);


CREATE TABLE "prices"
(
    "id"          bigserial                   NOT NULL,
    "product_id"  bigserial                   NOT NULL,
    "price_value" DOUBLE PRECISION            NOT NULL,
    "discount"    smallint(3)                 NULL,
    "created"     TIMESTAMP(6) WITH TIME zone NOT NULL,
    "updated"     TIMESTAMP(6) WITH TIME zone NULL
);
ALTER TABLE
    "prices"
    ADD PRIMARY KEY ("id");


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

ALTER TABLE
    "buyer"
    ADD PRIMARY KEY ("id");


CREATE TABLE "provider"
(
    "id"      bigserial                   NOT NULL,
    "name"    VARCHAR(128)                NOT NULL,
    "created" TIMESTAMP(6) WITH TIME zone NOT NULL,
    "updated" TIMESTAMP(6) WITH TIME zone NULL
);
ALTER TABLE
    "provider"
    ADD PRIMARY KEY ("id");


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