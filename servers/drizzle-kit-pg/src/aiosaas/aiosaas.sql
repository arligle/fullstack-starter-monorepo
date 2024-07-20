CREATE TABLE IF NOT EXISTS "users" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"first_name" varchar,
	"last_name" varchar,
	"email" varchar,
	"password_digest" varchar,
	"invitation_token" varchar,
	"forgot_password_token" varchar,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	"role" varchar DEFAULT '' NOT NULL,
	"avatar_id" uuid,
	"password_retry_count" smallint DEFAULT 0 NOT NULL,
	"company_size" varchar,
	"company_name" varchar,
	"phone_number" varchar
);
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

