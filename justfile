baseCmd := "bun run quartz"

install:
    bun install

sync:
    {{baseCmd}} sync

serve:
    {{baseCmd}} build --serve
