class Give < HyperComponent

  def iframe
    id = "4e05c432-596a-4891-8c6d-38581e879474"
    src = "https://host.nxt.blackbaud.com/donor-form?formId=#{id}&envid=p-pfJFr4mVUUaa236IU4z_rQ"
    IFRAME(
      id:    "form-#{id}",
      src:   src,
      class: "blackbaud-donation-form",
      title: "Donation Form",
      style: {
        backgroundColor: :white,
        maxWidth: 600, minWidth: 320, minHeight: 150,
        width: '100%', height: '100%',
        border: :none
      }
    )
  end

  # after_mount do
  #   url = 'https://host.nxt.blackbaud.com/donor-form?formId=4e05c432-596a-4891-8c6d-38581e879474&envid=p-pfJFr4mVUUaa236IU4z_rQ';
  #   iframe = `document.getElementById('form-4e05c432-596a-4891-8c6d-38581e879474')`
  #   # bbemlParser = new RegExp('[?&]bbeml=([^&#]*)').exec(document.location.search);
  #   # bbeml = bbemlParser ? decodeURI(bbemlParser[1]) || 0 : '';
  #   `#{iframe}.src = #{url}` # + '&referral=' + document.referrer + '&bbeml=' + bbeml;
  # end

  styles do
    {
      container: {
        fontSize: [WindowDims.height * WindowDims.width / 70_000, 17].max,
        overflow: :auto
      },
      header: {
        background: 'rgba(255, 255, 255, 0.6)',
        textAlign: :center,
        padding: [WindowDims.height * WindowDims.width / 80_000, 5].max, marginTop: 5, marginBottom: 20
      },
      paper: {
        background: 'rgba(255, 255, 255, 0.6)',
        padding: [WindowDims.height * WindowDims.width / 80_000, 5].max, marginTop: 5, marginBottom: 5
      },
      row: {
        display: :flex, flexFlow: :row, overflow: :hidden
      },
      metric: {
        fontSize: '0.6em',
        marginTop: '0.4em',
        width: '30%'
      },
      city: {
        flexGrow: 100
      },
      flag: {
        height: 20
      }
    }
  end

  render do
    Mui::Container(styles(:container), class: 'row content') do
      Mui::Grid(:container, spacing: 1) do
        Mui::Grid(:item, xs: 12, sm: 8) do
          #Mui::Paper(styles(:paper), elevation: 3) do
            iframe
          #end
        end
      end
    end
  end
end
