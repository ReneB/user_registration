class UserRegistration.InvitationsController extends UserRegistration.ApplicationController
  routingKey: 'invitations'

  constructor: ->
    super
    @setInvitation()

  create: (params) ->
    @invitation.save( (ErrorSet, Invitation) =>
      if (ErrorSet is undefined)
        @setInvitation(Invitation.get('inviter_name'))
        @fire('ModelSavedOnServer', Invitation)
    )

  setInvitation: (inviter_name) ->
    @set('invitation', new UserRegistration.Invitation)
    @invitation.set('inviter_name', inviter_name) if inviter_name isnt undefined

