classdef WideFieldPlotter
   methods(Static)
       function plot_mapped_waves(mapped_waves)
            figure
            nframes = size(mapped_waves,1);
            clims = [min(mapped_waves,[],'all') max(mapped_waves,[],'all')];
            for framei = 1:nframes
                imagesc(squeeze(mapped_waves(framei,:,:)),clims)
                title(num2str(framei))
                pause(0.1)
            end
       end
   end
end