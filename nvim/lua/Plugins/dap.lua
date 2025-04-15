return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "jay-babu/mason-nvim-dap.nvim",
        'theHamsta/nvim-dap-virtual-text',
        { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }
    },

	keys = {
		{
			"<leader>dR",
			function()
				require("dap").run_to_cursor()
			end,
			desc = "Run to Cursor",
		},
		{
			"<leader>dE",
			function()
				require("dapui").eval(vim.fn.input("[Expression] > "))
			end,
			desc = "Evaluate Input",
		},
		{
			"<leader>dC",
			function()
				require("dap").set_breakpoint(vim.fn.input("[Condition] > "))
			end,
			desc = "Conditional Breakpoint",
		},
		{
			"<leader>db",
			function()
				require("dap").step_back()
			end,
			desc = "Step Back",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>dd",
			function()
				require("dap").disconnect()
			end,
			desc = "Disconnect",
		},
		{
			"<leader>de",
			function()
				require("dapui").eval()
			end,
			mode = { "n", "v" },
			desc = "Evaluate",
		},
		{
			"<leader>dg",
			function()
				require("dap").session()
			end,
			desc = "Get Session",
		},
		{
			"<leader>dh",
			function()
				require("dap.ui.widgets").hover()
			end,
			desc = "Hover Variables",
		},
		{
			"<leader>dS",
			function()
				require("dap.ui.widgets").scopes()
			end,
			desc = "Scopes",
		},
	},

    config = function()
        require("mason").setup()
        require("mason-nvim-dap").setup()
        require("nvim-dap-virtual-text").setup()

        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end
}
