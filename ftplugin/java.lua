local mason = require("mason-registry")
local jdtls_path = mason.get_package("jdtls"):get_install_path()
local java_debug_path = mason.get_package("java-debug-adapter"):get_install_path()
local java_test_path = mason.get_package("java-test"):get_install_path()

local home = os.getenv("HOME")
local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")
local jdtls_dap = require("jdtls.dap")

local equinox_launcher_path = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local path_to_config = jdtls_path .. "/config_linux"
local lombok_path = jdtls_path .. "/lombok.jar"

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = jdtls_setup.find_root(root_markers)

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace" .. project_name

local bundles = {
	vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", true), "\n"))

local on_attach = function(_, bufnr)
	jdtls.setup_dap({ hotcodereplace = "auto" })
	jdtls_dap.setup_dap_main_class_configs()

	local map = vim.keymap.set
	map("n", "<leader>jev", "<cmd>lua require('jdtls').extract_variable()<cr>", { desc = "[JDTLS] Extract variable" })
	map("n", "<leader>joi", "<cmd>lua require('jdtls').organize_imports()<cr>", { desc = "[JDTLS] Extract variable" })
end

local capabilities = require("blink.cmp").get_lsp_capabilities()

local config = {
	cmd = {
		"/usr/lib/jvm/temurin-21-jdk-amd64/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. lombok_path,
		"-Xmx4g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- Eclipse jdtls location
		"-jar",
		equinox_launcher_path,
		"-configuration",
		path_to_config,
		"-data",
		workspace_dir,
	},
	root_dir = root_dir,
	on_attach = on_attach,
	settings = {
		java = {
			home = "/usr/lib/jvm/temurin-21-jdk-amd64",
			eclipse = { downloadSources = true },
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = {
					{
						name = "JavaSE-17",
						path = "/usr/lib/jvm/temurin-17-jdk-amd64",
					},
					{
						name = "JavaSE-21",
						path = "/usr/lib/jvm/temurin-21-jdk-amd64",
					},
					{
						name = "JavaSE-11",
						path = "/usr/lib/jvm/temurin-11-jdk-amd64",
					},
				},
			},
			maven = { downloadSources = true },
			implementationsCodeLens = { enabled = true },
			referencesCodeLens = { enabled = true },
			references = { includeDecompiledSources = true },
			signatureHelp = { enabled = true },
			format = { enabled = true },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				importOrder = {
					"java",
					"javax",
					"com",
					"org",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				useBlocks = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all",
				},
			},
		},
	},
	flags = {
		allow_incremental_sync = true,
	},
	capabilities = capabilities,
	init_options = {
		bundles = bundles,
		extendedClientCapabilities = jdtls.extendedClientCapabilities,
	},
}

jdtls.start_or_attach(config)
