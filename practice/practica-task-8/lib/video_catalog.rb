# A basic class for computer repo
class VideoCatalog
  PAGE_SIZE = 5

  def initialize(videos = [])
    @videos = videos
  end

  def <<(video)
    @videos << video
  end

  def current_amount
    @videos.size
  end

  def [](index)
    @videos[index]
  end

  def videos(page = 0)
    @videos[page * PAGE_SIZE, PAGE_SIZE].map.with_index do |video, index|
      {
        index: page * PAGE_SIZE + index,
        data: video
      }
    end
  end

  def page_count
    if @videos.size % PAGE_SIZE != 0
      @videos.size / PAGE_SIZE + 1
    else
      @videos.size / PAGE_SIZE
    end
  end

  def delete(index)
    @videos.delete_at(index)
  end
end
