class UserRegistration.InvitationsController extends UserRegistration.ApplicationController
  routingKey: 'invitations'

  constructor: ->
    super
    @setInvitation()
    @set('InvitationWasSend', false)

  create: (params) ->
    @invitation.save( (ErrorSet, Invitation) =>
      if (ErrorSet is undefined)
        @setInvitation(Invitation.get('inviter_name'))
        @fire('ModelSavedOnServer', Invitation)
        @set('InvitationWasSend', true)
    )

  setInvitation: (inviter_name) ->
    @set('invitation', new UserRegistration.Invitation)
    @invitation.set('inviter_name', inviter_name) if inviter_name isnt undefined

