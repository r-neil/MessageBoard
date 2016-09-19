from rest_framework import serializers

from . import models

class LeftMessageSerializer(serializers.ModelSerializer):

	class Meta:
		fields = (
			'create_date',
			'content',
			'author',
			)
		model = models.LeftMessage
