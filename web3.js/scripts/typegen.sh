set -e

# Generate typescript declarations
npx tsc -p tsconfig.d.json -d

# Flatten typescript declarations
npx rollup -c rollup.config.types.js

# Replace export with closing brace for module declaration
gsed -i '$s/export {.*};/}/' lib/index.d.ts

# Replace declare's with export's
gsed -i 's/declare/export/g' lib/index.d.ts

# Prepend declare module line
gsed -i '2s;^;declare module "@solana/web3.js" {\n;' lib/index.d.ts

# Run prettier
npx prettier --write lib/index.d.ts
