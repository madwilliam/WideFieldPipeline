root_path = '/net/dk-server/jaduckwo/DataAnalysis/';
handler = WideFieldFileHandler(root_path);

file_names = handler.get_experiments();
file_name =file_names(1);

wave = handler.load_vessel_wave_before_stimuli(file_name);
wave = handler.load_vessel_wave_after_stimuli(file_name);
wave = handler.load_neuron_wave_before_stimuli(file_name);
wave = handler.load_neuron_wave_after_stimuli(file_name);

parameters = handler.load_parameters(file_name);

map = handler.load_vessel_map_before_stimuli(file_name);
map = handler.load_vessel_map_after_stimuli(file_name);
map = handler.load_neuron_map_before_stimuli(file_name);
map = handler.load_neuron_map_after_stimuli(file_name);

mapped_waves = handler.map_wave(map,wave);

WideFieldPlotter.plot_mapped_waves(mapped_waves);