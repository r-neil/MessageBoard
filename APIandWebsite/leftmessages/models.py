from __future__ import unicode_literals

from django.db import models

class LeftMessage(models.Model):
	create_date = models.DateTimeField(auto_now_add=True)
	content = models.CharField(max_length=200)
	author = models.CharField(max_length=50)