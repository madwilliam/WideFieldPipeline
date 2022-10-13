classdef WideFieldFileHandler 
   properties
      root_path
   end
   methods
       function self = WideFieldFileHandler(root_path)
           self.root_path = root_path;
       end
       function file_names = get_experiments(self)
           parameter_files = self.get_parameter_files();
           parameter_file_names = [];
           parameter_file_names = [parameter_file_names {parameter_files.name}];
           file_names = cellfun(@(x) extractBefore(x,'_Parameters.mat') ,parameter_file_names,'UniformOutput',false);
       end
    
       function parameter_files = get_parameter_files(self)
           parameter_files = dir(fullfile(self.root_path,'/*/*Parameters.mat'));
       end
    
       function wave = load_vessel_wave_after_stimuli(self,file_name)
           wave = self.load_wave(file_name,'svd_puff_wave.h5');
       end

       function wave = load_vessel_wave_before_stimuli(self,file_name)
           wave = self.load_wave(file_name,'svd_beforepuff_wave.h5');
       end

       function wave = load_neuron_wave_after_stimuli(self,file_name)
           wave = self.load_wave(file_name,'svd_puff_neurons_wave.h5');
       end

       function wave = load_neuron_wave_before_stimuli(self,file_name)
           wave = self.load_wave(file_name,'svd_beforepuff_neurons_wave.h5');
       end

       function map = load_vessel_map_after_stimuli(self,file_name)
           map = self.load_map(file_name,'svd_puff.mat');
       end

       function map = load_vessel_map_before_stimuli(self,file_name)
           map = self.load_map(file_name,'svd_beforepuff.mat');
       end

       function map = load_neuron_map_after_stimuli(self,file_name)
           map = self.load_map(file_name,'svd_puff_neurons.mat');
       end

       function map = load_neuron_map_before_stimuli(self,file_name)
           map = self.load_map(file_name,'svd_beforepuff_neurons.mat');
       end

       function parameters = load_parameters(self,file_name)
           parameters = self.load_map(file_name,'_Parameters.mat');
       end

       function map = load_map(self,file_name,file_pattern)
           map_file_name = append(file_name,file_pattern);
           map_file_path = fullfile(self.root_path,file_name,map_file_name);
           if exist(map_file_path)
               map = load(map_file_path);
           else
               disp(append('wave files do not exist for ',map_file_name))
               map = nan;
           end
       end

       function wave = load_wave(self,file_name,file_pattern)
           wave_file_name = append(file_name,file_pattern);
           wave_file_path = fullfile(self.root_path,file_name,wave_file_name);
           if exist(wave_file_path)
                wave = h5read(wave_file_path,'/wave');
           else
               disp(append('wave files do not exist for ',wave_file_name))
               wave = nan;
           end
       end

       function mapped_waves = map_wave(self,map,wave)
           nframes = size(wave,2);
           mapped_waves = zeros([nframes size(map.toplot.mask)]);
           for framei = 1:nframes
               mapped_waves(framei,map.toplot.mask_ind) = wave(map.toplot.skel_label,framei);
           end
       end

   end
end