import random
import jwt
import requests
from typing import Optional, List
from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from sqlmodel import SQLModel, Field, create_engine, Session, select
from pydantic import BaseModel

# 1. إعداد تطبيق FastAPI
app = FastAPI(title="SolarMind API", version="1.0")

# تفعيل السماح بالاتصال من تطبيقات الـ Frontend (مثل فلاتر كروم)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 2. إعداد قاعدة البيانات SQLite
sqlite_file_name = "database.db"
sqlite_url = f"sqlite:///{sqlite_file_name}"
engine = create_engine(sqlite_url, connect_args={"check_same_thread": False})

class SolarData(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    status: str
    power_output_kw: float

def create_db_and_tables():
    SQLModel.metadata.create_all(engine)

def get_session():
    with Session(engine) as session:
        yield session

@app.on_event("startup")
def on_startup():
    create_db_and_tables()

# 3. التخزين المؤقت لتطبيق الفلاتر (Flutter) والأجهزة
database_storage = {}

class SolarDataModel(BaseModel):
    device_id: str
    battery_level: float
    consumption: float
    solar_generation: float
    status: str


# --- مسارات المشروع (Endpoints) ---

@app.get("/")
def read_root():
    return {"message": "Welcome to SolarMind Energy Management System & API!"}

# جلب جميع القراءات المخزنة من قاعدة البيانات
@app.get("/solar-status", response_model=List[SolarData])
def read_solar_statuses(session: Session = Depends(get_session)):
    statuses = session.exec(select(SolarData)).all()
    return statuses

# إضافة قراءة جديدة لقاعدة البيانات
@app.post("/solar-status", response_model=SolarData)
def create_solar_status(data: SolarData, session: Session = Depends(get_session)):
    session.add(data)
    session.commit()
    session.refresh(data)
    return data

# محاكاة جلب البيانات من إنفرترات Growatt وتخزينها تلقائياً
@app.post("/growatt/sync", response_model=SolarData)
def sync_growatt_inverter(session: Session = Depends(get_session)):
    simulated_status = "Normal - Producing Energy"
    simulated_power = round(random.uniform(3.5, 12.8), 2)  # بالكيلوواط
    
    db_item = SolarData(status=simulated_status, power_output_kw=simulated_power)
    session.add(db_item)
    session.commit()
    session.refresh(db_item)
    return db_item

# مسار تسجيل الدخول للحصول على التوكن (JWT Token)
@app.post("/token")
def login_for_access_token(username: str, password: str):
    SECRET_KEY = "solarmind_secret_key_graduation_project"
    ALGORITHM = "HS256"
    if username == "admin" and password == "solar123":
        token = jwt.encode({"sub": username}, SECRET_KEY, algorithm=ALGORITHM)
        return {"access_token": token, "token_type": "bearer"}
    raise HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="اسم المستخدم أو كلمة المرور غير صحيحة",
    )

# مسار لجلب حالة الطقس الحالية في جنين وربطها بنظام الطاقة
@app.get("/weather")
def get_weather_status():
    url = "https://api.open-meteo.com/v1/forecast?latitude=32.46&longitude=35.29&current_weather=true"
    try:
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
    except Exception:
        pass
    raise HTTPException(status_code=500, detail="فشل في جلب بيانات الطقس")

# مسارات خاصة بتطبيق الفلاتر (Flutter) وتحديث البيانات
@app.post("/api/update-solar")
def update_solar_data(data: SolarDataModel):
    database_storage[data.device_id] = {
        "battery_level": data.battery_level,
        "consumption": data.consumption,
        "solar_generation": data.solar_generation,
        "status": data.status
    }
    return {"message": "تم تحديث البيانات بنجاح", "data": database_storage[data.device_id]}

@app.get("/api/get-solar/{device_id}")
def get_solar_data(device_id: str):
    if device_id not in database_storage:
        return {
            "battery_level": 78.0,
            "consumption": 3.2,
            "solar_generation": 4.5,
            "status": "ممتازة"
        }
    return database_storage[device_id]


# --- الـ AI Chatbot المطور بأسئلة وإجابات مباشرة ---

class ChatRequest(BaseModel):
    question: str

@app.post("/ai-chat")
def ai_chat_endpoint(request: ChatRequest):
    q = request.question.lower()
    
    if 'استهلاك' in q or 'حجم' in q:
        response_text = 'حجم استهلاكك اليومي هو 3.2 كيلوواط/ساعة. أعلى فترة استهلاك كانت بين الساعة 12 ظهراً و 3 عصراً، وهو ضمن المعدل الممتاز والآمن.'
    elif 'بطارية' in q or 'تنفد' in q or 'شحن' in q:
        response_text = 'نسبة البطارية الحالية هي 78% (تخزن حوالي 8.5 كيلوواط). بالاستهلاك الحالي ستكفيك حتى الساعة 10:00 مساءً تقريباً قبل الحاجة للشحن.'
    elif 'توفير' in q or 'نصيحة' in q:
        response_text = 'لتوفير الطاقة الآن: يُفضل تشغيل الأحمال الثقيلة (كالغسالة والمكيف) بين الساعة 11 صباحاً و 3 عصراً للاستفادة المباشرة من أشعة الشمس، وتقليل الأحمال ليلاً.'
    elif 'طقس' in q or 'الجو' in q or 'حرارة' in q or 'غدا' in q or 'بكرة' in q:
        response_text = 'الطقس في جنين مشمس وغائم جزئياً، ودرجة الحرارة المتوقعة غداً حوالي 25° مئوية، وهو طقس ممتاز لإنتاج طاقة شمسية بكفاءة عالية.'
    elif 'جهاز' in q or 'أكثر' in q:
        response_text = 'الجهاز الأكثر استهلاكاً للطاقة حالياً في منزلك هو المكيف (يستهلك حوالي 1.8 كيلوواط/ساعة)، يليه سخان الماء.'
    elif 'إيقاف' in q or 'عن بعد' in q or 'اطفاء' in q:
        response_text = 'يمكنني المساعدة في إيقاف تشغيل الأحمال غير الضرورية لك الآن تلقائياً للحفاظ على طاقة البطارية للحالات الطارئة.'
    else:
        response_text = f'بخصوص سؤالك "{request.question}": نظام الطاقة الشمسية لديك يعمل بكفاءة عالية، البطارية حالياً عند 78% والاستهلاك اليومي المستقر هو 3.2 كيلوواط.'
        
    return {"reply": response_text}