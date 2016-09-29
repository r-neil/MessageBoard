from django import forms

from . import models

class MessageCreateForm(forms.ModelForm):
	class Meta:
		fields = (
			'content',
			'author',
			)
		model = models.LeftMessage

