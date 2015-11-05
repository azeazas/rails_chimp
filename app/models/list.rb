class List < ActiveRecord::Base
  require 'json'

  has_many :members


  def self.get_lists
    response = RestClient.get 'https://us12.api.mailchimp.com/3.0/lists',
                              { Authorization: "apikey d70e65cfba27c1de1886422ed8c84f9f-us12"}
    # puts JSON.pretty_generate(JSON.parse(response))
    response = JSON.parse(response)
    response["lists"].each do |list|
      List.find_or_create_by(chimp_id: list["id"]) do |item|
        item.name = list["name"]
        item.from_name = list["campaign_defaults"]["from_name"]
        item.from_email = list["campaign_defaults"]["from_email"]
      end
    end
  end


    def self.make_list
      RestClient::Request.execute(method: :post, url: 'https://us12.api.mailchimp.com/3.0/lists',
                                 user: "apikey:d70e65cfba27c1de1886422ed8c84f9f-us12",
                                  payload: {
                                    "name" => "Freddie's Favorite Hats",
                                    "contact" => {
                                      "company" => "MailChimp",
                                      "address1" => "675 Ponce De Leon Ave NE",
                                      "address2" => "Suite 5000",
                                      "city" => "Atlanta",
                                      "state" => "GA",
                                      "zip" => "30308",
                                      "country" => "US",
                                      "phone" => ""
                                    },
                                    "permission_reminder" => "You're receiving this email because you signed up for updates about Freddie's newest hats.",
                                    "campaign_defaults" => {
                                      "from_name" => "Freddie",
                                      "from_email" => "freddie@freddiehats.com",
                                      "subject" => "",
                                      "language" => "en"
                                    },
                                    "email_type_option" => true
                                  }
                                  )
    end



end
