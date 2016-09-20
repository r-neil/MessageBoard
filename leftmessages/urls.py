from django.conf.urls import url

from . import views

urlpatterns = [
	url(r'^$', views.DisplayMessages),
	url(r'^leave_message/$', views.LeaveMessage)
]