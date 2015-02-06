require 'csv'

module PostalcodeGeocoder
  class FileParser
    def initialize(file_name)
      @file_name = file_name
    end

    def headers
      CSV.read(@file_name, headers:true, col_sep:';').headers
    end

    def parse(col_sep=';', column_name='postcode')
      postal_codes = {}
      CSV.foreach(@file_name, col_sep: col_sep, headers: true) do |row|
        r = row.to_h
        r.delete(column_name)
        postal_codes[row[column_name]] = r
      end
      postal_codes
    end
  end
end