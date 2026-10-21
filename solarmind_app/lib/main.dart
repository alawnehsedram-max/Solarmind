import 'package:flutter/material.dart';

void main() {
  runApp(const SolarMindApp());
}

class SolarMindApp extends StatelessWidget {
  const SolarMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SolarMind',
      theme: ThemeData(
        fontFamily: 'Tajawal',
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: WelcomeScreen(),
      ),
    );
  }
}

// ==========================================
// ودجت الشعار المشترك (SolarMind Logo)
// ==========================================
class SolarMindLogo extends StatelessWidget {
  final double size;

  const SolarMindLogo({super.key, this.size = 140});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF1B000).withOpacity(0.2),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.wb_sunny,
              color: Color(0xFFF1B000),
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 1. شاشة الترحيب (Welcome Screen)
// ==========================================
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const Color primaryGold = Color(0xFFF1B000);
  static const Color darkGreen = Color(0xFF1B4D2E);
  static const Color textColor = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              const Center(child: SolarMindLogo(size: 160)),
              const SizedBox(height: 40),
              const Text(
                'أهلاً بك في سولار ماينـد',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: darkGreen),
              ),
              const SizedBox(height: 12),
              const Text(
                'سولار ماينـد تطبيقك الذكي الذي سيساعدك\nلتعرف ماذا يحصل بطاقة منزلك',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, height: 1.5, color: textColor),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(isActive: true),
                  const SizedBox(width: 8),
                  _buildDot(isActive: true),
                  const SizedBox(width: 8),
                  _buildDot(isActive: false),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Directionality(
                          textDirection: TextDirection.rtl,
                          child: LoginScreen(),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGold,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ابدأ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkGreen)),
                      SizedBox(width: 8),
                      Icon(Icons.wb_sunny_rounded, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildDot({required bool isActive}) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? primaryGold : primaryGold.withOpacity(0.3),
      ),
    );
  }
}

// ==========================================
// 2. شاشة تسجيل الدخول (Login Screen)
// ==========================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const Color primaryGold = Color(0xFFF1B000);
  static const Color darkGreen = Color(0xFF1B4D2E);
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SolarMindLogo(size: 45),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryGold.withOpacity(0.5)),
                        ),
                        child: const Icon(Icons.arrow_back, color: darkGreen, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text('أهلاً بك', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: darkGreen)),
                const SizedBox(height: 6),
                Text('أدخل حسابك الآن', style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                const SizedBox(height: 35),
                const Text('الإيميل', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: darkGreen)),
                const SizedBox(height: 8),
                TextField(
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'ahmad@example.com',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: primaryGold),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: primaryGold, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Text('كلمة السر', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: darkGreen)),
                const SizedBox(height: 8),
                TextField(
                  obscureText: _isPasswordObscured,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordObscured ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () => setState(() => _isPasswordObscured = !_isPasswordObscured),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: primaryGold),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: primaryGold, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('هل نسيت كلمة السر؟', style: TextStyle(color: darkGreen, fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VerificationScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGold,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child: const Text('تسجيل الدخول', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkGreen)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ليس لديك حساب؟ ', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text('سجل الآن', style: TextStyle(color: darkGreen, fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 3. شاشة إنشاء حساب جديد (Sign Up Screen)
// ==========================================
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const Color primaryGold = Color(0xFFF1B000);
  static const Color darkGreen = Color(0xFF1B4D2E);
  bool _agreedToTerms = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SolarMindLogo(size: 45),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryGold.withOpacity(0.5)),
                        ),
                        child: const Icon(Icons.arrow_back, color: darkGreen, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('إنشاء حساب جديد', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: darkGreen)),
                const SizedBox(height: 6),
                Text('ابدأ رحلتك مع توفير الطاقة', style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                const SizedBox(height: 25),
                const Text('الاسم', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: darkGreen)),
                const SizedBox(height: 6),
                TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'أحمد',
                    prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: primaryGold)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: primaryGold, width: 2)),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('الإيميل', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: darkGreen)),
                const SizedBox(height: 6),
                TextField(
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'ahmad@example.com',
                    prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: primaryGold)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: primaryGold, width: 2)),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('الرقم', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: darkGreen)),
                const SizedBox(height: 6),
                TextField(
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: '5********',
                    prefixIcon: const Icon(Icons.phone_outlined, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: primaryGold)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: primaryGold, width: 2)),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('كلمة السر', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: darkGreen)),
                const SizedBox(height: 6),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'على الأقل 8 أحرف',
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: primaryGold)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: primaryGold, width: 2)),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: _agreedToTerms,
                      activeColor: darkGreen,
                      onChanged: (val) => setState(() => _agreedToTerms = val ?? true),
                    ),
                    const Text('أوافق على الشروط ، وأريد توفير الكهرباء', style: TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VerificationScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGold,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child: const Text('أنشئ حسابك', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkGreen)),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 4. شاشة رمز التحقق (Verification Screen)
// ==========================================
class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  static const Color primaryGold = Color(0xFFF1B000);
  static const Color darkGreen = Color(0xFF1B4D2E);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SolarMindLogo(size: 45),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryGold.withOpacity(0.5)),
                        ),
                        child: const Icon(Icons.arrow_back, color: darkGreen, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                const Text('رمز التحقق', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: darkGreen)),
                const SizedBox(height: 10),
                const Text(
                  'أرسلنا رمز التحقق على رقم هاتفك الذي ينتهي بـ 56\nأدخله الآن',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) => Container(
                    width: 55,
                    height: 55,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryGold, width: 1.5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )),
                ),
                const SizedBox(height: 30),
                const Text('ألم يصلك الرمز؟', style: TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 8),
                const Text(
                  'اطلب رمز آخر (28 ث )',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkGreen),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGold,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child: const Text('تأكيد', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkGreen)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 5. الواجهة الرئيسية (Home Screen)
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color darkGreen = Color(0xFF1B4D2E);
  static const Color primaryGold = Color(0xFFF1B000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // الهيدر العلوي الأخضر
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: darkGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // أيقونة الجرس المخصصة
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7E6),
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryGold, width: 1.5),
                        ),
                        child: ClipOval(
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset(
                              'assets/bell_icon.png',
                              fit: BoxFit.contain,
                              errorBuilder: (c, e, s) => const Icon(Icons.notifications, color: primaryGold, size: 22),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text('مرحباً، أحمد', style: TextStyle(color: Colors.white70, fontSize: 13)),
                              SizedBox(height: 2),
                              Text('ما معدل استهلاكك اليوم؟', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(width: 12),
                          const SolarMindLogo(size: 45),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildTopCard('الشحـن', '78%'),
                      const SizedBox(width: 10),
                      _buildTopCard('اليوم', '3.2 kW'),
                      const SizedBox(width: 10),
                      _buildTopCard('توفيـر', '12 ₪'),
                    ],
                  ),
                ],
              ),
            ),

            // محتوى الصفحة
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // بطاقة حالة البطارية
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F9F4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFD4E7D4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(color: darkGreen, borderRadius: BorderRadius.circular(20)),
                              child: const Text('ممتازة', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                            Row(
                              children: [
                                const Text('حالة البطارية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkGreen)),
                                const SizedBox(width: 8),
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: primaryGold.withOpacity(0.5)),
                                  ),
                                  child: ClipOval(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset(
                                        'assets/battery_icon.png',
                                        fit: BoxFit.contain,
                                        errorBuilder: (c, e, s) => const Icon(Icons.battery_charging_full, color: darkGreen, size: 22),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // شريط تقدم ملون من اليمين إلى اليسار (RTL)
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: 0.78,
                              minHeight: 10,
                              backgroundColor: Colors.grey.shade300,
                              valueColor: const AlwaysStoppedAnimation<Color>(primaryGold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // النص محاذى جهة اليمين تماماً
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'ستنفد عند الساعة 10 مساءً، يرجى الشحن الآن...',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // بطاقة الاستهلاك اليومي
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F9F4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFD4E7D4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('3.2 kW • أمس 2.9', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            const Text('الاستهلاك اليومي', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkGreen)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildBar(40, darkGreen),
                            _buildBar(60, darkGreen),
                            _buildBar(30, darkGreen),
                            _buildBar(55, darkGreen),
                            _buildBar(20, darkGreen),
                            _buildBar(90, primaryGold),
                            _buildBar(50, darkGreen),
                            _buildBar(65, darkGreen),
                            _buildBar(45, darkGreen),
                            _buildBar(25, darkGreen),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // بطاقة الطقس
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F9F4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFD4E7D4)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.arrow_back, color: darkGreen, size: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text('غداً غائم، يُفضل الشحن اليوم', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: darkGreen)),
                            SizedBox(height: 4),
                            Text('• 27° • طاقة شمسية قوية الآن', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        Container(
                          width: 44,
                          height: 44,
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Image.asset(
                            'assets/weather_icon.png',
                            fit: BoxFit.contain,
                            errorBuilder: (c, e, s) => const Icon(Icons.wb_sunny, color: primaryGold, size: 28),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // الشريط السفلي وزر المساعد الذكي
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _BottomCustomNavItem(
                        assetPath: 'assets/menu_icon.png',
                        fallbackIcon: Icons.menu,
                        label: 'القائمة',
                      ),
                      _BottomCustomNavItem(
                        assetPath: 'assets/battery_icon.png',
                        fallbackIcon: Icons.battery_charging_full,
                        label: 'البطارية',
                      ),
                      _BottomCustomNavItem(
                        assetPath: 'assets/analytics_icon.png',
                        fallbackIcon: Icons.bar_chart,
                        label: 'التحليل',
                      ),
                      _BottomCustomNavItem(
                        assetPath: 'assets/home_icon.png',
                        fallbackIcon: Icons.home,
                        label: 'الرئيسية',
                        isSelected: true,
                      ),
                    ],
                  ),
                ),
                // زر المساعد العائم
                Positioned(
                  top: -26,
                  child: GestureDetector(
                    onTap: () => _showAiAssistantSheet(context),
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: darkGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryGold, width: 2.5),
                        boxShadow: [
                          BoxShadow(
                            color: primaryGold.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: ClipOval(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/ai_brain_icon.png',
                            fit: BoxFit.contain,
                            errorBuilder: (c, e, s) => const Icon(Icons.psychology_outlined, color: primaryGold, size: 34),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildTopCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  static Widget _buildBar(double height, Color color) {
    return Container(
      width: 14,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  void _showAiAssistantSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: darkGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                        child: const Icon(Icons.close, color: Colors.white, size: 18),
                      ),
                    ),
                    Row(
                      children: const [
                        Text('مساعد سولار مايند الذكي', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(width: 10),
                        Icon(Icons.psychology, color: primaryGold, size: 24),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F9F4),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFD4E7D4)),
                      ),
                      child: const Text(
                        'أهلاً بك في سولار مايند! أنا مساعدك الذكي، يمكنني مساعدتك في فهم استهلاكك وتوفير الطاقة. ماذا تحب أن تعرف؟',
                        style: TextStyle(fontSize: 14, height: 1.5, color: darkGreen),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('أسئلة سريعة:', style: TextStyle(fontSize: 13, color: Colors.grey)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: const [
                        _ChipButton('ما حجم استهلاك اليوم؟'),
                        _ChipButton('متى ستنفد البطارية؟'),
                        _ChipButton('كيف يمكنني توفير الطاقة؟'),
                        _ChipButton('ما هي حالة الطقس غداً؟'),
                        _ChipButton('ما هو الجهاز الأكثر استهلاكاً؟'),
                        _ChipButton('كيف يمكنني إيقاف تشغيل الأجهزة عن بُعد؟'),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey.shade200)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(color: darkGreen, shape: BoxShape.circle),
                      child: const Icon(Icons.send, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'اسأل مساعد سولار مايند...',
                          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: primaryGold)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: primaryGold, width: 2)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// عنصر مخصص لأيقونات الشريط السفلي
class _BottomCustomNavItem extends StatelessWidget {
  final String assetPath;
  final IconData fallbackIcon;
  final String label;
  final bool isSelected;

  const _BottomCustomNavItem({
    required this.assetPath,
    required this.fallbackIcon,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? const Color(0xFF1B4D2E) : Colors.grey;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 22,
          height: 22,
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(fallbackIcon, color: color, size: 22),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _ChipButton extends StatelessWidget {
  final String text;
  const _ChipButton(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1B000)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF1B4D2E), fontWeight: FontWeight.w500)),
    );
  }
}