require 'pry'

class DenpendencyError
  def initialize(msg)
    super(msg)
  end
end

class ProcessJob
  attr_accessor :right_node, :left_node

  def initialize(right_job, left_job: nil)
    binding.pry
    raise DenpendencyError("Job doesn't depend on the same") if right_job == left_job
    @right_node = right_job
    @left_node = left_job
  end

  def process
    puts right_node == left_node
  end
end

ProcessJob.new(gets.chomp).process
