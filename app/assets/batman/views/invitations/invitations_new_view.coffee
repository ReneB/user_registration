class UserRegistration.InvitationsNewView extends Batman.View
  source: 'invitations/new'

  viewWillAppear: ->
    @set('controller', UserRegistration.get('controllers').get('invitations'))

    @get('controller').on 'ModelSavedOnServer', (invitation) =>
      @set(
        'invitationFeedback',
        Batman.I18N.translate('content.invitation.feedback', colleague: invitation.get('recipient_name'))
      )
      @invitation().observe("recipient_name", ClearElementsCallback)
      @invitation().observe("recipient_email", ClearElementsCallback)

    ClearElementsCallback = (newValue, oldValue) =>
      @set('invitationFeedback', '')
      @invitation().forget "recipient_name", ClearElementsCallback
      @invitation().forget "recipient_email", ClearElementsCallback

  invitation: ->
    @get('controller').get('invitation')

  # buttonWasClicked: (node, event, view) ->
    # You can put all of your event handlers in this view file. You can access
    # data by using `view.lookupKeypath('someData')` or `@controller`.
