from rest_framework import serializers

from . import models

class LeftMessageSerializer(serializers.ModelSerializer):
	class Meta:
		fields = (
			'pk',
			'create_date',
			'content',
			'author',
			)
		model = models.LeftMessage

class CreateMessageSerializer(serializers.ModelSerializer):
	class Meta:
		fields = (
			'content',
			'author',
			)
		model = models.LeftMessage