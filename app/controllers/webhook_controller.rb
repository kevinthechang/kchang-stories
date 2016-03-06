class WebhookController < ApplicationController
  # require 'OpenSSL'
  # before_filter :init_check_signature
  #
  # def check_signature
  #   json_data = request.body.read
  #   @request = json_data
  #   if json_data != ""
  #     secret = "kevinsecretshhhhh"
  #     digest = OpenSSL::Digest.new('sha1')
  #     # @@calculated_signature = OpenSSL::HMAC.hexdigest(digest, secret, json_data).prepend('sha1=')
  #     # @@intercom_signature = request.env["HTTP_X_HUB_SIGNATURE"]
  #     @@calculated_signature = "1234"
  #     @@intercom_signature = "abcd"
  #     @calculated_signature = @@calculated_signature
  #     @intercom_signature = @@intercom_signature
  #   else
  #     if @@calculated_signature != nil
  #       @calculated_signature = @@calculated_signature
  #       @intercom_signature = @@intercom_signature
  #     else
  #       @calculated_signature = "Nothing"
  #       @intercom_signature = "Received"
  #     end
  #   end
  #   binding.pry
  #   if @calculated_signature == @intercom_signature
  #     @success = "Woohoo!"
  #   else
  #     @success = "Not the same!"
  #   end
  # end
  #
  # def init_check_signature
  #   @@calculated_signature ||= "Nothing"
  #   @@intercom_signature ||= "Received"
  # end
end
