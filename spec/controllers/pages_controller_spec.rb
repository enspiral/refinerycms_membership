require 'spec_helper'

describe PagesController do

  include Devise::TestHelpers

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  before do
    # this is required so we don't get redirected to the
    # 'create a first user' page
    controller.stub(:show_welcome_page?).and_return(false)
  end

  describe "check page with no user logged" do
    before do
      @page = Page.create!(:title => 'page all can see')
    end
    it "should let me see the page, even if no one is logged in" do
      get :show, :id => @page.id
      response.status.should eql 200
    end
  end

  describe "check pages and user roles for permissibility" do
    before do
      # mock up an authentication in the underlying warden library
      request.env['warden'] = mock(Warden, :authenticate => mock_user,
                                           :authenticate! => mock_user,
                                           :authenticate? => true)

      @page = Page.create!(
        :title => 'my restricted page',
        :roles => [Role[:my_role]])
    end

    it "should redirect for invalid page/user role combination" do
      @mock_user.stub(:roles).and_return([])
      get :show, :id => @page.id
      assert_redirected_to(login_members_path(:redirect => request.fullpath, :member_login => true))
    end

    it "should 200 for valid page/user role combination" do
      @mock_user.stub(:roles).and_return([Role[:my_role]])
      get :show, :id => @page.id
      response.status.should eql 200
    end
  end
end
