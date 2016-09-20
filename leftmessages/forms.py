from django import forms
from django.forms import ModelForm

from . import models

class MessageCreateForm(ModelForm):
	class Meta:
		fields = (
			'content',
			'author',
			)
		model = models.LeftMessage

