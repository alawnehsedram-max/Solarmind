import random
import time
import requests

API_URL = "http://127.0.0.1:8000/api/update-solar"
DEVICE_ID = "DEV_JENIN_01"

print("🚀 بدء محاكاة إرسال القراءات من القطعة إلى السيرفر...")

while True:
    try:
        data = {
            "device_id": DEVICE_ID,
            "battery_level": round(random.uniform(50.0, 98.0), 1),
            "consumption": round(random.uniform(1.2, 5.5), 2),
            "solar_generation": round(random.uniform(2.0, 8.5), 2),
            "status": "Normal / Charging"
        }

        response = requests.post(API_URL, json=data)
        if response.status_code == 200:
            print(f"✅ تم الإرسال بنجاح: بطارية {data['battery_level']}% | توليد {data['solar_generation']} kW")
        else:
            print(f"⚠️ خطأ في الإرسال: {response.status_code}")

    except Exception as e:
        print(f"❌ تعذر الاتصال بالسيرفر: {e}")

    time.sleep(5)