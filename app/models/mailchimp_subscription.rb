class MailchimpSubscription < ActiveRecord::Base
  require 'mailchimp'

  def self.monkey
    Mailchimp::API.new(MAILCHIMP_API_KEY)
  end

  def self.lists
    lists = monkey.lists.list
    list  = lists['data']
  end

  def self.list_name(id)
    result = monkey.lists.list({list_id: id})
    result['data'][0]['name'] if result
  end

  # http://andrew.coffee/blog/how-to-add-subscribers-to-a-mailchimp-list-with-ruby.html
  def self.subscribe(list_id, user_details)
    monkey.lists.subscribe(list_id,
                               # The email field is a struct that can use an
                               #    email address or two MailChimp specific list ids (see API docs)
                               {email: user_details[:email]},
                               # Set your merge vars here
                               {'FNAME' => user_details[:forename], 'LNAME' => user_details[:surname]})
    true
  rescue Mailchimp::ListAlreadySubscribedError
    'You already subscribed'
    # Decide what to do if the user is already subscribed
  rescue Mailchimp::ListDoesNotExistError => e
    # This is definitely a problem I want to know about
    #raise e
    'List does not exist'
  rescue Mailchimp::Error => e
    'Mailchimp API down, please try again later'
    # Unforeseen errors that need to be dealt with
  end
end
