# frozen_string_literal: true

TAB = "\t"
NEWLINE = "\n"

# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  attr_accessor :data

  def initialize
    @data
  end

  # Converts a String with TSV data into internal data structure @data
  # arguments: tsv - a String in TSV format
  # returns: nothing
  def take_tsv(tsv)
    rows = tsv.split(NEWLINE).map { |line| line.split(TAB) }
    headers = rows.first
    data_rows = rows[1..]

    @data = data_rows.map do |row|
      row.map.with_index { |cell, i| [headers[i], cell] }.to_h
    end
  end

  # Converts @data into tsv string
  # arguments: none
  # returns: String in TSV format
  def to_tsv
    headers = @data[0].keys.join(TAB)
    rows = @data.map { |hash| hash.values.join(TAB) }.join(NEWLINE)
    (headers + NEWLINE + rows + NEWLINE).to_s
  end
end
