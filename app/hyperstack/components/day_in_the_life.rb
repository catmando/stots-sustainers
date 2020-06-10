class DayInTheLife < HyperComponent
  render do
    DIV(class: 'row content') do
      IFRAME(
        style: { position: :absolute, width: '100%', height: '100%', left: 0, top: 0 },
        allow: "accelerometer; autoplay; loop; encrypted-media; gyroscope; picture-in-picture",
        src:   "https://www.youtube.com/embed/hRiAp0MGN8Y?playlist=hRiAp0MGN8Y&autoplay=1&loop=1&controls=0"
      )
    end
  end
end
