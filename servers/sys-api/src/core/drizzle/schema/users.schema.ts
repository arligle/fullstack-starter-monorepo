import { InferSelectModel } from "drizzle-orm";
import {
  pgTable,
  smallint,
  timestamp,
  unique,
  uuid,
  varchar
} from "drizzle-orm/pg-core";
import organizations from "./organizations.schema";
import { source, status } from "./enum";

export const users = pgTable(
  'users',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    first_name: varchar('first_name'),
    last_name: varchar('last_name'),
    email: varchar('email'),
    password: varchar('password'),
    password_digest: varchar('password_digest'),
    invitation_token: varchar('invitation_token'),
    forgot_password_token: varchar('forgot_password_token'),
    organization_id: uuid('organization_id').references(
      () => organizations.id,
      { onDelete: 'cascade' },
    ),
    created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
    updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
    role: varchar('role').default('').notNull(),
    avatar_id: uuid('avatar_id'),
    password_retry_count: smallint('password_retry_count').default(0).notNull(),
    company_size: varchar('company_size'),
    company_name: varchar('company_name'),
    status: status('status').default('invited').notNull(),
    source: source('source').default('invite').notNull(),
    phone_number: varchar('phone_number'),
  },
  (table) => {
    return {
      UQ_97672ac88f789774dd47f7c8be3: unique(
        'UQ_97672ac88f789774dd47f7c8be3',
      ).on(table.email),
    };
  },
);

export type User = InferSelectModel<typeof users>;
export default users;