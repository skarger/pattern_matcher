require "spec_helper"

RSpec.describe PatternMatcher do
  it "has a version number" do
    expect(PatternMatcher::VERSION).not_to be nil
  end

  it "accepts an input string and a pattern" do
    expect { PatternMatcher.match("", "") }.not_to raise_error
  end

  it "returns false for an empty pattern unless input is also empty" do
    expect(PatternMatcher.match("a", "")).to eq(false)
    expect(PatternMatcher.match("", "")).to eq(true)
  end

  context "patterns without * character" do
    it "returns true for exact matches" do
      expect(PatternMatcher.match("a", "a")).to eq(true)
      expect(PatternMatcher.match("b", "b")).to eq(true)

      expect(PatternMatcher.match("aaa", "aaa")).to eq(true)
      expect(PatternMatcher.match("bbb", "bbb")).to eq(true)
      expect(PatternMatcher.match("abab", "abab")).to eq(true)
      expect(PatternMatcher.match("bab", "bab")).to eq(true)
    end

    it "returns false if pattern is longer or shorter than input" do
      expect(PatternMatcher.match("ab", "aba")).to eq(false)
      expect(PatternMatcher.match("bbaa", "baa")).to eq(false)
    end

    it "returns false if pattern sequence is different that input sequence" do
      expect(PatternMatcher.match("a", "b")).to eq(false)
      expect(PatternMatcher.match("aa", "ba")).to eq(false)
      expect(PatternMatcher.match("aba", "abb")).to eq(false)
    end

    it "returns false if pattern is non-empty and input is empty" do
      expect(PatternMatcher.match("", "b")).to eq(false)
    end
  end

  context "patterns with * character" do
    it "handles zero or more occurrences" do
      expect(PatternMatcher.match("", "a*")).to eq(true)

      expect(PatternMatcher.match("a", "a*")).to eq(true)
      expect(PatternMatcher.match("aa", "a*")).to eq(true)
      expect(PatternMatcher.match("aaa", "a*")).to eq(true)

      expect(PatternMatcher.match("b", "b*")).to eq(true)
      expect(PatternMatcher.match("bb", "b*")).to eq(true)
      expect(PatternMatcher.match("bbb", "b*")).to eq(true)
    end

    it "handles a mix of pattern characters" do
      expect(PatternMatcher.match("aab", "a*b")).to eq(true)
      expect(PatternMatcher.match("abb", "ab*")).to eq(true)
    end

    it "handles zero occurrences followed by > 0 occurrences" do
      expect(PatternMatcher.match("b", "a*b")).to eq(true)
      expect(PatternMatcher.match("aa", "b*aa")).to eq(true)
    end

    it "still supports sub-runs with no * character" do
      expect(PatternMatcher.match("baab", "baab*")).to eq(true)
    end

    it "returns false if *-repetition cannot satisfy match" do
      expect(PatternMatcher.match("b", "a*")).to eq(false)
      expect(PatternMatcher.match("bbab", "b*a")).to eq(false)
      expect(PatternMatcher.match("bb", "b*a")).to eq(false)
      expect(PatternMatcher.match("bb", "b*a")).to eq(false)
      expect(PatternMatcher.match("bba", "b*")).to eq(false)
    end
  end

  context "patterns with multiple * characters" do
    it "handles > 1 wildcard" do
      expect(PatternMatcher.match("ab", "a*b*")).to eq(true)
      expect(PatternMatcher.match("aba", "a*b*a*")).to eq(true)
    end

    it "handles a mix of wildcards and plain letter runs" do
      expect(PatternMatcher.match("baabbbab", "ba*b*ab")).to eq(true)
      expect(PatternMatcher.match("aabbbab", "aab*ab*")).to eq(true)
    end

    it "matches lazily, not greedily" do
      expect(PatternMatcher.match("aabb", "a*ab*b")).to eq(true)
    end
  end
end
