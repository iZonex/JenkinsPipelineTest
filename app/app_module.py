""" Test module for check pytest """


class AppModule:
    """ Simple AppModule class to test py test """

    def __init__(self, name, action):
        self._name = name
        self._action = action

    def get_name(self):
        """ simple return name """
        return self._name

    def get_action(self):
        """ simple return action """
        return self._action
