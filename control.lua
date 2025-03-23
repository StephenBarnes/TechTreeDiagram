script.on_event(defines.events.on_player_created, function(ev)
	local techIds = {} -- ids of all techs
	local techEdges = {} -- id of prereq to list of ids of techs it's required for
	for id, tech in pairs(prototypes.technology) do
		table.insert(techIds, id)
		for prereqId, _ in pairs(tech.prerequisites) do
			if techEdges[prereqId] == nil then
				techEdges[prereqId] = {}
			end
			table.insert(techEdges[prereqId], id)
		end
	end

	local lines = {"digraph G {"}
	-- Add lines for all the tech id nodes.
	for _, id in ipairs(techIds) do
		table.insert(lines, string.format('"%s" [label="%s"];', id, id))
	end
	-- Add lines for all the tech-to-tech prereq edges.
	for prereqId, postreqIds in pairs(techEdges) do
		table.insert(lines, string.format('"%s" -> {"%s"};', prereqId, table.concat(postreqIds, '" "')))
	end
	table.insert(lines, "}")

	helpers.write_file("TechTreeDiagram.gv", table.concat(lines, '\n'))
end)
