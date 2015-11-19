module SyncClient
  class SyncClientController < ActionController::Base
    def sync
      if SyncClient::SubMessage.new(message_params).process
        render nothing: true, status: :ok
      else
        render nothing: true, status: :internal_server_error
      end
    end
  end

  private

  def message_params
    params.permit(:action, :object_type, :object_attributes)
  end
end