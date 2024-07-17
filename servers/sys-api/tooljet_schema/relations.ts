import { relations } from 'drizzle-orm/relations';
import {
  organizations,
  folders,
  apps,
  folder_apps,
  app_users,
  users,
  data_source_user_oauth2s,
  data_sources,
  user_group_permissions,
  group_permissions,
  comments,
  threads,
  app_versions,
  sso_configs,
  data_queries,
  files,
  plugins,
  org_environment_variables,
  comment_users,
  app_group_permissions,
  data_source_options,
  app_environments,
  internal_tables,
  user_sessions,
  organization_constants,
  org_environment_constant_values,
  event_handlers,
  pages,
  components,
  layouts,
  organization_users,
} from './schema';

export const foldersRelations = relations(folders, ({ one, many }) => ({
  organization: one(organizations, {
    fields: [folders.organization_id],
    references: [organizations.id],
  }),
  folder_apps: many(folder_apps),
}));

export const organizationsRelations = relations(organizations, ({ many }) => ({
  folders: many(folders),
  comments: many(comments),
  sso_configs: many(sso_configs),
  apps: many(apps),
  org_environment_variables: many(org_environment_variables),
  internal_tables: many(internal_tables),
  threads: many(threads),
  app_environments: many(app_environments),
  group_permissions: many(group_permissions),
  data_sources: many(data_sources),
  users: many(users),
  organization_users: many(organization_users),
}));

export const folder_appsRelations = relations(folder_apps, ({ one }) => ({
  app: one(apps, {
    fields: [folder_apps.app_id],
    references: [apps.id],
  }),
  folder: one(folders, {
    fields: [folder_apps.folder_id],
    references: [folders.id],
  }),
}));

export const appsRelations = relations(apps, ({ one, many }) => ({
  folder_apps: many(folder_apps),
  app_users: many(app_users),
  organization: one(organizations, {
    fields: [apps.organization_id],
    references: [organizations.id],
  }),
  app_group_permissions: many(app_group_permissions),
  threads: many(threads),
  app_versions: many(app_versions),
}));

export const app_usersRelations = relations(app_users, ({ one }) => ({
  app: one(apps, {
    fields: [app_users.app_id],
    references: [apps.id],
  }),
  user: one(users, {
    fields: [app_users.user_id],
    references: [users.id],
  }),
}));

export const usersRelations = relations(users, ({ one, many }) => ({
  app_users: many(app_users),
  data_source_user_oauth2s: many(data_source_user_oauth2s),
  user_group_permissions: many(user_group_permissions),
  comments: many(comments),
  comment_users: many(comment_users),
  threads: many(threads),
  user_sessions: many(user_sessions),
  organization: one(organizations, {
    fields: [users.organization_id],
    references: [organizations.id],
  }),
  organization_users: many(organization_users),
}));

export const data_source_user_oauth2sRelations = relations(
  data_source_user_oauth2s,
  ({ one }) => ({
    user: one(users, {
      fields: [data_source_user_oauth2s.user_id],
      references: [users.id],
    }),
    data_source: one(data_sources, {
      fields: [data_source_user_oauth2s.data_source_id],
      references: [data_sources.id],
    }),
  }),
);

export const data_sourcesRelations = relations(
  data_sources,
  ({ one, many }) => ({
    data_source_user_oauth2s: many(data_source_user_oauth2s),
    data_queries: many(data_queries),
    data_source_options: many(data_source_options),
    organization: one(organizations, {
      fields: [data_sources.organization_id],
      references: [organizations.id],
    }),
    plugin: one(plugins, {
      fields: [data_sources.plugin_id],
      references: [plugins.id],
    }),
    app_version: one(app_versions, {
      fields: [data_sources.app_version_id],
      references: [app_versions.id],
    }),
  }),
);

export const user_group_permissionsRelations = relations(
  user_group_permissions,
  ({ one }) => ({
    user: one(users, {
      fields: [user_group_permissions.user_id],
      references: [users.id],
    }),
    group_permission: one(group_permissions, {
      fields: [user_group_permissions.group_permission_id],
      references: [group_permissions.id],
    }),
  }),
);

export const group_permissionsRelations = relations(
  group_permissions,
  ({ one, many }) => ({
    user_group_permissions: many(user_group_permissions),
    app_group_permissions: many(app_group_permissions),
    organization: one(organizations, {
      fields: [group_permissions.organization_id],
      references: [organizations.id],
    }),
  }),
);

export const commentsRelations = relations(comments, ({ one, many }) => ({
  user: one(users, {
    fields: [comments.user_id],
    references: [users.id],
  }),
  thread: one(threads, {
    fields: [comments.thread_id],
    references: [threads.id],
  }),
  organization: one(organizations, {
    fields: [comments.organization_id],
    references: [organizations.id],
  }),
  app_version: one(app_versions, {
    fields: [comments.app_versions_id],
    references: [app_versions.id],
  }),
  comment_users: many(comment_users),
}));

export const threadsRelations = relations(threads, ({ one, many }) => ({
  comments: many(comments),
  user: one(users, {
    fields: [threads.user_id],
    references: [users.id],
  }),
  app: one(apps, {
    fields: [threads.app_id],
    references: [apps.id],
  }),
  organization: one(organizations, {
    fields: [threads.organization_id],
    references: [organizations.id],
  }),
  app_version: one(app_versions, {
    fields: [threads.app_versions_id],
    references: [app_versions.id],
  }),
}));

export const app_versionsRelations = relations(
  app_versions,
  ({ one, many }) => ({
    comments: many(comments),
    data_queries: many(data_queries),
    threads: many(threads),
    event_handlers: many(event_handlers),
    app: one(apps, {
      fields: [app_versions.app_id],
      references: [apps.id],
    }),
    app_environment: one(app_environments, {
      fields: [app_versions.current_environment_id],
      references: [app_environments.id],
    }),
    pages: many(pages),
    data_sources: many(data_sources),
  }),
);

export const sso_configsRelations = relations(sso_configs, ({ one }) => ({
  organization: one(organizations, {
    fields: [sso_configs.organization_id],
    references: [organizations.id],
  }),
}));

export const data_queriesRelations = relations(data_queries, ({ one }) => ({
  data_source: one(data_sources, {
    fields: [data_queries.data_source_id],
    references: [data_sources.id],
  }),
  app_version: one(app_versions, {
    fields: [data_queries.app_version_id],
    references: [app_versions.id],
  }),
}));

export const pluginsRelations = relations(plugins, ({ one, many }) => ({
  file_index_file_id: one(files, {
    fields: [plugins.index_file_id],
    references: [files.id],
    relationName: 'plugins_index_file_id_files_id',
  }),
  file_operations_file_id: one(files, {
    fields: [plugins.operations_file_id],
    references: [files.id],
    relationName: 'plugins_operations_file_id_files_id',
  }),
  file_icon_file_id: one(files, {
    fields: [plugins.icon_file_id],
    references: [files.id],
    relationName: 'plugins_icon_file_id_files_id',
  }),
  file_manifest_file_id: one(files, {
    fields: [plugins.manifest_file_id],
    references: [files.id],
    relationName: 'plugins_manifest_file_id_files_id',
  }),
  data_sources: many(data_sources),
}));

export const filesRelations = relations(files, ({ many }) => ({
  plugins_index_file_id: many(plugins, {
    relationName: 'plugins_index_file_id_files_id',
  }),
  plugins_operations_file_id: many(plugins, {
    relationName: 'plugins_operations_file_id_files_id',
  }),
  plugins_icon_file_id: many(plugins, {
    relationName: 'plugins_icon_file_id_files_id',
  }),
  plugins_manifest_file_id: many(plugins, {
    relationName: 'plugins_manifest_file_id_files_id',
  }),
}));

export const org_environment_variablesRelations = relations(
  org_environment_variables,
  ({ one }) => ({
    organization: one(organizations, {
      fields: [org_environment_variables.organization_id],
      references: [organizations.id],
    }),
  }),
);

export const comment_usersRelations = relations(comment_users, ({ one }) => ({
  user: one(users, {
    fields: [comment_users.user_id],
    references: [users.id],
  }),
  comment: one(comments, {
    fields: [comment_users.comment_id],
    references: [comments.id],
  }),
}));

export const app_group_permissionsRelations = relations(
  app_group_permissions,
  ({ one }) => ({
    app: one(apps, {
      fields: [app_group_permissions.app_id],
      references: [apps.id],
    }),
    group_permission: one(group_permissions, {
      fields: [app_group_permissions.group_permission_id],
      references: [group_permissions.id],
    }),
  }),
);

export const data_source_optionsRelations = relations(
  data_source_options,
  ({ one }) => ({
    data_source: one(data_sources, {
      fields: [data_source_options.data_source_id],
      references: [data_sources.id],
    }),
    app_environment: one(app_environments, {
      fields: [data_source_options.environment_id],
      references: [app_environments.id],
    }),
  }),
);

export const app_environmentsRelations = relations(
  app_environments,
  ({ one, many }) => ({
    data_source_options: many(data_source_options),
    organization: one(organizations, {
      fields: [app_environments.organization_id],
      references: [organizations.id],
    }),
    org_environment_constant_values: many(org_environment_constant_values),
    app_versions: many(app_versions),
  }),
);

export const internal_tablesRelations = relations(
  internal_tables,
  ({ one }) => ({
    organization: one(organizations, {
      fields: [internal_tables.organization_id],
      references: [organizations.id],
    }),
  }),
);

export const user_sessionsRelations = relations(user_sessions, ({ one }) => ({
  user: one(users, {
    fields: [user_sessions.user_id],
    references: [users.id],
  }),
}));

export const org_environment_constant_valuesRelations = relations(
  org_environment_constant_values,
  ({ one }) => ({
    organization_constant: one(organization_constants, {
      fields: [org_environment_constant_values.organization_constant_id],
      references: [organization_constants.id],
    }),
    app_environment: one(app_environments, {
      fields: [org_environment_constant_values.environment_id],
      references: [app_environments.id],
    }),
  }),
);

export const organization_constantsRelations = relations(
  organization_constants,
  ({ many }) => ({
    org_environment_constant_values: many(org_environment_constant_values),
  }),
);

export const event_handlersRelations = relations(event_handlers, ({ one }) => ({
  app_version: one(app_versions, {
    fields: [event_handlers.app_version_id],
    references: [app_versions.id],
  }),
}));

export const componentsRelations = relations(components, ({ one, many }) => ({
  page: one(pages, {
    fields: [components.page_id],
    references: [pages.id],
  }),
  layouts: many(layouts),
}));

export const pagesRelations = relations(pages, ({ one, many }) => ({
  components: many(components),
  app_version: one(app_versions, {
    fields: [pages.app_version_id],
    references: [app_versions.id],
  }),
}));

export const layoutsRelations = relations(layouts, ({ one }) => ({
  component: one(components, {
    fields: [layouts.component_id],
    references: [components.id],
  }),
}));

export const organization_usersRelations = relations(
  organization_users,
  ({ one }) => ({
    organization: one(organizations, {
      fields: [organization_users.organization_id],
      references: [organizations.id],
    }),
    user: one(users, {
      fields: [organization_users.user_id],
      references: [users.id],
    }),
  }),
);
