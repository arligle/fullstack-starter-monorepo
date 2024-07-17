/*
 Navicat Premium Data Transfer

 Source Server         : PostgreSQL
 Source Server Type    : PostgreSQL
 Source Server Version : 130015 (130015)
 Source Host           : localhost:5435
 Source Catalog        : tooljet
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 130015 (130015)
 File Encoding         : 65001

 Date: 17/07/2024 01:59:29
*/


-- ----------------------------
-- Type structure for dimension_unit
-- ----------------------------
DROP TYPE IF EXISTS "public"."dimension_unit";
CREATE TYPE "public"."dimension_unit" AS ENUM (
  'count',
  'percent'
);
ALTER TYPE "public"."dimension_unit" OWNER TO "admin";

-- ----------------------------
-- Type structure for event_handlers_target_enum
-- ----------------------------
DROP TYPE IF EXISTS "public"."event_handlers_target_enum";
CREATE TYPE "public"."event_handlers_target_enum" AS ENUM (
  'page',
  'component',
  'data_query',
  'table_column',
  'table_action'
);
ALTER TYPE "public"."event_handlers_target_enum" OWNER TO "admin";

-- ----------------------------
-- Type structure for layput_type
-- ----------------------------
DROP TYPE IF EXISTS "public"."layput_type";
CREATE TYPE "public"."layput_type" AS ENUM (
  'desktop',
  'mobile'
);
ALTER TYPE "public"."layput_type" OWNER TO "admin";

-- ----------------------------
-- Type structure for scope
-- ----------------------------
DROP TYPE IF EXISTS "public"."scope";
CREATE TYPE "public"."scope" AS ENUM (
  'local',
  'global'
);
ALTER TYPE "public"."scope" OWNER TO "admin";

-- ----------------------------
-- Type structure for source
-- ----------------------------
DROP TYPE IF EXISTS "public"."source";
CREATE TYPE "public"."source" AS ENUM (
  'signup',
  'invite',
  'google',
  'git',
  'workspace_signup'
);
ALTER TYPE "public"."source" OWNER TO "admin";

-- ----------------------------
-- Type structure for status
-- ----------------------------
DROP TYPE IF EXISTS "public"."status";
CREATE TYPE "public"."status" AS ENUM (
  'invited',
  'verified',
  'active',
  'archived'
);
ALTER TYPE "public"."status" OWNER TO "admin";

-- ----------------------------
-- Type structure for type
-- ----------------------------
DROP TYPE IF EXISTS "public"."type";
CREATE TYPE "public"."type" AS ENUM (
  'static',
  'default',
  'sample'
);
ALTER TYPE "public"."type" OWNER TO "admin";

-- ----------------------------
-- Type structure for variable_type
-- ----------------------------
DROP TYPE IF EXISTS "public"."variable_type";
CREATE TYPE "public"."variable_type" AS ENUM (
  'client',
  'server'
);
ALTER TYPE "public"."variable_type" OWNER TO "admin";

-- ----------------------------
-- Sequence structure for migrations_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."migrations_id_seq";
CREATE SEQUENCE "public"."migrations_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for app_environments
-- ----------------------------
DROP TABLE IF EXISTS "public"."app_environments";
CREATE TABLE "public"."app_environments" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "name" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "default" bool NOT NULL DEFAULT false,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now(),
  "organization_id" uuid NOT NULL,
  "priority" int4 DEFAULT 1,
  "enabled" bool NOT NULL DEFAULT true
)
;

-- ----------------------------
-- Table structure for app_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS "public"."app_group_permissions";
CREATE TABLE "public"."app_group_permissions" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "app_id" uuid NOT NULL,
  "group_permission_id" uuid NOT NULL,
  "read" bool NOT NULL DEFAULT false,
  "update" bool NOT NULL DEFAULT false,
  "delete" bool NOT NULL DEFAULT false,
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now(),
  "hide_from_dashboard" bool NOT NULL DEFAULT false
)
;

-- ----------------------------
-- Table structure for app_users
-- ----------------------------
DROP TABLE IF EXISTS "public"."app_users";
CREATE TABLE "public"."app_users" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "app_id" uuid NOT NULL,
  "user_id" uuid NOT NULL,
  "role" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for app_versions
-- ----------------------------
DROP TABLE IF EXISTS "public"."app_versions";
CREATE TABLE "public"."app_versions" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "name" varchar COLLATE "pg_catalog"."default",
  "definition" json,
  "app_id" uuid NOT NULL,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now(),
  "current_environment_id" uuid,
  "global_settings" json,
  "show_viewer_navigation" bool NOT NULL DEFAULT true,
  "home_page_id" uuid
)
;

-- ----------------------------
-- Table structure for apps
-- ----------------------------
DROP TABLE IF EXISTS "public"."apps";
CREATE TABLE "public"."apps" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "name" varchar COLLATE "pg_catalog"."default",
  "slug" varchar COLLATE "pg_catalog"."default",
  "user_id" uuid NOT NULL,
  "current_version_id" uuid,
  "is_public" bool,
  "organization_id" uuid NOT NULL,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now(),
  "icon" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "is_maintenance_on" bool NOT NULL DEFAULT false
)
;

-- ----------------------------
-- Table structure for comment_users
-- ----------------------------
DROP TABLE IF EXISTS "public"."comment_users";
CREATE TABLE "public"."comment_users" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "comment_id" uuid NOT NULL,
  "user_id" uuid NOT NULL,
  "is_read" bool DEFAULT false,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS "public"."comments";
CREATE TABLE "public"."comments" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "thread_id" uuid NOT NULL,
  "app_versions_id" uuid,
  "organization_id" uuid NOT NULL,
  "comment" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "is_read" bool DEFAULT false,
  "user_id" uuid,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for components
-- ----------------------------
DROP TABLE IF EXISTS "public"."components";
CREATE TABLE "public"."components" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "name" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "type" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "page_id" uuid NOT NULL,
  "parent" varchar COLLATE "pg_catalog"."default",
  "properties" json,
  "general_properties" json,
  "styles" json,
  "general_styles" json,
  "display_preferences" json,
  "validation" json,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for credentials
-- ----------------------------
DROP TABLE IF EXISTS "public"."credentials";
CREATE TABLE "public"."credentials" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "value_ciphertext" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for data_queries
-- ----------------------------
DROP TABLE IF EXISTS "public"."data_queries";
CREATE TABLE "public"."data_queries" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "data_source_id" uuid,
  "name" varchar COLLATE "pg_catalog"."default",
  "options" json,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now(),
  "app_version_id" uuid
)
;

-- ----------------------------
-- Table structure for data_source_options
-- ----------------------------
DROP TABLE IF EXISTS "public"."data_source_options";
CREATE TABLE "public"."data_source_options" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "data_source_id" uuid NOT NULL,
  "environment_id" uuid NOT NULL,
  "options" json,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for data_source_user_oauth2s
-- ----------------------------
DROP TABLE IF EXISTS "public"."data_source_user_oauth2s";
CREATE TABLE "public"."data_source_user_oauth2s" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "user_id" uuid NOT NULL,
  "data_source_id" uuid NOT NULL,
  "options_ciphertext" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for data_sources
-- ----------------------------
DROP TABLE IF EXISTS "public"."data_sources";
CREATE TABLE "public"."data_sources" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "name" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "kind" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now(),
  "app_version_id" uuid,
  "plugin_id" uuid,
  "organization_id" uuid,
  "type" "public"."type" NOT NULL DEFAULT 'default'::type,
  "scope" "public"."scope" NOT NULL DEFAULT 'local'::scope
)
;

-- ----------------------------
-- Table structure for event_handlers
-- ----------------------------
DROP TABLE IF EXISTS "public"."event_handlers";
CREATE TABLE "public"."event_handlers" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "name" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "index" int4 NOT NULL,
  "event" jsonb NOT NULL,
  "app_version_id" uuid NOT NULL,
  "source_id" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "target" "public"."event_handlers_target_enum" NOT NULL DEFAULT 'page'::event_handlers_target_enum,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for files
-- ----------------------------
DROP TABLE IF EXISTS "public"."files";
CREATE TABLE "public"."files" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "data" jsonb NOT NULL,
  "filename" varchar COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Table structure for folder_apps
-- ----------------------------
DROP TABLE IF EXISTS "public"."folder_apps";
CREATE TABLE "public"."folder_apps" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "folder_id" uuid NOT NULL,
  "app_id" uuid NOT NULL,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for folders
-- ----------------------------
DROP TABLE IF EXISTS "public"."folders";
CREATE TABLE "public"."folders" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "name" varchar COLLATE "pg_catalog"."default",
  "organization_id" uuid NOT NULL,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for group_permissions
-- ----------------------------
DROP TABLE IF EXISTS "public"."group_permissions";
CREATE TABLE "public"."group_permissions" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "organization_id" uuid NOT NULL,
  "group" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now(),
  "app_create" bool NOT NULL DEFAULT false,
  "app_delete" bool NOT NULL DEFAULT false,
  "folder_create" bool NOT NULL DEFAULT false,
  "folder_delete" bool NOT NULL DEFAULT false,
  "folder_update" bool NOT NULL DEFAULT false,
  "org_environment_variable_create" bool NOT NULL DEFAULT false,
  "org_environment_variable_update" bool NOT NULL DEFAULT false,
  "org_environment_variable_delete" bool NOT NULL DEFAULT false,
  "org_environment_constant_create" bool NOT NULL DEFAULT false,
  "org_environment_constant_delete" bool NOT NULL DEFAULT false
)
;

-- ----------------------------
-- Table structure for internal_tables
-- ----------------------------
DROP TABLE IF EXISTS "public"."internal_tables";
CREATE TABLE "public"."internal_tables" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "organization_id" uuid NOT NULL,
  "table_name" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for layouts
-- ----------------------------
DROP TABLE IF EXISTS "public"."layouts";
CREATE TABLE "public"."layouts" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "type" "public"."layput_type" NOT NULL,
  "top" float8,
  "left" float8,
  "width" float8,
  "height" float8,
  "component_id" uuid NOT NULL,
  "dimension_unit" "public"."dimension_unit" NOT NULL DEFAULT 'percent'::dimension_unit,
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for metadata
-- ----------------------------
DROP TABLE IF EXISTS "public"."metadata";
CREATE TABLE "public"."metadata" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "data" json,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS "public"."migrations";
CREATE TABLE "public"."migrations" (
  "id" int4 NOT NULL DEFAULT nextval('migrations_id_seq'::regclass),
  "timestamp" int8 NOT NULL,
  "name" varchar COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Table structure for org_environment_constant_values
-- ----------------------------
DROP TABLE IF EXISTS "public"."org_environment_constant_values";
CREATE TABLE "public"."org_environment_constant_values" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "organization_constant_id" uuid NOT NULL,
  "environment_id" uuid NOT NULL,
  "value" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now()
)
;

-- ----------------------------
-- Table structure for org_environment_variables
-- ----------------------------
DROP TABLE IF EXISTS "public"."org_environment_variables";
CREATE TABLE "public"."org_environment_variables" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "organization_id" uuid NOT NULL,
  "variable_name" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "value" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "variable_type" "public"."variable_type" NOT NULL,
  "encrypted" bool NOT NULL DEFAULT false,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for organization_constants
-- ----------------------------
DROP TABLE IF EXISTS "public"."organization_constants";
CREATE TABLE "public"."organization_constants" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "constant_name" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "organization_id" uuid NOT NULL,
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now()
)
;

-- ----------------------------
-- Table structure for organization_users
-- ----------------------------
DROP TABLE IF EXISTS "public"."organization_users";
CREATE TABLE "public"."organization_users" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "organization_id" uuid NOT NULL,
  "user_id" uuid NOT NULL,
  "role" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "status" varchar COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'invited'::character varying,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now(),
  "invitation_token" varchar COLLATE "pg_catalog"."default",
  "source" "public"."source" NOT NULL DEFAULT 'invite'::source
)
;

-- ----------------------------
-- Table structure for organizations
-- ----------------------------
DROP TABLE IF EXISTS "public"."organizations";
CREATE TABLE "public"."organizations" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "name" varchar COLLATE "pg_catalog"."default",
  "domain" varchar COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now(),
  "enable_sign_up" bool NOT NULL DEFAULT false,
  "inherit_sso" bool NOT NULL DEFAULT true,
  "slug" varchar(50) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for pages
-- ----------------------------
DROP TABLE IF EXISTS "public"."pages";
CREATE TABLE "public"."pages" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "name" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "index" int4 NOT NULL,
  "page_handle" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "disabled" bool,
  "hidden" bool,
  "app_version_id" uuid NOT NULL,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now(),
  "auto_compute_layout" bool NOT NULL DEFAULT false
)
;

-- ----------------------------
-- Table structure for plugins
-- ----------------------------
DROP TABLE IF EXISTS "public"."plugins";
CREATE TABLE "public"."plugins" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "plugin_id" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "repo" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "version" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "index_file_id" uuid NOT NULL,
  "operations_file_id" uuid NOT NULL,
  "icon_file_id" uuid NOT NULL,
  "manifest_file_id" uuid NOT NULL,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for sso_configs
-- ----------------------------
DROP TABLE IF EXISTS "public"."sso_configs";
CREATE TABLE "public"."sso_configs" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "organization_id" uuid NOT NULL,
  "sso" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "configs" json,
  "enabled" bool NOT NULL DEFAULT true,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now()
)
;

-- ----------------------------
-- Table structure for threads
-- ----------------------------
DROP TABLE IF EXISTS "public"."threads";
CREATE TABLE "public"."threads" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "x" varchar COLLATE "pg_catalog"."default",
  "y" varchar COLLATE "pg_catalog"."default",
  "app_id" uuid NOT NULL,
  "organization_id" uuid NOT NULL,
  "app_versions_id" uuid,
  "user_id" uuid,
  "is_resolved" bool DEFAULT false,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now(),
  "page_id" varchar COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for typeorm_metadata
-- ----------------------------
DROP TABLE IF EXISTS "public"."typeorm_metadata";
CREATE TABLE "public"."typeorm_metadata" (
  "type" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "database" varchar COLLATE "pg_catalog"."default",
  "schema" varchar COLLATE "pg_catalog"."default",
  "table" varchar COLLATE "pg_catalog"."default",
  "name" varchar COLLATE "pg_catalog"."default",
  "value" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Table structure for user_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS "public"."user_group_permissions";
CREATE TABLE "public"."user_group_permissions" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "user_id" uuid NOT NULL,
  "group_permission_id" uuid NOT NULL,
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "updated_at" timestamp(6) NOT NULL DEFAULT now()
)
;

-- ----------------------------
-- Table structure for user_sessions
-- ----------------------------
DROP TABLE IF EXISTS "public"."user_sessions";
CREATE TABLE "public"."user_sessions" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "user_id" uuid NOT NULL,
  "device" varchar COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'unknown'::character varying,
  "created_at" timestamp(6) NOT NULL DEFAULT now(),
  "expiry" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "public"."users";
CREATE TABLE "public"."users" (
  "id" uuid NOT NULL DEFAULT gen_random_uuid(),
  "first_name" varchar COLLATE "pg_catalog"."default",
  "last_name" varchar COLLATE "pg_catalog"."default",
  "email" varchar COLLATE "pg_catalog"."default",
  "password_digest" varchar COLLATE "pg_catalog"."default",
  "invitation_token" varchar COLLATE "pg_catalog"."default",
  "forgot_password_token" varchar COLLATE "pg_catalog"."default",
  "organization_id" uuid,
  "created_at" timestamp(6) DEFAULT now(),
  "updated_at" timestamp(6) DEFAULT now(),
  "role" varchar COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "avatar_id" uuid,
  "password_retry_count" int2 NOT NULL DEFAULT 0,
  "company_size" varchar COLLATE "pg_catalog"."default",
  "company_name" varchar COLLATE "pg_catalog"."default",
  "status" "public"."status" NOT NULL DEFAULT 'invited'::status,
  "source" "public"."source" NOT NULL DEFAULT 'invite'::source,
  "phone_number" varchar COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."migrations_id_seq"
OWNED BY "public"."migrations"."id";
SELECT setval('"public"."migrations_id_seq"', 1, false);

-- ----------------------------
-- Uniques structure for table app_environments
-- ----------------------------
ALTER TABLE "public"."app_environments" ADD CONSTRAINT "unique_organization_id_priority" UNIQUE ("organization_id", "priority");

-- ----------------------------
-- Primary Key structure for table app_environments
-- ----------------------------
ALTER TABLE "public"."app_environments" ADD CONSTRAINT "app_environments_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table app_group_permissions
-- ----------------------------
ALTER TABLE "public"."app_group_permissions" ADD CONSTRAINT "app_group_permissions_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table app_users
-- ----------------------------
ALTER TABLE "public"."app_users" ADD CONSTRAINT "app_users_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table app_versions
-- ----------------------------
ALTER TABLE "public"."app_versions" ADD CONSTRAINT "name_app_id_app_versions_unique" UNIQUE ("name", "app_id");

-- ----------------------------
-- Primary Key structure for table app_versions
-- ----------------------------
ALTER TABLE "public"."app_versions" ADD CONSTRAINT "app_versions_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table apps
-- ----------------------------
ALTER TABLE "public"."apps" ADD CONSTRAINT "app_name_organization_id_unique" UNIQUE ("name", "organization_id");
ALTER TABLE "public"."apps" ADD CONSTRAINT "UQ_35eef0fb1f3f2b435b8b6d82ba0" UNIQUE ("slug");

-- ----------------------------
-- Primary Key structure for table apps
-- ----------------------------
ALTER TABLE "public"."apps" ADD CONSTRAINT "apps_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table comment_users
-- ----------------------------
ALTER TABLE "public"."comment_users" ADD CONSTRAINT "comment_users_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table comments
-- ----------------------------
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table components
-- ----------------------------
CREATE INDEX "IDX_673dc1c412adfb5b54ec419224" ON "public"."components" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_dab02b08685ba25e5a59626992" ON "public"."components" USING btree (
  "type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "IDX_de521ef5844106d2b2033dd2d8" ON "public"."components" USING btree (
  "page_id" "pg_catalog"."uuid_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table components
-- ----------------------------
ALTER TABLE "public"."components" ADD CONSTRAINT "components_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table credentials
-- ----------------------------
ALTER TABLE "public"."credentials" ADD CONSTRAINT "credentials_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table data_queries
-- ----------------------------
ALTER TABLE "public"."data_queries" ADD CONSTRAINT "data_queries_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table data_source_options
-- ----------------------------
ALTER TABLE "public"."data_source_options" ADD CONSTRAINT "data_source_env_data_source_options_unique" UNIQUE ("data_source_id", "environment_id");

-- ----------------------------
-- Primary Key structure for table data_source_options
-- ----------------------------
ALTER TABLE "public"."data_source_options" ADD CONSTRAINT "data_source_options_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table data_source_user_oauth2s
-- ----------------------------
ALTER TABLE "public"."data_source_user_oauth2s" ADD CONSTRAINT "data_source_user_oauth2s_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table data_sources
-- ----------------------------
ALTER TABLE "public"."data_sources" ADD CONSTRAINT "data_sources_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table event_handlers
-- ----------------------------
ALTER TABLE "public"."event_handlers" ADD CONSTRAINT "event_handlers_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table files
-- ----------------------------
ALTER TABLE "public"."files" ADD CONSTRAINT "files_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table folder_apps
-- ----------------------------
ALTER TABLE "public"."folder_apps" ADD CONSTRAINT "folder_apps_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table folders
-- ----------------------------
ALTER TABLE "public"."folders" ADD CONSTRAINT "folder_name_organization_id_unique" UNIQUE ("name", "organization_id");

-- ----------------------------
-- Primary Key structure for table folders
-- ----------------------------
ALTER TABLE "public"."folders" ADD CONSTRAINT "folders_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table group_permissions
-- ----------------------------
ALTER TABLE "public"."group_permissions" ADD CONSTRAINT "UQ_9cb4cc225c96246e4d1b2e614bf" UNIQUE ("organization_id", "group");

-- ----------------------------
-- Primary Key structure for table group_permissions
-- ----------------------------
ALTER TABLE "public"."group_permissions" ADD CONSTRAINT "group_permissions_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table internal_tables
-- ----------------------------
ALTER TABLE "public"."internal_tables" ADD CONSTRAINT "organization_id_table_name_unique" UNIQUE ("organization_id", "table_name");

-- ----------------------------
-- Primary Key structure for table internal_tables
-- ----------------------------
ALTER TABLE "public"."internal_tables" ADD CONSTRAINT "internal_tables_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table layouts
-- ----------------------------
ALTER TABLE "public"."layouts" ADD CONSTRAINT "layouts_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table metadata
-- ----------------------------
ALTER TABLE "public"."metadata" ADD CONSTRAINT "metadata_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table migrations
-- ----------------------------
ALTER TABLE "public"."migrations" ADD CONSTRAINT "migrations_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table org_environment_constant_values
-- ----------------------------
ALTER TABLE "public"."org_environment_constant_values" ADD CONSTRAINT "UQ_88c9a33b0ea9d9d5ac9b3d7ac71" UNIQUE ("organization_constant_id", "environment_id");

-- ----------------------------
-- Primary Key structure for table org_environment_constant_values
-- ----------------------------
ALTER TABLE "public"."org_environment_constant_values" ADD CONSTRAINT "org_environment_constant_values_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table org_environment_variables
-- ----------------------------
ALTER TABLE "public"."org_environment_variables" ADD CONSTRAINT "UQ_336d8c341188f36c2b2eb32cabe" UNIQUE ("organization_id", "variable_name", "variable_type");

-- ----------------------------
-- Primary Key structure for table org_environment_variables
-- ----------------------------
ALTER TABLE "public"."org_environment_variables" ADD CONSTRAINT "org_environment_variables_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table organization_constants
-- ----------------------------
ALTER TABLE "public"."organization_constants" ADD CONSTRAINT "UQ_0619f60991924d2aca5152cb5c7" UNIQUE ("constant_name", "organization_id");

-- ----------------------------
-- Primary Key structure for table organization_constants
-- ----------------------------
ALTER TABLE "public"."organization_constants" ADD CONSTRAINT "organization_constants_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table organization_users
-- ----------------------------
ALTER TABLE "public"."organization_users" ADD CONSTRAINT "user_organization_unique" UNIQUE ("organization_id", "user_id");

-- ----------------------------
-- Primary Key structure for table organization_users
-- ----------------------------
ALTER TABLE "public"."organization_users" ADD CONSTRAINT "organization_users_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table organizations
-- ----------------------------
ALTER TABLE "public"."organizations" ADD CONSTRAINT "name_organizations_unique" UNIQUE ("name");
ALTER TABLE "public"."organizations" ADD CONSTRAINT "slug_organizations_unique" UNIQUE ("slug");

-- ----------------------------
-- Primary Key structure for table organizations
-- ----------------------------
ALTER TABLE "public"."organizations" ADD CONSTRAINT "organizations_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table pages
-- ----------------------------
ALTER TABLE "public"."pages" ADD CONSTRAINT "pages_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table plugins
-- ----------------------------
ALTER TABLE "public"."plugins" ADD CONSTRAINT "plugins_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sso_configs
-- ----------------------------
ALTER TABLE "public"."sso_configs" ADD CONSTRAINT "sso_configs_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table threads
-- ----------------------------
ALTER TABLE "public"."threads" ADD CONSTRAINT "threads_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table user_group_permissions
-- ----------------------------
ALTER TABLE "public"."user_group_permissions" ADD CONSTRAINT "user_group_permissions_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table user_sessions
-- ----------------------------
ALTER TABLE "public"."user_sessions" ADD CONSTRAINT "user_sessions_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "UQ_97672ac88f789774dd47f7c8be3" UNIQUE ("email");

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table app_environments
-- ----------------------------
ALTER TABLE "public"."app_environments" ADD CONSTRAINT "app_environments_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table app_group_permissions
-- ----------------------------
ALTER TABLE "public"."app_group_permissions" ADD CONSTRAINT "app_group_permissions_app_id_apps_id_fk" FOREIGN KEY ("app_id") REFERENCES "public"."apps" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."app_group_permissions" ADD CONSTRAINT "app_group_permissions_group_permission_id_group_permissions_id_" FOREIGN KEY ("group_permission_id") REFERENCES "public"."group_permissions" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table app_users
-- ----------------------------
ALTER TABLE "public"."app_users" ADD CONSTRAINT "app_users_app_id_apps_id_fk" FOREIGN KEY ("app_id") REFERENCES "public"."apps" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."app_users" ADD CONSTRAINT "app_users_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table app_versions
-- ----------------------------
ALTER TABLE "public"."app_versions" ADD CONSTRAINT "app_versions_app_id_apps_id_fk" FOREIGN KEY ("app_id") REFERENCES "public"."apps" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."app_versions" ADD CONSTRAINT "app_versions_current_environment_id_app_environments_id_fk" FOREIGN KEY ("current_environment_id") REFERENCES "public"."app_environments" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table apps
-- ----------------------------
ALTER TABLE "public"."apps" ADD CONSTRAINT "apps_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table comment_users
-- ----------------------------
ALTER TABLE "public"."comment_users" ADD CONSTRAINT "comment_users_comment_id_comments_id_fk" FOREIGN KEY ("comment_id") REFERENCES "public"."comments" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."comment_users" ADD CONSTRAINT "comment_users_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table comments
-- ----------------------------
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_app_versions_id_app_versions_id_fk" FOREIGN KEY ("app_versions_id") REFERENCES "public"."app_versions" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_thread_id_threads_id_fk" FOREIGN KEY ("thread_id") REFERENCES "public"."threads" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table components
-- ----------------------------
ALTER TABLE "public"."components" ADD CONSTRAINT "components_page_id_pages_id_fk" FOREIGN KEY ("page_id") REFERENCES "public"."pages" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table data_queries
-- ----------------------------
ALTER TABLE "public"."data_queries" ADD CONSTRAINT "data_queries_app_version_id_app_versions_id_fk" FOREIGN KEY ("app_version_id") REFERENCES "public"."app_versions" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."data_queries" ADD CONSTRAINT "data_queries_data_source_id_data_sources_id_fk" FOREIGN KEY ("data_source_id") REFERENCES "public"."data_sources" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table data_source_options
-- ----------------------------
ALTER TABLE "public"."data_source_options" ADD CONSTRAINT "data_source_options_data_source_id_data_sources_id_fk" FOREIGN KEY ("data_source_id") REFERENCES "public"."data_sources" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."data_source_options" ADD CONSTRAINT "data_source_options_environment_id_app_environments_id_fk" FOREIGN KEY ("environment_id") REFERENCES "public"."app_environments" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table data_source_user_oauth2s
-- ----------------------------
ALTER TABLE "public"."data_source_user_oauth2s" ADD CONSTRAINT "data_source_user_oauth2s_data_source_id_data_sources_id_fk" FOREIGN KEY ("data_source_id") REFERENCES "public"."data_sources" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."data_source_user_oauth2s" ADD CONSTRAINT "data_source_user_oauth2s_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table data_sources
-- ----------------------------
ALTER TABLE "public"."data_sources" ADD CONSTRAINT "data_sources_app_version_id_app_versions_id_fk" FOREIGN KEY ("app_version_id") REFERENCES "public"."app_versions" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."data_sources" ADD CONSTRAINT "data_sources_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."data_sources" ADD CONSTRAINT "data_sources_plugin_id_plugins_id_fk" FOREIGN KEY ("plugin_id") REFERENCES "public"."plugins" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table event_handlers
-- ----------------------------
ALTER TABLE "public"."event_handlers" ADD CONSTRAINT "event_handlers_app_version_id_app_versions_id_fk" FOREIGN KEY ("app_version_id") REFERENCES "public"."app_versions" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table folder_apps
-- ----------------------------
ALTER TABLE "public"."folder_apps" ADD CONSTRAINT "folder_apps_app_id_apps_id_fk" FOREIGN KEY ("app_id") REFERENCES "public"."apps" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."folder_apps" ADD CONSTRAINT "folder_apps_folder_id_folders_id_fk" FOREIGN KEY ("folder_id") REFERENCES "public"."folders" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table folders
-- ----------------------------
ALTER TABLE "public"."folders" ADD CONSTRAINT "folders_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table group_permissions
-- ----------------------------
ALTER TABLE "public"."group_permissions" ADD CONSTRAINT "group_permissions_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table internal_tables
-- ----------------------------
ALTER TABLE "public"."internal_tables" ADD CONSTRAINT "internal_tables_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table layouts
-- ----------------------------
ALTER TABLE "public"."layouts" ADD CONSTRAINT "layouts_component_id_components_id_fk" FOREIGN KEY ("component_id") REFERENCES "public"."components" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table org_environment_constant_values
-- ----------------------------
ALTER TABLE "public"."org_environment_constant_values" ADD CONSTRAINT "org_environment_constant_values_environment_id_app_environments" FOREIGN KEY ("environment_id") REFERENCES "public"."app_environments" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."org_environment_constant_values" ADD CONSTRAINT "org_environment_constant_values_organization_constant_id_organi" FOREIGN KEY ("organization_constant_id") REFERENCES "public"."organization_constants" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table org_environment_variables
-- ----------------------------
ALTER TABLE "public"."org_environment_variables" ADD CONSTRAINT "org_environment_variables_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table organization_users
-- ----------------------------
ALTER TABLE "public"."organization_users" ADD CONSTRAINT "organization_users_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."organization_users" ADD CONSTRAINT "organization_users_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table pages
-- ----------------------------
ALTER TABLE "public"."pages" ADD CONSTRAINT "pages_app_version_id_app_versions_id_fk" FOREIGN KEY ("app_version_id") REFERENCES "public"."app_versions" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table plugins
-- ----------------------------
ALTER TABLE "public"."plugins" ADD CONSTRAINT "plugins_icon_file_id_files_id_fk" FOREIGN KEY ("icon_file_id") REFERENCES "public"."files" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."plugins" ADD CONSTRAINT "plugins_index_file_id_files_id_fk" FOREIGN KEY ("index_file_id") REFERENCES "public"."files" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."plugins" ADD CONSTRAINT "plugins_manifest_file_id_files_id_fk" FOREIGN KEY ("manifest_file_id") REFERENCES "public"."files" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."plugins" ADD CONSTRAINT "plugins_operations_file_id_files_id_fk" FOREIGN KEY ("operations_file_id") REFERENCES "public"."files" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table sso_configs
-- ----------------------------
ALTER TABLE "public"."sso_configs" ADD CONSTRAINT "sso_configs_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table threads
-- ----------------------------
ALTER TABLE "public"."threads" ADD CONSTRAINT "threads_app_id_apps_id_fk" FOREIGN KEY ("app_id") REFERENCES "public"."apps" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."threads" ADD CONSTRAINT "threads_app_versions_id_app_versions_id_fk" FOREIGN KEY ("app_versions_id") REFERENCES "public"."app_versions" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."threads" ADD CONSTRAINT "threads_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."threads" ADD CONSTRAINT "threads_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table user_group_permissions
-- ----------------------------
ALTER TABLE "public"."user_group_permissions" ADD CONSTRAINT "user_group_permissions_group_permission_id_group_permissions_id" FOREIGN KEY ("group_permission_id") REFERENCES "public"."group_permissions" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."user_group_permissions" ADD CONSTRAINT "user_group_permissions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table user_sessions
-- ----------------------------
ALTER TABLE "public"."user_sessions" ADD CONSTRAINT "user_sessions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
