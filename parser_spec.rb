require './parser'

describe Parser do
  context "when executing single job" do
    let(:job) { described_class.new.parse_input("a => ")}
    it do
      expect(job).to eq(["a"])
      expect(job.length).to eq(1)
    end
  end

  context "when executing mutliple jobs without dependency" do
    let(:job) { described_class.new.parse_input("a =>
                                                 b =>
                                                 c =>")}
    it do
      expect(job).to eq(["a","b","c"])
      expect(job.length).to eq(3)
    end
  end

  context "when executing single dependency" do
    let(:job) { described_class.new.parse_input("a =>
                                                 b => c
                                                 c =>")}
    it do
      expect(job).to eq(["a","c","b"])
      expect(job.length).to eq(3)
    end
  end


  context "when executing with multiple dependency" do
    let(:job) { described_class.new.parse_input("a =>
                                                  b => c
                                                  c => f
                                                  d => a
                                                  e => b
                                                  f =>")}
    it do
      expect(job).to eq(["f","c","a", "d","b", "e"])
      expect(job.length).to eq(6)
    end
  end
end
