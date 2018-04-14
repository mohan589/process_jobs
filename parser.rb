require 'process_job'
require 'pry'

class Parser
  def parse_params(params)
    params.inject({}){|result,element|
      job = ProcessJob.new(element.split("=>").map(&:strip))
      binding.pry
    }
  end
end
