from django.contrib import admin

from . import models


class MessageAdmin(admin.ModelAdmin):
	list_display = ['create_date', 'content', 'author']
	ordering = ('create_date',)


admin.site.register(models.LeftMessage, MessageAdmin)