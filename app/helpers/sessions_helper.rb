module SessionsHelper
    def valid_type?(user_input)
        types = ["Admin", "Parent", "Babysitter"]
        types.include?(user_input)
    end

    def find_admin(user_name)
        Admin.find_by(username: user_name)
    end

    def find_parent(user_name)
        Parent.find_by(username: user_name)
    end

    def find_babysitter(user_name)
        Babysitter.find_by(username: user_name)
    end
    
    def find_user(user_type, user_name)
        if valid_type?(user_type)
            case user_type
            when "Admin"
                find_admin(user_name)
            when "Parent"
                find_parent(user_name)
            when "Babysitter"
                find_babysitter(user_name)
            else
                nil
            end
        else
            nil
        end
    end
    
    def choose_path(user_type, user)
        case user_type
        when "Admin"
            redirect_to admin_path(user) and return
        when "Parent"
            redirect_to parent_path(user) and return
        when "Babysitter"
            redirect_to babysitter_path(user) and return
        else
            nil
        end
    end

    def find_provider(auth)
        case auth["provider"]
        when "github"
            uid = { guid: auth["uid"] }
        when "facebook"
           uid = { fuid: auth["uid"] }
        else
            auth.clear
            session.clear
            redirect_to root_path and return
        end
    end

    
end