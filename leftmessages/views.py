from django.shortcuts import render
from django.http import HttpResponseRedirect, HttpResponse

from . import models
from . import serializers
from . import forms

def DisplayMessages(request):
	last_ten_messages = models.LeftMessage.objects.all().order_by('-create_date')[:10]
	return render(request, 'leftmessages/show_messages.html', {'last_ten_messages' : last_ten_messages})

	#API
class DisplayMessagesAPI():
	pass

def leave_message(request):
	if request.method == 'POST':
		form = forms.MessageCreateForm(request.POST)
		if form.is_valid():
			form.save()
			return HttpResponseRedirect("/")
	else:
		form = forms.MessageCreateForm()
		return render(request, 'leftmessages/create_form.html', {'form': form})

def delete_message(request, id):
	print("id: {}".format(id))
	message = models.LeftMessage.objects.get(pk=id)
	message.delete()	
	return HttpResponseRedirect("/")
