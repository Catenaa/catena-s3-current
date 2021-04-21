Config = {}

Config.RestrictedChannels = 10 -- channels that are encrypted (EMS, Fire and police can be included there) if we give eg 10, channels from 1 - 10 will be encrypted

Config.MaxFrequency = 500

Config.messages = {
  ['not_on_radio'] = 'You are not connected to a signal',
  ['on_radio'] = 'You are already connected to this signal: <b>',
  ['joined_to_radio'] = 'You are connected on: <b>',
  ['restricted_channel_error'] = 'You cannot connect to this signal!',
  ['you_on_radio'] = 'You are already connected to this signal: <b>',
  ['you_leave'] = 'You left the signal: <b>'
}