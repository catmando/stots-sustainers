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
    next unless WindowDims.width > 700 && WindowDims.height > 700

    font_size = [100, Header.height * 0.5].min
    {
      app_bar: { minHeight: Header.height, paddingTop: 20, paddingBottom: 20, paddingRight: 60 },
      tool_bar: { width: '100%', textAlign: :center, fontSize: font_size},
      menu_icon: { fontSize: font_size },
      hero: { width: '100%', fontSize: font_size },
      menu_item: { fontSize: font_size / 2 }
    }
  end

  def menu_link(path, text)
    #return if App.campaign&.slug.blank?
    return if "/#{App.campaign.slug}/#{path}" == App.location.pathname

    Mui::MenuItem(styles(:menu_item)) { text }
    .on(:click) do
      Footer.push_path(path)
      Header.close_menu!
    end
  end

  render(DIV, id: :app_bar, class: 'row header', style: {zIndex: 99, marginBottom: 5}) do
    Mui::AppBar(styles(:app_bar), position: :relative, id: 'header') do
      Mui::Toolbar(styles(:tool_bar)) do
        Mui::IconButton(edge: :start, color: :inherit, aria: {label: :menu, controls: :menu, haspopup: true}) do
          Icon::Menu(styles(:menu_icon), id: :nav_menu)
        end.on(:click) { Header.open_menu! unless App.campaign&.slug.blank? }
        Mui::Typography(styles(:hero)) { 'Become a STOTS Sustainer Today' }
      end
    end
    Mui::Menu(:keepMounted, id: :menu, anchorEl: Header.menu_anchor, open: Header.menu_open?) do
      menu_link('home',            'Home')
      menu_link('day-in-the-life', 'A Day In The Life')
      menu_link('mission',         'Our Mission')
      menu_link('from-the-rector', 'A Message From The Rector')
      menu_link('why-support',     'Why Support STOTS?')
      menu_link('give',            'Give Generously')
      menu_link('pick-campaign',   'Change Event')
    end.on(:close) { Header.close_menu! } if Header.menu_open?
  end
end
