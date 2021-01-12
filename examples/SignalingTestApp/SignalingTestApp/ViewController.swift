//
//  ViewController.swift
//  SignalingTestApp
//
//  Created by Gloria Li on 2021-01-11.
//

import UIKit
import AzureCommunicationChat
import AzureCommunication
import AzureCore
import AzureCommunicationSignaling

struct Constants {
    static let endpoint =  "<connection string>"
}

class ViewController: UIViewController {
    
    var chatClient:ChatClient? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = "<skypetoken>"
        onStart(skypeToken: value)
    }
    
    func onStop()
    {
        chatClient?.stopRealTimeNotifications()
    }
    
    func onStart (skypeToken: String)
    {
        let communicationUserCredential: CommunicationUserCredential
        do {
            communicationUserCredential = try CommunicationUserCredential(token:skypeToken)
        } catch {
            fatalError(error.localizedDescription)
        }
        
        chatClient = getClient(credential:communicationUserCredential)
        chatClient?.startRealTimeNotifications()
        
        chatClient?.on(event: "chatMessageReceived", listener:{
            (response, eventId)
            in
            self.handleChatEvents(response: response, eventId: eventId)
        })
        chatClient?.on(event: "typingIndicatorReceived", listener:{
            (response, eventId)
            in
            self.handleChatEvents(response: response, eventId: eventId)
        })
        chatClient?.on(event: "readReceiptReceived", listener:{
            (response, eventId)
            in
            self.handleChatEvents(response: response, eventId: eventId)
        })
        chatClient?.on(event: "chatMessageEdited", listener:{
            (response, eventId)
            in
            self.handleChatEvents(response: response, eventId: eventId)
        })
        chatClient?.on(event: "chatMessageDeleted", listener:{
            (response, eventId)
            in
            self.handleChatEvents(response: response, eventId: eventId)
        })
        chatClient?.on(event: "chatThreadCreated", listener:{
            (response, eventId)
            in
            self.handleChatEvents(response: response, eventId: eventId)
        })
        chatClient?.on(event: "chatThreadPropertiesUpdated", listener:{
            (response, eventId)
            in
            self.handleChatEvents(response: response, eventId: eventId)
        })
        chatClient?.on(event: "chatThreadDeleted", listener:{
            (response, eventId)
            in
            self.handleChatEvents(response: response, eventId: eventId)
        })
        chatClient?.on(event: "participantsAdded", listener:{
            (response, eventId)
            in
            self.handleChatEvents(response: response, eventId: eventId)
        })
        chatClient?.on(event: "participantsRemoved", listener:{
            (response, eventId)
            in
            self.handleChatEvents(response: response, eventId: eventId)
        })
        
    }
    
    func getClient(credential: CommunicationUserCredential? = nil) -> ChatClient {
        let scope = Constants.endpoint
        do {
            let options = AzureCommunicationChatClientOptions(logger: ClientLoggers.none)
            return try ChatClient(endpoint: scope, credential: credential!, withOptions: options)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func handleChatEvents (response:Any, eventId: ChatEventId)
    {
        if (eventId == ChatEventId.chatMessageReceived)
        {
            let response = response as! ChatMessageReceivedEvent
            print("\n------> ChatMessageReceivedEvent Received: ", response)
            print("\n------> threadId is: ", response.threadId)
            print("\n------> id is: ", response.id)
            print("\n------> content is: ", response.content)
        }
        else if(eventId == ChatEventId.typingIndicatorReceived)
        {
            let response = response as! TypingIndicatorReceivedEvent
            print("\n------> TypingIndicatorReceivedEvent Received: ", response)
            print("\n------> threadId is: ", response.threadId)
            print("\n------> receivedOn is: ", response.receivedOn)
            print("\n------> version is: ", response.version)
            
        }
        else if(eventId == ChatEventId.readReceiptReceived)
        {
            let response = response as! ReadReceiptReceivedEvent
            print("\n------> ReadReceiptReceivedEvent Received: ", response)
            print("\n------> threadId is: ", response.threadId)
            print("\n------> readOn is: ", response.readOn)
            print("\n------> chatMessageId is: ", response.chatMessageId)
        }
        else if(eventId == ChatEventId.chatMessageEdited)
        {
            let response = response as! ChatMessageEditedEvent
            print("\n------> ChatMessageEditedEvent Received: ", response)
            print("\n------> threadId is: ", response.threadId)
            print("\n------> editedOn is: ", response.editedOn)
            print("\n------> content is: ", response.content)
            
        }
        else if(eventId == ChatEventId.chatMessageDeleted)
        {
            let response = response as! ChatMessageDeletedEvent
            print("\n------> ChatMessageDeletedEvent Received: ", response)
            print("\n------> threadId is: ", response.threadId)
            print("\n------> deletedOn is: ", response.deletedOn)
            
        }
        else if(eventId == ChatEventId.chatThreadCreated)
        {
            let response = response as! ChatThreadCreatedEvent
            print("\n------> ChatThreadCreatedEvent Received: ", response)
            print("\n------> threadId is: ", response.threadId)
            print("\n------> createdOn is: ", response.createdOn)
            
        }
        else if(eventId == ChatEventId.chatThreadPropertiesUpdated)
        {
            let response = response as! ChatThreadPropertiesUpdatedEvent
            print("\n------> ChatThreadPropertiesUpdatedEvent Received: ", response)
            print("\n------> threadId is: ", response.threadId)
            print("\n------> updatedOn is: ", response.updatedOn)
            
        }
        else if(eventId == ChatEventId.chatThreadDeleted)
        {
            let response = response as! ChatThreadDeletedEvent
            print("\n------> ChatThreadDeletedEvent Received: ", response)
            print("\n------> threadId is: ", response.threadId)
            print("\n------> deletedOn is: ", response.deletedOn)
            
        }
        else if(eventId == ChatEventId.participantsAdded)
        {
            let response = response as! ParticipantsAddedEvent
            print("\n------> ParticipantsAddedEvent Received: ", response)
            print("\n------> threadId is: ", response.threadId)
            print("\n------> addedOn is: ", response.addedOn)
            
        }
        else if(eventId == ChatEventId.participantsRemoved)
        {
            let response = response as! ParticipantsRemovedEvent
            print("\n------> ParticipantsRemovedEvent Received: ", response)
            print("\n------> threadId is: ", response.threadId)
            print("\n------> removedOn is: ", response.removedOn)
        }
    }
    
}
