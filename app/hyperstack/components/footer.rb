class Footer < HyperComponent
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
      #DIV(styles(:button)) do
        Mui::Button(:fullWidth, styles(:button), size: size, variant: :contained, color: :primary) do
          text
        end.on(:click, &block)
      #end
    end
    Mui::Grid(xs: 0, lg: 3)
  end

  def self.push_path(path)
    mutate App.history.push(path)
  end

  render do
    Mui::Container(styles(:container), class: 'row footer') do
      Mui::Grid(:container, spacing: 1) do
        unless App.location.pathname == '/give'
          button('Please Give') { Footer.push_path('/give') }
        end
      end
    end
  end
end
