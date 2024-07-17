import db from "../dbkit";

export const ByteDashService = {

  getRestaurantCustomers(restaurantId: number) {
    return db.query.users.findMany();
  },
}

export type ByteDashService = typeof ByteDashService;
