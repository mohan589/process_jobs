require './process_job'
require 'pry'

class Parser
  def parse_params(params)
    Array(params).inject({}){|result,element|
      process_job = ProcessJob.new(element.split.reject{|ele| ele == "=>"}.first, element.split.reject{|ele| ele == "=>"}.last)
      result[process_job.right_node] = process_job
      result
      binding.pry
    }
  end
end
Parser.new.parse_params("a => b")
# Parser.new.parse_params("a => a")
