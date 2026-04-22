# jd.union.open.goods.query - 关键词商品查询接口【申请】

> 查询商品及优惠券信息，返回的结果可调用转链接口生成单品或二合一推广链接。支持按SKUID、关键词、优惠券基本属性、是否拼购、是否爆款等条件查询，建议不要同时传入SKUID和其他字段，以获得较多的结果。支持按价格、佣金比例、佣金、引单量等维度排序。用优惠券链接调用转链接口时，需传入搜索接口link字段返回的原始优惠券链接，切勿对链接进行任何encode、decode操作，否则将导致转链二合一推广链接
> 
> **数据来源**: joshome.jd.com (josCmsApiId: 15153)

## 接口信息

| 项目 | 说明 |
|------|------|
| 接口名称 | `jd.union.open.goods.query` |
| 中文名称 | 关键词商品查询接口【申请】 |
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
| `goodsReqDTO` | com.jd.union.open.gateway.api.dto.goods.base.GoodsReq | 是 | 请求入参 |
| 　└ `cid1` | Number | 否 | 一级类目id |
| 　└ `cid2` | Number | 否 | 二级类目id |
| 　└ `cid3` | Number | 否 | 三级类目id |
| 　└ `pageIndex` | Number | 否 | 页码 |
| 　└ `pageSize` | Number | 否 | 每页数量，单页数最大30，默认20 |
| 　└ `skuIds` | Number[] | 否 | skuid集合(一次最多支持查询20个sku)，数组类型开发时记得加[];仅sceneId=2时支持入参 |
| 　└ `keyword` | String | 否 | 关键词，字数同京东商品名称一致，目前未限制字数个数；支持cps长链接查询（https://union-click.jd.com）；支持cps短链接查询（https://u.jd.com）;sceneId=2时支持入参京东主站商品ID、京东商品链接（包含3.cn单品链接）。其他场景仅支持入参关键词、联盟商品ID、联盟商品链接 |
| 　└ `pricefrom` | Number | 否 | 商品券后价格下限 |
| 　└ `priceto` | Number | 否 | 商品券后价格上限 |
| 　└ `commissionShareStart` | Number | 否 | 佣金比例区间开始 |
| 　└ `commissionShareEnd` | Number | 否 | 佣金比例区间结束 |
| 　└ `owner` | String | 否 | 商品类型：自营[g]，POP[p] |
| 　└ `sortName` | String | 否 | 排序字段(price：单价, commissionShare：佣金比例, commission：佣金， inOrderCount30Days：30天引单量， inOrderComm30Days：30天支出佣金) |
| 　└ `sort` | String | 否 | asc,desc升降序,默认降序 |
| 　└ `isCoupon` | Number | 否 | 是否是优惠券商品，1：有优惠券 |
| 　└ `isPG` | Number | 否 | 是否是拼购商品，1：拼购商品 |
| 　└ `pingouPriceStart` | Number | 否 | 拼购价格区间开始 |
| 　└ `pingouPriceEnd` | Number | 否 | 拼购价格区间结束 |
| 　└ `isHot` | Number | 否 | 已废弃，请勿使用 |
| 　└ `brandCode` | String | 否 | 品牌code |
| 　└ `shopId` | Number | 否 | 店铺Id |
| 　└ `hasContent` | Number | 否 | 1：查询内容商品；其他值过滤掉此入参条件。 |
| 　└ `hasBestCoupon` | Number | 否 | 1：查询有最优惠券商品；其他值过滤掉此入参条件。（查询最优券需与isCoupon同时使用） |
| 　└ `pid` | String | 否 | 联盟id_应用iD_推广位id |
| 　└ `fields` | String | 否 | 支持出参数据筛选，逗号','分隔，目前可用：videoInfo(视频信息),hotWords(热词),similar(相似推荐商品),documentInfo(段子信息，智能文案),skuLabelInfo（商品标签）,promotionLabelInfo（商品促销标签）,stockState（商品库存）,companyType（小店标识），freeShippingInfo（是否包邮），seckillSpecialPriceInfo（秒杀专享价） |
| 　└ `forbidTypes` | String | 否 | 10微信京东购物小程序禁售，11微信京喜小程序禁售 |
| 　└ `jxFlags` | Number[] | 否 | 京喜商品类型，1京喜、2京喜工厂直供、3京喜优选，入参多个值表示或条件查询 |
| 　└ `shopLevelFrom` | Number | 否 | 支持传入0.0、2.5、3.0、3.5、4.0、4.5、4.9，默认为空表示不筛选评分 |
| 　└ `isbn` | String | 否 | 图书编号 |
| 　└ `spuId` | Number | 否 | 主商品spuId |
| 　└ `couponUrl` | String | 否 | 优惠券链接 |
| 　└ `deliveryType` | Number | 否 | 京东配送 1：是，0：不是 |
| 　└ `eliteType` | Number[] | 否 | 资源位17：极速版商品，22：百亿补贴，23：便宜包邮，38:学生价商品 |
| 　└ `isSeckill` | Number | 否 | 是否秒杀商品。1：是 |
| 　└ `isPresale` | Number | 否 | 是否预售商品。1：是 |
| 　└ `isReserve` | Number | 否 | 是否预约商品。1:是 |
| 　└ `bonusId` | Number | 否 | 奖励活动ID |
| 　└ `area` | String | 否 | 区域地址（查区域价格） |
| 　└ `isOversea` | Number | 否 | 是否全球购商品 1：是 |
| 　└ `userIdType` | Number | 否 | 用户ID类型，传入此参数可获得个性化推荐结果。当前userIdType支持的枚举值包括：8、16、32、64、128、32768。userIdType和userId需同时传入，且一一对应。userIdType各枚举值对应的userId含义如下：8(安卓移动设备Imei); 16(苹果移动设备Openudid)；32(苹果移动设备idfa); 64(安卓移动设备imei的md5编码，32位，大写，匹配率略低);128(苹果移动设备idfa的md5编码，32位，大写，匹配率略低); 32768(安卓移动设备oaid); 131072(安卓移动设备oaid的md5编码，32位，大写) |
| 　└ `userId` | String | 否 | userIdType对应的用户设备ID，传入此参数可获得个性化推荐结果，userIdType和userId需同时传入 |
| 　└ `channelId` | Number | 否 | 渠道关系ID |
| 　└ `ip` | String | 否 | 客户端ip |
| 　└ `provinceId` | Number | 否 | 省Id |
| 　└ `cityId` | Number | 否 | 市Id |
| 　└ `countryId` | Number | 否 | 县Id |
| 　└ `townId` | Number | 否 | 镇Id |
| 　└ `itemIds` | String[] | 否 | 联盟商品ID集合(一次最多支持查询20个itemId)，为字符串数组类型，开发时记得加[]；仅sceneId=1时支持入参 |
| 　└ `sceneId` | Number | 是 | 场景ID，支持入参1,2；2需要权限申请 |
| 　└ `pin` | String | 否 | 授权用户pin |
| 　└ `searchPosition` | String | 否 | 查询索引位，首次入参传入空字符串，再次入参传入响应参数searchPosition；仅支持查询eliteType=22,23；pageSize最大20；需向cps-qxsq@jd.com申请权限 |
| 　└ `cPin` | String | 否 | 授权用户唯一标识，请使用xid作为用户标识信息，传入xid_buyer参数中。 |
| 　└ `open_id_buyer` | String | 否 | 授权用户唯一标识，请使用xid作为用户标识信息，传入xid_buyer参数中。 |
| 　└ `xid_buyer` | String | 否 | 授权用户唯一标识，请使用xid作为用户标识信息，传入xid_buyer参数中。 |

---

## 响应参数

> 以下字段按层级结构展示，`　└ ` 表示嵌套字段

| 字段名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| `queryResult` | com.jd.union.GoodsQueryResult | 否 | 返回结果 |
| 　└ `code` | Number | 是 | 返回码 |
| 　└ `message` | String | 是 | 返回消息 |
| 　└ `data` | com.jd.union.GoodsResp[] | 是 | 数据明细 |
| 　　└ `goodsResp` | com.jd.union.GoodsResp | 是 | 数据明细 |
| 　　　└ `categoryInfo` | com.jd.union.CategoryInfo | 是 | 类目信息 |
| 　　　　└ `cid1` | Number | 是 | 一级类目ID |
| 　　　　└ `cid1Name` | String | 是 | 一级类目名称 |
| 　　　　└ `cid2` | Number | 是 | 二级类目ID |
| 　　　　└ `cid2Name` | String | 是 | 二级类目名称 |
| 　　　　└ `cid3` | Number | 是 | 三级类目ID |
| 　　　　└ `cid3Name` | String | 是 | 三级类目名称 |
| 　　　└ `comments` | Number | 是 | 评论数 |
| 　　　└ `commissionInfo` | com.jd.union.CommissionInfo | 是 | 佣金信息 |
| 　　　　└ `commission` | Number | 是 | 佣金 |
| 　　　　└ `commissionShare` | Number | 是 | 佣金比例 |
| 　　　　└ `couponCommission` | Number | 否 | 券后佣金，（促销价-优惠券面额）*佣金比例 |
| 　　　　└ `plusCommissionShare` | Number | 否 | plus佣金比例，plus用户购买推广者能获取到的佣金比例 |
| 　　　　└ `isLock` | Number | 否 | 是否锁定佣金比例：1是，0否 |
| 　　　　└ `startTime` | Number | 否 | 计划开始时间（时间戳，毫秒） |
| 　　　　└ `endTime` | Number | 否 | 计划结束时间（时间戳，毫秒） |
| 　　　　└ `lhCommissionStockMax` | Number | 否 | 限量高佣总库存 |
| 　　　　└ `lhCommissionStockRemaining` | Number | 否 | 限量高佣剩余库存 |
| 　　　└ `couponInfo` | com.jd.union.CouponInfo | 是 | 优惠券信息，返回内容为空说明该SKU无可用优惠券 |
| 　　　　└ `couponList` | com.jd.union.Coupon[] | 是 | 优惠券集合 |
| 　　　　　└ `coupon` | com.jd.union.Coupon | 是 | 优惠券明细 |
| 　　　　　　└ `bindType` | Number | 是 | 券种类 (优惠券种类：0 - 全品类，1 - 限品类（自营商品），2 - 限店铺，3 - 店铺限商品券) |
| 　　　　　　└ `discount` | Number | 是 | 券面额 |
| 　　　　　　└ `link` | String | 是 | 券链接 |
| 　　　　　　└ `platformType` | Number | 是 | 券使用平台 (平台类型：0 - 全平台券，1 - 限平台券) |
| 　　　　　　└ `quota` | Number | 是 | 券消费限额 |
| 　　　　　　└ `getStartTime` | Number | 是 | 领取开始时间(时间戳，毫秒) |
| 　　　　　　└ `getEndTime` | Number | 是 | 券领取结束时间(时间戳，毫秒) |
| 　　　　　　└ `useStartTime` | Number | 是 | 券有效使用开始时间(时间戳，毫秒) |
| 　　　　　　└ `useEndTime` | Number | 是 | 券有效使用结束时间(时间戳，毫秒) |
| 　　　　　　└ `isBest` | Number | 是 | 最优优惠券，1：是；0：否，购买一件商品可使用的面额最大优惠券 |
| 　　　　　　└ `hotValue` | Number | 是 | 券热度，值越大热度越高，区间:[0,10] |
| 　　　　　　└ `isInputCoupon` | Number | 否 | 入参couponUrl优惠券链接搜索对应的券，1 是 ，0 否 |
| 　　　　　　└ `couponStyle` | Number | 否 | 优惠券分类 0：满减券，3：满折券，28: 每满减券 |
| 　　　　　　└ `couponStatus` | Number | 否 | 领取状态。0： 正常可领， -1 ：不可领取， 1： 已领取 |
| 　　　　　　└ `timeCouponInfoList` | com.jd.union.TimeCouponInfo[] | 否 | 时段券信息集合 |
| 　　　　　　　└ `timeCouponInfo` | com.jd.union.TimeCouponInfo | 否 | 时段券信息 |
| 　　　　　　　　└ `timeCouponBegin` | String | 否 | 时段券领取开始时间 |
| 　　　　　　　　└ `timeCouponEnd` | String | 否 | 时段券领取结束时间 |
| 　　　└ `goodCommentsShare` | Number | 是 | 商品好评率 |
| 　　　└ `imageInfo` | com.jd.union.ImageInfo | 是 | 图片信息 |
| 　　　　└ `imageList` | com.jd.union.UrlInfo[] | 是 | 图片合集 |
| 　　　　　└ `urlInfo` | com.jd.union.UrlInfo | 是 | 图片合集 |
| 　　　　　　└ `url` | String | 是 | 图片链接地址，第一个图片链接为主图链接,修改图片尺寸拼接方法：/s***x***_jfs/，例如：http://img14.360buyimg.com/ads/s300x300_jfs/t22495/56/628456568/380476/9befc935/5b39fb01N7d1af390.jpg |
| 　　　　└ `whiteImage` | String | 否 | 白底图 |
| 　　　└ `inOrderCount30Days` | Number | 是 | 30天引单数量 |
| 　　　└ `isJdSale` | Number | 是 | 已废弃，请用owner |
| 　　　└ `materialUrl` | String | 是 | 商品落地页，当入参场景2且有对应场景权限时，返回京东商品链接，materialUrl拼接为：item.jd.com/{skuId}.html；其他返回联盟商品链接，materialUrl拼接为：jingfen.jd.com/detail/{itemId}.html |
| 　　　└ `priceInfo` | com.jd.union.PriceInfo | 是 | 价格信息 |
| 　　　　└ `price` | Number | 是 | 商品价格 |
| 　　　　└ `lowestPrice` | Number | 否 | 促销价 |
| 　　　　└ `lowestPriceType` | Number | 否 | 促销价类型，1：商品价格；2：拼购价格； 3：秒杀价格； 4：预售价格 |
| 　　　　└ `lowestCouponPrice` | Number | 否 | 券后价（有无券都返回此字段，价格排序以此字段排序） |
| 　　　　└ `historyPriceDay` | Number | 否 | 历史最低价天数（例：当前券后价最近180天最低） |
| 　　　└ `shopInfo` | com.jd.union.ShopInfo | 是 | 店铺信息 |
| 　　　　└ `shopName` | String | 是 | 店铺名称（或供应商名称） |
| 　　　　└ `shopId` | Number | 是 | 商家Id |
| 　　　　└ `shopLevel` | Number | 否 | 店铺等级 |
| 　　　　└ `shopLabel` | String | 否 | 1：京东好店  https://img12.360buyimg.com/schoolbt/jfs/t1/80828/19/2993/908/5d14277aEbb134d76/889d5265315e11ed.png |
| 　　　　└ `userEvaluateScore` | String | 否 | 用户评价评分（仅pop店铺有值） |
| 　　　　└ `commentFactorScoreRankGrade` | String | 否 | 用户评价评级（仅pop店铺有值） |
| 　　　　└ `logisticsLvyueScore` | String | 否 | 物流履约评分（仅pop店铺有值） |
| 　　　　└ `logisticsFactorScoreRankGrade` | String | 否 | 物流履约评级（仅pop店铺有值） |
| 　　　　└ `afterServiceScore` | String | 否 | 售后服务评分（仅pop店铺有值） |
| 　　　　└ `afsFactorScoreRankGrade` | String | 否 | 售后服务评级（仅pop店铺有值） |
| 　　　　└ `scoreRankRate` | String | 否 | 店铺风向标（仅pop店铺有值） |
| 　　　└ `skuId` | Number | 是 | 商品ID |
| 　　　└ `skuName` | String | 是 | 商品名称 |
| 　　　└ `isHot` | Number | 是 | 已废弃，请勿使用 |
| 　　　└ `spuid` | Number | 是 | spuid，其值为同款商品的主skuid |
| 　　　└ `brandCode` | String | 是 | 品牌code |
| 　　　└ `brandName` | String | 是 | 品牌名 |
| 　　　└ `owner` | String | 是 | g=自营，p=pop |
| 　　　└ `pinGouInfo` | com.jd.union.PinGouInfo | 是 | 拼购信息 |
| 　　　　└ `pingouPrice` | Number | 是 | 拼购价格 |
| 　　　　└ `pingouTmCount` | Number | 是 | 拼购成团所需人数 |
| 　　　　└ `pingouUrl` | String | 是 | 拼购落地页url |
| 　　　　└ `pingouStartTime` | Number | 是 | 拼购开始时间(时间戳，毫秒) |
| 　　　　└ `pingouEndTime` | Number | 是 | 拼购结束时间(时间戳，毫秒) |
| 　　　└ `videoInfo` | com.jd.union.VideoInfo | 是 | 视频信息 |
| 　　　　└ `videoList` | com.jd.union.Video[] | 否 | 视频集合 |
| 　　　　　└ `video` | com.jd.union.Video | 否 | 视频明细 |
| 　　　　　　└ `width` | Number | 是 | 宽 |
| 　　　　　　└ `high` | Number | 是 | 高 |
| 　　　　　　└ `imageUrl` | String | 是 | 视频图片地址 |
| 　　　　　　└ `videoType` | Number | 是 | 1:主图，2：商详 |
| 　　　　　　└ `playUrl` | String | 是 | 播放地址 |
| 　　　　　　└ `playType` | String | 是 | low：标清，high：高清 |
| 　　　　　　└ `duration` | Number | 否 | 时长(单位:s) |
| 　　　└ `commentInfo` | com.jd.union.CommentInfo | 否 | 评价信息 |
| 　　　　└ `commentList` | com.jd.union.Comment[] | 是 | 评价集合 |
| 　　　　　└ `comment` | com.jd.union.Comment | 是 | 评价列表 |
| 　　　　　　└ `content` | String | 是 | 评价内容 |
| 　　　　　　└ `imageList` | com.jd.union.UrlInfo[] | 是 | 图片集合【废弃】 |
| 　　　　　　　└ `urlInfo` | com.jd.union.UrlInfo | 是 | 图片集合【废弃】 |
| 　　　　　　　　└ `url` | String | 是 | 图片链接地址【废弃】 |
| 　　　└ `jxFlags` | Number[] | 否 | 京喜商品类型，1京喜、2京喜工厂直供、3京喜优选（包含3时可在京东APP购买） |
| 　　　└ `documentInfo` | com.jd.union.DocumentInfo | 否 | 商品段子信息，emoji表情等 |
| 　　　　└ `document` | String | 是 | 描述文案 |
| 　　　　└ `discount` | String | 否 | 优惠力度文案 |
| 　　　└ `bookInfo` | com.jd.union.BookInfo | 否 | 图书信息 |
| 　　　　└ `isbn` | String | 否 | 图书编号 |
| 　　　　└ `publisherName` | String | 否 | 出版商名称 |
| 　　　　└ `authorName` | String | 否 | 作者名称 |
| 　　　　└ `bookDesc` | String | 否 | 内容摘要 |
| 　　　　└ `bookName` | String | 否 | 图书中文名称 |
| 　　　　└ `foreignBookName` | String | 否 | 图书英文名称 |
| 　　　└ `specInfo` | com.jd.union.SpecInfo | 否 | 扩展信息 |
| 　　　　└ `size` | String | 否 | 尺寸 |
| 　　　　└ `color` | String | 否 | 颜色 |
| 　　　　└ `spec` | String | 否 | 自定义属性 |
| 　　　　└ `specName` | String | 否 | 自定义属性名称 |
| 　　　　└ `isFreeShipping` | Number | 否 | 是否包邮(1:是,0:否,2:自营商品遵从主站包邮规则) |
| 　　　└ `stockState` | Number | 否 | 库存状态：1有货、0无货（供tob选品场景参考，toc场景不适用） |
| 　　　└ `eliteType` | Number[] | 否 | 资源位17：极速版商品 |
| 　　　└ `forbidTypes` | Number[] | 否 | 0普通商品，10微信京东购物小程序禁售，11微信京喜小程序禁售 |
| 　　　└ `deliveryType` | Number | 否 | 京东配送 1：是，0：不是 |
| 　　　└ `skuLabelInfo` | com.jd.union.SkuLabelInfo | 否 | 商品标签 |
| 　　　　└ `is7ToReturn` | Number | 否 | 0：不支持；  1或null：支持7天无理由退货；  2：支持90天无理由退货；  4：支持15天无理由退货；  6：支持30天无理由退货； |
| 　　　　└ `fxg` | Number | 否 | 1：放心购商品 |
| 　　　　└ `fxgServiceList` | com.jd.kpl.CharacteristicServiceInfo[] | 否 | 放心购商品子标签集合 |
| 　　　　　└ `characteristicServiceInfo` | com.jd.kpl.CharacteristicServiceInfo | 否 | 放心购商品子标签，此字段值可能为空 |
| 　　　　　　└ `serviceName` | String | 否 | 服务名称 |
| 　　　└ `promotionLabelInfoList` | com.jd.union.PromotionLabelInfo[] | 否 | 商品促销标签集 |
| 　　　　└ `promotionLabelInfo` | com.jd.union.PromotionLabelInfo | 否 | 商品促销标签 |
| 　　　　　└ `promotionLabel` | String | 否 | 商品促销文案 |
| 　　　　　└ `lableName` | String | 否 | 促销标签名称【废弃】 |
| 　　　　　└ `startTime` | Number | 否 | 促销开始时间 |
| 　　　　　└ `endTime` | Number | 否 | 促销结束时间 |
| 　　　　　└ `promotionLableId` | Number | 否 | 促销ID【废弃】 |
| 　　　　　└ `labelName` | String | 否 | 促销标签名称 |
| 　　　　　└ `promotionLabelId` | Number | 否 | 促销ID |
| 　　　　　└ `provinceNameList` | String[] | 否 | 促销生效区域（国补）--省中文名 |
| 　　　　　└ `subType` | Number | 否 | 促销类型（国补），9105：以旧换新国补，9107：购新立减国补，9100： 支付立减 |
| 　　　　　└ `rebate` | Number | 否 | 促销优惠比例（国补），0到1之间的小数 |
| 　　　　　└ `topDiscount` | Number | 否 | 最大优惠金额（国补） |
| 　　　└ `secondPriceInfoList` | com.jd.union.SecondPriceInfo[] | 否 | 双价格 |
| 　　　　└ `secondPriceInfo` | com.jd.union.SecondPriceInfo | 否 | 双价格信息 |
| 　　　　　└ `secondPriceType` | Number | 否 | 双价格类型：2:plus会员价格，9:学生价，18:新人价 |
| 　　　　　└ `secondPrice` | Number | 否 | 价格 |
| 　　　└ `seckillInfo` | com.jd.union.SeckillInfo | 否 | 秒杀信息 |
| 　　　　└ `seckillOriPrice` | Number | 否 | 秒杀价原价 |
| 　　　　└ `seckillPrice` | Number | 否 | 秒杀价 |
| 　　　　└ `seckillStartTime` | Number | 否 | 秒杀开始时间(时间戳，毫秒) |
| 　　　　└ `seckillEndTime` | Number | 否 | 秒杀结束时间(时间戳，毫秒) |
| 　　　└ `preSaleInfo` | com.jd.union.PreSaleInfo | 否 | 预售信息 |
| 　　　　└ `currentPrice` | Number | 否 | 预售价格 |
| 　　　　└ `earnest` | Number | 否 | 订金金额（定金不能超过预售总价的20%） |
| 　　　　└ `preSalePayType` | Number | 否 | 预售支付类型：1.仅全款 2.定金、全款均可 5.一阶梯仅定金 |
| 　　　　└ `discountType` | Number | 否 | 1: 定金膨胀  2: 定金立减 |
| 　　　　└ `depositWorth` | Number | 否 | 定金膨胀金额（定金可抵XXX）【废弃】 |
| 　　　　└ `preAmountDeposit` | Number | 否 | 立减金额 |
| 　　　　└ `preSaleStartTime` | Number | 否 | 定金开始时间 |
| 　　　　└ `preSaleEndTime` | Number | 否 | 定金结束时间 |
| 　　　　└ `balanceStartTime` | Number | 否 | 尾款开始时间 |
| 　　　　└ `balanceEndTime` | Number | 否 | 尾款结束时间 |
| 　　　　└ `shipTime` | Number | 否 | 预计发货时间 |
| 　　　　└ `preSaleStatus` | Number | 否 | 预售状态（0 未开始；1 预售中；2 预售结束；3 尾款进行中；4 尾款结束） |
| 　　　　└ `amountDeposit` | Number | 否 | 定金膨胀金额（定金可抵XXX） |
| 　　　└ `reserveInfo` | com.jd.union.ReserveInfo | 否 | 预约信息 |
| 　　　　└ `price` | Number | 否 | 预约价格 |
| 　　　　└ `type` | Number | 否 | 预约类型：  1：预约购买资格（仅预约的用户才可以进行购买）；  5：预约抽签（仅中签用户可购买） |
| 　　　　└ `status` | Number | 否 | 1：等待预约  2：预约中  3：等待抢购/抽签中  4：抢购中  5：抢购结束 |
| 　　　　└ `startTime` | Number | 否 | 预定开始时间 |
| 　　　　└ `endTime` | Number | 否 | 预定结束时间 |
| 　　　　└ `panicBuyingStartTime` | Number | 否 | 抢购开始时间 |
| 　　　　└ `panicBuyingEndTime` | Number | 否 | 抢购结束时间 |
| 　　　└ `isOversea` | Number | 否 | 是否全球购商品 1：是 |
| 　　　└ `companyType` | Number | 否 | 2：POP自然人小店 |
| 　　　└ `purchasePriceInfo` | com.jd.union.PurchasePriceInfo | 否 | 到手价明细 |
| 　　　　└ `code` | Number | 否 | 返回码 |
| 　　　　└ `message` | String | 否 | 返回消息 |
| 　　　　└ `purchasePrice` | Number | 否 | 到手价 |
| 　　　　└ `thresholdPrice` | Number | 否 | 门槛价金额，计算到手价的基准价 |
| 　　　　└ `basisPriceType` | Number | 否 | 依据的价格类型，1、京东价 ,2 Plus价，7 粉丝价，8 新人价，9学生价，10 陪伴计划价（双价格新增） |
| 　　　　└ `promotionLabelInfoList` | com.jd.union.PromotionLabelInfo[] | 否 | 商品促销标签集 |
| 　　　　　└ `promotionLabelInfo` | com.jd.union.PromotionLabelInfo | 否 | 商品促销标签 |
| 　　　　　　└ `promotionLabel` | String | 否 | 商品促销文案 |
| 　　　　　　└ `startTime` | Number | 否 | 促销开始时间 |
| 　　　　　　└ `endTime` | Number | 否 | 促销结束时间 |
| 　　　　　　└ `promotionLabelId` | Number | 否 | 促销ID |
| 　　　　　　└ `labelName` | String | 否 | 促销标签名称 |
| 　　　　　　└ `provinceNameList` | String[] | 否 | 该字段为预留字段，尚未启用，请勿使用 |
| 　　　　　　└ `subType` | Number | 否 | 该字段为预留字段，尚未启用，请勿使用 |
| 　　　　　　└ `rebate` | Number | 否 | 该字段为预留字段，尚未启用，请勿使用 |
| 　　　　　　└ `topDiscount` | Number | 否 | 该字段为预留字段，尚未启用，请勿使用 |
| 　　　　└ `couponList` | com.jd.union.Coupon[] | 否 | 优惠券集合 |
| 　　　　　└ `coupon` | com.jd.union.Coupon | 否 | 优惠券明细 |
| 　　　　　　└ `bindType` | Number | 否 | 券种类 (优惠券种类：0 - 全品类，1 - 限品类（自营商品），2 - 限店铺，3 - 店铺限商品券) |
| 　　　　　　└ `discount` | Number | 否 | 券面额 |
| 　　　　　　└ `link` | String | 否 | 券链接 |
| 　　　　　　└ `platformType` | Number | 否 | 券使用平台 (平台类型：0 - 全平台券，1 - 限平台券) |
| 　　　　　　└ `quota` | Number | 否 | 券消费限额 |
| 　　　　　　└ `couponStyle` | Number | 否 | 优惠券分类 0：满减券，3：满折券，28: 每满减券 |
| 　　　　　　└ `couponStatus` | Number | 否 | 领取状态。0： 正常可领， -1 ：不可领取， 1： 已领取 |
| 　　　　　　└ `timeCouponInfoList` | com.jd.union.TimeCouponInfo[] | 否 | 时段券信息集合 |
| 　　　　　　　└ `timeCouponInfo` | com.jd.union.TimeCouponInfo | 否 | 时段券信息 |
| 　　　　　　　　└ `timeCouponBegin` | String | 否 | 时段券领取开始时间 |
| 　　　　　　　　└ `timeCouponEnd` | String | 否 | 时段券领取结束时间 |
| 　　　└ `itemId` | String | 否 | 联盟商品ID |
| 　　　└ `activityCardInfo` | com.jd.union.ActivityCardInfo | 否 | 超市购物卡明细 |
| 　　　　└ `amount` | Number | 否 | 超市卡金额 |
| 　　　　└ `activityType` | Number | 否 | 活动类型，购物返卡：3 |
| 　　　　└ `expireDay` | Number | 否 | 超市卡有效天数 |
| 　　　└ `smartDocumentInfoList` | com.jd.union.SmartDocumentInfo[] | 否 | GPT算法智能生成的推广文案集合,内含多个风格 |
| 　　　　└ `smartDocumentInfo` | com.jd.union.SmartDocumentInfo | 否 | 智能文案明细 |
| 　　　　　└ `documentType` | Number | 否 | 智能文案类型，1：最优推荐，2：知乎风格， 3：小红书风格， 4：社群风格 |
| 　　　　　└ `documentName` | String | 否 | 文案名称 |
| 　　　　　└ `document` | String | 否 | 智能文案内容 |
| 　　　└ `kaAdowner` | Number | 否 | 是否星选商家商品。1：是 |
| 　　　└ `oriItemId` | String | 否 | 原始入参ItemId |
| 　　　└ `callerItemId` | String | 否 | 工具商联盟商品ID |
| 　　　└ `skuTagList` | com.jd.union.SkuTagInfo[] | 否 | 联盟标签 |
| 　　　　└ `skuTagInfo` | com.jd.union.SkuTagInfo | 否 | 联盟标签明细 |
| 　　　　　└ `type` | Number | 否 | 标签类型 |
| 　　　　　└ `index` | Number | 否 | 优先级顺序（越小越优先） |
| 　　　　　└ `name` | String | 否 | 标签名称 |
| 　　　└ `inOrderCount30DaysSku` | Number | 否 | 30天引单数量(sku维度) |
| 　　　└ `specialSkuUrlInfo` | com.jd.union.SpecialSkuUrlInfo | 否 | 频道页信息 |
| 　　　　└ `skuUrlType` | Number | 否 | 频道页链接类型，1：秒杀专享价 |
| 　　　　└ `skuUrl` | String | 否 | 频道页地址 |
| 　　　└ `searchPageInfo` | com.jd.union.SearchPageInfo | 否 | 该字段信息已禁用，请勿获取和使用 |
| 　　　　└ `searchPageUrl` | String | 否 | 该字段信息已禁用，请勿获取和使用 |
| 　└ `totalCount` | Number | 是 | 有效商品总数量，上限1w |
| 　└ `hotWords` | String | 否 | 日常top10的热搜词，按小时更新 |
| 　└ `similarSkuList` | Number[] | 否 | 相似推荐商品skuId集合 |
| 　└ `similarItemIdList` | String[] | 否 | 相似推荐联盟商品ID集合 |
| 　└ `searchPosition` | String | 否 | 查询索引位，再次查询须入参该值 |

---

*文档来源：京东联盟官方 (joshome.jd.com)*
*字段数量：请求 56 个，响应 233 个*
*更新时间：2026-04-22*
