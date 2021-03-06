require 'uri'
require 'json'
require 'net/http'

class Assertion < ActiveRecord::Base
	#has_one :badge
	#has_one :user

	validates_presence_of :badge_id
	validates_presence_of :user_id

	before_validation(on: :create) do
	  #self.token = SecureRandom.urlsafe_base64(16)
	  self.uid = SecureRandom.urlsafe_base64(8)
	end

	# after_commit :bake, :if => :update_assertion?

	# def recipient
	# 	self.recipient.to_json
	# end

  # def verify
  #   self.verify.to_json
  # end
		
	def update_assertion?
		persisted? && !is_baked?
	end

	def baking_callback_url
		"/assertions/#{self.id}/#{self.uid}.json"
	end

  def bake
    #uri = URI.parse(BadgesEngine::Configuration.baker_url)
    uri = URI.parse('http://bakery.openbadges.org')
    http = Net::HTTP.new(uri.host, uri.port)
    path = "#{uri.path}?assertionUrl=#{self.baking_callback_url}"
    headers = {'Content-Type'=>'application/json','Accept'=>'application/json'}
    logger.debug("request: #{uri.host}#{path}")
    response = http.get(path, headers)
    
    unless response.kind_of?(Net::HTTPSuccess)
      raise "Baking badge failed: Response was not a success:\n\t'#{response.inspect}'"
    end

    if !response || response.body.blank?
      raise "Baking badge failed: Response was blank:\n\t'#{response.inspect}'"
    end
    
    badges_response = ActiveSupport::JSON.decode(response.body)
    logger.debug("response: #{badges_response.inspect}")
    
    if badges_response['status'] == 'success'
      self.update_attribute(:is_baked, true)
    else
      raise "Baking badge failed:\n\tStatus:'#{badges_response['status']}'\n\tError:'#{badges_response['error']}'\n\tReason:'#{badges_response['reason']}'"
    end
  end
  
  def open_badges_as_json
    as_json( only: [:uid, :recipient, :badge, :verify, :issuedOn, :expires] )
  end
end

