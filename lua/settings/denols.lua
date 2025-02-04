local M = {}

M.settings = {
    {
        deno = {
            codeLens = {
                implementations = true,
                references = true,
                referencesAllFunctions = true,
                test = true,
            },
            inlayHints = {
                parameterNames = {
                    enabled = "all",
                },
                parameterTypes = {
                    enabled = true,
                },
                variableTypes = {
                    enabled = true,
                },
                propertyDeclarationTypes = {
                    enabled = true,
                },
                functionLikeReturnTypes = {
                    enabled = true,
                },
                enumMemberValues = {
                    enabled = true,
                },
            },
            suggest = {
                paths = true,
                autoimports = true,
            },
        },
    },
}

return M
