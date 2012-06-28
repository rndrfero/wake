module WakeHelper
    
  def ico(x, color=nil)
    raw "<span class='iconic #{x}' style='color: #{color};'></span>"
  end
  
  def wake_referer_param?(*args)
    x = session[:wake_referer_params]
    for arg in args
      return false if x.blank?
      return true if x[arg.to_s] == true
      x = x[arg.to_s]
    end
    not x.blank?
  end

  def wake_click_order_by(column, _label=nil)
    _label ||= column.gsub(/^.*\./,'').humanize
    if params[:order] == column.to_s
#      raise (params[:desc]=='true' ? nil : 'true').inspect
      link_to _label, url_for(:action=>'index', :order=>column, :desc=>(params[:desc]=='true' ? 'false' : 'true'),
        :filter=>params[:filter]), :class=>'selected'
    else
      link_to _label, url_for(:action=>'index', :order=>column, :filter=>params[:filter])
    end
  end

  def wake_check_box(item)
    'x'
  end

  def wake_icon(ident, alt=nil)
    ident = ident.to_s
    raw '<img src="/wake/icons/'+ident+'.png" alt="'+(alt||ident)+'" title="'+(alt||ident)+'">'
  end

  def wake_onclick(item)
    raw "onclick=\"document.location='#{url_for :action=>'edit', :id=>item}'\""
  end

  def wake_onclick_remote(item)
    url = url_for :action=>'edit', :id=>item
    raw "onclick=\"$.ajax({url: '#{url}.js', data: 'page=#{params[:page]}'});\""
  end

  def wake_hl(string)
    @_search ||= params[:search]
    return string if @_search.blank? or string.blank?
    @_regexp ||= Regexp.new("(#{sanitize(@_search)})", Regexp::EXTENDED|Regexp::IGNORECASE)
    raw string.to_s.gsub @_regexp, "<span class=\"wake_hl\">\\1</span>"
  end

  def wake_button_destroy(item)
    return '' if not item.wake_destroyable? if item.respond_to? :wake_destroyable?
    link_to ico('x'), {:action=>'destroy',:id=>item}, 
      :method=>:delete, :data=>{:confirm=>'wake.general.confirm_destroy'.tt}
  end

  def wake_star_button(item)
    link_to raw(wake_icon(item.is_star? ? :star_on : :star_off)), {:action=>'toggle_star', :id=>item}, :method=>:post
  end

  def wake_field_error(attr_sym)
    raw @item.errors.empty? ? '' : "<span class=\"error\">#{@item.errors[attr_sym].first}</span>"
  end

  def wake_select_enum(key, choices)
	  choices = [['', nil]] + choices
		url = url_for :action=>'index'		

		filter_params = "?"

		for k,v in params[:filter]
		  next if k == key
  		filter_params << "filter[#{k}]=#{v}&"
		end if params[:filter]

		for k,v in params[:filter_range]
  		filter_params << "filter_range[#{k}]=#{v}&"
	  end if params[:filter_range]

		filter_params << "search=#{params[:search]}&" if params[:search]

	  onchange = "document.location='#{url}#{URI.escape filter_params}filter[#{key}]='+this.options[this.selectedIndex].value"
		selected = params[:filter] ? params[:filter][key] : nil
	  select 'not', 'important', choices, {:selected=>selected}, :onchange=>onchange
  end


	def wake_select_exclusive(collection, key=nil)
		key ||= collection.first.class.to_s.underscore + '_id'

	  choices = [['', nil]] + collection.map{ |x| [x.name,x.id] }
		url = url_for :action=>'index'

		filter_params = "?"

		for k,v in params[:filter]
		  next if k == key
  		filter_params << "filter[#{k}]=#{v}&"
		end if params[:filter]

		for k,v in params[:filter_range]
  		filter_params << "filter_range[#{k}]=#{v}&"
	  end if params[:filter_range]

		filter_params << "search=#{params[:search]}&" if params[:search]

	  onchange = "document.location='#{url}#{URI.escape filter_params}filter[#{key}]='+this.options[this.selectedIndex].value"
		selected = params[:filter] ? params[:filter][key] : nil
	  select 'not', 'important', choices, {:selected=>selected}, :onchange=>onchange
	end


  alias :wo :wake_onclick
  alias :wor :wake_onclick_remote
  alias :whl :wake_hl  
  alias :wfe :wake_field_error
  alias :wico :wake_icon
  
end
