defmodule MatcherSpec do
  use ESpec

  describe "#process(file_name)" do
    it "returns slow queries info" do
      result = Matcher.process("spec/fixtures/test_log_file")
      expect(result).to eq([
        %{
          :line => 10,
          :query => "with process number:[5568]:LOG:  select * from slow_table\n",
          :duration => "1500.00ms"
        },
        %{
          :line => 4,
          :query => "with process number:[5566]:LOG:  select * from slow_table\n",
          :duration => "1000.00ms"
        }
      ])
    end
  end
end
