defmodule MatcherSpec do
  use ESpec

  it "should pass" do
    expect(Matcher.contain_duration?({ "hello", 1234 })).to eq(false)
  end
end
