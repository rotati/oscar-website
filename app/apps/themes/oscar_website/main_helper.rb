module Themes::OscarWebsite::MainHelper
  def self.included(klass)
    klass.helper_method [:oscar_get_nav_menu] rescue "" # here your methods accessible from views
  end

  def oscar_website_settings(theme)
    # callback to save custom values of fields added in my_theme/views/admin/settings.html.erb
  end

  # callback called after theme installed
  def oscar_website_on_install_theme(theme)
    oscar_add_customize_theme_setting(theme)
    oscar_add_default_pages
    oscar_add_fields_to_home_page
    oscar_add_home_feature_post_type
    oscar_add_home_customer_image_post_type
    oscar_add_home_latest_blog_post_post_type
    oscar_add_what_clients_say_post_type
    oscar_add_latest_tweets_post_type
    oscar_add_fields_to_about_page
    oscar_add_about_score_post_type
    oscar_add_about_who_we_are_progress_post_type
    oscar_add_about_us_post_type
    oscar_add_fields_to_service_page
    oscar_add_service_post_type
    oscar_add_fields_to_testimonial_page
    oscar_add_fields_to_pricing_page
    oscar_add_pricing_post_type
    oscar_add_fields_to_contact_us_page
    oscar_add_faq_post_type
  end

  def oscar_add_default_pages
    page_post_type = current_site.the_post_type('page')
    if page_post_type.present?
      pages = ['Home', 'About', 'Features', 'Pricing', 'Testimonials', 'Services', 'Contact Us', 'FAQ']

      pages.each do |page|
        formatted_page = page.downcase.parameterize
        exist_page = current_site.the_post_type('page').the_posts.where("slug like '%#{formatted_page}%'")
        unless exist_page.present?
          page_post_type.add_post(title: page, content: 'lorem_ipsum')
        end
      end
    end
  end

  def oscar_add_fields_to_home_page
    page = current_site.the_post_type('page').the_post('home')

    if page.get_field_groups.where(slug: 'home-introduction-fields').blank?
      home_field_group = page.add_field_group({ name: 'Home Introduction Fields', slug: 'home-introduction-fields' })
      home_field_group.add_field({ name: 'Introduction Sentence', slug: 'introdution-sentence' }, { field_key: 'text_box', required: true, default_value: 'The fastest way to grow your business with the leader in'})
      home_field_group.add_field({ name: 'Big Word', slug: 'big-word' }, { field_key: 'text_box', required: true, default_value: 'Technology'})
      home_field_group.add_field({ name: 'Option And Feature', slug: 'option-and-feature' }, { field_key: 'text_box', required: true, default_value: 'Check out our options and features included.'})
      home_field_group.add_field({ name: 'Get Start Now', slug: 'get-start-now' }, { field_key: 'url', required: true, default_value: 'https://www.google.com.kh/'})
      home_field_group.add_field({ name: 'Learn More', slug: 'learn-more' }, { field_key: 'url', required: true, default_value: 'https://www.google.com.kh/'})
    end

    if page.get_field_groups.where(slug: 'home-concept-fields').blank?
      home_field_group = page.add_field_group({ name: 'Home Concept Fields', slug: 'home-concept-fields' })
      home_field_group.add_field({ name: 'Project Name', slug: 'project-name' }, { field_key: 'text_box', required: true, default_value: 'Oscar Website'})
      home_field_group.add_field({ name: 'Slide Word', slug: 'concept-slide-word' }, { field_key: 'text_box', required: true, default_value: 'Website', multiple: true})
      home_field_group.add_field({ name: 'Project Meaning', slug: 'project-meaning' }, { field_key: 'text_box', required: true, default_value: 'help children in Cambodia'})
      home_field_group.add_field({ name: 'Concept Description', slug: 'concept-description' }, { field_key: 'text_box', required: true, default_value: 'We help all children in Camodia'})
      home_field_group.add_field({ name: 'First Image', slug: 'concept-first-image' }, { field_key: 'image', required: true })
      home_field_group.add_field({ name: 'First Description', slug: 'concept-first-description' }, { field_key: 'text_box', required: true, default_value: 'Strategy' })
      home_field_group.add_field({ name: 'Second Image', slug: 'concept-second-image' }, { field_key: 'image', required: true })
      home_field_group.add_field({ name: 'Second Description', slug: 'concept-second-description' }, { field_key: 'text_box', required: true, default_value: 'Planning'})
      home_field_group.add_field({ name: 'Third Image', slug: 'concept-third-image' }, { field_key: 'image', required: true })
      home_field_group.add_field({ name: 'Third Description', slug: 'concept-third-description' }, { field_key: 'text_box', required: true, default_value: 'Build'})
      home_field_group.add_field({ name: 'Big Image', slug: 'concept-big-image' }, { field_key: 'image', required: true, multiple: true})
      home_field_group.add_field({ name: 'Big Description', slug: 'concept-big-description' }, { field_key: 'text_box', required: true, default_value: 'Our Work'})
    end

    if page.get_field_groups.where(slug: 'home-customer-description-fields').blank?
      home_field_group = page.add_field_group({ name: 'Home Customer Description Fields', slug: 'home-customer-description-fields' })
      home_field_group.add_field({ name: 'Main First Description', slug: 'main-first-description' }, { field_key: 'text_box', required: true, default_value: 'Our Customer'})
      home_field_group.add_field({ name: 'Slide Word', slug: 'customer-description-slide-word' }, { field_key: 'text_box', required: true, default_value: 'Happy', multiple: true})
      home_field_group.add_field({ name: 'Main Scecond Description', slug: 'main-second-description' }, { field_key: 'text_box', required: true, default_value: 'to help children in Cambodia'})
      home_field_group.add_field({ name: 'Sub Description', slug: 'sub-description' }, { field_key: 'text_box', required: true, default_value: '25,000 customers in 100 countries use Porto Template. Meet our customers.'})
    end

    if page.get_field_groups.where(slug: 'home-customer-background-image-fields').blank?
      home_field_group = page.add_field_group({ name: 'Home Customer Background Image Fields', slug: 'home-customer-background-image-fields' })
      home_field_group.add_field({ name: 'Background Image', slug: 'home-background-image' }, { field_key: 'image', required: true})
    end
  end

  def oscar_add_fields_to_contact_us_page
    page = current_site.the_post_type('page').the_post('contact-us')

    if page.get_field_groups.where(slug: 'contact-get-in-touch-fields').blank?
      contact_field_group = page.add_field_group({ name: 'Get In Touch', slug: 'contact-get-in-touch-fields' })
      contact_field_group.add_field({ name: 'Description', slug: 'contact-get-in-touch-decription' }, { field_key: 'text_area', required: true, default_value: 'Please Contact Us!!!'})
    end

    if page.get_field_groups.where(slug: 'contact-business-hour-fields').blank?
      contact_field_group = page.add_field_group({ name: 'Business Hours', slug: 'contact-business-hour-fields' })
      contact_field_group.add_field({ name: 'Business Hour', slug: 'contact-business-hour' }, { field_key: 'text_box', required: true, default_value: 'Monday - Friday - 9am to 5pm', multiple: true})
    end

    if page.get_field_groups.where(slug: 'contact-map-fields').blank?
      contact_field_group = page.add_field_group({ name: 'Map', slug: 'contact-map-fields' })
      contact_field_group.add_field({ name: 'Map URL', slug: 'contact-map' }, { field_key: 'url', required: true })
    end
  end

  def oscar_add_fields_to_pricing_page
    page = current_site.the_post_type('page').the_post('pricing')

    if page.get_field_groups.where(slug: 'pricing-fields').blank?
      pricing_field_group = page.add_field_group({ name: 'Prcing Header Fields', slug: 'pricing-header-fields' })
      pricing_field_group.add_field({ name: 'Introduction Sentence', slug: 'pricing-introdution-sentence' }, { field_key: 'text_area', required: true, default_value: 'You can configure your pricing table using the grid system in order to make it responsive for small devices.'})
    end

    if page.get_field_groups.where(slug: 'pricing-plan-fields').blank?
      pricing_field_group = page.add_field_group({ name: 'Prcing Plan Header Fields', slug: 'pricing-plan-header-fields' })
      pricing_field_group.add_field({ name: 'Introduction Sentence', slug: 'pricing-plan-introdution-sentence' }, { field_key: 'text_area', required: true, default_value: 'Using the "Most Popular" css class.'})
    end
  end

  def oscar_add_fields_to_testimonial_page
    page = current_site.the_post_type('page').the_post('testimonials')

    if page.get_field_groups.where(slug: 'testimonial-fields').blank?
      testimonial_field_group = page.add_field_group({ name: 'Testimonial Fields', slug: 'testimonial-fields' })
      testimonial_field_group.add_field({ name: 'Background Image', slug: 'testimonial-background-image' }, { field_key: 'image', required: true })
    end
  end

  def oscar_add_fields_to_about_page
    page = current_site.the_post_type('page').the_post('about')

    if page.get_field_groups.where(slug: 'about-content-fields').blank?
      about_field_group = page.add_field_group({ name: 'About Content Fields', slug: 'about-content-fields' })
      about_field_group.add_field({ name: 'Title', slug: 'about-title' }, { field_key: 'text_box', required: true, default_value: 'The New Way to'})
      about_field_group.add_field({ name: 'Slide Words', slug: 'about-slider' }, { field_key: 'text_box', required: true, default_value: 'Technology', multiple: true})
      about_field_group.add_field({ name: 'Content', slug: 'about-content-text' }, { field_key: 'text_area', required: true, default_value: 'About Content'})
    end

    if page.get_field_groups.where(slug: 'about-who-we-are-fields').blank?
      about_field_group = page.add_field_group({ name: 'About Who We Are Fields', slug: 'about-who-we-are-fields' })
      about_field_group.add_field({ name: 'Content', slug: 'about-who-we-are-content' }, { field_key: 'text_area', required: true, default_value: 'About Who We Are Content'})
    end

    if page.get_field_groups.where(slug: 'about-footer-fields').blank?
      about_field_group = page.add_field_group({ name: 'About Footer', slug: 'about-footer-fields' })
      about_field_group.add_field({ name: 'Main Sentence', slug: 'about-footer-main-sentence-content' }, { field_key: 'text_box', required: true, default_value: 'Oscar Website is awesome.'})
      about_field_group.add_field({ name: 'Sub Sentence', slug: 'about-footer-sub-sentence-content' }, { field_key: 'text_box', required: true, default_value: 'Together work with Oscar.'})
    end

    if page.get_field_groups.where(slug: 'about-video-fields').blank?
      about_field_group = page.add_field_group({ name: 'About Video Fields', slug: 'about-video-fields' })
      about_field_group.add_field({ name: 'Video', slug: 'about-video' }, { field_key: 'video', required: true })
    end
  end

  def oscar_add_fields_to_service_page
    page = current_site.the_post_type('page').the_post('services')

    if page.get_field_groups.where(slug: 'service-welcome-content-fields').blank?
      service_field_group = page.add_field_group({ name: 'Service Welcome Content Fields', slug: 'service-welcome-content-fields' })
      service_field_group.add_field({ name: 'Welcome Content', slug: 'service-welcome-content' }, { field_key: 'text_area', required: true, default_value: 'Our service in Oscar Website'})
    end
  end

  def oscar_add_service_post_type
    if current_site.the_post_type('service').blank?
      service = current_site.post_types.create(name: 'Service', slug: 'service')
      options = {
        has_category: false,
        has_content: true,
        has_tags: false,
        has_summary: false,
        has_comments: false,
        has_picture: false,
        has_template: false,
        has_keywords: false,
        contents_route_format: 'post_of_posttype'
      }
      service.set_meta('_default', options)
      if service.get_field_groups.where(slug: 'service-score-fields').blank?
        service_field_group = service.add_field_group({ name: 'Service Fields', slug: 'service-fields' } )

        service_field_group.add_field({ name: 'Font Awesome Icon Name', slug: 'service-font-awesome-icon-name' }, { field_key: 'text_box', required: true } )
        service_field_group.add_field({ name: 'Title', slug: 'service-title' }, { field_key: 'text_box', required: true } )
        service_field_group.add_field({ name: 'Description', slug: 'service-description' }, { field_key: 'text_area', required: true } )
      end
    end
  end

  def oscar_add_faq_post_type
    if current_site.the_post_type('faq').blank?
      faq = current_site.post_types.create(name: 'FAQ', slug: 'faq-post-type')
      options = {
        has_category: false,
        has_content: true,
        has_tags: false,
        has_summary: false,
        has_comments: false,
        has_picture: false,
        has_template: false,
        has_keywords: false,
        contents_route_format: 'post_of_posttype'
      }
      faq.set_meta('_default', options)
      if faq.get_field_groups.where(slug: 'faq-fields').blank?
        faq_field_group = faq.add_field_group({ name: 'FAQ Fields', slug: 'faq-fields' } )

        faq_field_group.add_field({ name: 'Question', slug: 'faq-question' }, { field_key: 'text_box', required: true } )
        faq_field_group.add_field({ name: 'Answer', slug: 'faq-answer' }, { field_key: 'text_area', required: true } )
      end
    end
  end

  def oscar_add_pricing_post_type
    if current_site.the_post_type('pricing-card').blank?
      pricing = current_site.post_types.create(name: 'Pricing', slug: 'pricing-card')
      options = {
        has_category: false,
        has_content: true,
        has_tags: false,
        has_summary: false,
        has_comments: false,
        has_picture: false,
        has_template: false,
        has_keywords: false,
        contents_route_format: 'post_of_posttype'
      }
      pricing.set_meta('_default', options)
      if pricing.get_field_groups.where(slug: 'pricing-fields').blank?
        pricing_field_group = pricing.add_field_group({ name: 'Pricing Fields', slug: 'pricing-fields' } )

        pricing_field_group.add_field({ name: 'Level', slug: 'pricing-level' }, { field_key: 'text_box', required: true } )
        pricing_field_group.add_field({ name: 'Price', slug: 'pricing-price' }, { field_key: 'numeric', required: true } )
        pricing_field_group.add_field({ name: 'Item', slug: 'pricing-item' }, { field_key: 'text_box', required: true, multiple: true } )
        pricing_field_group.add_field({ name: 'Popular', slug: 'pricing-popular' }, { field_key: 'checkbox'} )
      end
    end
  end

  def oscar_add_about_score_post_type
    if current_site.the_post_type('about-score').blank?
      about = current_site.post_types.create(name: 'About Score', slug: 'about-score')
      options = {
        has_category: false,
        has_content: true,
        has_tags: false,
        has_summary: false,
        has_comments: false,
        has_picture: false,
        has_template: false,
        has_keywords: false,
        contents_route_format: 'post_of_posttype'
      }
      about.set_meta('_default', options)
      if about.get_field_groups.where(slug: 'about-score-fields').blank?
        about_field_group = about.add_field_group({ name: 'About Score Fields', slug: 'about-score-fields' } )

        about_field_group.add_field({ name: 'Number', slug: 'about-score-number' }, { field_key: 'numeric', required: true } )
        about_field_group.add_field({ name: 'Sign', slug: 'about-score-sign' }, { field_key: 'text_box', required: false } )
        about_field_group.add_field({ name: 'Text', slug: 'about-score-text' }, { field_key: 'text_box', required: true } )
      end
    end
  end

  def oscar_add_about_us_post_type
    if current_site.the_post_type('about-us').blank?
      about = current_site.post_types.create(name: 'About Us', slug: 'about-us')
      options = {
        has_category: false,
        has_content: true,
        has_tags: false,
        has_summary: false,
        has_comments: false,
        has_picture: false,
        has_template: false,
        has_keywords: false,
        contents_route_format: 'post_of_posttype'
      }
      about.set_meta('_default', options)

      if about.get_field_groups.where(slug: 'about-us-fields').blank?
        about_field_group = about.add_field_group({ name: 'About Us Fields', slug: 'about-us-fields' } )

        about_field_group.add_field({ name: 'Image', slug: 'about-us-image' }, { field_key: 'image', required: true, multiple: true } )
        about_field_group.add_field({ name: 'Name', slug: 'about-us-name' }, { field_key: 'text_box', required: true } )
        about_field_group.add_field({ name: 'Position', slug: 'about-us-position' }, { field_key: 'text_box', required: true } )
        about_field_group.add_field({ name: 'Facebook', slug: 'about-us-facebook' }, { field_key: 'url', required: true } )
        about_field_group.add_field({ name: 'Twitter', slug: 'about-us-twitter' }, { field_key: 'url', required: true } )
        about_field_group.add_field({ name: 'Linkedin', slug: 'about-us-linkedin' }, { field_key: 'url', required: true } )
      end

      if about.get_field_groups.where(slug: 'about-us-progress-work-fields').blank?
        about_field_group = about.add_field_group({ name: 'Progress work', slug: 'about-us-progress-work-fields' } )

        about_field_group.add_field({ name: 'Name 1st', slug: 'about-us-progress-work-name-1st' }, { field_key: 'text_box', required: true } )
        about_field_group.add_field({ name: 'Percent 1st', slug: 'about-us-progress-work-percent-1st' }, { field_key: 'numeric', required: true } )
        about_field_group.add_field({ name: 'Name 2nd', slug: 'about-us-progress-work-name-2nd' }, { field_key: 'text_box', required: false } )
        about_field_group.add_field({ name: 'Percent 2nd', slug: 'about-us-progress-work-percent-2nd' }, { field_key: 'numeric', required: false } )
        about_field_group.add_field({ name: 'Name 3rd', slug: 'about-us-progress-work-name-3rd' }, { field_key: 'text_box', required: false } )
        about_field_group.add_field({ name: 'Percent 3rd', slug: 'about-us-progress-work-percent-3rd' }, { field_key: 'numeric', required: false } )
        about_field_group.add_field({ name: 'Name 4th', slug: 'about-us-progress-work-name-4th' }, { field_key: 'text_box', required: false } )
        about_field_group.add_field({ name: 'Percent 4th', slug: 'about-us-progress-work-percent-4th' }, { field_key: 'numeric', required: false } )
      end

      if about.get_field_groups.where(slug: 'about-us-referent-fields').blank?
        about_field_group = about.add_field_group({ name: 'Referent', slug: 'about-us-referent-fields' } )

        about_field_group.add_field({ name: 'Background Image', slug: 'about-us-background-image' }, { field_key: 'image', required: true } )
        about_field_group.add_field({ name: 'Comment 1st', slug: 'about-us-referent-comment-1st' }, { field_key: 'text_area', required: true } )
        about_field_group.add_field({ name: 'Name 1st', slug: 'about-us-referent-name-1st' }, { field_key: 'text_box', required: true } )
        about_field_group.add_field({ name: 'Positon 1st', slug: 'about-us-referent-position-1st' }, { field_key: 'text_box', required: true } )
        about_field_group.add_field({ name: 'Comment 2nd', slug: 'about-us-referent-comment-2nd' }, { field_key: 'text_area', required: false } )
        about_field_group.add_field({ name: 'Name 2nd', slug: 'about-us-referent-name-2nd' }, { field_key: 'text_box', required: false } )
        about_field_group.add_field({ name: 'Positon 2nd', slug: 'about-us-referent-position-2nd' }, { field_key: 'text_box', required: false } )
      end

      if about.get_field_groups.where(slug: 'about-us-my-work-fields').blank?
        about_field_group = about.add_field_group({ name: 'My Work', slug: 'about-us-my-work-fields' } )

        about_field_group.add_field({ name: 'Description', slug: 'about-us-my-work-description' }, { field_key: 'text_area', required: true } )

        about_field_group.add_field({ name: 'Image 1st', slug: 'about-us-my-work-image-1st' }, { field_key: 'image', required: true } )
        about_field_group.add_field({ name: 'Title 1st', slug: 'about-us-my-work-title-1st' }, { field_key: 'text_box', required: true } )
        about_field_group.add_field({ name: 'Sub Title 1st', slug: 'about-us-my-work-sub-title-1st' }, { field_key: 'text_box', required: true } )
        about_field_group.add_field({ name: 'Image 2nd', slug: 'about-us-my-work-image-2nd' }, { field_key: 'image', required: false } )
        about_field_group.add_field({ name: 'Title 2nd', slug: 'about-us-my-work-title-2nd' }, { field_key: 'text_box', required: false } )
        about_field_group.add_field({ name: 'Sub Title 2nd', slug: 'about-us-my-work-sub-title-2nd' }, { field_key: 'text_box', required: false } )
        about_field_group.add_field({ name: 'Image 3rd', slug: 'about-us-my-work-image-3rd' }, { field_key: 'image', required: false } )
        about_field_group.add_field({ name: 'Title 3rd', slug: 'about-us-my-work-title-3rd' }, { field_key: 'text_box', required: false } )
        about_field_group.add_field({ name: 'Sub Title 3rd', slug: 'about-us-my-work-sub-title-3rd' }, { field_key: 'text_box', required: false } )
        about_field_group.add_field({ name: 'Image 4th', slug: 'about-us-my-work-image-4th' }, { field_key: 'image', required: false } )
        about_field_group.add_field({ name: 'Title 4th', slug: 'about-us-my-work-title-4th' }, { field_key: 'text_box', required: false } )
        about_field_group.add_field({ name: 'Sub Title 4th', slug: 'about-us-my-work-sub-title-4th' }, { field_key: 'text_box', required: false } )
      end
    end
  end

  def oscar_add_about_who_we_are_progress_post_type
    if current_site.the_post_type('about-who-we-are-progress').blank?
      about = current_site.post_types.create(name: 'About Who We Are Progress', slug: 'about-who-we-are-progress')
      options = {
        has_category: false,
        has_content: true,
        has_tags: false,
        has_summary: false,
        has_comments: false,
        has_picture: false,
        has_template: false,
        has_keywords: false,
        contents_route_format: 'post_of_posttype'
      }
      about.set_meta('_default', options)
      if about.get_field_groups.where(slug: 'about-who-we-are-progress-fields').blank?
        about_field_group = about.add_field_group({ name: 'About Who We Are Progress Fields', slug: 'about-who-we-are-progress-fields' } )

        about_field_group.add_field({ name: 'Title', slug: 'about-who-we-are-progress-title' }, { field_key: 'text_box', required: true } )
        about_field_group.add_field({ name: 'Percent', slug: 'about-who-we-are-progress-percent' }, { field_key: 'numeric', required: true } )
      end
    end
  end

  def oscar_add_home_feature_post_type
    if current_site.the_post_type('home-feature').blank?
      feature = current_site.post_types.create(name: 'Home Feature', slug: 'home-feature')
      options = {
        has_category: false,
        has_content: true,
        has_tags: false,
        has_summary: false,
        has_comments: false,
        has_picture: false,
        has_template: false,
        has_keywords: false,
        contents_route_format: 'post_of_posttype'
      }
      feature.set_meta('_default', options)
      if feature.get_field_groups.where(slug: 'home-feature-fields').blank?
        feature_field_group = feature.add_field_group({ name: 'Home Feature Fields', slug: 'home-feature-fields' } )

        feature_field_group.add_field({ name: 'Feature Icon', slug: 'feature-icon' }, { field_key: 'image', required: true } )
        feature_field_group.add_field({ name: 'Feature Url', slug: 'Feature-url' }, { field_key: 'url', required: true } )
      end
    end
  end

  def oscar_add_home_customer_image_post_type
    if current_site.the_post_type('home-customer-image').blank?
      customer = current_site.post_types.create(name: 'Home Customer Image', slug: 'home-customer-image')
      options = {
        has_category: false,
        has_content: true,
        has_tags: false,
        has_summary: false,
        has_comments: false,
        has_picture: false,
        has_template: false,
        has_keywords: false,
        contents_route_format: 'post_of_posttype'
      }
      customer.set_meta('_default', options)
      if customer.get_field_groups.where(slug: 'home-customer-image-fields').blank?
        customer_field_group = customer.add_field_group({ name: 'Home Customer Image Fields', slug: 'home-customer-image-fields' } )
        customer_field_group.add_field({ name: 'Customer Logo', slug: 'customer-logo' }, { field_key: 'image', required: true } )
      end
    end
  end

  def oscar_add_home_latest_blog_post_post_type
    if current_site.the_post_type('home-latest-blog-post').blank?
      post = current_site.post_types.create(name: 'Home Latest Blog Post', slug: 'home-latest-blog-post')
      options = {
        has_category: false,
        has_content: true,
        has_tags: false,
        has_summary: false,
        has_comments: false,
        has_picture: false,
        has_template: false,
        has_keywords: false,
        contents_route_format: 'post_of_posttype'
      }
      post.set_meta('_default', options)
      if post.get_field_groups.where(slug: 'home-latest-blog-post-fields').blank?
        post_field_group = post.add_field_group({ name: 'Home Latest Blog Post Fields', slug: 'home-latest-blog-post-fields' } )
        post_field_group.add_field({ name: 'Date', slug: 'date' }, { field_key: 'date', required: true } )
        post_field_group.add_field({ name: 'Post Title', slug: 'post-title' }, { field_key: 'text_box', required: true } )
        post_field_group.add_field({ name: 'Post Title Url', slug: 'post-url' }, { field_key: 'url', required: true } )
        post_field_group.add_field({ name: 'Post Content', slug: 'post-content' }, { field_key: 'text_area', required: true } )
      end
    end
  end

  def oscar_add_what_clients_say_post_type
    if current_site.the_post_type('home-what-clients-say').blank?
      post = current_site.post_types.create(name: 'What Clients Say', slug: 'home-what-clients-say')
      options = {
        has_category: false,
        has_content: true,
        has_tags: false,
        has_summary: false,
        has_comments: false,
        has_picture: false,
        has_template: false,
        has_keywords: false,
        contents_route_format: 'post_of_posttype'
      }
      post.set_meta('_default', options)
      if post.get_field_groups.where(slug: 'home-what-clients-say-fields').blank?
        post_field_group = post.add_field_group({ name: 'Home What Clients Say Fields', slug: 'home-what-clients-say-fields' } )
        post_field_group.add_field({ name: 'What Client Say', slug: 'what-client-say' }, { field_key: 'text_area', required: true } )
        post_field_group.add_field({ name: 'Client Image', slug: 'client-image' }, { field_key: 'image', required: true } )
        post_field_group.add_field({ name: 'Client Name', slug: 'client-name' }, { field_key: 'text_box', required: true } )
        post_field_group.add_field({ name: 'Client Position', slug: 'client-position' }, { field_key: 'text_box', required: true } )
      end
    end
  end

  def oscar_add_latest_tweets_post_type
    if current_site.the_post_type('home-latest-tweets').blank?
      tweet = current_site.post_types.create(name: 'Tweets', slug: 'home-tweets')
      options = {
        has_category: false,
        has_content: true,
        has_tags: false,
        has_summary: false,
        has_comments: false,
        has_picture: false,
        has_template: false,
        has_keywords: false,
        contents_route_format: 'post_of_posttype'
      }
      tweet.set_meta('_default', options)
      if tweet.get_field_groups.where(slug: 'home-latest-tweets-fields').blank?
        post_field_group = tweet.add_field_group({ name: 'Home Tweets Fields', slug: 'home-tweets-fields' } )
        post_field_group.add_field({ name: 'Tweet Content', slug: 'tweet-content' }, { field_key: 'text_area', required: true } )
        post_field_group.add_field({ name: 'Tweet Date', slug: 'tweet-date' }, { field_key: 'date', required: true } )
      end
    end
  end

  def oscar_add_customize_theme_setting(theme)
    if theme.get_field_groups.where(slug: 'social-media').blank?
      group = theme.add_field_group({name: 'Social Media', slug: 'social-media'})
      group.add_field({ name: 'Facebook Url', slug: 'facebook-url' }, { field_key: 'url', require: false })
      group.add_field({ name: 'Twitter Url', slug: 'twitter-url' }, { field_key: 'url' })
      group.add_field({ name: 'Linkedin Url', slug: 'linkedin-url' }, { field_key: 'url' })
    end

    if theme.get_field_groups.where(slug: 'home-slider').blank?
      group = theme.add_field_group({name: 'Home Slider', slug: 'home-slider'})
      group.add_field({ name: 'Image Slider', slug: 'image-slider' }, { field_key: 'image', require: true })
      group.add_field({ name: 'Video Slider', slug: 'video-slider' }, { field_key: 'video', require: false })
      group.add_field({ name: 'First Text Load', slug: 'first-text-load' }, { field_key: 'text_box' })
      group.add_field({ name: 'Second Text Load', slug: 'second-text-load' }, { field_key: 'text_box' })
      group.add_field({ name: 'Third Text Load', slug: 'third-text-load' }, { field_key: 'text_box' })
    end

    if theme.get_field_groups.where(slug: 'contact-us').blank?
      group = theme.add_field_group({name: 'Contact Us', slug: 'contact-us'})
      group.add_field({ name: 'Address', slug: 'contact-address' }, { field_key: 'text_box', require: true })
      group.add_field({ name: 'Phone', slug: 'contact-phone' }, { field_key: 'phone', require: true })
      group.add_field({ name: 'Email', slug: 'contact-email' }, { field_key: 'email', require: true })
    end
  end

  def oscar_get_nav_menu(key = 'main_menu', class_name = "navigation")
    option = {
      menu_slug: key,
      container_class: class_name,
      container_id: 'main-menu-ul',
      item_class_parent: 'dropdown mega-dropdown',
      sub_class:        'dropdown-menu mega-dropdown-menu row',
      callback_item: lambda do |args|
        args[:link_attrs] = "data-title='#{args[:link][:name].parameterize}'"
        if args[:has_children]
          args[:settings][:after] = "<span class='dropdown-icon'><i class='fa fa-angle-down' aria-hidden='true'></i></span>"
          args[:link_attrs] += "data-toggle='dropdown'"
        end
      end
    }
    draw_menu(option)
  end

  # callback executed after theme uninstalled
  def oscar_website_on_uninstall_theme(theme)
  end
end
