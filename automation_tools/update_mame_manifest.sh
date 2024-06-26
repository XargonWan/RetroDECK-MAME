#!/bin/bash

git clone https://github.com/XargonWan/RetroDECK --depth=1 RetroDECK

# Creating MAME manifest
manifest_header="manifest-header.yml"
mame_module="mame-module.yml"
mame_manifest="net.retrodeck.mame.yml"
command="/app/bin/mame" 

# sed -n '/command/q;p' RetroDECK/net.retrodeck.retrodeck.yml > "$manifest_header"  TEMPORARY DISABLED TO TRY A BUILD WITH ANOTHER RUNTIME
echo -e "command: $command\n" >> "$manifest_header"
sed -i '/^[[:space:]]*#/d' "$manifest_header"
sed -i 's/[[:space:]]*#.*$//' "$manifest_header"
sed -n '/finish-args:/,${/cleanup:/q;p;}' RetroDECK/net.retrodeck.retrodeck.yml >> "$manifest_header"

sed -i 's/net.retrodeck.retrodeck/net.retrodeck.mame/' "$manifest_header"

cat "$manifest_header" > "$mame_manifest"
cat "$mame_module" >> "$mame_manifest"

rm -rf RetroDECK