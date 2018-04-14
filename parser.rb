require './process_job'
require 'pry'
require 'set'

class Parser
  #parses the initial params
  def self.parse_params(params)
    params.split("\n").inject({}){|result,element|
      process_job = ProcessJob.new(*element.split('=>').map(&:strip))
      result[process_job.right_node] = process_job
      result
    }
  end

  #Needs to sort data to check the multiple job dependency
  def parse_input(params)
    puts "============ Job will execute with following order ================="
    puts Parser.sort_jobs!(Parser.parse_params(params))
    puts "============ ************************************* ================="
     Parser.sort_jobs!(Parser.parse_params(params))
  end

  def self.check_cyclic_dependancy(job_params)
    return nil if job_params.nil?

    job_params.each do |ele, job|
      look_up = Set.new
      while(job = job_params[job.left_node])
        break if !job.left_node
        if look_up.add?(job.right_node).nil?
          return true
        end
      end
    end
    return false
  end

  def self.sort_jobs!(data)
    raise DenpendencyError.new("Job doesn't depend on the same") if self.check_cyclic_dependancy(data)

    data.values.inject(Array.new) { |elements, obj|
      if !elements.include? obj.right_node
        elements << obj.right_node
      end
      if obj.left_node
        elements.delete(obj.left_node)
        pos = elements.index(obj.right_node)
        elements.insert(pos, obj.left_node)
      end
      elements
    }
  end
end

Parser.new.parse_input("a =>")

Parser.new.parse_input("a =>
                         b => ")
Parser.new.parse_input("a =>
                         b => c")

 Parser.new.parse_input("a =>
b => c
c =>")

Parser.new.parse_input("a =>
                         b => c
                         c => f
                         d => a
                         e => b
                         f => ")
#  Parser.new.parse_input("a =>
# b => c
# c => f
# d => a
# e =>
# f => b") will raise an error
# Parser.new.parse_input("a => a")
