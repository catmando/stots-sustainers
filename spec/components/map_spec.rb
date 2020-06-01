require 'spec_helper'

describe 'Map Component', js: true do
  it 'will not wake the heart beat if things load slowly' do
    mount 'App' do
      Prayer.class_eval do
        class << self
          alias_method :original_as_geojson, :as_geojson
          def as_geojson
            start_time = Time.now
            elapsed_time = 0
            while elapsed_time < 1
              1_000_000.times { elapsed_time = Time.now - start_time }
              puts "elapsed time: #{elapsed_time}"
            end
            original_as_geojson
          end
        end
      end
    end
    on_client { @not_reset = true } # @not_reset will be reinitialized if we reload
    on_client { App.history.push '/map' }
    expect { @not_reset }.on_client_to be_truthy
  end

  it 'will not wake the heart beat if things run slowly' do
    mount 'App' do
      # Map.class_eval do
      #   alias_method :original_map, :map
      #   def map
      #     return @map if @map
      #     start_time = Time.now
      #     elapsed_time = 0
      #     while elapsed_time < 1
      #       1_000_000.times { elapsed_time = Time.now - start_time }
      #       puts "elapsed time: #{elapsed_time}"
      #     end
      #     original_map
      #   end
      # end
    end
    on_client { @not_reset = true } # @not_reset will be reinitialized if we reload
    on_client { App.history.push '/map' }
    expect { @not_reset }.on_client_to be_truthy
  end
end
