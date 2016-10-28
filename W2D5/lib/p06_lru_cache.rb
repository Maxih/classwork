require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)

    val = nil
    if @map[key].nil?
      val = @prc.call(key)
      link = @store.insert(key, val)
      @map[key] = link
    else
      val = @map[key].val
      update_link!(@map[key])
    end
    eject! if count > @max

    val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.remove(link)
    @store.insert(link.key, link.val)
  end

  def eject!

    to_delete = @store.first
    @map.delete(to_delete.key)
    @store.remove(to_delete.key)
  end
end
