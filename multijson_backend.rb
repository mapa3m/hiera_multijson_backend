class Hiera
  module Backend
    class Multijson_backend
      def initialize
        Hiera.debug('Multi-file JSON backend starting')
      end
      def lookup(key, scope, order_override,resolution_type)
        answer = nil
        Backend.datasources(scope,order_override) do |source|
          dir="#{Backend.datadir(:multijson,scope)}/#{source}/#{key.gsub(':','_') }"
          next unless File.directory? dir
          answer = Hash.new if answer.nil?
          Hiera.debug("Found directory #{dir}")
          Dir.chdir(dir)
          Dir.glob('*.json') do |file|
            Hiera.debug("Found #{file} in #{dir}")
            answer[file.sub('.json','')] = JSON.parse(File.read("#{dir}/#{file}"))
          end
        end
        return answer
      end
    end
  end
end