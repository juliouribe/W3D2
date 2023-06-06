class Card
  attr_reader :faceup, :value

  def initialize(value)
    @value = value
    @faceup = false
  end

  def hide
    @faceup = false
  end

  def reveal
    @faceup = true
  end

  def to_s
    showing = @faceup ? 'face-up' : 'face-down'
    "#{@value} is #{showing}"
  end

  def ==(element)
    @value == element
  end
end
