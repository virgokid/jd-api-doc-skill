# jd.union.open.goods.rank.query - 联盟实时热销榜商品接口

> 联盟实时热销榜商品接口，支持榜单Id和排序类型查询榜单商品列表
> 
> **数据来源**: joshome.jd.com (josCmsApiId: 21055)

## 接口信息

| 项目 | 说明 |
|------|------|
| 接口名称 | `jd.union.open.goods.rank.query` |
| 中文名称 | 联盟实时热销榜商品接口 |
| 接口地址 | `https://api.jd.com/routerjson` |
| 请求方式 | GET/POST（推荐POST） |
| 数据格式 | JSON |
| 版本 | 1.0 |

---

## 请求参数

> 以下字段按层级结构展示，`　└ ` 表示嵌套字段

| 字段名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| `appKey` | String | 否 | appKey |
| `RankGoodsReq` | com.jd.union.open.gateway.api.dto.goods.rank.RankGoodsReq | 是 | 请求入参 |
| 　└ `rankId` | Number | 是 | 榜单ID（200000：全部，200001：食品酒水，200002：家庭清洁，200003：个护美妆，200004：医药保健，200005：生鲜，200006：数码家电，200007：家居日用，200008：时尚生活） |
| 　└ `sortType` | Number | 是 | 排序类型（    1：2小时，2：高佣，3：24小时） |
| 　└ `pageIndex` | Number | 否 | 页码 |
| 　└ `pageSize` | Number | 否 | 每页数量，单页数最大20，默认10 |

---

## 响应参数

> 以下字段按层级结构展示，`　└ ` 表示嵌套字段

| 字段名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| `queryResult` | com.jd.union.RankGoodsQueryResult | 是 | 返回结果 |
| 　└ `code` | Number | 否 | 返回码 |
| 　└ `message` | String | 否 | 返回消息 |
| 　└ `data` | com.jd.union.RankGoodsResp[] | 否 | 数据明细 |
| 　　└ `rankGoodsResp` | com.jd.union.RankGoodsResp | 否 | 数据明细 |
| 　　　└ `itemId` | String | 否 | 联盟商品ID |
| 　　　└ `skuId` | Number | 否 | 商品skuId |
| 　　　└ `skuName` | String | 否 | 商品名称 |
| 　　　└ `imageUrl` | String | 否 | 商品主图 |
| 　　　└ `imgList` | String[] | 否 | 商品图片列表 |
| 　　　└ `wlprice` | Number | 否 | 基准价 |
| 　　　└ `commissionShare` | Number | 否 | 佣金比例 |
| 　　　└ `comments` | Number | 否 | 评论总数 |
| 　　　└ `goodComments` | Number | 否 | 好评数 |
| 　　　└ `goodCommentsShare` | Number | 否 | 好评率 |
| 　　　└ `skuTagList` | com.jd.union.SkuTagInfo[] | 否 | 联盟标签 |
| 　　　　└ `skuTagInfo` | com.jd.union.SkuTagInfo | 否 | 联盟标签明细 |
| 　　　　　└ `type` | Number | 否 | 标签类型 |
| 　　　　　└ `index` | Number | 否 | 优先级顺序（越小越优先） |
| 　　　　　└ `name` | String | 否 | 标签名称 |
| 　　　└ `purchasePriceInfo` | com.jd.union.RankPurchasePriceInfo | 否 | 到手价 |
| 　　　　└ `purchasePrice` | Number | 否 | 到手价 |
| 　　　　└ `promotionLabelInfoList` | com.jd.union.RankPromotionLabelInfo[] | 否 | 促销标签集 |
| 　　　　　└ `promotionLabelInfo` | com.jd.union.RankPromotionLabelInfo | 否 | 促销标签 |
| 　　　　　　└ `promotionLabelId` | String | 否 | 促销id |
| 　　　　　　└ `labelName` | String | 否 | 促销名称 |
| 　　　　└ `couponList` | com.jd.union.RankCoupon[] | 否 | 优惠券集合 |
| 　　　　　└ `coupon` | com.jd.union.RankCoupon | 否 | 优惠券明细 |
| 　　　　　　└ `link` | String | 否 | 券链接 |
| 　　　　　　└ `discount` | Number | 否 | 券面额 |
| 　　　　　　└ `quota` | Number | 否 | 券消费限额 |
| 　　　　　　└ `remainCnt` | Number | 否 | 券剩余数量 |
| 　　　　　　└ `couponStyle` | Number | 否 | 优惠券分类 0：满减券，3：满折券，28: 每满减券 |
| 　　　　　　└ `couponStatus` | Number | 否 | 领取状态。0： 正常可领， -1 ：不可领取， 1： 已领取 |
| 　　　　　　└ `timeCouponInfoList` | com.jd.union.TimeCouponInfo[] | 否 | 时段券信息集合 |
| 　　　　　　　└ `timeCouponInfo` | com.jd.union.TimeCouponInfo | 否 | 时段券信息 |
| 　　　　　　　　└ `timeCouponBegin` | String | 否 | 时段券领取开始时间 |
| 　　　　　　　　└ `timeCouponEnd` | String | 否 | 时段券领取结束时间 |
| 　└ `totalCount` | Number | 否 | 商品总数 |

---

*文档来源：京东联盟官方 (joshome.jd.com)*
*字段数量：请求 6 个，响应 39 个*
*更新时间：2026-04-22*
