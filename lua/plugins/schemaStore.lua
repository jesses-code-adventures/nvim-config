-- JSON/YAML schemas.
return {
    {
        'b0o/SchemaStore.nvim',
        lazy = true,
        extra = {
            {
                description = "",
                fileMatch = { "postgrestools.json" },
                name = "postgrestools.json",
                url = "https://pgtools.dev/schemas/0.6.0/schema.json",
            },
        },
    }
}
