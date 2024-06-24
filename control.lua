script.on_event(defines.events.on_player_created, function(ev)
	game.write_file("TechTreeDiagram.gv",table.concat({},'\n'))
end)