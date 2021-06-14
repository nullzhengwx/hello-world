
-- ----------------------------
-- https://gitee.com/tommygun/MyScriptToPgScript
-- Table structure for queue_task
-- -- 2021-06-14 12:51:56
-- -- Tbl#queue_task
-- ----------------------------

CREATE SEQUENCE "queue_task_queue_id_seq"
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

-- DROP TABLE IF EXISTS "queue_task";

CREATE TABLE "queue_task"(
	"queue_id" bigint NOT NULL DEFAULT nextval('"queue_task_queue_id_seq"'::regclass),
	"queue_name" character varying(30) COLLATE "default",
	"payload" character varying(1000) COLLATE "default",
	"create_at" bigint,
	"next_process_at" bigint,
	"attempt" bigint,
	"feed_id" bigint,
	"version" bigint
)
WITH (
    OIDS = FALSE
)
;

COMMENT ON TABLE "queue_task" IS 'Tbl#queue_task';

COMMENT ON COLUMN "queue_task"."queue_id" IS 'queue id';
COMMENT ON COLUMN "queue_task"."queue_name" IS 'queue name';
COMMENT ON COLUMN "queue_task"."payload" IS 'payload';
COMMENT ON COLUMN "queue_task"."create_at" IS 'create timestamp';
COMMENT ON COLUMN "queue_task"."next_process_at" IS 'next process timestamp';
COMMENT ON COLUMN "queue_task"."attempt" IS 'times';
COMMENT ON COLUMN "queue_task"."feed_id" IS 'feed iD';
COMMENT ON COLUMN "queue_task"."version" IS 'version';

-- ----------------------------
-- https://gitee.com/tommygun/MyScriptToPgScript
-- Table structure for feed_log
-- -- 2021-06-14 12:51:56
-- -- Tbl#feed_log
-- ----------------------------

CREATE SEQUENCE "feed_log_log_id_seq"
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

-- DROP TABLE IF EXISTS "feed_log";

CREATE TABLE "feed_log"(
	"log_id" bigint NOT NULL DEFAULT nextval('"feed_log_log_id_seq"'::regclass),
	"feed_id" bigint,
	"status" character varying(100) COLLATE "default",
	"create_at" bigint
)
WITH (
    OIDS = FALSE
)
;

COMMENT ON TABLE "feed_log" IS 'Tbl#feed_log';

COMMENT ON COLUMN "feed_log"."log_id" IS 'log id';
COMMENT ON COLUMN "feed_log"."feed_id" IS 'feed id';
COMMENT ON COLUMN "feed_log"."status" IS 'feed status';
COMMENT ON COLUMN "feed_log"."create_at" IS 'create timestamp';

-- ----------------------------
-- https://gitee.com/tommygun/MyScriptToPgScript
-- Table structure for feed_parameter
-- -- 2021-06-14 12:51:56
-- -- Tbl#feed_parameter
-- ----------------------------

CREATE SEQUENCE "feed_parameter_parameter_id_seq"
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

-- DROP TABLE IF EXISTS "feed_parameter";

CREATE TABLE "feed_parameter"(
	"parameter_id" bigint NOT NULL DEFAULT nextval('"feed_parameter_parameter_id_seq"'::regclass),
	"feed_id" bigint,
	"param_type" character varying(226) COLLATE "default",
	"create_at" bigint
)
WITH (
    OIDS = FALSE
)
;

COMMENT ON TABLE "feed_parameter" IS 'Tbl#feed_parameter';

COMMENT ON COLUMN "feed_parameter"."parameter_id" IS 'parameter id';
COMMENT ON COLUMN "feed_parameter"."feed_id" IS 'feed id';
COMMENT ON COLUMN "feed_parameter"."param_type" IS 'param type';
COMMENT ON COLUMN "feed_parameter"."create_at" IS 'create timestamp';

-- ----------------------------
-- https://gitee.com/tommygun/MyScriptToPgScript
-- Table structure for feed_om
-- -- 2021-06-14 12:51:56
-- -- Tbl#feed_om
-- ----------------------------

CREATE SEQUENCE "feed_om_feed_id_seq"
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

-- DROP TABLE IF EXISTS "feed_om";

CREATE TABLE "feed_om"(
	"feed_id" bigint NOT NULL DEFAULT nextval('"feed_om_feed_id_seq"'::regclass),
	"process_id" character varying(226) COLLATE "default",
	"instance_id" character varying(226) COLLATE "default",
	"COB_date" character varying(226) COLLATE "default",
	"source_system" character varying(226) COLLATE "default",
	"region" character varying(226) COLLATE "default",
	"site" character varying(226) COLLATE "default",
	"data_type" character varying(226) COLLATE "default",
	"data_sub_type" character varying(226) COLLATE "default",
	"payload" character varying(1000) COLLATE "default",
	"status" character varying(226) COLLATE "default",
	"commit_id" character varying(226) COLLATE "default",
	"create_at" bigint
)
WITH (
    OIDS = FALSE
)
;

COMMENT ON TABLE "feed_om" IS 'Tbl#feed_om';

COMMENT ON COLUMN "feed_om"."feed_id" IS 'feed id';
COMMENT ON COLUMN "feed_om"."process_id" IS 'process id';
COMMENT ON COLUMN "feed_om"."instance_id" IS 'instance id';
COMMENT ON COLUMN "feed_om"."COB_date" IS 'business date';
COMMENT ON COLUMN "feed_om"."source_system" IS 'source system';
COMMENT ON COLUMN "feed_om"."region" IS 'region';
COMMENT ON COLUMN "feed_om"."site" IS 'site';
COMMENT ON COLUMN "feed_om"."data_type" IS 'data type';
COMMENT ON COLUMN "feed_om"."data_sub_type" IS 'data sub type';
COMMENT ON COLUMN "feed_om"."payload" IS 'payload';
COMMENT ON COLUMN "feed_om"."status" IS 'feed status';
COMMENT ON COLUMN "feed_om"."commit_id" IS 'transaction commit id';
COMMENT ON COLUMN "feed_om"."create_at" IS '创建日期';
