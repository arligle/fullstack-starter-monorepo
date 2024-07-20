import { Organization } from '@/core/drizzle/schema/organizations.schema'
export class OrganizationBase implements Organization {
  id: string;
  name: string;
  domain: string;
  created_at: string;
  updated_at: string;
  enable_sign_up: boolean;
  inherit_sso: boolean;
  slug: string;

}
