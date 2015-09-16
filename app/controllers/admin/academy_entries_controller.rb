module Admin
  class AcademyEntriesController < Manticore::ApplicationController
    before_action :set_academy_entry, only: [:edit, :update, :destroy]

    edit_image_for AcademyEntry, :image

    def index
      @academy_entries = AcademyEntry.all
    end

    def new
      @academy_entry = AcademyEntry.new
    end

    def create
      @academy_entry = AcademyEntry.new(academy_entry_params)
      if @academy_entry.save
        redirect_to admin_academy_entries_path, notice: 'Academy entry successfully created.'
      else
        render action: :new
      end
    end

    def edit
    end

    def update
      if @academy_entry.update_attributes(academy_entry_params)
        redirect_to admin_academy_entries_path, notice: 'Academy entry successfully updated.'
      else
        render action: :edit
      end
    end

    def destroy
      @academy_entry.destroy
      redirect_to admin_academy_entries_path, notice: 'Academy entry destroyed.'
    end

    private

    def set_academy_entry
      @academy_entry = AcademyEntry.friendly.find(params[:id])
    end

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def academy_entry_params
      params.require(:academy_entry).permit(:display, :image, :level, :email_content, :mailchimp_form, :mailchimp_frequency, :pdf_download, :summary, :title, :image_cache, :remove_image, :remove_pdf_download)
    end

  end
end
