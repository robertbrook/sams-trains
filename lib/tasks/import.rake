require 'csv'

task :setup => [
  :import_scales,
  :import_locomotive_classes,
  :import_manufacturers,
  :import_operators,
  :import_liveries,
  :import_scores,
  :import_coaches,
  :import_reviews
]

task :import_scales => :environment do
  puts "importing scales"
  CSV.open("db/data/scales.tsv", col_sep: "\t").each do |row|
    scale = Scale.new
    scale.name = row[0]
    scale.save
  end
end

task :import_locomotive_classes => :environment do
  puts "importing locomotive classes"
  CSV.open("db/data/locomotive_classes.tsv", col_sep: "\t").each do |row|
    locomotive_class = LocomotiveClass.new
    locomotive_class.name = row[0]
    locomotive_class.nickname = row[1]
    locomotive_class.wikidata_id = row[2]
    locomotive_class.save
  end
end

task :import_manufacturers => :environment do
  puts "importing manufacturers"
  CSV.open("db/data/manufacturers.tsv", col_sep: "\t").each do |row|
    manufacturer = Manufacturer.new
    manufacturer.name = row[0]
    manufacturer.wikidata_id = row[1]
    manufacturer.save
  end
end

task :import_operators => :environment do
  puts "importing operators"
  CSV.open("db/data/operators.tsv", col_sep: "\t").each do |row|
    operator = Operator.new
    operator.name = row[0]
    operator.full_name = row[1]
    operator.is_fictional = row[2]
    operator.wikidata_id = row[3]
    operator.save
  end
end

task :import_liveries => :environment do
  puts "importing liveries"
  CSV.open("db/data/liveries.tsv", col_sep: "\t").each do |row|
    livery = Livery.new
    livery.name = row[0]
    livery.is_fictional = row[1]
    livery.save
  end
end

task :import_scores => :environment do
  puts "importing scores"
  CSV.open("db/data/scores.tsv", col_sep: "\t").each do |row|
    score = Score.new
    score.score = row[0]
    score.save
  end
end

task :import_coaches => :environment do
  puts "importing coaches"
  CSV.open("db/data/reviews.tsv", col_sep: "\t").each do |row|
    if row[10] != 'Not given' and !row[10].nil?
      coach = Coach.find_by_number( row[10] )
      unless coach
        coach = Coach.new
        coach.number = row[10]
        coach.save
      end
    end
  end
end

task :import_reviews => :environment do
  puts "importing models, reviews and links to scores"
  CSV.open("db/data/reviews.tsv", col_sep: "\t").each do |row|
    if row[10] != 'Not given' and !row[10].nil?
    
      # Get relationships from model
      scale = Scale.find_by_name( row[4] )
      locomotive_class = LocomotiveClass.find_by_name( row[6] )
      manufacturer = Manufacturer.find_by_name( row[3] )
      operator = Operator.find_by_name( row[5] )
      livery = Livery.find_by_name( row[7] )
      
      # Link the livery to the operator
      if livery
        livery.operator = operator
        livery.save
      end
    
      # Create model
      model = Model.new
      model.scale = scale
      model.locomotive_class = locomotive_class
      model.manufacturer = manufacturer
      model.operator = operator
      model.livery = livery if livery
      model.save
    
      # Create review
      review = Review.new
      review.score = row[14]
      review.published_on = row[0].to_date
      review.reviewed_as_part_of_trainset = row[2]
      review.youtube_url = row[1]
      review.model = model
      review.save
      
      # Create link to scores
      coach = Coach.find_by_number( row[10] )
      haulage_capability = HaulageCapability.new
      haulage_capability.review = review
      haulage_capability.coach = coach
      haulage_capability.save
      
      # Create link to detail score.
      score = Score.find_by_score( row[8] )
      detail_score = DetailScore.new
      detail_score.review = review
      detail_score.score = score
      detail_score.save
      
      # Create link to performance score.
      score = Score.find_by_score( row[9] )
      performance_score = PerformanceScore.new
      performance_score.review = review
      performance_score.score = score
      performance_score.save
      
      # Create link to mechanism score.
      score = Score.find_by_score( row[11] )
      mechanism_score = MechanismScore.new
      mechanism_score.review = review
      mechanism_score.score = score
      mechanism_score.save
      
      # Create link to quality score.
      score = Score.find_by_score( row[12] )
      quality_score = QualityScore.new
      quality_score.review = review
      quality_score.score = score
      quality_score.save
      
      # Create link to value score.
      score = Score.find_by_score( row[13] )
      value_score = ValueScore.new
      value_score.review = review
      value_score.score = score
      value_score.save
    end
  end
end