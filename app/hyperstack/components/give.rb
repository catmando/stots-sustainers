class Give < HyperComponent

  param :id

  def iframe
    src = "https://host.nxt.blackbaud.com/donor-form?"\
          "formId=#{id}&envid=p-pfJFr4mVUUaa236IU4z_rQ&"\
          "referral=#{`encodeURIComponent(document.location.href)`}"
    IFRAME(
      id:    "form-#{id}",
      src:   src,
      class: "blackbaud-donation-form",
      title: "Donation Form",
      style: {
        backgroundColor: :white,
        maxWidth: 600, minWidth: 290, minHeight: 150,
        width: '100%', height: '100%',
        border: :none
      }
    )
  end

  render do
    Mui::Container(style: { overflow: :auto }, class: 'row content') do
      Mui::Grid(:container, spacing: 1) do
        Mui::Grid(:item, xs: 12, sm: 8) do
          iframe
        end
      end
    end
  end
end
