baseCmd := "bun run quartz"

install:
    bun install
    {{baseCmd}} plugin install

sync:
    {{baseCmd}} sync

serve:
    git add --all
    git commit -m "Sync: {{datetime_utc("%v %r")}}"
    git pull origin v5
    git push origin v5
