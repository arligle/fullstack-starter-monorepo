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
