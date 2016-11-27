
module ApplicationHelper
  def link_to_add_fields name, f, association
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, "#", class: "add_fields btn btn-primary btn-large
      waves-effect waves-light blue", data: {id: id, fields: fields.gsub("\n", "")})
  end
  # def link_to_add_fields(name = nil, f = nil, association = nil, options = nil, html_options = nil, &block)
  #     f, association, options, html_options = name, f, association, options if block_given?
  #     options = {} if options.nil?
  #     html_options = {} if html_options.nil?
  #     if options.include? :locals
  #       locals = options[:locals]
  #     else
  #       locals = { }
  #     end
  #     if options.include? :partial
  #       partial = options[:partial]
  #     else
  #       partial = association.to_s.singularize + '_fields'
  #     end

  #     new_object = f.object.class.reflect_on_association(association).klass.new
  #     fields = f.fields_for(association, new_object, child_index: 'new_record') do |builder|
  #       render(partial, locals.merge!( f: builder))
  #     end
  #     html_options['data-form-prepend'] = raw CGI::escapeHTML( fields )
  #     html_options['href'] = '#'
  #     content_tag(:a, name, html_options, &block)
  # end
  #
  def resource_name
    :user
  end
  def resource
    @resource ||= User.new
  end
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def generate_log
    f = File.open(File.join(Settings.log_directory, "admin.log"), "r")
    html_string = ""
    f.each_line do |line|
      if line.length > 0
        html_string << "<tr class='card'><td>#{line}</td></tr>"
      end
    end
    html_string.html_safe
  end

  def spend_time exam
    time = exam.subject.duration * Settings.MINUTE
    if exam.end_time - exam.start_time <= exam.subject.duration * Settings.MINUTE
      time = exam.end_time.to_i - exam.start_time.to_i
    end
    Time.at(time).utc.strftime Settings.TIME_FORMAT
  end
end

