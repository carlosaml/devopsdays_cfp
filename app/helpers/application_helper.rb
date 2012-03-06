# encoding: UTF-8
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def prepend_http(url)
    return url if url.blank?
    !!( url !~ /\A(?:http:\/\/)/i ) ? "http://#{url}" : url
  end

  def link_to_menu_item(tag, name, url)
    content_tag(tag, :class => (current_page?(url) ? "selected" : "")) do
      link_to name, url
    end
  end

  def autotab
    @current_tab ||= 0
    @current_tab += 1
  end

  def sortable_column(text, column, parameters=request.parameters)
    if(parameters[:column] == column.to_s)
      direction = parameters[:direction] == 'down' ? 'up' : 'down'
    else
      direction = 'down'
    end
    link_to text, parameters.merge(:column => column, :direction => direction, :page => nil)
  end

  def textilize(text)
    ::RedCloth.new(text, [:filter_html, :sanitize_html]).to_html(:textile).html_safe
  end

  def present_date(conference, date_map)
    content = raw "#{l(date_map.first)}: #{t("conference.dates.#{date_map.last}")}"
    content = content_tag('strong'){content} if date_map.first == current_date(conference).try(:first)
    content
  end

  def current_date(conference)
    now = DateTime.now
    conference.dates.select{|date_map| now < date_map.first}.first
  end
end
