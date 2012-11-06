module Github
  class Repos
    def self.list(user = nil)
      if user.nil?
        request = Github.makeGetRequest("/user/repos?sort=pushed")  
      else
        request = Github.makeGetRequest("/users/#{user}/repos?sort=pushed")  
      end

      response = JSON.parse(request)

      if response.kind_of?(Array)
        response.each do |repo|
          puts "#{repo['name']} (#{repo['url']})"  
          puts " - Description: #{repo['description']}"
          puts " - Owner: #{repo['owner']['login']}"
          puts " - Language: #{repo['language']}"
          created_at = repo['created_at'].split("T")
          created_at_date = created_at[0].split("-")
          created_at_date = "#{created_at_date[1]}/#{created_at_date[2]}/#{created_at_date[0]}" 
          puts " - Created At: #{created_at[1]} on #{created_at_date}"
          updated_at = repo['updated_at'].split("T")
          updated_at_date = updated_at[0].split("-")
          updated_at_date = "#{updated_at_date[1]}/#{updated_at_date[2]}/#{updated_at_date[0]}" 
          puts " - Last Updated: #{updated_at[1]} on #{updated_at_date}"
          puts ""
        end
      elsif !response["errors"].nil?
        puts "ERROR: #{response['errors'][0]['message']}"
      elsif !response["message"].nil?
        puts "ERROR: #{response["message"]}"
      end
    end

    def self.create(name, description)
      if name.nil?
        print "Name of repository: "
        name = STDIN.gets.chomp
      end

      if description.nil?
        print "Description of repository: "
        description = STDIN.gets.chomp
      end

      jsonHash = {"name" => name, "description" => description}.to_json
      request = Github.makePostRequest("/user/repos", jsonHash)
      response = JSON.parse(request)

      if response["errors"].nil? && response["message"].nil?
        puts "Repository \"#{name}\" succesfully created! Hosted at: #{JSON.parse(request)["url"]}"
      elsif !response["errors"].nil?
        puts "ERROR: #{response['errors'][0]['message']}"
      elsif !response["message"].nil?
        puts "ERROR: #{response["message"]}"
      end
      puts ""
    end

    def self.delete(name)
      if name.nil?
        print "Name of repository: "
        name = STDIN.gets.chomp
      end

      puts "This well permenantly delete the repository '#{name}' from your github account. Are you sure you want to do this?"
      print "If so, type the name of the repository (enter to cancle): "
      confirm = STDIN.gets.chomp

      if confirm == name
        request = Github.makeDeleteRequest("/repos/#{Github.user}/#{name}")
        if request.nil?
          response = nil
        else
          response = JSON.parse(request)
        end

        if response.nil?
          puts "Repository '#{name}' has been deleted!"
        elsif !response["errors"].nil?
          puts "ERROR: #{response['errors'][0]['message']}"
        elsif !response["message"].nil?
          puts "ERROR: #{response["message"]}"
        end
      else
        puts "Name entered was incorrect and request has been cancled."
      end
      puts ""
    end

    def self.get(owner, name)
      if !name.nil?
        if owner == "self"
          request = Github.makeGetRequest("/repos/#{Github.user}/#{name}")  
        else
          request = Github.makeGetRequest("/repos/#{owner}/#{name}")  
        end

        response = JSON.parse(request)
        
        if response["errors"].nil? && response["message"].nil?
          puts "#{response['name']} (#{response['url']})"  
          puts " - Description: #{response['description']}"
          puts " - Owner: #{response['owner']['login']}"
          puts " - Language: #{response['language']}"
          created_at = response['created_at'].split("T")
          created_at_date = created_at[0].split("-")
          created_at_date = "#{created_at_date[1]}/#{created_at_date[2]}/#{created_at_date[0]}" 
          puts " - Created At: #{created_at[1]} on #{created_at_date}"
          updated_at = response['updated_at'].split("T")
          updated_at_date = updated_at[0].split("-")
          updated_at_date = "#{updated_at_date[1]}/#{updated_at_date[2]}/#{updated_at_date[0]}" 
          puts " - Last Updated: #{updated_at[1]} on #{updated_at_date}"
        elsif !response["errors"].nil?
          puts "ERROR: #{response['errors'][0]['message']}"
        elsif !response["message"].nil?
          puts "ERROR: #{response["message"]}"
        end
         puts ""
      else
        puts "A repository name must be specified."
        puts ""
      end      
    end
  end
end
