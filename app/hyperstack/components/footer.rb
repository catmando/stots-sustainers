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
          button('Select Event') { Header.open_menu! }
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
