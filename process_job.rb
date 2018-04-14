require 'pry'
require './dependency_error'

class ProcessJob
  attr_accessor :right_node, :left_node

  def initialize(right_job, left_job = nil)
    raise DenpendencyError.new("Job doesn't depend on the same") if right_job == left_job
    @right_node = right_job
    @left_node = (left_job == "") ? nil : left_job
  end

  def process_dependency?
    !!@left_node
  end
end
