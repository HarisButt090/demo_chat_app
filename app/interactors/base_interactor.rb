# :Base Interactor for including the Interactor Module:

class BaseInteractor
    include Interactor
  
    # Common methods to share params across all interactors
    def params
      context.params
    end
  
    def current_user
      context&.current_user
    end
  
    def generate_blob!(file)
      ActiveStorage::Blob.create_and_upload!(
        io: file,
        filename: file.original_filename,
        content_type: file.content_type
      )
    end
end