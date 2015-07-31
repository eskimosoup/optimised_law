module Admin
  class AcademyEntryDownloadsController < Manticore::ApplicationController
    before_action :set_academy_entry_download, only: [:edit, :update, :destroy]

    def index
      @academy_entry_downloads = AcademyEntryDownload.order(:academy_entry_id)
    end

    def new
      @academy_entry_download = AcademyEntryDownload.new
    end

    def create
      @academy_entry_download = AcademyEntryDownload.new(academy_entry_download_params)
      if @academy_entry_download.save
        redirect_to admin_academy_entry_downloads_path, notice: 'Academy entry download successfully created.'
      else
        render action: :new
      end
    end

    def edit
    end

    def update
      if @academy_entry_download.update_attributes(academy_entry_download_params)
        redirect_to admin_academy_entry_downloads_path, notice: 'Academy entry download successfully updated.'
      else
        render action: :edit
      end
    end

    def destroy
      @academy_entry_download.destroy
      redirect_to admin_academy_entry_downloads_path, notice: 'Academy entry download destroyed.'
    end

    private

    def set_academy_entry_download
      @academy_entry_download = AcademyEntryDownload.find(params[:id])
    end

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def academy_entry_download_params
      params.require(:academy_entry_download).permit(:company, :email, :forename, :surname)
    end

  end
end
