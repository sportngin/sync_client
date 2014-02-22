SyncClient::Engine.routes.draw do
  match 'sync_client' => 'sync_client#sync', via: :post
end