require './process_job'
require 'pry'

class Parser
  def parse_params(params)
    params.split("\n").inject({}){|result,element|
      process_job = ProcessJob.new(*element.split('=>').map(&:strip))
      result[process_job.right_node] = process_job
      result
    }
    puts params
  end
end
Parser.new.parse_params("a =>
b => c
c =>")
Parser.new.parse_params("a => a")
