#include "twitchirc.h"
#include "main.h"

TwitchIRC::TwitchIRC *twitchIRC = nullptr;

void HandleConnection(const bool _error, std::string _message)
{
    if (_error)
    {
        printf("[ClientIRC] Error ::> %s\n", _message.c_str());
        return;
    }
    //printf("[ClientIRC] Connected ::> %s\n", _message.c_str());
}

void HandleRecv(TwitchIRC::Message _message)
{
    if (strcmp(_message.GetString().c_str(), "Ping"))
    {
        twitchIRC->SendMessage(("Pong " + _message.GetAuthor().GetMention()).c_str(), _message.GetChannelID().c_str());
    }
    printf("<#%s> %s : %s\n", _message.GetChannelID().c_str(), _message.GetAuthor().GetUsername().c_str(), _message.GetString().c_str());
}


void HandleUserJoined(TwitchIRC::User _user)
{
    //printf("%s - Joined\n", _user.GetUsername().c_str());
}

void HandleUserLeft(TwitchIRC::User _user)
{
    //printf("%s - Left\n", _user.GetUsername().c_str());
}

void HandleIRCError(std::string _errMsg)
{
    //printf("[Client IRC] Error ::> %s \n", _errMsg.c_str());
}
void HandleUnhandledTwitchEvent(std::string _rawMessage, TwitchIRC::IRCEvent _event)
{
    //printf("[Twitch Event] :: %s - %s\n", _event.GetEventName().c_str(), _event.GetData().c_str());
}

int main()
{
    twitchIRC = TwitchIRC::TwitchIRC::LoadFromFile("twitch.secret");

    if (twitchIRC != nullptr)
    {
        twitchIRC->SetClientIRCConnectionCallback(HandleConnection);
        twitchIRC->SetClientIRCErrorCallback(HandleIRCError);
        twitchIRC->SetReceiveMessageCallback(HandleRecv);

        twitchIRC->SetTwitchUserJoinedCallback(HandleUserJoined);
        twitchIRC->SetTwitchUserLeftCallback(HandleUserLeft);
        twitchIRC->SetTwitchUnhandledEventCallback(HandleUnhandledTwitchEvent);

        while (!twitchIRC->IsConnected())
        {
            twitchIRC->Connect("ludwig");

            while (twitchIRC->IsConnected())
            {
                twitchIRC->Poll();
            }
        }

        delete twitchIRC;
        return 0;
    }
    return 1;
}