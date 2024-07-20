import { ValidateIf } from 'class-validator';
/***
 * @description 定义了一个名为CanBeUndefined的装饰器，当被调用时返回validateIf的结果。
 * validateif是一个装饰器工厂函数，它可以将验证条件应用于属性。当属性值为undefined时，验证条件将被应用。
 * ValidateIf((data, value) => value !== undefined)：
 * 这里，ValidateIf装饰器接受一个函数，该函数接受两个参数：data和value。
 * data是当前对象的实例，而value是被装饰属性的值。
 * 这个函数返回一个布尔值，指示是否应该对该属性进行验证。
 * 在这个例子中，只有当属性值不是undefined时，才会进行验证。 *
 */

export function CanBeUndefined() {
  return ValidateIf((data, value) => value !== undefined);
}
