class Footer < HyperComponent

  param :pathname

  styles do
    # override default button style if we have enough space
    {
      button: WindowDims.area == :large ? { minHeight: 60, fontSize: 40 } : {},
      container: { marginTop: 5, marginBottom: 5, width: '100%' }
    }
  end

  def size
    WindowDims.width > 1000 ? :large : :medium
  end

  def button(text, &block)
    Mui::Grid(xs: 0, lg: 3)
    Mui::Grid(:item, xs: 12, lg: 6) do
      Mui::Button(:fullWidth, styles(:button), size: size, variant: :contained, color: :primary) do
        text
      end.on(:click, &block)
    end
    Mui::Grid(xs: 0, lg: 3)
  end

  def give_buttons(text, &block)
    Mui::Grid(xs: 0, lg: 1)
    Mui::Grid(:item, xs: 6, lg: 5) do
      Mui::Button(:fullWidth, styles(:button), size: size, variant: :contained, color: :primary) do
        'Return Home'
      end.on(:click) { Footer.push_path('home') }
    end
    Mui::Grid(:item, xs: 6, lg: 5) do
      Mui::Button(:fullWidth, styles(:button), size: size, variant: :contained, color: :primary) do
        text
      end.on(:click, &block)
    end
    Mui::Grid(xs: 0, lg: 1)
  end

  def choose_event
    Mui::Grid(xs: 0, lg: 3)
    Mui::Grid(:item, xs: 12, lg: 6) do
      Mui::FormControl(variant: :outlined, style: {width: '100%', fontSize: 20}) do
        Mui::InputLabel(htmlFor: "select-event-label") { 'Select Event' }
        Mui::Select(
          style: {background: :white, width: '100%', fontSize: 10},
          labelId: "select-event-label",
          id: 'select-event'
         ) do
          Campaign.each do |campaign|
            Mui::MenuItem(value: campaign.slug, style: {whiteSpace: :normal}) { campaign.name }
            Mui::Divider() unless campaign == Campaign.last
          end
        end.on(:click) { |evt| App.history.push("/#{evt.target.value}") }
      end
    end
    Mui::Grid(xs: 0, lg: 3)
  end

  def self.push_path(path)
    mutate App.history.push(
      "#{'/' + App.campaign.slug unless path == 'pick-campaign'}/#{path}"
    )
  end

  render do
    return '' if pathname == '/'
    Mui::Container(styles(:container), class: 'row footer') do
      Mui::Grid(:container, spacing: 1) do
        if pathname == '/pick-campaign'
          choose_event
        elsif /give$/.match? pathname
          give_buttons('One Time Gift') { Footer.push_path('one-time-gift') }
        elsif /one-time-gift$/.match? pathname
          give_buttons('Monthly Gift') { Footer.push_path('give') }
        else
          button('Please Give') { Footer.push_path('give') }
        end
      end
    end
  end
end
