class EchosController < ApplicationController

  before_action :client, only: :create
  protect_from_forgery except: :create

  def index
    render :json => "HEllo"
  end

  def create
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    head :bad_request if !@client.validate_signature(body, signature)

    events = @client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: event.message['text']
          }
          @client.reply_message(event['replyToken'], message)
        end
      end
    end

    head :ok
  end

  private

  def client
    @client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end
  end
end
