# 京东联盟 API 列表

> 数据来源: joshome.jd.com (京东联盟官方文档)
> 更新时间: 2026-04-22
> 接口总数: 87

---

## 核心接口（常用）

| API 名称 | josCmsApiId | 用途 |
|----------|-------------|------|
| jd.union.open.goods.query | 15153 | 关键词商品查询 |
| jd.union.open.goods.jingfen.query | 15165 | 京粉精选商品 |
| jd.union.open.goods.rank.query | 21055 | 实时热销榜 |
| jd.union.open.goods.promotiongoodsinfo.query | 15155 | 商品详情查询 |
| jd.union.open.promotion.bysubunionid.get | 15157 | 转链接口（支持subunionid） |
| jd.union.open.promotion.common.get | 15154 | 通用转链接口 |
| jd.union.open.order.row.query | 16108 | 订单行查询 |
| jd.union.open.order.query | 15126 | 订单查询（即将下线） |
| jd.union.open.coupon.gift.get | 15850 | 礼金创建 |

---

## 分类索引

### 商品查询类
- goods.query (15153) - 关键词商品查询
- goods.jingfen.query (15165) - 京粉精选
- goods.rank.query (21055) - 实时热销榜
- goods.promotiongoodsinfo.query (15155) - 商品详情
- goods.bigfield.query (15429) - 商品大字段
- goods.material.query (16713) - 个性化推荐
- goods.combination.query (19209) - 凑单商品
- goods.snapshop.query (20010) - 拍照购选品
- goods.hotspot.query (22075) - 热点商品

### 推广链接类
- promotion.bysubunionid.get (15157) - 转链（支持subunionid）
- promotion.common.get (15154) - 通用转链
- promotion.byunionid.get (15158) - 工具商转链
- promotion.applet.get (15677) - 小程序转链

### 订单查询类
- order.row.query (16108) - 订单行查询（推荐）
- order.query (15126) - 订单查询（即将下线）
- order.bonus.query (15627) - 奖励订单查询

### 优惠券/礼金类
- coupon.query (15156) - 优惠券查询
- coupon.gift.get (15850) - 礼金创建
- coupon.gift.stop (15824) - 礼金停止

### 推广位/PID管理类
- position.query (15160) - 推广位查询
- position.create (18490) - 推广位创建
- user.pid.get (15162) - PID获取

---

*本文档由 jd-api-doc-skill 自动生成*
