import { pgEnum } from "drizzle-orm/pg-core";

export const dimension_unit = pgEnum('dimension_unit', ['count', 'percent']);
export const event_handlers_target_enum = pgEnum('event_handlers_target_enum', [
  'page',
  'component',
  'data_query',
  'table_column',
  'table_action',
]);
export const layput_type = pgEnum('layput_type', ['desktop', 'mobile']);
export const scope = pgEnum('scope', ['local', 'global']);
export const source = pgEnum('source', [
  'signup',
  'invite',
  'google',
  'git',
  'workspace_signup',
]);
export const status = pgEnum('status', [
  'invited',
  'verified',
  'active',
  'archived',
]);
export const type = pgEnum('type', ['static', 'default', 'sample']);
export const variable_type = pgEnum('variable_type', ['client', 'server']);