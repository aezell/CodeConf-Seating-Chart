class Main
  get "/" do
    @seats = Seat.all
    @title = "Code Conf Seatr"
    if @seats.count == 0 then
      redirect '/create'
    end
    haml :home
  end

  get "/create" do
    rows = 17
    cols = 21

    for i in 0..rows
      for j in 0..cols

        s = Seat.new(
          :row => i,
          :col => j,
          :taken => true,
          :created => Time.now
        )

        if s.save then

        end

      end
    end

  end

  get "/seats.json" do
    @seats = Seat.all(:order => [ :row.asc, :col.asc  ])
    data = {}

    currentRow = nil
    temp = nil
    @seats.each do |seat|
      if seat.row != currentRow then
        data[seat.row] = {}
        currentRow = seat.row
      end

      data[seat.row][seat.col] = seat.taken ? "x" : nil

    end

    content_type :json
    data.to_json
  end

  get "/update/:id/mark/:taken[/]?" do
    seat = Seat.get(params[:id])
    seat.update(:taken => (params[:taken] == 'x'))
    if request.save then
      redirect '/'
      #"#{request.inspect}"
    end
  end
end