DO $$ BEGIN
 CREATE TYPE "public"."dimension_unit" AS ENUM('count', 'percent');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 CREATE TYPE "public"."event_handlers_target_enum" AS ENUM('page', 'component', 'data_query', 'table_column', 'table_action');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 CREATE TYPE "public"."layput_type" AS ENUM('desktop', 'mobile');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 CREATE TYPE "public"."scope" AS ENUM('local', 'global');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 CREATE TYPE "public"."source" AS ENUM('signup', 'invite', 'google', 'git', 'workspace_signup');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 CREATE TYPE "public"."status" AS ENUM('invited', 'verified', 'active', 'archived');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 CREATE TYPE "public"."type" AS ENUM('static', 'default', 'sample');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 CREATE TYPE "public"."variable_type" AS ENUM('client', 'server');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "organizations" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" varchar,
	"domain" varchar,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	"enable_sign_up" boolean DEFAULT false NOT NULL,
	"inherit_sso" boolean DEFAULT true NOT NULL,
	"slug" varchar(50),
	CONSTRAINT "name_organizations_unique" UNIQUE("name"),
	CONSTRAINT "slug_organizations_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "users" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"first_name" varchar,
	"last_name" varchar,
	"email" varchar,
	"password_digest" varchar,
	"invitation_token" varchar,
	"forgot_password_token" varchar,
	"organization_id" uuid,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	"role" varchar DEFAULT '' NOT NULL,
	"avatar_id" uuid,
	"password_retry_count" smallint DEFAULT 0 NOT NULL,
	"company_size" varchar,
	"company_name" varchar,
	"status" "status" DEFAULT 'invited' NOT NULL,
	"source" "source" DEFAULT 'invite' NOT NULL,
	"phone_number" varchar,
	CONSTRAINT "UQ_97672ac88f789774dd47f7c8be3" UNIQUE("email")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "users" ADD CONSTRAINT "users_organization_id_organizations_id_fk" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
