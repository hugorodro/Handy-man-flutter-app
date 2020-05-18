from django import forms
from lunaconAPI.models import Order
from django.conf import settings

class OrderForm(forms.ModelForm):

    class Meta:
        model = Order
        fields = ['quantity','orderer', 'product']

class MultipleOrderForm(forms.Form):
    number = forms.IntegerField(min_value=2, max_value = 5)

    