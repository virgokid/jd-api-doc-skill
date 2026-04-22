# JD联盟API 文档技能

> 从京东联盟官方数据源 (joshome.jd.com) 获取 API 文档并生成层级字段表格

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**中文** | **[English](./README_EN.md)**

## 概述

本工具可自动从京东官方 `joshome.jd.com` 获取京东联盟 API 文档，解析 JSON 响应并生成带有层级字段表格的 Markdown 文档。

**核心特性**:

- 🔗 直接访问官方 JD 文档 API
- 🎯 **触发词自动激活** - 无需手动调用，AI 自动识别
- 📁 文档缓存到本地目录
- 📊 递归解析嵌套字段结构
- 📝 生成层级 Markdown 表格
- 🛠 处理边缘情况（未定义名称、多行描述）
- 🔗 集成 JD SDK 工作流

## ⚡ 自动触发机制（v1.1.0 新增）

本技能支持**自动触发**，当用户输入匹配以下规则时，AI 会自动激活此技能：

### 触发规则

| 类别 | 触发词 | 示例用户输入 |
|------|--------|--------------|
| **精确匹配** | API 名称 | `jd.union.open.goods.query 怎么用` |
| **语义匹配** | 功能关键词 | `京东联盟转链怎么转` → 自动映射到转链接口 |
| **泛化匹配** | 列表查询 | `京东联盟有什么接口` → 生成 API 列表索引 |
| **前缀匹配** | 主题关键词 | `京东联盟...` / `jd.union...` |

### 语义映射表

| 用户输入关键词 | 自动映射 API |
|----------------|--------------|
| `转链` / `推广链接` | `promotion.bysubunionid.get` |
| `商品查询` / `搜索商品` | `goods.query` |
| `精选` / `京粉` | `goods.jingfen.query` |
| `热销榜` / `排行榜` | `goods.rank.query` |
| `订单查询` / `佣金查询` | `order.row.query` |
| `礼金` / `京享礼金` | `coupon.gift.get` |

### 配置说明

触发规则在 `plugin.json` 的 `triggers` 字段中定义：

```json
{
  "triggers": {
    "exact": ["jd.union.open.goods.query", ...],
    "semantic": ["转链", "商品查询", ...],
    "general": ["京东联盟接口", "京东联盟有什么接口"],
    "prefix": ["京东联盟", "jd.union"]
  },
  "hooks": {
    "PreResponse": [
      {
        "patterns": ["京东联盟", "jd\\.union", "转链", ...],
        "action": "invoke_skill",
        "skill": "jd-api-doc-skill:jd-api-doc-skill",
        "priority": 100
      }
    ]
  }
}
```

## 快速开始

### 安装

### 方式一：通过 Claude Code Plugin 安装（推荐）

```bash
# 添加插件仓库
claude plugin marketplace add https://github.com/virgokid/jd-api-doc-skill

# 安装插件
claude plugin install jd-api-doc-skill

# 验证安装（重启 Claude Code 后）
# 在对话中输入：京东联盟有什么接口
# 应自动触发此技能并返回接口列表
```

### 方式二：手动安装

```bash
# 克隆仓库
git clone https://github.com/virgokid/jd-api-doc-skill.git

# 复制到 Claude skills 目录（整个目录结构）
cp -r jd-api-doc-skill/.claude ~/.claude/

# 验证安装
# 检查文件是否存在
ls ~/.claude/skills/jd-api-doc-skill/SKILL.md
```

安装后，当你提到以下关键词时技能会自动激活：
- `京东联盟接口` / `京东API文档` / `jd.union.open`
- `商品查询` / `转链` / `精选` / `订单查询`
- `josCmsApiId`

**方式三：作为独立工具使用**

```bash
# 克隆仓库
git clone https://github.com/virgokid/jd-api-doc-skill.git
cd jd-api-doc-skill

# 添加执行权限
chmod +x jd-api-fetch.sh
```

### 基本用法

```bash
# 生成 API 列表索引
./jd-api-fetch.sh --index

# 按短名称获取
./jd-api-fetch.sh goods-query

# 按 API ID 获取
./jd-api-fetch.sh 15153

# 强制刷新已存在的文档
./jd-api-fetch.sh --force goods-query
```

## 前置条件

- `curl` - HTTP 请求
- `jq` - JSON 解析（可选）
- `node` - 递归字段解析

## 触发词

当提到以下关键词时，可激活此工具：

| 类别 | 触发词 |
|------|--------|
| 精确匹配 | `jd.union.open`, `josCmsApiId`, `京东联盟接口`, `京东API文档` |
| 语义匹配 | `商品查询` → goods.query, `转链` → promotion.bysubunionid.get, `精选` → goods.jingfen.query, `热销榜` → goods.rank.query, `订单查询` → order.row.query |

## 文档目录

```
api-docs/
├── INDEX.md                    # API 列表索引
├── jd.union.open.goods.query.md
├── jd.union.open.goods.rank.query.md
└── ...
```

## 详细文档

参见 [.claude/skills/jd-api-doc-skill/SKILL.md](./.claude/skills/jd-api-doc-skill/SKILL.md) 获取完整文档，包括：
- 触发词映射
- 工作流集成钩子
- Agent API 接口
- 边缘情况处理

## 常用 API ID

| API 名称 | josCmsApiId | 说明 |
|----------|-------------|------|
| `jd.union.open.goods.query` | 15153 | 关键词商品查询 |
| `jd.union.open.goods.rank.query` | 21055 | 实时热销榜 |
| `jd.union.open.goods.jingfen.query` | 15165 | 京粉精选 |
| `jd.union.open.order.row.query` | 16108 | 订单查询 |
| `jd.union.open.promotion.bysubunionid.get` | 15157 | 转链接口 |

## 输出示例

```markdown
| `couponInfo` | com.jd.union.CouponInfo | 是 | 优惠券信息 |
| 　└ `couponList` | com.jd.union.Coupon[] | 是 | 优惠券集合 |
| 　　└ `coupon` | com.jd.union.Coupon | 是 | 优惠券明细 |
| 　　　└ `bindType` | Number | 是 | 券种类 |
| 　　　└ `discount` | Number | 是 | 券面额 |
```

## 文件结构

```
jd-api-doc-skill/
├── .claude-plugin/
│   ├── plugin.json         # 插件配置
│   └── marketplace.json    # 市场配置
├── .claude/
│   └── skills/
│       └── jd-api-doc-skill/
│           └── SKILL.md    # Skill 定义文档（含 YAML frontmatter）
├── skill.json              # Skill 元数据（多平台支持）
├── README.md               # 中文说明（主文档）
├── README_EN.md            # 英文说明
├── jd-api-fetch.sh         # 执行脚本
├── api-docs/               # 文档缓存目录
│   ├── INDEX.md            # API 列表索引
│   └── *.md                # 缓存的 API 文档
├── evals/                  # 评估配置
│   └── trigger-eval.json   # 触发词评估
└── LICENSE                 # MIT 许可证
```

## 贡献

欢迎提交 Pull Request！

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

## 更新日志

### v1.2.0 (2026-04-22)
- 📁 重构项目结构，符合标准 Claude skill 格式
- 📝 添加 YAML frontmatter 到 SKILL.md
- 📦 添加根目录 skill.json 支持多平台
- 🧹 清理旧目录结构

### v1.1.0 (2026-04-22)
- ✨ 新增 `triggers` 配置，支持精确/语义/泛化/前缀四种触发规则
- ✨ 新增 `hooks.PreResponse` 钩子配置
- 📝 SKILL.md frontmatter 增加 triggers 定义
- 📝 更新 README 说明自动触发机制

### v1.0.0 (2026-04-22)
- 🎉 初始发布

## 许可证

[MIT License](LICENSE)

## 兼容性

### 支持的平台

| 平台 | 状态 | 说明 |
|------|------|------|
| Claude Code | ✅ 完全支持 | 主要支持平台 |
| Cursor | ✅ 支持 | 通过 skill.json |
| Windsurf | ✅ 支持 | 通过 skill.json |
| GitHub Copilot | ✅ 支持 | 通过 skill.json |
| Gemini CLI | ✅ 支持 | 通过 skill.json |

### 与其他插件的兼容性

本插件与以下插件/系统兼容，不会产生冲突：

- ✅ **OpenClaw** - 使用不同的插件格式，可同时安装
- ✅ **superpowers** - 功能互补，无冲突
- ✅ **claude-mem** - 内存系统，可同时使用
- ✅ **其他 Claude Code 插件** - 标准格式，无冲突

### 已知限制

- 触发词仅支持中文和英文关键词
- 需要网络连接访问 `joshome.jd.com` 获取最新文档
- 缓存文档存放在 `api-docs/` 目录

## 致谢

- 数据来源: [joshome.jd.com](https://joshome.jd.com) - 京东联盟官方文档 API

---

**作者**: virgokid  
**更新日期**: 2026-04-22
