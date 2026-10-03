return {
	{
		"emrearmagan/atlas.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"MeanderingProgrammer/render-markdown.nvim",
		},
		-- See Configuration below
		---@type AtlasConfig
		opts = {
			ui = {
				statusline = true,
				picker = "auto",
				listed_buffer = false,
			},

			providers = {
				---@type AtlasGitLabConfig
				gitlab = {
					base_url = vim.env.ATLAS_GITLAB_URL,
					token = vim.env.ATLAS_GITLAB_TOKEN,
				},

				---@type AtlasBitbucketConfig
				bitbucket = {
					user = vim.env.ATLAS_BITBUCKET_USER,
					token = vim.env.ATLAS_BITBUCKET_TOKEN,
				},

				---@type AtlasJiraConfig
				jira = {
					base_url = ATLAS_JIRA_URL,
					email = ATLAS_JIRA_EMAIL,
					token = ATLAS_JIRA_TOKEN,
					auth_method = "bearer",
					api_type = "cloud",
				},
			},

			pulls = {},

			issues = {},
		},
	},
}
