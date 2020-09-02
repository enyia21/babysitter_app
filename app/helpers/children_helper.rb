module ChildrenHelper
    def children_not_entered(parent)
        !parent.children.present? 
    end
end
