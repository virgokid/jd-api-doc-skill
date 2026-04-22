# JD联盟API 文档.SKILL

> 从京东联盟官方数据源 (joshome.jd.com) 获取 API 文档并生成层级字段表格

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 概述

本工具可自动从京东官方 `joshome.jd.com` 获取京东联盟 API 文档，解析 JSON 响应并生成带有层级字段表格的 Markdown 文档。

**核心特性**:

- 🔗 直接访问官方 JD 文档 API
- 🎯 触发词自动激活
- 📁 文档缓存到本地目录
- 📊 递归解析嵌套字段结构
- 📝 生成层级 Markdown 表格
- 🛠 处理边缘情况（未定义名称、多行描述）
- 🔗 集成 JD SDK 工作流

## 快速开始

### 安装

**方式一：通过 Claude Code Plugin 安装（推荐）**

```bash
# 添加插件仓库（如果使用 GitHub 仓库）
claude plugin marketplace add https://github.com/your-username/jd-api-doc-skill

# 安装插件
claude plugin install jd-api-doc-skill

# 启用插件
claude plugin enable jd-api-doc-skill
```

**方式二：手动安装**

```bash
# 克隆并复制到 Claude Code skills 目录
git clone https://github.com/your-username/jd-api-doc-skill.git
cp -r jd-api-doc-skill ~/.claude/skills/
```

安装后，当你提到以下关键词时技能会自动激活：
- `京东联盟接口` / `京东API文档` / `jd.union.open`
- `商品查询` / `转链` / `精选` / `订单查询`
- `josCmsApiId`

**方式三：作为独立工具使用**

```bash
# 克隆仓库
git clone https://github.com/your-username/jd-api-doc-skill.git
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

参见 [SKILL.md](./SKILL.md) 获取完整文档，包括：
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
├── README.md           # 英文说明
├── README_CN.md        # 中文说明
├── SKILL.md            # Skill 定义文档
├── jd-api-fetch.sh     # 执行脚本
├── api-docs/           # 文档缓存目录
│   ├── INDEX.md        # API 列表索引
│   └── *.md            # 缓存的 API 文档
└── LICENSE             # MIT 许可证
```

## 贡献

欢迎提交 Pull Request！

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

## 许可证

[MIT License](LICENSE)

## 致谢

- 数据来源: [joshome.jd.com](https://joshome.jd.com) - 京东联盟官方文档 API

---

**作者**: Claude Code Agent
**更新日期**: 2026-04-22
