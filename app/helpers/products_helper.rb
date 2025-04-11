module ProductsHelper
  def simple_description(description, length = 100)
    description.truncate(length)
  end

  def date_format(date, **options)
    options[:format] ||= :default

    I18n.l(date, **options)
  end
end
