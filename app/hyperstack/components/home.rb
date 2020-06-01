class Home < HyperComponent
  render do
    DIV(class: 'row content') do
      DIV(styles(:container)) do
        'HOME'
      end
    end
  end
end
