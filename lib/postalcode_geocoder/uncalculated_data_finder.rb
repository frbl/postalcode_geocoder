module PostalcodeGeocoder
  class UncalculatedDataFinder
    def find_data(data)
      last_val = bsearch_highest_val(data)
      keys = data.keys[0..last_val]
      data.except(*keys)
    end

    private

    def bsearch_highest_val(data)
      values = data.values
      last_val = 0
      last_val = -1 if values[0][PostalcodeGeocoder::LONGITUDE_COLUMN].nil?
      index = data.size / 2
      adjuster = index
      while (last_val < data.size && !values[last_val+1][PostalcodeGeocoder::LONGITUDE_COLUMN].nil?) do
        puts index
        if values[index][PostalcodeGeocoder::LONGITUDE_COLUMN].nil?
          adj = -1
        else
          last_val = index
          adj = 1
        end
        puts adjuster
        adjuster = (adjuster / 2)
        index += adj * (adjuster + 1)
      end
      last_val
    end

  end
end