from fastapi import FastAPI, Depends
app = FastAPI()
@app.get("/")
def read_root():
    return{"message":"Welcome to SolarMind Energy Management System!"}
@app.get("/solar-status")
def get_solar_status():
    return {"status": "Active", "power_output_kw":5.2}

    from fastapi import FastAPI, Depends
from sqlmodel import SQLModel, Field, create_engine, Session, select
from typing import Optional, List

# 1. تعريف شكل البيانات (الجدول)
class SolarData(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    status: str
    power_output_kw: float

# 2. إنشاء قاعدة البيانات SQLite
sqlite_file_name = "database.db"
sqlite_url = f"sqlite:///{sqlite_file_name}"
engine = create_engine(sqlite_url, connect_args={"check_same_thread": False})

def create_db_and_tables():
    SQLModel.metadata.create_all(engine)

def get_session():
    with Session(engine) as session:
        yield session

app = FastAPI(title="SolarMind API")

@app.on_event("startup")
def on_startup():
    create_db_and_tables()

# 3. المسارات (Endpoints)
@app.get("/")
def read_root():
    return {"message": "Welcome to SolarMind API with Database!"}

# إضافة قراءة جديدة لقاعدة البيانات
@app.post("/solar-status", response_model=SolarData)
def create_solar_status(data: SolarData, session: Session = Depends(get_session)):
    session.add(data)
    session.commit()
    session.refresh(data)
    return data

# جلب جميع القراءات المخزنة
@app.get("/solar-status", response_model=List[SolarData])
def read_solar_statuses(session: Session = Depends(get_session)):
    statuses = session.exec(select(SolarData)).all()
    return statuses

import random

# محاكاة جلب البيانات من انفرترات Growatt وتخزينها تلقائياً في قاعدة البيانات
@app.post("/growatt/sync", response_model=SolarData)
def sync_growatt_inverter(session: Session = Depends(get_session)):
    # توليد بيانات وهمية واقعية لقراءة الإنفرتر (مثلاً حالة النظام مع نسبة توليد طاقة عشوائية)
    simulated_status = "Normal - Producing Energy"
    simulated_power = round(random.uniform(3.5, 12.8), 2)  # بالكيلوواط
    
    # إنشاء الكائن وتخزينه
    db_item = SolarData(status=simulated_status, power_output_kw=simulated_power)
    session.add(db_item)
    session.commit()
    session.refresh(db_item)
    return db_item

    # جلب جميع القراءات المخزنة من قاعدة البيانات
@app.get("/solar-status", response_model=List[SolarData])
def read_solar_statuses(session: Session = Depends(get_session)):
    statuses = session.exec(select(SolarData)).all()
    return statuses

    from fastapi import FastAPI, Depends, HTTPException, status
from sqlmodel import SQLModel, Field, create_engine, Session, select
import random
import jwt
from typing import List

# (تأكدي أن كود قاعدة البيانات والجداول الـ SolarData موجودة بالأعلى كالسابق)

SECRET_KEY = "solarmind_secret_key_graduation_project"
ALGORITHM = "HS256"

# مسار تسجيل الدخول للحصول على التوكن
@app.post("/token")
def login_for_access_token(username: str, password: str):
    if username == "admin" and password == "solar123":
        token = jwt.encode({"sub": username}, SECRET_KEY, algorithm=ALGORITHM)
        return {"access_token": token, "token_type": "bearer"}
    raise HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="اسم المستخدم أو كلمة المرور غير صحيحة",
    )

    import requests

# مسار لجلب حالة الطقس الحالية في جنين وربطها بنظام الطاقة
@app.get("/weather")
def get_weather_status():
    # استخدام خدمة مجانية لجلب الطقس (مثلاً إحداثيات جنين: خط عرض 32.46، خط طول 35.29)
    url = "https://api.open-meteo.com/v1/forecast?latitude=32.46&longitude=35.29&current_weather=true"
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        current = data.get("current_weather", {})
        return {
            "location": "Jenin, Palestine",
            "temperature_celsius": current.get("temperature"),
            "windspeed": current.get("windspeed"),
            "condition_code": current.get("weathercode")
        }
    raise HTTPException(status_code=500, detail="فشل في جلب بيانات الطقس")