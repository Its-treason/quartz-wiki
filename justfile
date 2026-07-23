baseCmd := "bun run quartz"

install:
    bun install
    {{baseCmd}} plugin install

sync:
    {{baseCmd}} sync

serve:
    {{baseCmd}} build --serve
