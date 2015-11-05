class Member < ActiveRecord::Base
  belongs_to :list

  def self.get_members(list_id)
    response = RestClient.get "https://us12.api.mailchimp.com/3.0/lists/#{list_id}/members",
                              { Authorization: "apikey d70e65cfba27c1de1886422ed8c84f9f-us12"}
    # puts JSON.pretty_generate(JSON.parse(response))
    response = JSON.parse(response)
    response["members"].each do |member|
      Member.find_or_create_by(chimp_id: member["id"]) do |item|
        item.first_name = member["merge_fields"]["FNAME"]
        item.last_name = member["merge_fields"]["LNAME"]
        item.email = member["email_address"]
        item.list = List.find_by(chimp_id: member["list_id"])
      end
    end

  end
end
