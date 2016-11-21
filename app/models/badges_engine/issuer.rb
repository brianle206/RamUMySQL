module BadgesEngine
	class Issuer
		include ActiveModel::Validations
		include ActiveModel::Serialization

		validates_presence_of :name, :url

		attr_accessor :name, :url

		def initialize(attrs={})
			@name  = attrs[:name]
			@url   = attrs[:url]
		end
	end
end
