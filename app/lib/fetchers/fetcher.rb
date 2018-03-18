module Fetchers
  class Fetcher
    def self.call *args
      new.call *args
    end

    def save_json_data_to_config file_path
      File.open(file_path, 'w') do |f|
        f.write json_data.to_json
      end
    end

    def find_incorrect_answers key, correct_answer
      json_data.select do |country|
        country[key] != correct_answer
      end.uniq.map do |country|
        country[key]
      end.shuffle.sample(3)
    end
  end
end
