class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  #/app/models/　はdb:migrate不要
end
