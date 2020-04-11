require 'rubygems'
require 'bundler/setup'
require 'roo'

module Parser
    class Excel
        attr_accessor :sheet

        SHEET_NAME = "Awesome People List-Master"
        def initialize(path)
            xlsx = Roo::Excelx.new(path)
            sheet = xlsx.sheet_for(SHEET_NAME)
            raise ::StandardError if sheet.nil?
            @sheet = sheet
        end

        def _find_table_headers_row_idx()
            start_row = @sheet.first_row
            end_row = @sheet.last_row

            headers_clue_string = 'full name'
            headers_row_idx = nil
            for i in start_row..end_row
                row = sheet.row(i)
                if row[1]&.downcase&.include?(headers_clue_string)
                    headers_row_idx = i
                    break
                end
            end

            raise ::StandardError if headers_row_idx.nil?
            headers_row_idx
        end

        def _parse_employees_from_sheet(table_headers, start_row, end_row)
            employees = []
            for i in start_row..end_row
                row = sheet.row(i)
                next if row.nil? || row[1].nil?

                employee = {}
                for j in 1..(table_headers.length)
                    employee[table_headers[j-1]] = row[j].nil? ? "" : row[j]
                end

                employee["name"] = employee["name"].downcase
                employee["country"] = employee["country"].downcase
                employees << employee
            end

            employees
        end

        def parse()
            start_row = @sheet.first_row
            end_row = @sheet.last_row

            table_headers_row_idx = _find_table_headers_row_idx
            table_headers = []
            table_headers_map = {
                "Full Name (first and last)" => "name",
                "Most recent title" => "job",
                "Most recent company" => "company",
                "Linkedin" => "linkedin",
                "Personal email address" => "email",
                "Function" => "function",
                "Country" => "country",
            }
            table_headers = @sheet.row(table_headers_row_idx).map{|val| table_headers_map[val]}.reject(&:nil?)
            
            employees = _parse_employees_from_sheet(table_headers, table_headers_row_idx+1, end_row)
        end
    end
end