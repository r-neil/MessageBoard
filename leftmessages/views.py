from django.shortcuts import render
from django.http import	HttpResponse


from . import models
from . import serializers

# display last 10 messages
	#site
def DisplayMessages(request):
	last_ten_messages = models.LeftMessage.objects.all()[:10]
	return render(request, 'leftmessages/show_messages.html', {'last_ten_messages' : last_ten_messages})

	#API
class DisplayMessagesAPI():
	pass



# create new message
	#site

	#api

#delete and edit to complete CRUD? 

