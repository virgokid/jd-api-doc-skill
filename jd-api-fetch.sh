#!/bin/bash
# JD Union API Documentation Fetcher
#
# Usage:
#   ./jd-api-fetch.sh --index              # Generate API list index
#   ./jd-api-fetch.sh <api-name>           # Fetch by short name
#   ./jd-api-fetch.sh <josCmsApiId>        # Fetch by ID
#   ./jd-api-fetch.sh --force <api-name>   # Force refresh
#
# Examples:
#   ./jd-api-fetch.sh --index
#   ./jd-api-fetch.sh goods-query
#   ./jd-api-fetch.sh 15153
#   ./jd-api-fetch.sh --force goods-query

set -e

# Default output directory
OUTPUT_DIR="${JD_API_DOCS_DIR:-./api-docs}"
mkdir -p "${OUTPUT_DIR}"

# API name to josCmsApiId mapping
declare -A API_MAP
API_MAP["goods-query"]=15153
API_MAP["goods-rank"]=21055
API_MAP["jingfen-query"]=15165
API_MAP["goods-detail"]=15155
API_MAP["order-query"]=16108
API_MAP["promotion-convert"]=15157
API_MAP["coupon-gift"]=15850

# API name to full API name mapping
declare -A API_FULL_NAME
API_FULL_NAME["goods-query"]="jd.union.open.goods.query"
API_FULL_NAME["goods-rank"]="jd.union.open.goods.rank.query"
API_FULL_NAME["jingfen-query"]="jd.union.open.goods.jingfen.query"
API_FULL_NAME["goods-detail"]="jd.union.open.goods.promotiongoodsinfo.query"
API_FULL_NAME["order-query"]="jd.union.open.order.row.query"
API_FULL_NAME["promotion-convert"]="jd.union.open.promotion.bysubunionid.get"
API_FULL_NAME["coupon-gift"]="jd.union.open.coupon.gift.get"

# Function: Generate API Index
generate_index() {
  echo "==> Fetching API list from joshome.jd.com..."

  local INDEX_FILE="${OUTPUT_DIR}/INDEX.md"
  local TEMP_LIST="${OUTPUT_DIR}/.api-list.json"

  curl -s "https://joshome.jd.com/classification/list?id=550" > "${TEMP_LIST}"

  node << 'INDEX_SCRIPT'
const fs = require('fs');
const data = JSON.parse(fs.readFileSync('./api-docs/.api-list.json', 'utf8'));

const today = new Date().toISOString().split('T')[0];

let markdown = '# JD Union API 列表\n\n';
markdown += '> 数据来源: joshome.jd.com 官方接口\n\n';
markdown += '| API 名称 | 中文名称 | josCmsApiId | 文档状态 |\n';
markdown += '|----------|----------|-------------|----------|\n';

const apis = data.data || [];
apis.forEach(api => {
  const apiName = api.apiName || '-';
  const znName = api.znName || api.apiDesc?.substring(0, 20) || '-';
  const id = api.josCmsApiId || '-';

  // Check if doc exists
  const docFile = './api-docs/' + apiName + '.md';
  const exists = fs.existsSync(docFile);
  const status = exists ? '✅ 已获取' : '⬜ 未获取';

  markdown += '| `' + apiName + '` | ' + znName + ' | ' + id + ' | ' + status + ' |\n';
});

markdown += '\n---\n\n';
markdown += '*总计: ' + apis.length + ' 个接口*\n';
markdown += '*更新时间: ' + today + '*\n';

fs.writeFileSync('./api-docs/INDEX.md', markdown);
console.log('Generated: api-docs/INDEX.md');
console.log('Total APIs:', apis.length);
INDEX_SCRIPT

  rm -f "${TEMP_LIST}"
  echo "==> Done!"
  exit 0
}

# Function: Get API ID from argument
get_api_id() {
  local arg="$1"

  # Check if it's a short name
  if [[ -n "${API_MAP[$arg]}" ]]; then
    API_ID="${API_MAP[$arg]}"
    OUTPUT_NAME="${API_FULL_NAME[$arg]}"
    return 0
  fi

  # Check if it's a numeric ID
  if [[ "$arg" =~ ^[0-9]+$ ]]; then
    API_ID="$arg"
    OUTPUT_NAME="api-${arg}"
    return 0
  fi

  echo "Error: Unknown API name or ID: $arg"
  echo "Available names: ${!API_MAP[@]}"
  exit 1
}

# Parse arguments
FORCE_REFRESH=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --index)
      generate_index
      ;;
    --force)
      FORCE_REFRESH=true
      shift
      ;;
    *)
      get_api_id "$1"
      shift
      ;;
  esac
done

# Check if document already exists
DOC_FILE="${OUTPUT_DIR}/${OUTPUT_NAME}.md"

if [[ -f "${DOC_FILE}" ]] && [[ "$FORCE_REFRESH" == false ]]; then
  echo "==> Document already exists: ${DOC_FILE}"
  echo "==> Use --force to refresh, or read the existing document:"
  echo ""
  head -30 "${DOC_FILE}"
  exit 0
fi

# Fetch API documentation
TEMP_FILE="${OUTPUT_DIR}/.${OUTPUT_NAME}-raw.json"

echo "==> Fetching API documentation (josCmsApiId: ${API_ID})..."
curl -s "https://joshome.jd.com/api/detail?id=${API_ID}" > "${TEMP_FILE}"

echo "==> Parsing field structure..."
cd "${OUTPUT_DIR}"

export JD_API_ID="${API_ID}"
export JD_OUTPUT_NAME="${OUTPUT_NAME}"

node << 'PARSE_SCRIPT'
const fs = require('fs');

const API_ID = process.env.JD_API_ID;
const OUTPUT_NAME = process.env.JD_OUTPUT_NAME;
const tempFile = '.' + OUTPUT_NAME + '-raw.json';

const data = JSON.parse(fs.readFileSync(tempFile, 'utf8'));
const api = data.data.josCmsApi;
const method = data.data.method;

// Recursive field parser
function parseElements(elements, depth) {
  depth = depth || 0;
  const results = [];
  const indent = '　'.repeat(depth) + (depth > 0 ? '└ ' : '');

  if (!elements) return results;

  for (let i = 0; i < elements.length; i++) {
    const el = elements[i];
    const name = el.webPamer || el.name || 'unknown';
    const type = el.type || '-';
    const required = el.required === true ? '是' : (el.required === false ? '否' : '-');
    const desc = (el.desc || '').replace(/\n/g, ' ').trim();

    results.push('| ' + indent + '`' + name + '` | ' + type + ' | ' + required + ' | ' + (desc || '-') + ' |');

    if (el.elements && el.elements.length > 0) {
      const nested = parseElements(el.elements, depth + 1);
      for (let j = 0; j < nested.length; j++) {
        results.push(nested[j]);
      }
    }
  }

  return results;
}

function countFields(elements) {
  if (!elements) return 0;
  let count = 0;
  for (let i = 0; i < elements.length; i++) {
    count++;
    if (elements[i].elements) {
      count += countFields(elements[i].elements);
    }
  }
  return count;
}

// Decode HTML entities
function decodeHtml(str) {
  return (str || '')
    .replace(/&#x([0-9a-f]+);/gi, (match, hex) => String.fromCharCode(parseInt(hex, 16)))
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"');
}

const apiName = api.apiName;
const znName = decodeHtml(api.znName);
const apiDesc = decodeHtml(api.apiDesc || '');

const reqElements = method.elements || [];
const respElements = (method.josResult && method.josResult.elements) ? method.josResult.elements : [];

const reqFields = parseElements(reqElements, 0);
const respFields = parseElements(respElements, 0);

const reqCount = countFields(reqElements);
const respCount = countFields(respElements);

const today = new Date().toISOString().split('T')[0];

const markdown = '# ' + apiName + ' - ' + znName + '\n\n' +
  '> ' + apiDesc.substring(0, 200) + '\n' +
  '> \n' +
  '> **数据来源**: joshome.jd.com (josCmsApiId: ' + API_ID + ')\n\n' +
  '## 接口信息\n\n' +
  '| 项目 | 说明 |\n' +
  '|------|------|\n' +
  '| 接口名称 | `' + apiName + '` |\n' +
  '| 中文名称 | ' + znName + ' |\n' +
  '| 接口地址 | `https://api.jd.com/routerjson` |\n' +
  '| 请求方式 | GET/POST（推荐POST） |\n' +
  '| 数据格式 | JSON |\n' +
  '| 版本 | 1.0 |\n\n' +
  '---\n\n' +
  '## 请求参数\n\n' +
  '> 以下字段按层级结构展示，`　└ ` 表示嵌套字段\n\n' +
  '| 字段名 | 类型 | 必填 | 说明 |\n' +
  '|--------|------|------|------|\n' +
  reqFields.join('\n') + '\n\n' +
  '---\n\n' +
  '## 响应参数\n\n' +
  '> 以下字段按层级结构展示，`　└ ` 表示嵌套字段\n\n' +
  '| 字段名 | 类型 | 必填 | 说明 |\n' +
  '|--------|------|------|------|\n' +
  respFields.join('\n') + '\n\n' +
  '---\n\n' +
  '*文档来源：京东联盟官方 (joshome.jd.com)*\n' +
  '*字段数量：请求 ' + reqCount + ' 个，响应 ' + respCount + ' 个*\n' +
  '*更新时间：' + today + '*\n';

fs.writeFileSync(OUTPUT_NAME + '.md', markdown);

console.log('');
console.log('API 名称:', apiName);
console.log('中文名称:', znName);
console.log('');
console.log('请求字段:', reqCount, '个');
console.log('响应字段:', respCount, '个');
console.log('');
console.log('生成文件:', OUTPUT_NAME + '.md');
PARSE_SCRIPT

echo ""
echo "==> Cleaning up..."
rm -f "${TEMP_FILE}"

echo "==> Done! Output: ${DOC_FILE}"
