import { boolean, pgTable, timestamp, unique, uuid, varchar } from "drizzle-orm/pg-core";
import { InferSelectModel } from 'drizzle-orm';

export const organizations = pgTable(
  'organizations',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    name: varchar('name'),
    domain: varchar('domain'),
    created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
    updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
    enable_sign_up: boolean('enable_sign_up').default(false).notNull(),
    inherit_sso: boolean('inherit_sso').default(true).notNull(),
    slug: varchar('slug', { length: 50 }),
  },
  (table) => {
    return {
      name_organizations_unique: unique('name_organizations_unique').on(
        table.name,
      ),
      slug_organizations_unique: unique('slug_organizations_unique').on(
        table.slug,
      ),
    };
  },
);
export type Organization = InferSelectModel<typeof organizations>;
export default organizations;