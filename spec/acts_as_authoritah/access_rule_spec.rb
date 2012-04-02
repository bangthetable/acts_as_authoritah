require 'spec_helper'

describe AccessRule do
  context "after setup" do
    before :each do
      @access_rule = AccessRule.new("BlogPosts#edit", "edit a blog post",{:admin => true, :anonymous => false})
    end
  
    it "should be able to build a new access rule and return its identifier" do
      @access_rule.identifier.should eq "BlogPosts#edit"
    end
  
    it "should be able to build a new access rule and return its description" do
      @access_rule.description.should eq "edit a blog post"
    end
  
    it "should be able to build a new access rule and return its access-rights" do
      @access_rule.access_rights.should eq({:admin => true, :anonymous => false})
    end
  end
  
  describe "identifier" do
    context "action" do
      it "should return nil if identifier is empty" do
        access_rule = AccessRule.new("", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.action.should be_nil
      end
      
      it "should return nil if identifier is nil" do
        access_rule = AccessRule.new(nil, "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.action.should be_nil
      end

      it "should return nil if only controller name is present" do
        access_rule = AccessRule.new("BlogPosts", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.action.should be_nil
      end
      
      it "should return nil if only controller name and scope is present" do
        access_rule = AccessRule.new("Admin::BlogPosts", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.action.should be_nil
      end

      it "should return nil if only controller name and '#' is present" do
        access_rule = AccessRule.new("Admin::BlogPosts#", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.action.should be_nil
      end

      it "should return action name when controller and action are present" do
        access_rule = AccessRule.new("BlogPosts#edit", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.action.should eq "edit"
      end
      
      it "should return action name when controller, one level scope and action are present" do
        access_rule = AccessRule.new("Projects::BlogPosts#edit", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.action.should eq "edit"
      end
      
      it "should return action name when controller, two level scopes and action are present" do
        access_rule = AccessRule.new("Admin::Projects::BlogPosts#edit", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.action.should eq "edit"
      end
    end
    
    context "controller" do
      it "should return nil if identifier is empty" do
        access_rule = AccessRule.new("", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.controller.should be_nil
      end
      
      it "should return nil if identifier is nil" do
        access_rule = AccessRule.new(nil, "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.controller.should be_nil
      end

      it "should return controller name if only controller is present" do
        access_rule = AccessRule.new("BlogPosts", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.controller.should eq "BlogPosts"
      end
      
      it "should return controller name if controller and action are present" do
        access_rule = AccessRule.new("BlogPosts#edit", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.controller.should eq "BlogPosts"
      end
      
      it "should return controller name if controller, one level scope and action are present" do
        access_rule = AccessRule.new("Projects::BlogPosts#edit", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.controller.should eq "Projects::BlogPosts"
      end
      
      it "should return controller name if controller, two level scopes and action are present" do
        access_rule = AccessRule.new("Admin::Projects::BlogPosts#edit", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.controller.should eq "Admin::Projects::BlogPosts"
      end

      it "should return controller name if controller and '#' are present" do
        access_rule = AccessRule.new("BlogPosts#", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.controller.should eq "BlogPosts"
      end
    end
    
    context "scopes" do
      it "should return nil if identifier is empty" do
        access_rule = AccessRule.new("", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.scopes.should eq []
      end
      
      it "should return nil if identifier is nil" do
        access_rule = AccessRule.new(nil, "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.scopes.should eq []
      end

      it "should return [] if only controller is present" do
        access_rule = AccessRule.new("BlogPosts", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.scopes.should eq []
      end
      
      it "should return scope array if controller and level one scope is present" do
        access_rule = AccessRule.new("Projects::BlogPosts", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.scopes.should eq ["Projects"]
      end
      
      it "should return scope array if controller and level two scope is present" do
        access_rule = AccessRule.new("Admin::Projects::BlogPosts", "edit a blog post",{:admin => true, :anonymous => false})
        access_rule.scopes.should eq ["Admin","Projects"]
      end


    end
  end

end