module Commands
    def self.interactive
        excel_path = "./layoffs.xlsx"

        unless File.exist?(excel_path)
            excel_url = "https://docs.google.com/spreadsheets/u/0/d/1U13Ef3EnJnMzuElElAJPbWiNBKutQuB7ldQED4C8L_Y/export?format=xlsx"
            download = open(excel_url)
            IO.copy_stream(download, excel_path)
        end
        
        excel_parser = Parser::Excel.new(excel_path)

        employees = excel_parser.parse
        employees.each do |employee|
            begin
                Employee.create(employee)
            rescue ActiveRecord::RecordNotUnique
                puts "Record Not Unique #{employee}"
            end
        end

        prompt = "> "
        while buf = Readline.readline(prompt, true)
            case(buf)
            when "exit", "quit", "exit()", "quit()"
                break
            else
                records_array = ActiveRecord::Base.connection.execute(buf)
                puts records_array
            end
        end
    end
end