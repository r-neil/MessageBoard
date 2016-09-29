from django.shortcuts import render
from django.http import HttpResponseRedirect, HttpResponse
from rest_framework import status
from rest_framework.exceptions import APIException
from rest_framework.views import APIView
from rest_framework.response import Response

from . import models
from . import serializers
from . import forms

# HTML Methods
def DisplayMessages(request):
	last_ten_messages = models.LeftMessage.objects.all().order_by('-create_date')[:10]
	return render(request, 'leftmessages/show_messages.html', {'last_ten_messages' : last_ten_messages})

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
	message = models.LeftMessage.objects.get(pk=id)
	message.delete()	
	return HttpResponseRedirect("/")

# REST API Classes

class DisplayCreateMessagesAPI(APIView):
	def empty_view(self):
		'''
		Returns standard "No Messages" 
		'''
		raise APIException("No Messages")

	def get(self, request, format=None):
		last_ten_messages = models.LeftMessage.objects.all().order_by('-create_date')[:10]
		if len(last_ten_messages) == 0:
			return empty_view()

		serializer = serializers.LeftMessageSerializer(last_ten_messages, many=True)
		return Response(serializer.data)

	def post(self, request, format=None):
		print("***POST IS CALLED***")
		print("{}".format(request.data))
		serializer = serializers.CreateMessageSerializer(date=request.data)
		print("post!")
		serializer.is_valid(raise_exception=True)
		serializer.save()
		return Response(serializer.data, status=status.HTTP_201_CREATED)



# class DeleteMessage(APIView):

# 	message = models.LeftMessage.objects.get(pk=1)
# 	print("delete: {}".format(message))
# 	raise APIException("message has been deleted")




