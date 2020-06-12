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
      paper: { padding: [WindowDims.height * WindowDims.width / 80_000, 3].max, margin: [WindowDims.height * WindowDims.width / 80_000, 3].max, opacity: 0.9, display: :flex, flexFlow: :row, overflow: :hidden },
      thermometer: { backgroundColor: :white },
      message: { margin: 5, padding: 10, fontSize: font_size}
    }
  end

  def total_gifts
    App.campaign.gifts.inject(0) { |total, gift| total + gift.annual_amount }
  end

  def format_number(number)
    "$#{number.to_i.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
  end

  def percent_of_goal
    total_gifts / App.campaign.goal.to_f * 100
  end

  def glass_height
    if WindowDims.height < 360
      50
    elsif WindowDims.height < 375
      70
    elsif WindowDims.height < 411
      85
    elsif WindowDims.height < 767
      120
    else
      (WindowDims.height-300)*0.5
    end
  end

  def thermometer
    DIV(class: 'donation-meter') do
      STRONG { 'Our Goal' }
      STRONG(class: :goal) { format_number(App.campaign.goal) }
      SPAN(class: :glass, style: {height: glass_height}) do
        STRONG(class: :total, style: { bottom: "#{[percent_of_goal, 92].min}%" }) { format_number(total_gifts) }
        SPAN(class: :amount, style: { height: "#{[percent_of_goal, 97].min}%" })
      end
      DIV(class: :bulb) do
        SPAN(class: 'red-circle')
        SPAN(class: 'filler') { SPAN() }
      end
    end
  end

  REMARKABLE = `new Remarkable({html: true})`

  render do
    DIV(class: 'row content') do
      Mui::Paper(styles(:paper), elevation: 3) do
        DIV(styles(:thermometer)) do
          thermometer
        end
        DIV(styles(:message)) do
          DIV(dangerously_set_inner_HTML: { __html:  `#{REMARKABLE}.render(#{App.campaign.greeting.to_s})`})
        end
      end
    end
  end
end
