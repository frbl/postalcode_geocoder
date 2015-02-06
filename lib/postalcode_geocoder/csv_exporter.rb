module PostalcodeGeocoder
  class CsvExporter
    def export(data, google_data, filename, headers, col_sep=';', column_name='postcode')
      my_headers = Array.new(headers)
      CSV.open(filename, "wb",
               col_sep: col_sep,
               write_headers: true,
               headers: headers) do |csv|

        my_headers.delete column_name
        my_headers.delete LONGITUDE_COLUMN
        my_headers.delete LATITUDE_COLUMN
        data.each do |postal_code, object|
          puts postal_code
          arr = [postal_code]
          my_headers.each do |header|
            arr << object[header]
          end

          if object[LONGITUDE_COLUMN] && object[LATITUDE_COLUMN]
            arr << object[LONGITUDE_COLUMN]
            arr << object[LATITUDE_COLUMN]
          else
            if google_data[postal_code]
              arr << google_data[postal_code].longitude
              arr << google_data[postal_code].latitude
            else
              arr << nil
              arr << nil
            end
          end
          csv << arr
        end
      end
    end
  end
end