namespace :slurp do
  desc "TODO"
  task assets: :environment do
  
    require "csv"

    csv_text = File.read(Rails.root.join("lib", "csvs", "assets_csv.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      puts row.to_hash
      a = Asset.new
      a.ticker = row["ticker"]
      a.name = row["name"]
      a.asset_type = row["type"]
      a.save
      puts "#{a.name} saved"
    end

    puts "There are now #{Asset.count} rows in the Assets table."
  
  end
end
