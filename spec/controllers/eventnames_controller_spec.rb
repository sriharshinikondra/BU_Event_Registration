require 'rails_helper'

# integration tests
# deep (hit the database)
# shallow (stub the database, stubbing the collaborating model)

describe EventnamesController, type: :controller do
  
  describe '#index' do  #there would be quite a few tests here!
    before(:each) do
      @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
      session[:user_id] = @user.id      
      @current_user = @user      
    end 
    let(:eventname1) {instance_double('Eventname', eventnamecode: '12345', title: 'Graduation ceremony', description: 'Econ', create_date: '1977-05-25')}
    let(:eventname2) {instance_double('Eventname', eventnamecode: '127A5', title: 'commencement', description: 'Plants and animals', create_date: '1971-03-11')}
    let(:eventname3) {instance_double('Eventname', eventnamecode: '190H5', title: 'farewell', description: 'Maps and directions', create_date: '1982-06-25')}
    let(:eventnames) { [eventname1, eventname2, eventname3] }
    it 'Retrieves all of the eventnames' do
      allow(Eventname).to receive(:all).and_return([eventname1, eventname2, eventname3])
      get :index
      expect(assigns(:eventnames)).to eq(eventnames)
    end
  end
  describe '#new' do
    before(:each) do
      @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
      session[:user_id] = @user.id      
      @current_user = @user      
    end     
    it 'selects the new template for rendering' do
      get :new
      expect(response).to render_template('new')
    end
  end  
  describe '#create' do
    before(:each) do
      @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
      session[:user_id] = @user.id      
      @current_user = @user      
    end 
    let(:params) { {eventnamecode: '12345', title: 'Economics', description: 'Econ', create_date: '1977-05-25'} }
    let(:eventname) { instance_double('Eventname', params)}
    let(:id1) {'1'}
    it 'Creates a new eventname' do
      expect(Eventname).to receive(:create!).with(params).and_return(eventname)
      post :create, eventname: params
    end
    it 'Sets a flash message' do
      allow(Eventname).to receive(:create!).with(params).and_return(eventname)
      post :create, eventname: params
      expect(flash[:notice]).to match(/^.* was successfully created.$/)  
    end
    it 'Redirects to the eventname page' do
      allow(Eventname).to receive(:create!).with(params).and_return(eventname)
      post :create, eventname: params
      expect(response).to redirect_to(eventnames_path)
    end
  end
  describe '#show' do
    before(:each) do
      @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
      session[:user_id] = @user.id      
      @current_user = @user      
    end
    let(:eventname1) {instance_double('Eventname', eventnamecode: '12345', title: 'Economics', description: 'Econ', create_date: '1977-05-25')}
    let(:id1) {'1'}
    it 'Retrieves the eventname' do
      expect(controller).to receive(:set_eventname).and_return(eventname1)
      get :show, id: id1 
    end
    it 'selects the show template for rendering' do
      allow(controller).to receive(:set_eventname).and_return(eventname1)
      get :show, id: id1 
      expect(response).to render_template('show')  
    end
    it 'makes the eventname available to the template' do
      allow(controller).to receive(:set_eventname).and_return(eventname1)
      get :show, id: id1 
      expect(assigns(:eventname)).to eq(eventname1)
    end
  end
 
  describe '#edit' do
    before(:each) do
      @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
      session[:user_id] = @user.id      
      @current_user = @user      
    end
    let(:id1) {'1'}
    let(:eventname){instance_double('Eventname', eventnamecode: '12345', title: 'Economics', description: 'Econ', create_date: '1977-05-25')}
    it 'Retrieves the eventname' do
      expect(controller).to receive(:set_eventname).and_return(eventname)
      get :edit, id: id1 
    end
    it 'selects the Edit template for rendering' do
      allow(controller).to receive(:set_eventname).and_return(eventname)
      get :edit, id: id1 
      expect(response).to render_template('edit') 
    end
    it 'makes the eventname available to the template' do
      allow(controller).to receive(:set_eventname).and_return(eventname)
      get :edit, id: id1 
      expect(assigns(:eventname)).to eq(eventname)
    end
  end
  describe '#destroy' do
    before(:each) do
      @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
      session[:user_id] = @user.id      
      @current_user = @user      
    end
    let(:id1) {'1'}
    let(:eventname) {instance_double('Eventname', eventnamecode: '12345', title: 'Economics', description: 'Econ', create_date: '1977-05-25')}
    it 'Retrieves the eventname' do
      expect(controller).to receive(:set_eventname).and_return(eventname)
      allow(eventname).to receive(:destroy)
      delete :destroy, :id => id1
    end    
    it 'Calls the destroy method to delete the eventname' do
      allow(controller).to receive(:set_eventname).and_return(eventname)
      expect(eventname).to receive(:destroy)
      delete :destroy, :id => id1
    end
    it 'Sets the flash message' do
      allow(controller).to receive(:set_eventname).and_return(eventname)
      allow(eventname).to receive(:destroy)
      delete :destroy, :id => id1
      expect(flash[:notice]).to match(/^Eventname \'[^']*\' deleted.$/)  
    end
    it 'Redirects to the eventnames page' do
      allow(controller).to receive(:set_eventname).and_return(eventname)
      allow(eventname).to receive(:destroy)
      delete :destroy, :id => id1
      expect(response).to redirect_to(eventnames_path)
    end
  end
  describe '#update' do
    before(:each) do
      @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
      session[:user_id] = @user.id      
      @current_user = @user      
    end
    let(:params) { {eventnamecode: '12345', title: 'Economics', description: 'Econ', create_date: '1977-05-25'} }
    let(:eventname) { instance_double('Eventname', params)}
    let(:id1) {'1'}
    let(:updated){ instance_double('Eventname', title: 'Zoology', description: 'Animals') }
    it 'Retrieves the eventname' do
      expect(controller).to receive(:set_eventname).and_return(eventname)
      allow(eventname).to receive(:update_attributes!).with(params)
      put :update, id: id1, eventname: params
    end
    it 'Updates the eventname attributes' do
      allow(controller).to receive(:set_eventname).and_return(eventname)
      expect(eventname).to receive(:update_attributes!).with(params).and_return(updated)
      put :update, id: id1, eventname: params
    end
    it 'Sets a flash message' do
      allow(controller).to receive(:set_eventname).and_return(eventname)
      allow(eventname).to receive(:update_attributes!).with(params).and_return(updated)
      put :update, id: id1, eventname: params
      expect(flash[:notice]).to match(/^.* was successfully updated.$/)  
    end
    it 'Redirects to the eventnames page' do
      allow(controller).to receive(:set_eventname).and_return(eventname)
      allow(eventname).to receive(:update_attributes!).with(params).and_return(updated)
      put :update, id: id1, eventname: params
      expect(response).to redirect_to(eventname_path(eventname))
    end
  end
end
