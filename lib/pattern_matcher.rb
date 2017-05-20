require "pattern_matcher/version"

module PatternMatcher
  def self.match(input, pattern)
    letters = input.split ""
    self.match_list(letters, pattern)
  end

  private

  def self.match_list(letters, pattern)
    if pattern == ""
      letters == []
    else
      initial_pattern, rest_of_pattern = partition_pattern(pattern)
      pattern_letter = initial_pattern[0]

      if zero_or_more_pattern? initial_pattern
        lazy_match?(letters, pattern_letter, rest_of_pattern)
      else
        letters[0] == pattern_letter &&
          match_list(letters[1, letters.length], rest_of_pattern)
      end
    end
  end

  # expects pattern to be a string with length >= 1
  def self.partition_pattern(pattern)
    if pattern.length > 1
      if pattern[1] == "*"
        # "a*bab*a" -> ["a*", "bab*a"]
        [pattern.slice(0, 2), pattern.slice(2, pattern.length)]
      else
        # "abab*a" -> ["a", "bab*a"]
        [pattern[0], pattern.slice(1, pattern.length)]
      end
    else
      # "b" -> ["b", ""]
      [pattern[0], ""]
    end
  end

  def self.zero_or_more_pattern?(pattern)
    pattern.length > 1
  end

  def self.lazy_match?(letters, pattern_letter, rest_of_pattern)
    return true if letters == []

    letters.each_with_index do |letter, index|
      if letter != pattern_letter
        return match_list(letters[index, letters.length], rest_of_pattern)
      else
        rest_of_input = letters[index + 1, letters.length]
        if match_list(rest_of_input, rest_of_pattern)
          return true
        end
      end
    end

    return false
  end
end
