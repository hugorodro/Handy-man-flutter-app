# Generated by Django 3.0.5 on 2020-06-21 22:30

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('lunaconAPI', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='jobsite',
            name='code',
            field=models.CharField(max_length=20),
        ),
    ]
