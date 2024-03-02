/**
 * 记录项类型
 */
export default class ItemCategory{
  /**
   * 类型id
   */
  id: number
  /**
   * 类型名称
   */
  name: ResourceStr

  constructor(id: number, name: ResourceStr) {
    this.id = id
    this.name = name
  }
}
