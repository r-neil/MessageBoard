from django.conf.urls import url

from . import views

urlpatterns = [
	url(r'^$', views.DisplayMessages, name='display_message'),
	url(r'^leave_message/$', views.leave_message, name='leave_message'),
	url(r'^delete/(?P<id>\d+)', views.delete_message, name='delete_message'),
	url(r'^api/show_messages' , views.DisplayCreateMessagesAPI.as_view(), name='api_show_messages'),
]