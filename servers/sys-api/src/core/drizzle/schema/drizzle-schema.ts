import users from './users.schema';
import organizations from './organizations.schema';
import articles from './articles.schema';

export const drizzleSchema = {
  users,
  organizations,
  articles,
};
export * from './enum';