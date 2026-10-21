# HSE Bridge Inspection
اپلیکیشن Flutter برای چک‌لیست بازرسی HSE در محدوده پایه پل و حفر چاه.

## اجرا
1. Flutter و Android Studio را نصب کنید.
2. در پوشه پروژه:
   flutter pub get
3. برای اجرای آزمایشی:
   flutter run
4. برای ساخت APK:
   flutter build apk --release

فایل APK بعد از build در مسیر:
build/app/outputs/flutter-apk/app-release.apk

ویژگی‌های نسخه اول:
- سه بخش قبل از کار، حین کار و پایان کار
- وضعیت ایمن / ناایمن / N/A
- شرح مورد ناایمن و اقدام اصلاحی
- مشخصات پروژه، محل و بازرس
- ذخیره آفلاین گزارش‌ها روی گوشی

## ساخت APK فقط با گوشی (از طریق GitHub Actions)
1. این ZIP را در گوشی از حالت فشرده خارج کنید.
2. در GitHub یک مخزن جدید بسازید و فایل‌های داخل پوشه پروژه را در آن بارگذاری کنید.
3. فایل `.github/workflows/build-apk.yml` را هم همراه پروژه بارگذاری کنید.
4. در مخزن GitHub به بخش **Actions** بروید و اجرای **Build Android APK** را انتخاب کنید؛ سپس **Run workflow** را بزنید.
5. پس از اتمام موفق اجرا، وارد همان اجرای workflow شوید و از بخش **Artifacts** فایل `hse-bridge-inspection-apk` را دانلود کنید.
6. ZIP مربوط به Artifact را باز کنید؛ فایل `app-release.apk` داخل آن است.

نکته: ساخت APK در فضای ابری انجام می‌شود و ممکن است لازم باشد یک حساب GitHub بسازید. این فایل APK هنوز ساخته نشده است؛ این ZIP پروژه را برای ساخت آنلاین آماده می‌کند.
