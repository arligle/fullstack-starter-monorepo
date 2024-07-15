import {
  pgTable,
  pgEnum,
  serial,
  bigint,
  varchar,
  text,
  uuid,
  timestamp,
  unique,
  json,
  boolean,
  integer,
  jsonb,
  index,
  doublePrecision,
  smallint,
} from 'drizzle-orm/pg-core';

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

export const migrations = pgTable('migrations', {
  id: serial('id').primaryKey().notNull(),
  // You can use { mode: "bigint" } if numbers are exceeding js number limitations
  timestamp: bigint('timestamp', { mode: 'number' }).notNull(),
  name: varchar('name').notNull(),
});

export const typeorm_metadata = pgTable('typeorm_metadata', {
  type: varchar('type').notNull(),
  database: varchar('database'),
  schema: varchar('schema'),
  table: varchar('table'),
  name: varchar('name'),
  value: text('value'),
});

export const credentials = pgTable('credentials', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  value_ciphertext: varchar('value_ciphertext'),
  created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
});

export const folders = pgTable(
  'folders',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    // TODO: failed to parse database type 'citext'
    name: varchar('name'),
    organization_id: uuid('organization_id')
      .notNull()
      .references(() => organizations.id, { onDelete: 'cascade' }),
    created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
    updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
  },
  (table) => {
    return {
      folder_name_organization_id_unique: unique(
        'folder_name_organization_id_unique',
      ).on(table.name, table.organization_id),
    };
  },
);

export const folder_apps = pgTable('folder_apps', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  folder_id: uuid('folder_id')
    .notNull()
    .references(() => folders.id, { onDelete: 'cascade' }),
  app_id: uuid('app_id')
    .notNull()
    .references(() => apps.id, { onDelete: 'cascade' }),
  created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
});

export const metadata = pgTable('metadata', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  data: json('data'),
  created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
});

export const app_users = pgTable('app_users', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  app_id: uuid('app_id')
    .notNull()
    .references(() => apps.id, { onDelete: 'cascade' }),
  user_id: uuid('user_id')
    .notNull()
    .references(() => users.id, { onDelete: 'cascade' }),
  role: varchar('role').notNull(),
  created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
});

export const data_source_user_oauth2s = pgTable('data_source_user_oauth2s', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  user_id: uuid('user_id')
    .notNull()
    .references(() => users.id, { onDelete: 'cascade' }),
  data_source_id: uuid('data_source_id')
    .notNull()
    .references(() => data_sources.id, { onDelete: 'cascade' }),
  options_ciphertext: varchar('options_ciphertext').notNull(),
  created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
});

export const user_group_permissions = pgTable('user_group_permissions', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  user_id: uuid('user_id')
    .notNull()
    .references(() => users.id, { onDelete: 'cascade' }),
  group_permission_id: uuid('group_permission_id')
    .notNull()
    .references(() => group_permissions.id, { onDelete: 'cascade' }),
  created_at: timestamp('created_at', { mode: 'string' })
    .defaultNow()
    .notNull(),
  updated_at: timestamp('updated_at', { mode: 'string' })
    .defaultNow()
    .notNull(),
});

export const comments = pgTable('comments', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  thread_id: uuid('thread_id')
    .notNull()
    .references(() => threads.id, { onDelete: 'cascade' }),
  app_versions_id: uuid('app_versions_id').references(() => app_versions.id, {
    onDelete: 'cascade',
  }),
  organization_id: uuid('organization_id')
    .notNull()
    .references(() => organizations.id, { onDelete: 'cascade' }),
  comment: varchar('comment').notNull(),
  is_read: boolean('is_read').default(false),
  user_id: uuid('user_id').references(() => users.id, { onDelete: 'cascade' }),
  created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
});

export const sso_configs = pgTable('sso_configs', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  organization_id: uuid('organization_id')
    .notNull()
    .references(() => organizations.id, { onDelete: 'cascade' }),
  sso: varchar('sso').notNull(),
  configs: json('configs'),
  enabled: boolean('enabled').default(true).notNull(),
  created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
});

export const apps = pgTable(
  'apps',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    name: varchar('name'),
    slug: varchar('slug'),
    user_id: uuid('user_id').notNull(),
    current_version_id: uuid('current_version_id'),
    is_public: boolean('is_public'),
    organization_id: uuid('organization_id')
      .notNull()
      .references(() => organizations.id, { onDelete: 'cascade' }),
    created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
    updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
    // TODO:icon: varchar("icon", { length: 255 }).default(NULL:: character varying),
    icon: varchar('icon', { length: 255 }).default(''),
    is_maintenance_on: boolean('is_maintenance_on').default(false).notNull(),
  },
  (table) => {
    return {
      app_name_organization_id_unique: unique(
        'app_name_organization_id_unique',
      ).on(table.name, table.organization_id),
      UQ_35eef0fb1f3f2b435b8b6d82ba0: unique(
        'UQ_35eef0fb1f3f2b435b8b6d82ba0',
      ).on(table.slug),
    };
  },
);

export const data_queries = pgTable('data_queries', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  data_source_id: uuid('data_source_id').references(() => data_sources.id, {
    onDelete: 'cascade',
  }),
  name: varchar('name'),
  options: json('options'),
  created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
  app_version_id: uuid('app_version_id').references(() => app_versions.id, {
    onDelete: 'cascade',
  }),
});

export const files = pgTable('files', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  // TODO: failed to parse database type 'bytea'
  data: jsonb('data').notNull(),
  filename: varchar('filename').notNull(),
});

export const plugins = pgTable('plugins', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  plugin_id: varchar('plugin_id').notNull(),
  name: varchar('name').notNull(),
  repo: varchar('repo').notNull(),
  description: varchar('description').notNull(),
  version: varchar('version').notNull(),
  index_file_id: uuid('index_file_id')
    .notNull()
    .references(() => files.id),
  operations_file_id: uuid('operations_file_id')
    .notNull()
    .references(() => files.id),
  icon_file_id: uuid('icon_file_id')
    .notNull()
    .references(() => files.id),
  manifest_file_id: uuid('manifest_file_id')
    .notNull()
    .references(() => files.id),
  created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
});

export const org_environment_variables = pgTable(
  'org_environment_variables',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    organization_id: uuid('organization_id')
      .notNull()
      .references(() => organizations.id, { onDelete: 'cascade' }),
    variable_name: varchar('variable_name').notNull(),
    value: varchar('value').notNull(),
    variable_type: variable_type('variable_type').notNull(),
    encrypted: boolean('encrypted').default(false).notNull(),
    created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
    updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
  },
  (table) => {
    return {
      UQ_336d8c341188f36c2b2eb32cabe: unique(
        'UQ_336d8c341188f36c2b2eb32cabe',
      ).on(table.organization_id, table.variable_name, table.variable_type),
    };
  },
);

export const comment_users = pgTable('comment_users', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  comment_id: uuid('comment_id')
    .notNull()
    .references(() => comments.id, { onDelete: 'cascade' }),
  user_id: uuid('user_id')
    .notNull()
    .references(() => users.id),
  is_read: boolean('is_read').default(false),
  created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
});

export const app_group_permissions = pgTable('app_group_permissions', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  app_id: uuid('app_id')
    .notNull()
    .references(() => apps.id, { onDelete: 'cascade' }),
  group_permission_id: uuid('group_permission_id')
    .notNull()
    .references(() => group_permissions.id, { onDelete: 'cascade' }),
  read: boolean('read').default(false).notNull(),
  update: boolean('update').default(false).notNull(),
  delete: boolean('delete').default(false).notNull(),
  created_at: timestamp('created_at', { mode: 'string' })
    .defaultNow()
    .notNull(),
  updated_at: timestamp('updated_at', { mode: 'string' })
    .defaultNow()
    .notNull(),
  hide_from_dashboard: boolean('hide_from_dashboard').default(false).notNull(),
});

export const data_source_options = pgTable(
  'data_source_options',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    data_source_id: uuid('data_source_id')
      .notNull()
      .references(() => data_sources.id, { onDelete: 'cascade' }),
    environment_id: uuid('environment_id')
      .notNull()
      .references(() => app_environments.id, { onDelete: 'cascade' }),
    options: json('options'),
    created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
    updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
  },
  (table) => {
    return {
      data_source_env_data_source_options_unique: unique(
        'data_source_env_data_source_options_unique',
      ).on(table.data_source_id, table.environment_id),
    };
  },
);

export const internal_tables = pgTable(
  'internal_tables',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    organization_id: uuid('organization_id')
      .notNull()
      .references(() => organizations.id, { onDelete: 'cascade' }),
    table_name: varchar('table_name').notNull(),
    created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
    updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
  },
  (table) => {
    return {
      organization_id_table_name_unique: unique(
        'organization_id_table_name_unique',
      ).on(table.organization_id, table.table_name),
    };
  },
);

export const threads = pgTable('threads', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  x: varchar('x'),
  y: varchar('y'),
  app_id: uuid('app_id')
    .notNull()
    .references(() => apps.id, { onDelete: 'cascade' }),
  organization_id: uuid('organization_id')
    .notNull()
    .references(() => organizations.id, { onDelete: 'cascade' }),
  app_versions_id: uuid('app_versions_id').references(() => app_versions.id, {
    onDelete: 'cascade',
  }),
  user_id: uuid('user_id').references(() => users.id, { onDelete: 'cascade' }),
  is_resolved: boolean('is_resolved').default(false),
  created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
  page_id: varchar('page_id'),
});

export const user_sessions = pgTable('user_sessions', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  user_id: uuid('user_id')
    .notNull()
    .references(() => users.id, { onDelete: 'cascade' }),
  device: varchar('device').default('unknown').notNull(),
  created_at: timestamp('created_at', { mode: 'string' })
    .defaultNow()
    .notNull(),
  expiry: timestamp('expiry', { mode: 'string' }).notNull(),
});

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

export const app_environments = pgTable(
  'app_environments',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    name: varchar('name').notNull(),
    default: boolean('default').default(false).notNull(),
    created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
    updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
    organization_id: uuid('organization_id')
      .notNull()
      .references(() => organizations.id, { onDelete: 'cascade' }),
    priority: integer('priority').default(1),
    enabled: boolean('enabled').default(true).notNull(),
  },
  (table) => {
    return {
      unique_organization_id_priority: unique(
        'unique_organization_id_priority',
      ).on(table.organization_id, table.priority),
    };
  },
);

export const organization_constants = pgTable(
  'organization_constants',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    constant_name: varchar('constant_name').notNull(),
    organization_id: uuid('organization_id').notNull(),
    created_at: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updated_at: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
  },
  (table) => {
    return {
      UQ_0619f60991924d2aca5152cb5c7: unique(
        'UQ_0619f60991924d2aca5152cb5c7',
      ).on(table.constant_name, table.organization_id),
    };
  },
);

export const org_environment_constant_values = pgTable(
  'org_environment_constant_values',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    organization_constant_id: uuid('organization_constant_id')
      .notNull()
      .references(() => organization_constants.id, { onDelete: 'cascade' }),
    environment_id: uuid('environment_id')
      .notNull()
      .references(() => app_environments.id, { onDelete: 'cascade' }),
    value: varchar('value'),
    created_at: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updated_at: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
  },
  (table) => {
    return {
      UQ_88c9a33b0ea9d9d5ac9b3d7ac71: unique(
        'UQ_88c9a33b0ea9d9d5ac9b3d7ac71',
      ).on(table.organization_constant_id, table.environment_id),
    };
  },
);

export const group_permissions = pgTable(
  'group_permissions',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    organization_id: uuid('organization_id')
      .notNull()
      .references(() => organizations.id, { onDelete: 'cascade' }),
    group: varchar('group').notNull(),
    created_at: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updated_at: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    app_create: boolean('app_create').default(false).notNull(),
    app_delete: boolean('app_delete').default(false).notNull(),
    folder_create: boolean('folder_create').default(false).notNull(),
    folder_delete: boolean('folder_delete').default(false).notNull(),
    folder_update: boolean('folder_update').default(false).notNull(),
    org_environment_variable_create: boolean('org_environment_variable_create')
      .default(false)
      .notNull(),
    org_environment_variable_update: boolean('org_environment_variable_update')
      .default(false)
      .notNull(),
    org_environment_variable_delete: boolean('org_environment_variable_delete')
      .default(false)
      .notNull(),
    org_environment_constant_create: boolean('org_environment_constant_create')
      .default(false)
      .notNull(),
    org_environment_constant_delete: boolean('org_environment_constant_delete')
      .default(false)
      .notNull(),
  },
  (table) => {
    return {
      UQ_9cb4cc225c96246e4d1b2e614bf: unique(
        'UQ_9cb4cc225c96246e4d1b2e614bf',
      ).on(table.organization_id, table.group),
    };
  },
);

export const event_handlers = pgTable('event_handlers', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  name: varchar('name').notNull(),
  index: integer('index').notNull(),
  event: jsonb('event').notNull(),
  app_version_id: uuid('app_version_id')
    .notNull()
    .references(() => app_versions.id, { onDelete: 'cascade' }),
  source_id: varchar('source_id').notNull(),
  target: event_handlers_target_enum('target').default('page').notNull(),
  created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
});

export const app_versions = pgTable(
  'app_versions',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    name: varchar('name'),
    definition: json('definition'),
    app_id: uuid('app_id')
      .notNull()
      .references(() => apps.id, { onDelete: 'cascade' }),
    created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
    updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
    current_environment_id: uuid('current_environment_id').references(
      () => app_environments.id,
    ),
    global_settings: json('global_settings'),
    show_viewer_navigation: boolean('show_viewer_navigation')
      .default(true)
      .notNull(),
    home_page_id: uuid('home_page_id'),
  },
  (table) => {
    return {
      name_app_id_app_versions_unique: unique(
        'name_app_id_app_versions_unique',
      ).on(table.name, table.app_id),
    };
  },
);

export const components = pgTable(
  'components',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    name: varchar('name').notNull(),
    type: varchar('type').notNull(),
    page_id: uuid('page_id')
      .notNull()
      .references(() => pages.id, { onDelete: 'cascade' }),
    parent: varchar('parent'),
    properties: json('properties'),
    general_properties: json('general_properties'),
    styles: json('styles'),
    general_styles: json('general_styles'),
    display_preferences: json('display_preferences'),
    validation: json('validation'),
    created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
    updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
  },
  (table) => {
    return {
      IDX_673dc1c412adfb5b54ec419224: index(
        'IDX_673dc1c412adfb5b54ec419224',
      ).using('btree', table.name),
      IDX_dab02b08685ba25e5a59626992: index(
        'IDX_dab02b08685ba25e5a59626992',
      ).using('btree', table.type),
      IDX_de521ef5844106d2b2033dd2d8: index(
        'IDX_de521ef5844106d2b2033dd2d8',
      ).using('btree', table.page_id),
    };
  },
);

export const pages = pgTable('pages', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  name: varchar('name').notNull(),
  index: integer('index').notNull(),
  page_handle: varchar('page_handle').notNull(),
  disabled: boolean('disabled'),
  hidden: boolean('hidden'),
  app_version_id: uuid('app_version_id')
    .notNull()
    .references(() => app_versions.id, { onDelete: 'cascade' }),
  created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
  auto_compute_layout: boolean('auto_compute_layout').default(false).notNull(),
});

export const layouts = pgTable('layouts', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  type: layput_type('type').notNull(),
  top: doublePrecision('top'),
  left: doublePrecision('left'),
  width: doublePrecision('width'),
  height: doublePrecision('height'),
  component_id: uuid('component_id')
    .notNull()
    .references(() => components.id, { onDelete: 'cascade' }),
  dimension_unit: dimension_unit('dimension_unit').default('percent').notNull(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
});

export const data_sources = pgTable('data_sources', {
  id: uuid('id').defaultRandom().primaryKey().notNull(),
  name: varchar('name').notNull(),
  kind: varchar('kind').notNull(),
  created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
  app_version_id: uuid('app_version_id').references(() => app_versions.id, {
    onDelete: 'cascade',
  }),
  plugin_id: uuid('plugin_id').references(() => plugins.id, {
    onDelete: 'cascade',
  }),
  organization_id: uuid('organization_id').references(() => organizations.id),
  type: type('type').default('default').notNull(),
  scope: scope('scope').default('local').notNull(),
});

export const users = pgTable(
  'users',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    first_name: varchar('first_name'),
    last_name: varchar('last_name'),
    email: varchar('email'),
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

export const organization_users = pgTable(
  'organization_users',
  {
    id: uuid('id').defaultRandom().primaryKey().notNull(),
    organization_id: uuid('organization_id')
      .notNull()
      .references(() => organizations.id, { onDelete: 'cascade' }),
    user_id: uuid('user_id')
      .notNull()
      .references(() => users.id, { onDelete: 'cascade' }),
    role: varchar('role').notNull(),
    status: varchar('status').default('invited').notNull(),
    created_at: timestamp('created_at', { mode: 'string' }).defaultNow(),
    updated_at: timestamp('updated_at', { mode: 'string' }).defaultNow(),
    invitation_token: varchar('invitation_token'),
    source: source('source').default('invite').notNull(),
  },
  (table) => {
    return {
      user_organization_unique: unique('user_organization_unique').on(
        table.organization_id,
        table.user_id,
      ),
    };
  },
);
