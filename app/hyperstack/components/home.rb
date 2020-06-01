class Home < HyperComponent
  def p?(yes, no)
    WindowDims.portrait? ? yes : no
  end

  def font_size
    case WindowDims.area
    when :large
      25
    when :medium
      17
    else
      14
    end
  end

  styles do
    {
      container:
        { display: :flex, flexFlow: :row, overflow: :hidden},
      thermometer: { flex: 1, flexGrow: 30, paddingLeft: 30 },
      message: { opacity: 0.9, flex: 2, flexGrow: 70, margin: 5, padding: 10, fontSize: font_size}
        # padding: [WindowDims.height * WindowDims.width / 80_000, 5].max, margin: 5,
        # fontSize: font_size }
    }
  end

  def total_gifts
    Gift.inject(0) { |total, gift| total + gift.amount }
  end

  render do
    DIV(class: 'row content') do
      DIV(styles(:container)) do
        DIV(styles(:thermometer)) do
          Thermometer(min: 0, max: 1000, width: 20, height: WindowDims.height-250, backgroundColor: :blue, fillColor: :green, current: total_gifts)
        end

        Mui::Paper(styles(:message), elevation: 3) do
          P { "Welcome to the STOTS Board Meeting. Please consider a sustaining monthly gift."}
          P { "Our goal for the meeting is $1000 in new monthly gifts." }
          P { "Please give now, and give generously!" }
          P(style: {marginTop: 20}) { "So far we have raised $#{total_gifts}" }
        end
      end
    end
  end
end
