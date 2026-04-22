# JD Union API Documentation Skill

> A Claude Code skill for fetching JD Union (京东联盟) API documentation from official sources and generating hierarchical Markdown tables.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Overview

This skill enables automated fetching of JD Union API documentation directly from the official `joshome.jd.com` source. It parses JSON responses and generates comprehensive Markdown documentation with hierarchical field tables.

**Key Features**:
- 🔗 Direct access to official JD documentation API
- 🎯 Semantic trigger word activation
- 📁 Local document caching in `api-docs/` directory
- 📊 Recursive parsing of nested field structures
- 📝 Generates hierarchical Markdown tables
- 🔗 JD SDK workflow integration

## Quick Start

### Installation

**Option 1: Install via Claude Code Plugin (Recommended)**

```bash
# Add the plugin repository (if using a GitHub repo)
claude plugin marketplace add https://github.com/your-username/jd-api-doc-skill

# Install the plugin
claude plugin install jd-api-doc-skill

# Enable the plugin
claude plugin enable jd-api-doc-skill
```

**Option 2: Manual Installation**

```bash
# Clone and copy to Claude Code skills directory
git clone https://github.com/your-username/jd-api-doc-skill.git
cp -r jd-api-doc-skill ~/.claude/skills/
```

After installation, the skill will be automatically activated when you mention keywords like:
- `京东联盟接口` / `京东API文档` / `jd.union.open`
- `商品查询` / `转链` / `精选` / `订单查询`
- `josCmsApiId`

**Option 3: Use as Standalone Tool**

```bash
# Clone the repository
git clone https://github.com/your-username/jd-api-doc-skill.git
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
├── README.md           # This file
├── README_CN.md        # Chinese README
├── SKILL.md            # Complete skill documentation
├── jd-api-fetch.sh     # Executable script
├── api-docs/           # Document cache
│   ├── INDEX.md        # API list index
│   └── *.md            # Cached API docs
└── LICENSE             # MIT License
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Data source: [joshome.jd.com](https://joshome.jd.com) - Official JD Union Documentation API

---

**Author**: Claude Code Agent
**Last Updated**: 2026-04-22
