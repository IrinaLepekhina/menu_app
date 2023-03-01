module ApplicationHelper
  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    # target.active_model_serializer.new(target, options).to_json
    ActiveModelSerializers::SerializableResource.new(target, options).as_json
  end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }
    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }
    
    renderer = ::Redcarpet::Render::HTML.new(options)
    markdown = ::Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end
end
