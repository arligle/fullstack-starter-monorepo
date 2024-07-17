import {
  pgTable,
  smallint,
  timestamp,
  uuid,
  varchar
} from "drizzle-orm/pg-core";

const users = pgTable(
  'users',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    first_name: varchar('first_name'),
    last_name: varchar('last_name'),
    email: varchar('email'),
    password_digest: varchar('password_digest'),
    invitation_token: varchar('invitation_token'),
    forgot_password_token: varchar('forgot_password_token'),

    created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
    updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
    role: varchar('role').default('').notNull(),
    avatar_id: uuid('avatar_id'),
    password_retry_count: smallint('password_retry_count').default(0).notNull(),
    company_size: varchar('company_size'),
    company_name: varchar('company_name'),
    phone_number: varchar('phone_number'),
  }
);

export default users;