class WebhookController < ApplicationController
  # before_filter :init_check_signature
  skip_before_filter  :verify_authenticity_token
  # respond_to :json

  def check_signature
    # cache_signatures = ActiveSupport::Cache::MemoryStore.new
    # cache_signatures.write('test','success')
    json_data = request.body.read
    # binding.pry
    # @request = Rails.cache.read('post_request')
    if json_data != ""
      Rails.cache.write('post_request',json_data)
      secret = "kevinsecretshhhhh"
      digest = OpenSSL::Digest.new('sha1')
      calculated_signature = OpenSSL::HMAC.hexdigest(digest, secret, json_data).prepend('sha1=')
      intercom_signature = request.env["HTTP_X_HUB_SIGNATURE"]
      # calculated_signature = "1234"
      # intercom_signature = "abcd"
      Rails.cache.write('calculated_signature',calculated_signature)
      Rails.cache.write('intercom_signature',intercom_signature)
      @calculated_signature = calculated_signature
      @intercom_signature = intercom_signature
    # else
    #   # binding.pry
    #   if Rails.cache.read('calculated_signature') != nil
    #     @calculated_signature = Rails.cache.read('calculated_signature')
    #     @intercom_signature = Rails.cache.read('intercom_signature')
    #   else
    #     @calculated_signature = "Nothing"
    #     @intercom_signature = "Received"
    #   end
    # end
    # # binding.pry
    # if @calculated_signature == @intercom_signature
    #   @success = "Woohoo!"
    # else
    #   @success = "Not the same!"
    # end
  end

  def check_signature_display
    # Get the cached request body
    @request = Rails.cache.read('post_request')
    @request = "No Request" if @request == ""

    # Check if there's a cached value for the signatures
    if Rails.cache.read('calculated_signature') != nil
      @calculated_signature = Rails.cache.read('calculated_signature')
      @intercom_signature = Rails.cache.read('intercom_signature')
    else
      @calculated_signature = "Nothing"
      @intercom_signature = "Received"
    end

    # Check if the signatures match
    if @calculated_signature == @intercom_signature
      @success = "Woohoo!"
    else
      @success = "Not the same!"
    end
  end
  # def init_check_signature
  #   cache_signatures = ActiveSupport::Cache::MemoryStore.new
  # end
end
