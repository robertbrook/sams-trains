class Operator < ApplicationRecord
  
  has_many :liveries, -> { order 'name' }
  
  def models
    Model.find_by_sql(
      "
        SELECT m.*, s.name as scale_name, man.name as manufacturer_name, o.name as operator_name, l.name as locomotive_class_name
        FROM models m, scales s, manufacturers man, operators o, locomotive_classes l
        WHERE m.scale_id = s.id
        AND m.manufacturer_id = man.id
        AND m.operator_id = o.id
        AND m.locomotive_class_id = l.id
        AND o.id = #{self.id}
        ORDER BY scale_name, manufacturer_name, locomotive_class_name, operator_name
      "
    )
  end
  
  def title
    title = self.name
    title += ' (' + self.full_name + ')' if self.full_name
    title
  end
  
  def wikidata_url
    "https://www.wikidata.org/wiki/" + self.wikidata_id
  end
  
  def wikipedia_url
    "https://www.wikidata.org/wiki/Special:GoToLinkedPage/enwiki/" + self.wikidata_id
  end
end
