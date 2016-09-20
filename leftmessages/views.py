from django.shortcuts import render
from django.http import HttpResponseRedirect, HttpResponse
from django.urls import reverse

from . import models
from . import serializers
from . import forms

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
def leave_message(request):
	if request.method == 'POST':
		form = forms.MessageCreateForm(request.POST)
		if form.is_valid():
			print('form saved')
			form.save()
			return render(request, 'leftmessages/create_form.html', {'form': form})
	else:
		form = forms.MessageCreateForm()
		return render(request, 'leftmessages/create_form.html', {'form': form})
		
	#api

#delete and edit to complete CRUD? 

