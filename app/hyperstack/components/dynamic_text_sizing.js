//= require 'vendor/FontMetrics.min.js'
//= require 'vendor/opentype.min.js'
//= require 'jquery.svg.js'
//= require 'jquery.svgdom.js'

(function($) {
  // gives us back a doogin id
  doogin_general_id_extract = function(regex, jquery_obj, match_index, attr) {
    match_obj = jquery_obj.attr(attr).match(regex)
    if(match_obj) { return match_obj[match_index]; }
    return null;
  }

  doogin_field_to_id = function(jquery_field){
    return doogin_general_id_extract(/doogin-text-field-(\d+)/, jquery_field, 1, 'class');
  }

  // takes an id and selects all doogin_text_fields associated with it
  doogin_id_to_fields = function(id){
    return $('.doogin-text-field-' + id);
  }

  // this takes one of the doogin text boxes and gets the doogin-id
  doogin_input_to_id = function(jquery_input_field){
    return doogin_general_id_extract(/doogin-input-field-(\d+)/, jquery_input_field, 1, 'id');
  }

  link_to_id = function(jquery_input_field){
    return doogin_general_id_extract(/field-group-(\d+)/, jquery_input_field, 1, 'class');
  }

  function FontSizeDict() {
    this.size_dict = {}
    // for now we assume that this is correctly initialized and built.
    this.field_id_to_group_ids = {}
    this.current_path = "";

    // determines if a FontSizeDict has been initialized for the CURRENT
    // Doodle background, makes sure this does not persist between pages
    this.initialized = function() {
      return this.current_path == window.location.pathname;
    }

    // return the minimum size in all fields that share a group_id, or if none
    // are initialized return NaN
    this.get_size_by_id = function(id){
      var outer_scope = this;
      var link_array = this.field_id_to_group_ids[id] || {};
      var min_size = NaN;
      for(var i = 0; i < link_array.length; ++i){
        var current_size = this.size_dict[link_array[i]];
        if(current_size && (!min_size || current_size < min_size)){
          min_size = current_size
        }
      }
      return min_size;
      //return Math.min.apply(null, this.field_id_to_group_ids[id].map(function(assc_id) {return outer_scope.size_dict[assc_id]} ));
    }

    // private method to factor out some of the logic below
    this._valid_font_size = function(font_size){
      return font_size && font_size > 0
    }
    // updates jquery_fields to integral value size
    this.update_size_by_id = function(id, size){
      var outer_scope = this;
      var prev_min = this.get_size_by_id(id)
      this.size_dict[id] = size;
      if(prev_min != this.get_size_by_id(id) && this._valid_font_size(size)){
        if (id && this.field_id_to_group_ids[id].length > 1) {
          this.field_id_to_group_ids[id].forEach(function(id_val){
            if(id_val != id) {
              // don't need to redraw current min sized element
              this.redraw(id_val);
            }
          }.bind(this)) // need to bind this so we can use this functions scope inside forEach
        }
      }
    }
    this.update_size_by_field = function(field, size){
      return this.update_size_by_id(doogin_field_to_id(field),size);
    }
    this.redraw = function(id){
      console.debug('redrawing element due to resize')
      var field_string = 'doogin-text-field-' + id
      var value = $('#doogin-input-field-' + id).val()
      $('div.'+field_string).attr('doogin-field-value', value).draw_text();
    }

    this.initialize = function(force){
      if(!this.initialized() || force || false){
        this.build_dict();
        this.initialize_size_dict();
        this.current_path = window.location.pathname;
      }
    }

    this.initialize_size_dict = function(){
      Object.keys(this.field_id_to_group_ids).forEach(function(key){
        this.size_dict[key] = NaN;
      }, this)
    }

    this.build_dict = function(){
      // first we just want to add each field to an array with just itself
      // need to reset size_dict and linked fields as jQuery objects persist across page changes
      this.size_dict = {}
      this.field_id_to_group_ids = {}
      var outermost_this = this;
      $("div[class*='doogin-text-field']").each(function() {
          var id = doogin_field_to_id($(this));
          outermost_this.field_id_to_group_ids[id] = outermost_this.field_id_to_group_ids[id] || [id]
        });
      // now we need to take care of linking these field
      var linked_fields = $("textarea[class*='field-group-']")
      linked_fields.each(function() {
        var outer_id = doogin_input_to_id($(this));
        var link_id = link_to_id($(this));
        //var to_link = $('field-group-' + link_id, linked_fields);
        var to_link = linked_fields.filter('.field-group-' + link_id)
        to_link.each(function(){
          var inner_id = doogin_input_to_id($(this));
          if(outer_id != inner_id){
            outermost_this.field_id_to_group_ids[outer_id].push(inner_id);
          }
        });
      });
    }
  }

  var loaded_fonts = {},
      field_values = {},
      font_size_dict = new FontSizeDict();

  window.loaded_fonts = loaded_fonts;

  $.get_bg_id = function() {
    window.location.pathname
  }

  $.get_font_dict = function() {
    return font_size_dict;
  }

  // should add our datastructure here so that it persists.

  $.loaded_fonts = function (fontURL) {
    return loaded_fonts[fontURL];
  }

  // gets called every time that a field is updated
  $.doogin_field_update = function (field, value) {
    console.debug("calling doogin field update");
    field_values[field] = value;
    // a hack to get doodle-peview to work on the doodlebin side
    field = field.replace('input','text')
    $('div.'+field).attr('doogin-field-value', value).draw_text();
  }

  $.load_fonts = function() {
    $("img.doogin-loading").one("load", function() {
      $(this).removeClass('doogin-loading')
    }).each(function() {
      if(this.complete) $(this).trigger('load');
    });

    // this stays in dynamic_text_sizing because its needed for pdf rendering
    var interval = setInterval(function() {
      if ($('.doogin-loading').length === 0) {
        clearInterval(interval);

        setTimeout(function() {
          console.debug("Fonts and images are loaded.");

          $('.show_on_ready').show();
          $('.doogin-text').show();
          $('.doodle-artwork').css({'opacity': '1', 'height': 'auto'});
          $('.doodle-gallery-item-loader').css('display', 'none');
          $('body').attr('id', 'page-loaded');

          window.status = "LOADED";
          $(document).trigger('doodle_ready');

          console.debug("!! DOODLE READY !!");
        }, 500)
      } else {
        console.debug("Fonts and images are loading...");
      }
    }, 500);

    var set_fonts = function (type) {
      let nameAttr = type == 'backup_font_url' ? 'doogin_backup_font_name' : 'doogin_font_name',
        fields = $('[' + type + ']'),
        fonts = {};

      fields.each(function (index, field) {
        let fontName = $(field).attr(nameAttr),
          fontURL = $(field).attr(type);

        if (!fonts[fontName]) {
          fonts[fontName] = fontURL;
        }
      });

      for (let fontName in fonts) {
        let fontURL = fonts[fontName];

        if (!loaded_fonts[fontURL]) {
          console.debug("[FontFace] Loading font - " + fontURL);

          let font = new FontFace(fontName, "url(" + fontURL + ")");

          font.load().then(function (fontFace) {
            console.debug("[FontFace] Font loaded - " + fontURL);

            document.fonts.add(fontFace);

            console.debug("[opentype.js] Loading font - " + fontURL);

            opentype.load(fontURL, function (err, openFont) {
              if (err) {
                console.error("[opentype.js] Failed to load font - " + err);
              } else {
                console.debug("[opentype.js] Font loaded - " + fontURL);

                openFont.fontFace = fontFace;
                openFont.url = fontURL;
                openFont.fontFamily = fontName;
                openFont.metrics  = FontMetrics({
                  fontFamily: fontName
                });

                addFontFaceStyle(openFont);

                loaded_fonts[fontURL] = openFont;

                setTimeout(function() {
                  setTrueMetrics(fontURL);

                  $('[font_url="' + fontURL + '"]').draw_text();
                }, 50)
              }
            });
          }).catch(function (err) {
            console.error("[FontFace] Failed to load font - " + err);
          })
        } else {
          $('[font_url="' + fontURL + '"]').draw_text();
        }
      }
    }

    var addFontFaceStyle = function (font) {
      if (font.styleNode) { return; }

      font.styleNode = document.createElement("style");

      var styletext = "@font-face {\n";

      styletext += "  font-family: '" + font.fontFamily + "';\n";
      styletext += "  src: url('" + font.url + "') format('" + font.outlinesFormat + "');\n";
      styletext += "}";

      font.styleNode.type = "text/css";
      font.styleNode.innerHTML = styletext;

      document.head.appendChild(font.styleNode);
    }

    set_fonts('font_url')
    set_fonts('backup_font_url');

    opentype.Font.prototype.forEachGlyph2 = function(text, x, y, fontSize, options, callback) {
      var this$1 = this;

      x = x !== undefined ? x : 0;
      y = y !== undefined ? y : 0;
      fontSize = fontSize !== undefined ? fontSize : 72;
      options = options || this.defaultRenderOptions;
      var fontScale = 1 / this.unitsPerEm * fontSize;
      var glyphs = this.stringToGlyphs(text, options);
      var kerningLookups;
      if (options.kerning) {
        var script = options.script || this.position.getDefaultScriptName();
        kerningLookups = this.position.getKerningTables(script, options.language);
      }
      for (var i = 0; i < glyphs.length; i += 1) {
        var glyph = glyphs[i];

        callback(
          text[i],
          x,
          y,
          (glyph.xMax || 0) * fontScale,
          (glyph.yMax || 0) * fontScale,
          (glyph.xMin || 0) * fontScale,
          (glyph.yMin || 0) * fontScale
        );

        if (glyph.advanceWidth) {
          x += glyph.advanceWidth * fontScale;
        }

        if (options.kerning && i < glyphs.length - 1) {
          // We should apply position adjustment lookups in a more generic way.
          // Here we only use the xAdvance value.
          var kerningValue = kerningLookups ?
              this$1.position.getKerningValue(kerningLookups, glyph.index, glyphs[i + 1].index) :
              this$1.getKerningValue(glyph, glyphs[i + 1]);
          x += kerningValue * fontScale;
        }

        if (options.letterSpacing) {
          x += options.letterSpacing * fontSize;
        } else if (options.tracking) {
          x += (options.tracking / 1000) * fontSize;
        }
      }
      return x;
    };

    // iterate through each glyph in a string s of size size and get max witdth and height of all glyphs in the font
    $.measure_text = function (text, size, fontURL) {
      var font = $.loaded_fonts(fontURL),
        x = 0,
        min_y = 0,
        max_y = 0,
        width = 0;

      font.forEachGlyph2(text, 0, 0, size, { kerning: true }, function (glyph, glyph_x, glyph_y, glyph_xMax, glyph_yMax, glyph_xMin, glyph_yMin) {
        x     = Math.min(x, glyph_x + glyph_xMin)
        min_y = Math.min(min_y, glyph_yMin)
        max_y = Math.max(max_y, glyph_yMax)
        width = Math.max(width, glyph_x + glyph_xMax)
      });

      return {
        height : max_y - min_y + 2,
        width  : width - x + 2,
        x      : 1 - x,
        y      : 1 + max_y
      }
    }

    // here we are given a string, font size max_width, and a pair of ascenders
    // the ascenders are analogous to height
    $.fit_font = function(s, font_size, fontURL, max_width, max_ascender, max_descender) {
      if (!max_ascender) max_ascender = 99999;
      if (!max_descender) max_descender = 99999;
      max_descender = Math.max(max_descender, 1.0);
      max_ascender = Math.ceil(max_ascender+1);
      max_descender = Math.ceil(max_descender+1);
      console.debug("fit_font: s= "+s+
                    " font_size = "+font_size+
                    " font = "+fontURL+
                    " max_width = "+max_width+
                    " max_ascender = "+max_ascender+
                    " max_descender = "+max_descender)
      var m = $.measure_text(s, font_size, fontURL);
      if (!m) return;

      var too_big = function () {
        var result = (m.width > max_width) || (m.y > max_ascender) || (m.height - m.y > max_descender)

        if (result) {
          console.debug("too big! - m.width: "+m.width+" max_width: "+max_width+" m.y: "+m.y+" max_ascender: "+max_ascender+" m.height: "+m.height+" max_descender: "+max_descender)
        }

        return result
      }

      var scale = Math.min(1, max_width/m.width, max_ascender/m.y, max_descender/(Math.max(m.y, m.height)-m.y));
      console.debug("text measured. height: "+m.height+" width: "+m.width+" x: "+m.x+" y: "+m.y+" scale: "+scale);
      var scaled_font_size = font_size * scale;
      console.debug("initial measurement: m.width = "+m.width+" m.height = "+m.height+" scaled_font_size = "+scaled_font_size)
      for (m = $.measure_text(s, scaled_font_size, fontURL); too_big(); m = $.measure_text(s, (scaled_font_size -= 0.25), fontURL)) {
        console.debug("remeasuring: m.width = "+m.width+" m.height = "+m.height+" scaled_font_size = "+scaled_font_size)
      };
      console.debug("final measurement: max_width = "+max_width+
                  " m.width = "+m.width+
                  " m.height = "+m.height+
                  " m.x = "+m.x+
                  " m.y = "+m.y+
                  " descent = "+(m.height-m.y)+
                  " scaled_font_size = "+scaled_font_size)
      return {fontSize: scaled_font_size, x: m.x, y: m.y, width: m.width, height: m.height};
    }

    // calculate font measurements for a loaded font
    var setTrueMetrics = function (fontURL) {
      var font = loaded_fonts[fontURL];

      console.debug("Current metrics for "+font.url+" ascent = "+font.metrics.ascent+" decent = "+font.metrics.descent)
      var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ,~`!@#$%^&*()_-+={}[]|\;:'<>?,./" + '"'
      font.metrics.ascent = font.metrics.ascent || 0.75
      font.metrics.descent = font.metrics.descent || -0.25
      var m = $.measure_text(chars, 100, font.url);

      font.metrics.ascent = m.y / 100.0;
      font.metrics.descent = (m.y - m.height) / 100.0

      console.debug("True metrics set for "+font.url+" ascent = "+font.metrics.ascent+" decent = "+font.metrics.descent)
    }
  }

  var padding = 0; //0.5*96
  var leading = 1.2;

  $.fn.extend({
    // this is called every time a field is updated
    draw_text: function() {
      $.get_font_dict().initialize();
      // 'this' is the selection of multipe text fields
      // because thumbnails are just miniaturization of
      // the actuall doogin elements 'this' will be more than a single field
      return this.each(function () {
        var font        = loaded_fonts[$(this).attr('font_url')];
        var backupFont  = loaded_fonts[$(this).attr('backup_font_url')];
        var font_family = font ? "'" + font.fontFamily + "'" : undefined;

        if (backupFont !== undefined) {
          font_family += ", " + "'" + backupFont.fontFamily + "'";
        }

        if (font == undefined || font.fontFace.status == "unloaded") {
          return;
        }

        var next_text = $(this).attr('doogin-field-value');

        // Not sure why this put in, rendering the field with blank text works fine
        // Having this code was breaking fields with blank text,
        // causing it to think it was still loading since it did not have .hasSVG class
        if (!next_text) {
          $(this).removeClass('doogin-loading').css('font-family', font.fontFamily)
          return;
        }

        next_text = next_text.replace(/\ +/g," ").replace(/^\ /,"").replace(/\ $/,"")

        $(this).svg('destroy')
        next_text = next_text.split("\n")

        var line_count = next_text.length,
          height = $(this).css('height').replace(/px$/, "") - padding,
          max_width = $(this).css('width').replace(/px$/, "") - padding,
          anchor = $(this).attr('svg-anchor'),
          fill = $(this).attr('svg-fill'),
          svg_display_block = $(this).attr('svg-display-block');

        /*

        a) calculate font size based on ascender, descender and number of lines
        b) measure each line using initial font size
        c) scale the font size.
        d) Which ever line has smallest font use fit_font algorithm to get the correct font size, remember measurements
        e) measure remaining lines with this final font size.

        */

        var ascent = font.metrics.ascent;
        var descent = font.metrics.descent;

        var font_size = height / (Math.max(1, (ascent-descent))+(line_count-1) * leading);

        var metrics = [];
        var current_id = doogin_field_to_id($(this));
        var min_font_size = font_size;

        // iterates line by line to get a min font size
        $.each(next_text, function(i, line) {
          metrics[i] = $.fit_font(
            line,
            font_size,
            font.url,
            max_width,
            (i==0) && ascent*font_size,
            (i==next_text.length-1) && -descent*font_size)
          if (metrics[i]) {
            min_font_size = Math.min(metrics[i].fontSize, min_font_size)
          }
        });

        // only want to update the dict here and only do this ONCE per draw call
        // otherwise you can easily get into some infinte loops :(
        if (current_id) {
          $.get_font_dict().update_size_by_id(current_id, min_font_size)
        }

        $.each(next_text, function(i, line) {
          if (metrics[i]) {
            if (metrics[i].fontSize >  (current_id ? $.get_font_dict().get_size_by_id(current_id) : min_font_size)) {
              // metrics[i] = $.measure_text(line, min_font_size, font.fontFamily)
              metrics[i] = $.measure_text(line, (current_id ? $.get_font_dict().get_size_by_id(current_id) : min_font_size), font.url)
            }
            if (anchor == "start") {
              metrics[i].start = 0
            } else if (anchor == "end") {
              metrics[i].start = metrics[i].width
            } else {
              metrics[i].start = (metrics[i].width) / 2.0;
            }
          }

        })

        var x_start_point;
        if (anchor == "start") {
          x_start_point = 0
        } else if (anchor == "end") {
          x_start_point = max_width
        } else {
          x_start_point = max_width / 2.0
        }

        if (current_id) {
          min_font_size = $.get_font_dict().get_size_by_id(current_id);
        }

        var scaled_height = (ascent - descent) * min_font_size + (line_count - 1) * min_font_size * leading

        var svg_style = "overflow: visible; width: 100%; height: 100%;"
        if (svg_display_block == "true") { svg_style = svg_style + " display: block;" }

        $(this).svg({
          settings: { style: svg_style },
          onLoad:   function(svg) {
            if (current_id) {
              min_font_size = $.get_font_dict().get_size_by_id(current_id);
            }
              var y = padding/2+ascent*min_font_size+(height-scaled_height)/2
            var texts = svg.createText();
            $.each(next_text, function(i, line) {
              if (metrics[i]) {

                $.loaded_fonts(font.url).forEachGlyph2(line, padding / 2 + x_start_point - metrics[i].start + metrics[i].x, y, min_font_size, { kerning: true }, function (char, x, y) {
                  texts.span(char, {x: x, y: y})
                })
                // create a dummy span with left_offset and true_width to support the admin font display partial
                texts.span(line, {x: padding/2 + x_start_point - metrics[i].start + metrics[i].x, y: y, left_offset: metrics[i].x, true_width: metrics[i].width, style: "display:none", class: "full_line"})
              }
              y += min_font_size * leading
            });
            svg.text(0, 0, texts, { fontFamily: font_family, fontSize: min_font_size, fill: fill, textAnchor: "start" });
            $(this).removeClass('doogin-loading');
          }
        });
      });
    }
  });
})(jQuery);
