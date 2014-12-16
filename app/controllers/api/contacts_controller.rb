class Api::ContactsController < Api::ApplicationController
  def create
    @contct = Contact.new(params[:contact])
    return render json: {errors: @contct.errors.full_messages}, status: :bad_request unless @contct.valid?
    client = Google::APIClient.new(application_name: 'mochimochi-reservation', application_version: '1.0.0')
    client.authorization = Signet::OAuth2::Client.new(
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      audience: 'https://accounts.google.com/o/oauth2/token',
      scope: 'https://www.googleapis.com/auth/drive',
      issuer: ENV['ISSUER'],
      signing_key: Google::APIClient::KeyUtils.load_from_pkcs12('key.p12', 'notasecret')
    )
    token = client.authorization.fetch_access_token!
    session = GoogleDrive.login_with_oauth(token['access_token'])
    worksheet = session.spreadsheet_by_key(ENV['SPREADSHEET_KEY']).worksheets[0]

    row = worksheet.num_rows + 1
    worksheet[row, 1] = @contct.email
    worksheet[row, 2] = @contct.name
    worksheet[row, 3] = @contct.content
    worksheet[row, 4] = @contct.motimoti_vol1_count
    worksheet.save

    head :ok
  end
end
