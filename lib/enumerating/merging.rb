module Enumerating

  class Merger

    include Enumerable

    def initialize(enumerables, &transformer)
      @enumerables = enumerables
      @transformer = transformer
    end

    def each(&block)
      return to_enum unless block_given?
      Generator.new(@enumerables.map(&:to_enum), @transformer).each(&block)
    end

    class Generator

      def initialize(enumerators, transformer)
        @enumerators = enumerators
        @transformer = transformer
      end

      def each
        while true do
          discard_empty_enumerators
          break if @enumerators.empty?
          yield next_enumerator.next
        end
      end

      private

      def discard_empty_enumerators
        @enumerators.delete_if do |e|
          begin
            e.peek
            false
          rescue StopIteration
            true
          end
        end
      end

      def next_enumerator
        @enumerators.min_by { |enumerator| transform(enumerator.peek) }
      end

      def transform(item)
        return item unless @transformer
        @transformer.call(item)
      end

    end

  end

end

class << Enumerating
  
  def merging(*enumerables)
    Enumerating::Merger.new(enumerables)
  end

  def merging_by(*enumerables, &block)
    Enumerating::Merger.new(enumerables, &block)
  end
  
end
