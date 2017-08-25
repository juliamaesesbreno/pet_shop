class Animal < ApplicationRecord
	def self.search(animal)
 if animal
   where('Species LIKE ? OR Breed LIKE ? OR Status LIKE ? OR Price LIKE ?', "%#{animal}%","%#{animal}%","%#{animal}%","%#{animal}%").order('id DESC')
 else
   order('id DESC')
 end
end
end