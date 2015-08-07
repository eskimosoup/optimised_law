class SEO

  def self.objects_for_seo(controller_name)
    case controller_name
      when 'articles'
        Article.order(:title)
      when 'academy_entries'
        Article.order(:title)
      else
        []
    end
  end

  def self.objects_for_sitemap(controller_name)
    case controller_name
      when 'articles'
        Article.where('display = ? and date <= ?', true, Date.today).order(:title)
      when 'academy_entries'
        Article.where(display: true).order(:title)
    else
      []
    end
  end

  def self.rebuild!
    nominal_urls_added = []

    # The method for retrieving the routes and their details keeps changing
    # between rails versions so this is likely to keep needing updating.
    routes = Rails.application.routes.routes.select{|x| [//, /^GET$/].include?(x.verb)}.map do |route|
      { :alias => route.name,
        :path => route.path.spec.to_s.gsub("(.:format)", ""),
        :controller => route.defaults[:controller],
        :action => route.defaults[:action] }
    end

    # Reject routes without a controller such as 301s
    routes = routes.reject{|route| route[:controller].nil?}

    # Reject routes without an alias
    routes = routes.reject{|route| route[:alias].nil?}

    # Reject rails standard routes
    rails_standard_routes_aliases = %w( rails_mailers rails_info_properties rails_info_routes rails_info )
    routes = routes.reject{|route| rails_standard_routes_aliases.include?(route[:alias])}

    # Reject admin routes
    routes = routes.reject{|route| route[:controller].include?("admin")}

    #SITE SPECIFIC
    unwanted_controllers = %w( job_applications event_bookings )
    routes = routes.reject{|route| unwanted_controllers.include?(route[:controller])}
    unwanted_paths = ['/locations/:location_id/offices/:office_id/contacts/new', '/testimonials/filter', '/resources/filter',
                      '/team-members/ajax_suggest', '/events/calendar', '/team-members/:id/vcard']
    routes = routes.reject{|route| unwanted_paths.include?(route[:path]) }

    routes.each do |route|
      if route[:path].include? ":id"
        uses_friendly_id = nil
        has_name_method = nil

        objects_for_sitemap = SEO.objects_for_sitemap(route[:controller])

        SEO.objects_for_seo(route[:controller]).each do |object|
          has_parent = nil
          parent_method = nil
          parent_path = nil
          if uses_friendly_id.nil?
            begin
              object.friendly_id
            rescue NoMethodError
              uses_friendly_id = false
            else
              uses_friendly_id = true
            end
          end

          if has_name_method.nil?
            begin
              object.name
            rescue NoMethodError
              has_name_method = false
            else
              has_name_method = true
            end
          end

          if has_parent.nil?
            split_paths = route[:path].split("/")
            split_paths.each do |split|
              if split.include?("_id")
                has_parent = true
                parent_path = split
                parent_method = split.gsub("_id", "").gsub(":", "")
              end
            end

            if has_parent.nil?
              has_parent = false
            end

            if has_parent and !parent_method.blank?
              parent_uses_friendly_id = nil
              if parent_uses_friendly_id.nil?
                begin

                  object.send(parent_method).friendly_id
                rescue NoMethodError
                  parent_uses_friendly_id = false
                else
                  parent_uses_friendly_id = true
                end
              end
            end
          end

          if uses_friendly_id
            if has_parent and parent_uses_friendly_id
              nominal_url = route[:path].gsub(':id', object.friendly_id).gsub(parent_path, object.send(parent_method).friendly_id)
              seo_entry = SeoEntry.find_or_create_by(nominal_url: nominal_url)
              nominal_urls_added << nominal_url
            elsif has_parent

              nominal_url = route[:path].gsub(':id', object.friendly_id).gsub(parent_path, object.send("#{parent_method}_id").to_s)
              seo_entry = SeoEntry.find_or_create_by(nominal_url: nominal_url)
              nominal_urls_added << nominal_url
            else
              seo_entry = SeoEntry.find_or_create_by(nominal_url: route[:path].gsub(':id', object.friendly_id))
              nominal_urls_added << route[:path].gsub(':id', object.friendly_id)
            end


            if seo_entry.title.blank?
              if has_name_method
                seo_entry.title = object.name.split(' ').map(&:capitalize).join(' ')
              else
                seo_entry.title = object.friendly_id.gsub('-', ' ').split(' ').map(&:capitalize).join(' ')
              end
            end
          else
            if has_parent and parent_uses_friendly_id
              nominal_url = route[:path].gsub(':id', object.friendly_id).gsub(parent_path, object.send(parent_method).friendly_id)
              seo_entry = SeoEntry.find_or_create_by(nominal_url: nominal_url)
              nominal_urls_added << nominal_url
            elsif has_parent
              nominal_url = route[:path].gsub(':id', object.friendly_id).gsub(parent_path, object.send("#{parent_method}_id").to_s)
              seo_entry = SeoEntry.find_or_create_by(nominal_url: nominal_url)
              nominal_urls_added << nominal_url
            else
              seo_entry = SeoEntry.find_or_create_by(nominal_url: route[:path].gsub(':id', object.id.to_s))
              nominal_urls_added << route[:path].gsub(':id', object.id.to_s)
            end

            if seo_entry.title.blank?
              if has_name_method
                seo_entry.title = object.name
              else
                seo_entry.title = "#{object.class.name} - #{object.id}"
              end
            end
          end
          seo_entry.in_sitemap = objects_for_sitemap.include? object
          seo_entry.save
        end
      else
        seo_entry = SeoEntry.find_or_create_by(nominal_url: route[:path])
        nominal_urls_added << route[:path]
        seo_entry.title = route[:alias].gsub('_', ' ').split(' ').map(&:capitalize).join(' ') if seo_entry.title.blank?
        seo_entry.save
      end
    end

    SeoEntry.where("nominal_url NOT IN (?)", nominal_urls_added).each{|x| x.destroy}
  end

end
