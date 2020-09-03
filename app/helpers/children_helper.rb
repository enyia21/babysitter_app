module ChildrenHelper
    def children_not_entered(parent)
        !parent.children.present? 
    end

    def get_full_name(user)
        binding.pry
        "#{user.first_name} #{user.last_name}"
    end

    def never_been_babysat(child)
        !child.appointments.present?
    end
end
