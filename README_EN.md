# JD Union API Documentation Skill

> A Claude Code skill for fetching JD Union (京东联盟) API documentation from official sources and generating hierarchical Markdown tables.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**[中文文档](./README.md)** | English

## Overview

This skill enables automated fetching of JD Union API documentation directly from the official `joshome.jd.com` source. It parses JSON responses and generates comprehensive Markdown documentation with hierarchical field tables.

**Key Features**:
- 🔗 Direct access to official JD documentation API
- 🎯 **Auto-trigger activation** - AI automatically recognizes trigger words
- 📁 Local document caching in `api-docs/` directory
- 📊 Recursive parsing of nested field structures
- 📝 Generates hierarchical Markdown tables
- 🔗 JD SDK workflow integration

## ⚡ Auto-Trigger Mechanism (v1.1.0)

This skill supports **automatic activation**. When user input matches the following rules, AI will automatically invoke this skill:

### Trigger Rules

| Category | Trigger Words | Example User Input |
|----------|---------------|-------------------|
| **Exact Match** | API names | `How to use jd.union.open.goods.query` |
| **Semantic Match** | Feature keywords | `京东联盟转链怎么转` → Maps to promotion API |
| **General Match** | List queries | `京东联盟有什么接口` → Generate API index |
| **Prefix Match** | Topic keywords | `京东联盟...` / `jd.union...` |

### Semantic Mapping Table

| User Keyword | Auto-mapped API |
|--------------|-----------------|
| `转链` / `推广链接` | `promotion.bysubunionid.get` |
| `商品查询` / `搜索商品` | `goods.query` |
| `精选` / `京粉` | `goods.jingfen.query` |
| `热销榜` / `排行榜` | `goods.rank.query` |
| `订单查询` / `佣金查询` | `order.row.query` |
| `礼金` / `京享礼金` | `coupon.gift.get` |

### Configuration

Trigger rules are defined in `plugin.json`:

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

## Quick Start

### Installation

**Option 1: Install via Claude Code Plugin (Recommended)**

```bash
# Add the plugin repository
claude plugin marketplace add https://github.com/virgokid/jd-api-doc-skill

# Install the plugin
claude plugin install jd-api-doc-skill

# Enable the plugin
claude plugin enable jd-api-doc-skill
```

**Option 2: Manual Installation**

```bash
# Clone and copy to Claude Code skills directory
git clone https://github.com/virgokid/jd-api-doc-skill.git
cp -r jd-api-doc-skill ~/.claude/skills/
```

After installation, the skill will be automatically activated when you mention keywords like:
- `京东联盟接口` / `京东API文档` / `jd.union.open`
- `商品查询` / `转链` / `精选` / `订单查询`
- `josCmsApiId`

**Option 3: Use as Standalone Tool**

```bash
# Clone the repository
git clone https://github.com/virgokid/jd-api-doc-skill.git
cd jd-api-doc-skill

# Make script executable
chmod +x jd-api-fetch.sh
```

### Basic Usage

```bash
# Generate API list index
./jd-api-fetch.sh --index

# Fetch by short name
./jd-api-fetch.sh goods-query

# Fetch by API ID
./jd-api-fetch.sh 15153

# Force refresh existing document
./jd-api-fetch.sh --force goods-query
```

## Prerequisites

- `curl` - for HTTP requests
- `jq` - for JSON parsing (optional)
- `node` - for recursive field parsing

## Trigger Words

The skill activates automatically when these keywords are detected:

| Category | Trigger Words |
|----------|---------------|
| Exact Match | `jd.union.open`, `josCmsApiId`, `京东联盟接口`, `京东API文档` |
| Semantic | `商品查询` → goods.query, `转链` → promotion.bysubunionid.get, `精选` → goods.jingfen.query, `热销榜` → goods.rank.query, `订单查询` → order.row.query |

## Documentation

See [SKILL.md](./SKILL.md) for complete documentation including:
- Trigger Word Mapping
- Workflow Integration Hooks
- Agent API Interfaces
- Edge Cases & Solutions

## Common API IDs

| API Name | josCmsApiId | Description |
|----------|-------------|-------------|
| `jd.union.open.goods.query` | 15153 | Keyword goods search |
| `jd.union.open.goods.rank.query` | 21055 | Real-time hot sales |
| `jd.union.open.goods.jingfen.query` | 15165 | Jingfen selection |
| `jd.union.open.order.row.query` | 16108 | Order query |
| `jd.union.open.promotion.bysubunionid.get` | 15157 | Convert link |

## Output Example

```markdown
| `couponInfo` | com.jd.union.CouponInfo | 是 | 优惠券信息 |
| 　└ `couponList` | com.jd.union.Coupon[] | 是 | 优惠券集合 |
| 　　└ `coupon` | com.jd.union.Coupon | 是 | 优惠券明细 |
| 　　　└ `bindType` | Number | 是 | 券种类 |
| 　　　└ `discount` | Number | 是 | 券面额 |
```

## File Structure

```
jd-api-doc-skill/
├── .claude-plugin/
│   ├── plugin.json         # Plugin config (with triggers)
│   └── marketplace.json    # Marketplace config
├── skills/
│   └── jd-api-doc-skill/
│       └── SKILL.md        # Skill definition
├── README.md               # Chinese README (Main)
├── README_EN.md            # English README
├── jd-api-fetch.sh         # Executable script
├── api-docs/               # Document cache
│   ├── INDEX.md            # API list index
│   └── *.md                # Cached API docs
└── LICENSE                 # MIT License
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Changelog

### v1.1.0 (2026-04-22)
- ✨ Added `triggers` config with exact/semantic/general/prefix rules
- ✨ Added `hooks.PreResponse` hook configuration
- 📝 Added triggers to SKILL.md frontmatter
- 📝 Updated README with auto-trigger documentation

### v1.0.0 (2026-04-22)
- 🎉 Initial release

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Data source: [joshome.jd.com](https://joshome.jd.com) - Official JD Union Documentation API

---

**Author**: virgokid  
**Last Updated**: 2026-04-22
