import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const HseApp());

class HseApp extends StatelessWidget {
  const HseApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HSE پایه پل',
      theme: ThemeData(useMaterial3: true, fontFamily: 'sans'),
      home: const HomePage(),
    );
  }
}

const sections = <String, List<String>>{
  'قبل از شروع کار': [
    'محدوده حفاری مشخص، محصور و دارای علائم هشداردهنده است.',
    'دهانه چاه‌ها و بازشوها دارای حفاظ مقاوم و مناسب هستند.',
    'دیواره‌های حفاری از نظر ریزش، ترک، لق‌شدگی و ناپایداری بررسی شده‌اند.',
    'خاک، سنگ و مصالح سست از لبه حفاری دور شده‌اند.',
    'فاصله ایمن ماشین‌آلات و بارهای سنگین از لبه حفاری رعایت شده است.',
    'مسیر ورود و خروج ایمن به تراز پایین حفاری فراهم است.',
    'نردبان یا راه‌پله دسترسی سالم و پایدار است.',
    'وینچ‌ها و سازه‌های نگهدارنده از نظر پایداری و مهاربندی بررسی شده‌اند.',
    'سیم‌بکسل، قلاب و ضامن قلاب سالم هستند.',
    'کابل‌ها و تجهیزات برق سالم و فاقد اتصالات ناایمن هستند.',
    'مسیر ماشین‌آلات و نفرات مشخص و تا حد امکان جدا شده است.',
    'ماشین‌آلات بازدید روزانه شده و وضعیت فنی قابل قبول دارند.',
    'رانندگان و اپراتورها صلاحیت لازم دارند.',
    'PPE متناسب با فعالیت در اختیار افراد است.',
    'مجوزهای کاری، ارزیابی ریسک و توجیه ایمنی فعالیت‌ها کنترل شده‌اند.',
  ],
  'حین کار': [
    'ورود افراد متفرقه به محدوده عملیاتی کنترل می‌شود.',
    'افراد در محدوده حرکت بیل مکانیکی، لودر و کمپرسی قرار نمی‌گیرند.',
    'برای دنده‌عقب ماشین‌آلات از راهنمای مناسب استفاده می‌شود.',
    'مسیر تردد ماشین‌آلات از مسیر نفرات جدا نگه داشته می‌شود.',
    'ماشین‌آلات در فاصله ایمن از لبه حفاری کار می‌کنند.',
    'هیچ فردی زیر بار معلق یا در مسیر احتمالی سقوط بار قرار ندارد.',
    'وینچ بیش از ظرفیت مجاز خود استفاده نمی‌شود.',
    'عملیات بالابری توسط فرد مجاز و با ارتباط مناسب انجام می‌شود.',
    'سیم‌بکسل و تجهیزات بالابری وضعیت خطرناک پیدا نکرده‌اند.',
    'کابل‌ها و شیلنگ‌ها در مسیر تردد رها نشده‌اند.',
    'علائم ناپایداری یا ریزش در دیواره حفاری مشاهده نمی‌شود.',
    'آب یا گل باعث خطر لغزش، سقوط یا ناپایداری حفاری نشده است.',
    'آرماتور و تجهیزات روی کف باعث گیرکردن یا سقوط افراد نشده‌اند.',
    'نظم و نظافت محل کار حفظ می‌شود.',
    'کلاه، کفش ایمنی، جلیقه و سایر PPEهای لازم استفاده می‌شوند.',
    'علائم هشداردهنده قابل مشاهده و در محل مناسب هستند.',
    'روشنایی محل برای کار و تردد کافی است.',
    'گردوغبار، سروصدا و سایر عوامل زیان‌آور کنترل می‌شوند.',
    'در صورت خطر فوری، فعالیت متوقف و محل ایمن‌سازی می‌شود.',
    'موارد ناایمن همان زمان اعلام و پیگیری می‌شوند.',
  ],
  'پایان کار': [
    'افراد و تجهیزات غیرضروری از محدوده خطر خارج شده‌اند.',
    'دهانه چاه‌ها و بازشوهای باقی‌مانده مجدداً ایمن و محصور شده‌اند.',
    'وینچ‌ها و تجهیزات بالابری در وضعیت ایمن قرار گرفته‌اند.',
    'کابل‌ها، شیلنگ‌ها و ابزار از مسیر تردد جمع‌آوری شده‌اند.',
    'سنگ، ضایعات، میلگرد و موانع خطرناک از مسیر تردد پاکسازی شده‌اند.',
    'ماشین‌آلات در محل مناسب و ایمن متوقف شده‌اند.',
    'موارد اصلاحی بازمانده برای شیفت بعد مشخص و منتقل شده‌اند.',
    'موارد مهم ناایمن با عکس و شرح اقدام اصلاحی مستندسازی شده‌اند.',
    'اقدامات اصلاحی انجام‌شده کنترل و تأیید شده‌اند.',
    'گزارش روزانه HSE تکمیل و ارائه شده است.',
  ],
};

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> reports = [];

  @override
  void initState() {
    super.initState();
    loadReports();
  }

  Future<void> loadReports() async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getStringList('reports') ?? [];
    setState(() {
      reports = raw.map((e) => Map<String, dynamic>.from(jsonDecode(e))).toList();
    });
  }

  Future<void> deleteReport(int i) async {
    final p = await SharedPreferences.getInstance();
    reports.removeAt(i);
    await p.setStringList('reports', reports.map(jsonEncode).toList());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('HSE پایه پل')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (_) => const InspectionPage()));
            loadReports();
          },
          icon: const Icon(Icons.add),
          label: const Text('بازرسی جدید'),
        ),
        body: reports.isEmpty
            ? const Center(child: Text('هنوز گزارشی ثبت نشده است.'))
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: reports.length,
                itemBuilder: (_, i) {
                  final r = reports[i];
                  return Card(
                    child: ListTile(
                      title: Text('${r['location'] ?? 'محل نامشخص'} — ${r['inspector'] ?? ''}'),
                      subtitle: Text('ایمن: ${r['safe']}   ناایمن: ${r['unsafe']}   N/A: ${r['na']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => deleteReport(i),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class InspectionPage extends StatefulWidget {
  const InspectionPage({super.key});
  @override
  State<InspectionPage> createState() => _InspectionPageState();
}

class _InspectionPageState extends State<InspectionPage> {
  final project = TextEditingController();
  final location = TextEditingController();
  final inspector = TextEditingController();
  final Map<String, String> status = {};
  final Map<String, TextEditingController> notes = {};

  @override
  void dispose() {
    project.dispose();
    location.dispose();
    inspector.dispose();
    for (final c in notes.values) c.dispose();
    super.dispose();
  }

  Future<void> save() async {
    final p = await SharedPreferences.getInstance();
    int safe = 0, unsafe = 0, na = 0;
    final answers = <Map<String, dynamic>>[];

    for (final entry in sections.entries) {
      for (final item in entry.value) {
        final s = status[item] ?? 'N/A';
        if (s == 'ایمن') safe++;
        else if (s == 'ناایمن') unsafe++;
        else na++;
        answers.add({
          'section': entry.key,
          'item': item,
          'status': s,
          'note': notes[item]?.text ?? '',
        });
      }
    }

    final report = {
      'project': project.text,
      'location': location.text,
      'inspector': inspector.text,
      'date': DateTime.now().toIso8601String(),
      'safe': safe,
      'unsafe': unsafe,
      'na': na,
      'answers': answers,
    };

    final raw = p.getStringList('reports') ?? [];
    raw.add(jsonEncode(report));
    await p.setStringList('reports', raw);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('گزارش با موفقیت ذخیره شد.')));
      Navigator.pop(context);
    }
  }

  Widget itemCard(String item) {
    final s = status[item] ?? 'N/A';
    final controller = notes.putIfAbsent(item, () => TextEditingController());

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: ['ایمن', 'ناایمن', 'N/A'].map((x) {
                return ChoiceChip(
                  label: Text(x),
                  selected: s == x,
                  onSelected: (_) => setState(() => status[item] = x),
                );
              }).toList(),
            ),
            if (s == 'ناایمن') ...[
              const SizedBox(height: 8),
              TextField(
                controller: controller,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'شرح مورد ناایمن / اقدام اصلاحی',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('بازرسی جدید')),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: FilledButton.icon(
              onPressed: save,
              icon: const Icon(Icons.save),
              label: const Padding(
                padding: EdgeInsets.all(12),
                child: Text('ذخیره گزارش'),
              ),
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            TextField(controller: project, decoration: const InputDecoration(labelText: 'نام پروژه', border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(controller: location, decoration: const InputDecoration(labelText: 'محل / پایه پل', border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(controller: inspector, decoration: const InputDecoration(labelText: 'نام بازرس HSE', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            for (final entry in sections.entries) ...[
              Text(entry.key, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              for (final item in entry.value) itemCard(item),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
