class PackagesController < ApplicationController
  def index
    
    if @current_user == nil
      redirect_to("/user_sign_in")
   else 
    matching_packages = Package.all
    @list_of_packages = matching_packages.order({ :created_at => :desc })

    @package_waiting= @list_of_packages.where({ :status => "waiting_on"})
    @package_received= @list_of_packages.where({ :status => "received"})

    render({ :template => "packages/index.html.erb" })
   end 
   
  end

  def show
    the_id = params.fetch("path_id")

    matching_packages = Package.where({ :id => the_id })

    @the_package = matching_packages.at(0)

    render({ :template => "packages/show.html.erb" })
  end

  def create
    the_package = Package.new
    the_package.description = params.fetch("query_description")
    the_package.arrival_date = params.fetch("query_arrival_date")
    the_package.details = params.fetch("query_details")
    the_package.user_id = @current_user.id
    the_package.status = "waiting_on"

    if the_package.valid?
      the_package.save
      redirect_to("/", { :notice => "Package created successfully." })
    else
      redirect_to("/", { :alert => the_package.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("package_id")
    the_package = Package.where({ :id => the_id }).at(0)

    the_package.user_id = @current_user.id
    the_package.status = "received"

    if the_package.valid?
      the_package.save
      redirect_to("/", { :notice => "Package updated successfully."} )
    else
      redirect_to("/", { :alert => the_package.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_package = Package.where({ :id => the_id }).at(0)

    the_package.destroy

    redirect_to("/", { :notice => "Package deleted successfully."} )
  end
end
