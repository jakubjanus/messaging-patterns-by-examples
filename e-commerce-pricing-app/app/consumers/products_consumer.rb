# frozen_string_literal: true

class ProductsConsumer < ApplicationConsumer
  def consume
    Rails.logger.info "Received #{messages.size} messages"
    messages.each { |message| log_message(message) }
  end

  private

  def log_message(message)
    log_msg = <<~LOG
      Payload:
        #{message.payload}
        headers: #{message.headers}
    LOG

    Rails.logger.info log_msg
  end
end
