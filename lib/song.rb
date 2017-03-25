class Song
  attr_accessor :name, :artist_name
  # read/write to :name & :artist_name class properties

  # like a bucket of stuff I refer back to constantly
  @@all = []
  # holds all new instances of class objects

# class methods
  
  def self.all
    @@all
    # returns the array of all class objects
  end

  def save # helper method for create class constructors
    self.class.all << self
    # adds the current object instance to the @@all class objects array
  end

  # class constructors

  def self.create 
    song = self.new
    song.save
    song
    # creates a new class object instance, saves, and returns song instance
  end

  def self.new_by_name(name) # helper method for self.create_by_name(name)
    song = self.new
    song.name = name
    song
    # creates a new class instance with name argument, returns song instance
  end
  
  def self.create_by_name(name) # helper method for find_or_create_by_name(name)
    song = self.new_by_name(name)
    song.save
    song
    # creates a new class instance with name argument, saves, and returns instance
  end

  # finder class methods
  
  def self.find_by_name(name) # helper method for find_or_create_by_name(name)
    @@all.find { |song| song.name == name }
    # find the first song in all @@all array that matches X name
  end 

  def self.find_or_create_by_name(name)
    if self.all.include?(self.name)
      self.find_by_name(name)
    else 
      self.create_by_name(name)
    end
    #  @@all for song instance, returns it, or 
    # creates a new instance using name argument using create_by_name
  end

  def self.alphabetical
    self.all.sort_by { |song| song.name }
    # returns all the songs in ascending alphabetical order
  end

  def self.new_from_filename(filename)
    split_file = filename.split(" - ")
    artist_name = split_file[0]
    song_name = split_file[1]

    song = self.new
    song.name = song_name.chomp(".mp3")
    song.artist_name = artist_name
    song
    # split file name into artist name and song name
    # create a new song instance - does not save
    # modifies song name to remove attached file extension
    # returns song
  end

  def self.create_from_filename(filename)
    split_file = filename.split(" - ")
    artist_name = split_file[0]
    song_name = split_file[1]

    song = self.create
    song.name = song_name.chomp(".mp3")
    song.artist_name = artist_name
    song
    # split file into artist and song name
    # create new song instance -> which saves object
    # remove extension, set song name and artist name
    #
  end

  def self.destroy_all
    self.all.clear
    # clear all the objects from the @@all class array
  end
  
end
