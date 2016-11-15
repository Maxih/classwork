require 'json'

class Flash
  attr_accessor :now

  def initialize(req)
    @now = JSON.parse(req.cookies['_rails_lite_app_flash']) if req.cookies['_rails_lite_app_flash']
    @now ||= {}
    @now = FlashStore.new(@now)
    @flash = FlashStore.new
  end

  def [](key)
    @now[key.to_s] || @flash[key.to_s]
  end

  def []=(key, val)
    @flash[key.to_s] = val
  end
  
  def store_flash(res)
    res.set_cookie('_rails_lite_app_flash', @flash.to_json)
  end
end

class FlashStore
  def initialize(store = {})
    @store = store
  end

  def [](key)
    @store[key.to_s]
  end

  def []=(key, val)
    @store[key.to_s] = val
  end

  def to_json
    @store.to_json
  end
end
flash = Flash.new
flash.now[:key] = :value
