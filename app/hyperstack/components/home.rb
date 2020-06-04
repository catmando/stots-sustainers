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
        { },
      paper: { padding: [WindowDims.height * WindowDims.width / 80_000, 5].max, margin: [WindowDims.height * WindowDims.width / 80_000, 5].max, opacity: 0.9, display: :flex, flexFlow: :row, overflow: :hidden },
      thermometer: { flex: 1, flexGrow: 30, paddingLeft: 30, backgroundColor: :white },
      message: { flex: 2, flexGrow: 70, margin: 5, padding: 10, fontSize: font_size}
    }
  end

  def total_gifts
    Gift.inject(0) { |total, gift| total + gift.amount } * 12
  end

  def thermometer_height
    (WindowDims.height - Header.height - 180)
  end

  def format_number(number)
    number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

  def thermometer
    percent_of_goal = "#{total_gifts/12000.0*100}%"
    puts percent_of_goal
    DIV(class: 'donation-meter') do
      STRONG { 'Our Goal' }
      STRONG(class: :goal) { '$12,000' }
      SPAN(class: :glass) do
        STRONG(class: :total, style: { bottom: percent_of_goal }) { "$#{format_number(total_gifts)}" }
        SPAN(class: :amount, style: { height: percent_of_goal })
      end
      DIV(class: :bulb) do
        SPAN(class: 'red-circle')
        SPAN(class: 'filler') { SPAN() }
      end
    end
  end

  render do
    DIV(class: 'row content') do
      #DIV(styles(:container)) do
        Mui::Paper(styles(:paper), elevation: 3, style: {height: 440}) do
          DIV(styles(:thermometer)) do
            thermometer
            #Thermometer(min: 0, max: 1000, width: 20, height: thermometer_height, backgroundColor: :blue, fillColor: :green, current: total_gifts)
          end

          DIV(styles(:message)) do
            P { "Welcome to the STOTS Board Meeting. Please consider a sustaining monthly gift."}
            P { "Our goal for the meeting is $12,000 annually in new sustaining gifts." }
            P { "Please give now, and give generously!" }
            P(style: {marginTop: 20}) { "So far we have raised $#{total_gifts}" }
          end
        end
      end
    #end
  end
end
