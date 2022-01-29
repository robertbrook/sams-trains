require 'csv'

task :setup => [
  :import_scales,
  :import_locomotive_classes,
  :import_manufacturers,
  :import_operators,
  :import_liveries,
  :import_reviews
]

task :import_scales => :environment do
  puts "importing scales"
  CSV.open("db/data/scales.tsv", col_sep: "\t").each do |row|
    scale = Scale.find_by_name( row[0] )
    unless scale
      scale = Scale.new
      scale.name = row[0]
      scale.save
    end
  end
end

task :import_locomotive_classes => :environment do
  puts "importing locomotive classes"
  CSV.open("db/data/locomotive_classes.tsv", col_sep: "\t").each do |row|
    locomotive_class = LocomotiveClass.find_by_name( row[0] )
    unless locomotive_class
      locomotive_class = LocomotiveClass.new
      locomotive_class.name = row[0]
      locomotive_class.nickname = row[1]
      locomotive_class.wikidata_id = row[2]
      locomotive_class.save
    end
  end
end

task :import_manufacturers => :environment do
  puts "importing manufacturers"
  CSV.open("db/data/manufacturers.tsv", col_sep: "\t").each do |row|
    manufacturer = Manufacturer.find_by_name( row[0] )
    unless manufacturer
      manufacturer = Manufacturer.new
      manufacturer.name = row[0]
      manufacturer.wikidata_id = row[1]
      manufacturer.save
    end
  end
end

task :import_operators => :environment do
  puts "importing operators"
  CSV.open("db/data/operators.tsv", col_sep: "\t").each do |row|
    operator = Operator.find_by_name( row[0] )
    unless operator
      operator = Operator.new
      operator.name = row[0]
      operator.is_fictional = row[1]
      operator.full_name = row[2]
      operator.wikidata_id = row[3]
      operator.save
    end
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

task :import_reviews => :environment do
  puts "importing scales, models, reviews and links to scores"
  CSV.open("db/data/reviews.tsv", col_sep: "\t").each do |row|
    
    # We assume Sam only reviews a maximum of one locomotive a day ...
    # ... so we check to see if a review exists with a publication date of the review we're trying to import.
    review = Review.find_by_published_on( row[0] )
    
    # If there is no previously imported review with a publication date of the review we're trying to import ...
    unless review
      
      # ... we know this review has not been seen before and ...
      # ... we want to check if the review we're trying to import has been marked as completed.
      # If the review we're trying to import is marked as completed ...
      if row[15] == 'TRUE'
        
        
        # ... we import the review and associated data
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
    
        # Create scores where scores have been populated
        if column_valid?( row[10] )
          haulage_capability = HaulageCapability.find_by_number_of_coaches( row[10] )
          unless haulage_capability
            haulage_capability = HaulageCapability.new
            haulage_capability.number_of_coaches = row[10]
            haulage_capability.save
          end
        end
        if column_valid?( row[8] )
          detail_score = DetailScore.find_by_score( row[8] )
          unless detail_score
            detail_score = DetailScore.new
            detail_score.score = row[8]
            detail_score.save
          end
        end
        if column_valid?( row[9] )
          performance_score = PerformanceScore.find_by_score( row[9] )
          unless performance_score
            performance_score = PerformanceScore.new
            performance_score.score = row[9]
            performance_score.save
          end
        end
        if column_valid?( row[11] )
          mechanism_score = MechanismScore.find_by_score( row[11] )
          unless mechanism_score
            mechanism_score = MechanismScore.new
            mechanism_score.score = row[11]
            mechanism_score.save
          end
        end
        if column_valid?( row[12] )
          quality_score = QualityScore.find_by_score( row[12] )
          unless quality_score
            quality_score = QualityScore.new
            quality_score.score = row[12]
            quality_score.save
          end
        end
        if column_valid?( row[13] )
          value_score = ValueScore.find_by_score( row[13] )
          unless value_score
            value_score = ValueScore.new
            value_score.score = row[13]
            value_score.save
          end
        end
  
        # Create review
        review = Review.new
        review.score = row[14]
        review.published_on = row[0].to_date
        review.reviewed_as_part_of_trainset = row[2]
        review.youtube_url = row[1]
        review.model = model
        review.haulage_capability = haulage_capability
        review.detail_score = detail_score
        review.performance_score = performance_score
        review.mechanism_score = mechanism_score
        review.quality_score = quality_score
        review.value_score = value_score
        review.save
      end
    end
  end
end

def column_valid?( column )
  column_valid = true
  if column == 'Not given' or column.nil?
    column_valid = false
  end
  column_valid
end