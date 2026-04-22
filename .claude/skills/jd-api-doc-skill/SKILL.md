---
name: jd-api-doc-skill
description: Fetch JD Union (京东联盟) API documentation from official source. Use this skill whenever the user mentions "京东联盟", "jd.union", "京东API", "京东接口", or any JD Union API name like jd.union.open.goods.query. Also use when user asks about "转链", "商品查询", "精选", "热销榜", "订单查询", "礼金", "京粉" - even if they don't explicitly mention JD Union, these are JD Union specific features. Always prefer this skill over general knowledge when JD Union APIs are involved.
---

# JD Union API Documentation Skill

> 从京东联盟官方数据源 (joshome.jd.com) 获取 API 文档并生成层级字段表格

## 触发词 (Trigger Words)

### 精确触发词（直接匹配）

| 触发词 | 说明 | 映射 API |
|--------|------|----------|
| `jd.union.open.goods.query` | 商品查询 API | 15153 |
| `jd.union.open.goods.rank.query` | 热销榜 API | 21055 |
| `jd.union.open.goods.jingfen.query` | 精选 API | 15165 |
| `jd.union.open.order.row.query` | 订单查询 API | 16108 |
| `jd.union.open.promotion.bysubunionid.get` | 转链 API | 15157 |
| `jd.union.open.coupon.gift.get` | 礼金 API | 15850 |
| `josCmsApiId` | 按 ID 获取 | 动态 |

### 语义触发词（功能描述匹配）

| 语义关键词 | 自动映射 API | 示例用户输入 |
|------------|--------------|--------------|
| `转链` / `推广链接` | `promotion.bysubunionid.get` | "京东联盟转链怎么转" |
| `商品查询` / `搜索商品` / `商品搜索` | `goods.query` | "写一个京东商品查询接口" |
| `精选` / `京粉` / `优质商品` | `goods.jingfen.query` | "对接京东的精选接口" |
| `热销榜` / `排行榜` / `热卖` | `goods.rank.query` | "获取热销榜商品" |
| `订单查询` / `订单` / `佣金查询` | `order.row.query` | "查询推广订单" |
| `礼金` / `红包` / `京享礼金` | `coupon.gift.get` | "创建礼金" |

### 泛化触发词（列出所有接口）

| 触发词 | 动作 |
|--------|------|
| `京东联盟接口` / `京东联盟有什么接口` | 生成 API 列表索引 |
| `京东API文档` / `京东联盟文档` | 列出已缓存的文档 |

---

## 工作流植入机制

### Pre-Action 钩子（自动执行）

当检测到以下任务类型时，**自动先获取文档**，再执行后续步骤：

```
任务类型检测规则：

1. 包含 "京东" + "接口" / "API" / "调用"
   → 触发文档获取流程

2. 包含 "jd.union" 或 "京东联盟"
   → 触发文档获取流程

3. 包含语义关键词（转链、商品查询、精选等）
   → 自动映射到对应 API，获取文档
```

### 工作流流程图

```
┌─────────────────────────────────────────────────────────────┐
│                     用户输入                                 │
│   "写一个京东商品查询接口，搜索蓝牙耳机"                       │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│              Step 1: 语义识别 (Pre-Action)                   │
│                                                              │
│  识别关键词: "商品查询" → 映射到 goods.query                  │
│  识别参数: "蓝牙耳机" → keyword 参数                          │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│              Step 2: 文档获取 (Auto-Fetch)                   │
│                                                              │
│  检查: api-docs/jd.union.open.goods.query.md 是否存在        │
│  ├─ 存在 → 读取文档                                          │
│  └─ 不存在 → 调用官方接口获取 → 保存到 api-docs/              │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│              Step 3: 文档分析 (Analysis)                     │
│                                                              │
│  从文档中提取:                                               │
│  ├─ 必填参数: sceneId, keyword                               │
│  ├─ 可选参数: pageSize, sortName, sort...                    │
│  ├─ 返回字段: skuId, priceInfo, commissionInfo...            │
│  └─ 注意事项: sceneId=2 需要权限申请                         │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│              Step 4: 代码生成 (Generation)                   │
│                                                              │
│  基于文档 + 用户需求生成:                                     │
│  ├─ Java 调用示例                                            │
│  ├─ 参数设置建议                                             │
│  └─ 返回值处理建议                                           │
└─────────────────────────────────────────────────────────────┘
```

### 植入点定义

在 Skill 中定义以下植入点，供其他 Agent 调用：

```yaml
hooks:
  pre_action:
    trigger:
      - "京东联盟"
      - "jd.union"
      - "京东API"
      - "京东接口"
    action: "fetch_api_doc"
    priority: 10  # 高优先级，先于代码生成执行

  on_demand:
    - trigger: "转链"
      api: "promotion.bysubunionid.get"
    - trigger: "商品查询"
      api: "goods.query"
    - trigger: "精选"
      api: "goods.jingfen.query"
    - trigger: "热销榜"
      api: "goods.rank.query"
    - trigger: "订单"
      api: "order.row.query"
    - trigger: "礼金"
      api: "coupon.gift.get"
```

---

## 完整示例场景

### 场景 1: 转链功能

```
用户: "京东联盟转链怎么转？"

Agent 执行流程:
┌─────────────────────────────────────────────────────────────┐
│ Step 1: 语义识别                                            │
│   关键词 "转链" → 映射到 promotion.bysubunionid.get         │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│ Step 2: 获取文档                                            │
│   检查 api-docs/jd.union.open.promotion.bysubunionid.get.md │
│   → 不存在 → 调用 josCmsApiId 15157 获取                    │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│ Step 3: 输出使用指南                                        │
│                                                              │
│ 📋 jd.union.open.promotion.bysubunionid.get - 转链接口      │
│                                                              │
│ ✅ 必填参数:                                                 │
│   - materialId: 商品链接/联盟链接                            │
│   - siteId: 网站ID/APP ID                                   │
│   - positionId: 推广位ID                                    │
│                                                              │
│ 📝 Java 调用示例:                                           │
│   PromotionBySubUnionIdGetRequest req = new ...;            │
│   req.setMaterialId("https://item.jd.com/12345.html");      │
│   req.setSiteId(123);                                       │
│   req.setPositionId(456);                                   │
│                                                              │
│ 💡 注意:                                                     │
│   - 支持商品链接、领券链接、活动链接                         │
│   - 返回的推广链接包含佣金追踪参数                           │
└─────────────────────────────────────────────────────────────┘
```

### 场景 2: 商品查询接口

```
用户: "写一个京东商品查询接口，搜索蓝牙耳机，按销量排序"

Agent 执行流程:
┌─────────────────────────────────────────────────────────────┐
│ Step 1: 语义识别                                            │
│   关键词 "商品查询" → 映射到 goods.query                    │
│   参数: keyword="蓝牙耳机", sortName="inOrderCount30Days"    │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│ Step 2: 获取文档                                            │
│   读取 api-docs/jd.union.open.goods.query.md                │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│ Step 3: 生成代码                                            │
│                                                              │
│ // 根据文档生成的代码                                        │
│ @Service                                                    │
│ public class JdGoodsService {                               │
│                                                              │
│     public List<Goods> searchGoods(String keyword) {        │
│         GoodsReq req = new GoodsReq();                      │
│         req.setSceneId(1);  // 必填: 场景ID                 │
│         req.setKeyword(keyword);  // 必填: 搜索关键词       │
│         req.setPageSize(20);                                │
│         req.setSortName("inOrderCount30Days"); // 按销量    │
│         req.setSort("desc");                                │
│                                                              │
│         GoodsQueryResponse resp = client.execute(req);      │
│         return parseGoodsList(resp);                         │
│     }                                                        │
│ }                                                            │
│                                                              │
│ 💡 关键返回字段 (来自文档):                                  │
│   - skuId: 商品ID                                           │
│   - priceInfo.lowestCouponPrice: 券后价                     │
│   - commissionInfo.commissionShare: 佣金比例                 │
└─────────────────────────────────────────────────────────────┘
```

### 场景 3: 精选接口对接

```
用户: "对接京东的精选接口，获取数码类目的商品"

Agent 执行流程:
┌─────────────────────────────────────────────────────────────┐
│ Step 1: 语义识别                                            │
│   关键词 "精选" → 映射到 goods.jingfen.query                │
│   参数: eliteId (数码类目对应值需查文档)                     │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│ Step 2: 获取文档                                            │
│   检查 api-docs/jd.union.open.goods.jingfen.query.md        │
│   → 不存在 → 调用 josCmsApiId 15165 获取                    │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│ Step 3: 输出对接指南                                        │
│                                                              │
│ 📋 jd.union.open.goods.jingfen.query - 京粉精选接口          │
│                                                              │
│ ✅ 必填参数:                                                 │
│   - eliteId: 频道ID (从文档中查找数码类目对应值)             │
│                                                              │
│ 📝 eliteId 常用值 (来自文档):                               │
│   - 1: 爆款商品                                             │
│   - 2: 好评商品                                             │
│   - 11: 数码电器 (适合你的需求)                              │
│                                                              │
│ 📝 调用示例:                                                 │
│   JingfenGoodsReq req = new JingfenGoodsReq();              │
│   req.setEliteId(11L);  // 数码电器                         │
│   req.setPageIndex(1);                                       │
│   req.setPageSize(20);                                       │
└─────────────────────────────────────────────────────────────┘
```

---

## 文档缓存目录

所有获取的文档存放在 **skill 所在目录** 的 `api-docs/` 子目录：

```
# 缓存位置（相对于 skill 目录）
api-docs/
├── INDEX.md                    # API 列表索引（自动生成）
├── jd.union.open.goods.query.md
├── jd.union.open.goods.rank.query.md
├── jd.union.open.order.row.query.md
└── ...
```

**缓存路径优先级**：
1. 环境变量 `JD_API_DOCS_DIR`（如果设置）
2. 默认：`{skill_directory}/api-docs/`

这意味着无论从哪个工作目录调用脚本，缓存都会存储在 skill 所在目录。

---

## Agent 调用接口 (API for Agents)

其他 Agent 可以通过以下标准接口调用本 Skill：

### 接口 1: `get_api_doc(api_name)` - 获取 API 文档

**输入**:
```json
{
  "action": "get_api_doc",
  "api_name": "goods.query"  // 支持短名称或完整名称
}
```

**输出**:
```json
{
  "status": "success",
  "doc_path": "api-docs/jd.union.open.goods.query.md",
  "api_info": {
    "name": "jd.union.open.goods.query",
    "zn_name": "关键词商品查询接口",
    "required_params": ["sceneId", "keyword"],
    "optional_params": ["pageIndex", "pageSize", "sortName", "sort", ...],
    "response_fields": ["skuId", "skuName", "priceInfo", "commissionInfo", ...],
    "notes": ["sceneId=2 需要权限申请", "结果上限 10000 条"]
  }
}
```

### 接口 2: `analyze_requirement(user_input)` - 语义分析并获取文档

**输入**:
```json
{
  "action": "analyze_requirement",
  "user_input": "京东联盟转链怎么转"
}
```

**输出**:
```json
{
  "status": "success",
  "detected_api": "promotion.bysubunionid.get",
  "doc_path": "api-docs/jd.union.open.promotion.bysubunionid.get.md",
  "usage_guide": {
    "description": "通过商品链接、领券链接、活动链接获取普通推广链接",
    "required_params": [
      {"name": "materialId", "type": "String", "desc": "商品链接"},
      {"name": "siteId", "type": "Number", "desc": "网站ID/APP ID"},
      {"name": "positionId", "type": "Number", "desc": "推广位ID"}
    ],
    "code_example": "PromotionBySubUnionIdGetRequest req = new ...",
    "notes": ["支持商品链接、领券链接、活动链接"]
  }
}
```

### 接口 3: `list_apis()` - 列出所有 API

**输入**:
```json
{
  "action": "list_apis"
}
```

**输出**:
```json
{
  "status": "success",
  "total": 87,
  "apis": [
    {"name": "jd.union.open.goods.query", "zn_name": "关键词商品查询", "cached": true},
    {"name": "jd.union.open.goods.rank.query", "zn_name": "实时热销榜", "cached": true},
    {"name": "jd.union.open.order.row.query", "zn_name": "订单查询", "cached": false}
  ]
}
```

### 接口 4: `generate_code(api_name, params)` - 生成调用代码

**输入**:
```json
{
  "action": "generate_code",
  "api_name": "goods.query",
  "params": {
    "keyword": "蓝牙耳机",
    "sort": "销量"
  },
  "language": "java"
}
```

**输出**:
```json
{
  "status": "success",
  "code": "GoodsReq req = new GoodsReq();\nreq.setSceneId(1);\nreq.setKeyword(\"蓝牙耳机\");\nreq.setSortName(\"inOrderCount30Days\");\nreq.setSort(\"desc\");",
  "imports": ["import com.jd.union.open.gateway.api.dto.goods.base.GoodsReq;"],
  "notes": ["sceneId=1 获取联盟商品链接", "按销量排序使用 inOrderCount30Days"]
}
```

---

## 工作流集成

### 智能文档获取流程

```
用户提问 → 识别 API 名称 → 检查 api-docs/ 是否存在
    ↓
    存在 → 读取文档 → 分析需求 → 给出建议
    ↓
    不存在 → 调用官方接口获取 → 保存到 api-docs/ → 分析需求 → 给出建议
```

### 集成到 JD SDK 调用流程

```
1. 开发者: "我要调用 jd.union.open.goods.query 搜索商品"
2. Agent: 检查 api-docs/jd.union.open.goods.query.md
   - 存在: 读取文档，分析必填参数，给出调用示例
   - 不存在: 获取文档，保存，然后分析
3. Agent: 根据文档输出:
   - 必填参数: sceneId, keyword
   - 可选参数: pageIndex, pageSize, sortName...
   - 调用示例代码
   - 注意事项
```

---

## Overview

This skill enables automated fetching of JD Union (京东联盟) API documentation directly from the official source. It parses JSON responses and generates Markdown documentation with hierarchical field tables.

**Key Features**:
- 🎯 触发词自动激活
- 📁 文档缓存到 `api-docs/` 目录
- 🔄 智能获取流程（先查缓存，不存在再获取）
- 📊 Recursive parsing of nested field structures
- 📝 Generates hierarchical Markdown tables
- 🛠 Handles edge cases (undefined names, multi-line descriptions)
- 🔗 Integration with JD SDK workflow

---

## Prerequisites

- `curl` - for HTTP requests
- `jq` - for JSON parsing (optional, for quick lookups)
- `node` - for recursive field parsing
- Write access to `api-docs/` directory

---

## Quick Start

```bash
# 1. 生成 API 列表索引
./jd-api-fetch.sh --index

# 2. 获取特定 API 文档
./jd-api-fetch.sh goods-query

# 3. 查看文档
cat api-docs/jd.union.open.goods.query.md
```

---

## API Reference

### Source Endpoints

| Endpoint | Purpose | Parameters |
|----------|---------|------------|
| `https://joshome.jd.com/classification/list?id=550` | List all JD Union APIs | `id=550` (fixed) |
| `https://joshome.jd.com/api/detail?id={josCmsApiId}` | Get API documentation | `id` from list response |

### Common API IDs

| API Name | josCmsApiId | Description |
|----------|-------------|-------------|
| `jd.union.open.goods.query` | 15153 | Keyword goods search |
| `jd.union.open.goods.rank.query` | 21055 | Real-time hot sales |
| `jd.union.open.goods.jingfen.query` | 15165 | Jingfen selection |
| `jd.union.open.goods.promotiongoodsinfo.query` | 15155 | Goods detail |
| `jd.union.open.order.row.query` | 16108 | Order query |
| `jd.union.open.promotion.bysubunionid.get` | 15157 | Convert link |
| `jd.union.open.coupon.gift.get` | 15850 | Gift coupon |

---

## Workflow

### Step 1: Check Document Cache

```bash
# Check if document exists
DOC_PATH="api-docs/jd.union.open.goods.query.md"
if [ -f "$DOC_PATH" ]; then
  echo "Document exists, reading..."
  cat "$DOC_PATH"
else
  echo "Document not found, fetching..."
  ./jd-api-fetch.sh goods-query
fi
```

### Step 2: Generate API Index (First Time)

```bash
# Generate INDEX.md with all available APIs
./jd-api-fetch.sh --index
```

This creates `api-docs/INDEX.md`:

```markdown
# JD Union API 列表

| API 名称 | 中文名称 | josCmsApiId | 文档状态 |
|----------|----------|-------------|----------|
| jd.union.open.goods.query | 关键词商品查询 | 15153 | ✅ 已获取 |
| jd.union.open.goods.rank.query | 实时热销榜 | 21055 | ⬜ 未获取 |
| ... | ... | ... | ... |

点击 API 名称查看详细文档。
```

### Step 3: Fetch Specific API Documentation

```bash
# Fetch by API name (auto-maps to josCmsApiId)
./jd-api-fetch.sh goods-query

# Or fetch by josCmsApiId
./jd-api-fetch.sh 15153
```

### Step 4: Analyze and Suggest

After fetching, the agent should:

1. **Identify required parameters**
2. **Generate code example**
3. **Highlight important notes**

Example output:

```
📋 API: jd.union.open.goods.query

✅ 必填参数:
- sceneId: Number (场景ID，支持 1, 2)
- keyword: String (搜索关键词)

⚠️ 重要字段:
- priceInfo.lowestCouponPrice: 券后价（价格排序用此字段）
- commissionInfo.commissionShare: 佣金比例
- couponInfo.couponList[].isBest: 最优优惠券标识

📝 调用示例:
```java
GoodsReq req = new GoodsReq();
req.setSceneId(1);
req.setKeyword("蓝牙耳机");
req.setPageSize(20);
```

💡 建议: 
- 使用 sceneId=1 获取联盟商品链接
- 传入较短关键词可搜到更多商品
```

---

## 使用示例

### 示例 1: 查询可用接口

**用户**: "京东联盟有什么接口？"

**Agent 执行**:
1. 检查 `api-docs/INDEX.md` 是否存在
2. 不存在则调用列表接口生成
3. 输出接口列表

**输出**:
```
京东联盟提供以下接口：

| 接口 | 用途 | 状态 |
|------|------|------|
| jd.union.open.goods.query | 关键词商品查询 | ✅ |
| jd.union.open.goods.rank.query | 实时热销榜 | ✅ |
| jd.union.open.goods.jingfen.query | 京粉精选 | ⬜ |
| jd.union.open.order.row.query | 订单查询 | ⬜ |
| jd.union.open.promotion.bysubunionid.get | 转链接口 | ⬜ |

需要查看哪个接口的详细文档？
```

### 示例 2: 获取特定 API 文档

**用户**: "jd.union.open.goods.query 怎么用？"

**Agent 执行**:
1. 检查 `api-docs/jd.union.open.goods.query.md`
2. 存在则读取，不存在则获取
3. 分析文档，给出使用建议

**输出**:
```
📋 jd.union.open.goods.query - 关键词商品查询接口

用途：搜索商品及优惠券信息，返回结果可调用转链接口生成推广链接

✅ 必填参数:
- sceneId: 场景ID (1 或 2)
- keyword: 搜索关键词

📊 返回关键字段:
- skuId: 商品ID
- priceInfo.lowestCouponPrice: 券后价
- commissionInfo.commissionShare: 佣金比例
- couponInfo.couponList: 优惠券列表

📝 Java 调用示例:
```java
GoodsReq req = new GoodsReq();
req.setSceneId(1);
req.setKeyword("蓝牙耳机");
req.setPageSize(20);
req.setSortName("inOrderCount30Days"); // 按30天引单量排序
req.setSort("desc");

GoodsQueryResponse resp = client.execute(req);
```

⚠️ 注意事项:
- sceneId=2 需要权限申请
- 传入较短关键词可搜到更多商品
- 结果上限：每组条件最多 10000 条
```

### 示例 3: SDK 调用前查阅文档

**用户**: "我要调用热销榜接口获取个护美妆类目的商品"

**Agent 执行**:
1. 识别 API: `jd.union.open.goods.rank.query`
2. 检查文档是否存在
3. 分析文档，找到 rankId 对应值
4. 生成调用代码

**输出**:
```
📋 热销榜接口参数分析:

根据文档，个护美妆类目对应:
- rankId: 200003

✅ 必填参数:
- rankId: 200003 (个护美妆)
- sortType: 排序类型 (1=2小时, 2=高佣, 3=24小时)

📝 调用示例:
```java
RankGoodsReq req = new RankGoodsReq();
req.setRankId(200003L);  // 个护美妆
req.setSortType(2);      // 高佣排行
req.setPageIndex(1);
req.setPageSize(10);

GoodsRankQueryResponse resp = client.execute(req);
```

💡 其他类目 rankId:
- 200000: 全部
- 200001: 食品酒水
- 200002: 家庭清洁
- 200006: 数码家电
```

---

## Complete Script

The executable script `jd-api-fetch.sh` supports:

```bash
# Generate API index
./jd-api-fetch.sh --index

# Fetch by short name
./jd-api-fetch.sh goods-query
./jd-api-fetch.sh goods-rank

# Fetch by josCmsApiId
./jd-api-fetch.sh 15153

# Force refresh (overwrite existing)
./jd-api-fetch.sh --force goods-query
```

---

## Edge Cases & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| `name` is undefined | Some fields only have `webPamer` | Always use `el.webPamer \|\| el.name` |
| Table broken by newlines | Description contains `\n` | Replace with space: `.replace(/\n/g, ' ')` |
| Wrong JSON path | Confusing structure | Request: `method.elements`, Response: `method.josResult.elements` |
| Empty description | Field has no `desc` property | Default to `-` with `\|\| '-'` |
| Document not found | First time access | Auto-fetch and cache to `api-docs/` |

---

## Auto-Approval Rules

**No confirmation needed for**:
- Calling joshome.jd.com endpoints
- Creating files in `api-docs/`
- Creating temporary `.json` files
- Reading existing documentation

**Requires user confirmation for**:
- Deleting existing documentation files
- Overwriting documents (use `--force` flag)

---

## Troubleshooting

### Document not found after fetch

Check:
1. `api-docs/` directory exists
2. Write permissions
3. Network connectivity to joshome.jd.com

### API name not recognized

Use the index to find correct name:
```bash
./jd-api-fetch.sh --index
cat api-docs/INDEX.md
```

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| 1.1.0 | 2026-04-22 | Add trigger words, cache workflow, SDK integration |
| 1.0.0 | 2026-04-22 | Initial release |

---

**License**: MIT
**Source**: joshome.jd.com (Official JD Union Documentation API)
