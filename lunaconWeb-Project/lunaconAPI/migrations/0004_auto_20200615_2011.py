# Generated by Django 3.0.5 on 2020-06-15 20:11

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('lunaconAPI', '0003_auto_20200610_1806'),
    ]

    operations = [
        migrations.AddField(
            model_name='product_order',
            name='time',
            field=models.DateTimeField(auto_now_add=True, default=django.utils.timezone.now),
            preserve_default=False,
        ),
        migrations.AlterUniqueTogether(
            name='product_order',
            unique_together=set(),
        ),
    ]
