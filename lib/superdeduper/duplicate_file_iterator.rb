# frozen_string_literal: true

# Filters a collection based on the internal members aggregator
class DuplicateFileIterator
  include Enumerable

  def initialize(collection = [], duplicates: true)
    @collection = collection
    @duplicates = duplicates
  end

  def each(&block)
    grouped = @collection.group_by(&:aggregator) # How does this class know about the members internals...? coupling...?

    if @duplicates
      grouped.select { |k, v| v.length > 1 }.each(&block)
    else
      grouped.select { |k, v| v.length == 1 }.each(&block)
    end
  end
end
