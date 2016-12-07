module ApplicationHelper

	def link_to_add_fields(name, f, association)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.singularize + "_fields", f: builder)
		end
		link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
	end

	def will_paginate(collection_or_options = nil, options = {})
	    if collection_or_options.is_a? Hash
	      options, collection_or_options = collection_or_options, nil
	    end
	    unless options[:renderer]
	      options = options.merge :renderer => BootstrapPagination::Rails
	    end
	    super *[collection_or_options, options].compact
	end

	def grab_profile(id)
		@avatar = Profile.find_by(user_id: id)
	end

end
