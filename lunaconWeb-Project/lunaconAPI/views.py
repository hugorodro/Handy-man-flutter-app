from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.views import APIView
from .models import Order, Product_Order, Product, JobSite, Vendor
from .serializers import OrderSerializer, ProductOrderSerializer, ProductSerializer, VendorSerializer, JobSiteSerializer, UserSerializer 

# from .forms import OrderForm, MultipleOrderForm
from django.forms import formset_factory
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.contrib import messages

from rest_framework.response import Response
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token


class CustomObtainAuthToken(ObtainAuthToken):
    def post(self, request, *args, **kwargs):
        response = super(CustomObtainAuthToken, self).post(request, *args, **kwargs)
        token = Token.objects.get(key=response.data['token'])
        return Response({'token': token.key, 'id': token.user_id})

class OrderView(viewsets.ModelViewSet):
    
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

class ProductOrderView(viewsets.ModelViewSet):
    queryset = Product_Order.objects.all()
    serializer_class = ProductOrderSerializer
 
class ProductView(viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
 
# class EquipmentView(viewsets.ModelViewSet):
#     queryset = Equipment.objects.all()
#     serializer_class = EquipmentSerializer

# class EquipmentStatusView(viewsets.ModelViewSet):
#     queryset = EquipmentStatus.objects.all()
#     serializer_class = EquipmentStatusSerializer

 
class JobSiteView(viewsets.ModelViewSet):
    queryset = JobSite.objects.all()
    serializer_class = JobSiteSerializer
 
class VendorView(viewsets.ModelViewSet):
    
    queryset = Vendor.objects.all()
    serializer_class = VendorSerializer

# class UserExistsView(viewsets.ModelViewSet):

#     queryset = User.objects.all()
#     serializer_class = UserSerializer
    
  




# def home(request):
#     return render(request, 'lunaconAPI/home.html')

# def placeorder(request):
#     product_info = ProductView.queryset
#     multiple_form = MultipleOrderForm
#     if request.method == 'POST':
#         print(9)
#         filled_form = OrderForm(request.POST)
#         if filled_form.is_valid():
#             print(8)
#             filled_form.save()
#             note = 'Your order will will placed by the end of the week!'
#             new_form = OrderForm()
#             return render(request, 'lunaconAPI/placeorder.html', {'product_info': product_info,'orderform':new_form, 'note':note, 'multiple_form':multiple_form})
#     else:
#         print(99)
#         form = OrderForm()
#         return render(request, 'lunaconAPI/placeorder.html', {'product_info': product_info,'orderform':form, 'multiple_form':multiple_form})

# def placeorders(request):
#     print(1)
#     product_info = ProductView.queryset
#     number_of_products = 2
#     filled_multiple_products_form = MultipleOrderForm(request.GET)
#     if filled_multiple_products_form.is_valid():
#         print(2)
#         number_of_products = filled_multiple_products_form.cleaned_data['number']
#     print(3) 
#     OrderFormSet = formset_factory(OrderForm, extra=number_of_products)
#     formset = OrderFormSet()
#     if request.method == 'POST':
#         print(4)
#         filled_formset = OrderFormSet(request.POST)
#         if filled_formset.is_valid():
#             print(5)
            
#             note = 'Products have been ordered'
#         else:
#             print(7)
#             note = 'Order was not created, try again'
#         return render(request, 'lunaconAPI/placeorders.html', {'product_info': product_info, 'note':note,'formset': formset})
#     else: 
#         print(6)
#         return render(request, 'lunaconAPI/placeorders.html', {'product_info': product_info, 'formset': formset})


# def login_request(request):
#     if request.method == 'POST':
#         form = AuthenticationForm(request=request, data=request.POST)
#         if form.is_valid():
#             username = form.cleaned_data.get('username')
#             password = form.cleaned_data.get('password')
#             user = authenticate(username=username, password=password)
#             if user is not None:
#                 login(request, user)
#                 messages.info(request, f"You are now logged in as {username}")
#                 return render(request, 'lunaconAPI/home.html')

#             else:
#                 messages.error(request, "Invalid username or password.")
#         else:
#             messages.error(request, "Invalid username or password.")
#     form = AuthenticationForm()
#     return render(request = request,
#                     template_name = "lunaconAPI/login.html",
#                     context={"form":form})


# def logout_request(request):
#     logout(request)
#     messages.info(request, "Logged out successfully!")
#     return render(request, 'lunaconAPI/login.html')




