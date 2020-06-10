class Header < HyperComponent
  include Hyperstack::Router::Helpers

  def self.open_menu!
    mutate @menu_up = true
  end

  def self.close_menu!
    mutate @menu_up = false
  end

  def self.menu_open?
    observe !!@menu_up
  end

  def self.menu_anchor
    `#{jQ['#nav_menu']}[0]`
  end

  def self.height
    [160, [56, WindowDims.width / 1900 * 170].max].min
  end

  styles do
    next {menu_item: { whiteSpace: :normal } } unless WindowDims.width > 700 && WindowDims.height > 700

    font_size = [100, Header.height * 0.5].min
    {
      app_bar: { minHeight: Header.height, paddingTop: 20, paddingBottom: 20, paddingRight: 60 },
      tool_bar: { width: '100%', textAlign: :center, fontSize: font_size},
      menu_icon: { fontSize: font_size },
      hero: { width: '100%', fontSize: font_size },
      menu_item: { fontSize: font_size / 2, whiteSpace: :normal }
    }
  end

  def menu_link(path, text, &block)
    return if "/#{App.campaign.slug}/#{path}" == App.location.pathname

    Mui::MenuItem(styles(:menu_item)) { text }
    .on(:click) do
      Footer.push_path(path)
      Header.close_menu!
      block.call if block
    end
  end

  render(DIV, id: :app_bar, class: 'row header', style: {zIndex: 99, marginBottom: 5}) do
    Mui::AppBar(styles(:app_bar), position: :relative, id: 'header') do
      Mui::Toolbar(styles(:tool_bar)) do
        Mui::IconButton(edge: :start, color: :inherit, aria: {label: :menu, controls: :menu, haspopup: true}) do
          Icon::Menu(styles(:menu_icon), id: :nav_menu)
        end.on(:click) { Header.open_menu! }
        Mui::Typography(styles(:hero)) { 'Become a STOTS Sustainer Today' }
      end
    end
    Mui::Menu(:keepMounted, id: :menu, anchorEl: Header.menu_anchor, open: Header.menu_open?) do
      if App.campaign&.slug.blank?
        Mui::MenuItem(styles(:menu_item)) do
          B { 'Select Your Event...' }
        end
        Mui::Divider()
        Campaign.each do |campaign|
          Mui::MenuItem(styles(:menu_item), value: campaign.slug) do
            campaign.name
          end.on(:click) do
            App.history.push("/#{campaign.slug}")
            Header.close_menu!
          end
          Mui::Divider() unless campaign == Campaign.last
        end
      else
        menu_link('home',            'Home')
        menu_link('day-in-the-life', 'A Day In The Life')
        menu_link('mission',         'Our Mission')
        menu_link('from-the-rector', 'A Message From The Rector')
        menu_link('why-support',     'Why Support STOTS?')
        menu_link('give',            'Give Generously')
        menu_link('pick-campaign',   'Change Event') { after(0) { Header.open_menu! } }
      end
    end.on(:close) { Header.close_menu! } if Header.menu_open?
  end
end
