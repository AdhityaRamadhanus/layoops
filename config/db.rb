ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => ":memory:"
)

ActiveRecord::Schema.define do
    unless ActiveRecord::Base.connection.tables.include? 'employees'
        create_table :employees do |table|
            table.column :name, :string
            table.column :job, :string
            table.column :company, :string
            table.column :country, :string
            table.column :email, :string
            table.column :linkedin, :string
            table.column :function, :string
        end

        add_index :employees, [:name, :company, :country], :unique => true
    end
end

