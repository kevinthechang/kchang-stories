class WebhookController < ApplicationController
  # before_filter :init_check_signature
  skip_before_filter  :verify_authenticity_token
  # respond_to :json
  require 'json'

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

      # send response back to Intercom
      render json: { text: "Got it!", status: 200}

      # process conversation note and create user note
      parsed_json = JSON.parse(json_data)
      Rails.cache.write('webhook_topic', parsed_json.class)
      # item = json_data["data"]["item"]
      # # check if topic is conversation.admin.noted
      # if topic == "conversation.admin.noted"
      #   if item["conversation_parts"]["conversation_parts"][0]["body"] == "<p>webhook note</p>"
      #     userId = item["user"]["id"]
      #     intercom = Intercom::Client.new(app_id: 'umxbi8zj', api_key: '1da89d0c08354cc43301eca6bec0b25188903c41')
      #     note = intercom.notes.create(:body => "Note from Webhook", :id => userId)
      #   end
      # end

    end
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
      @topic = Rails.cache.read('webhook_topic')
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
