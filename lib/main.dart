import 'package:flutter/material.dart';

/// ============================================================
/// DATA MAHASISWA — GANTI BAGIAN INI DENGAN DATA ANDA
/// ============================================================
class DataMahasiswa {
  static const String nama = 'AHMAD BADRUL FURQON';
  static const String nim = '2495114004';
  static const String kelas = 'A';
  static const String programStudi = 'TEKNIK INFORMATIKA';
  static const String universitas = 'UNIVERSITAS HASYIM ASYARI';
  static const String hobi = 'NGODING (sebulan sekali)';
  static const String email = 'ahmadbadrulfurqon@unhasy.ac.id';

  // Kartu "Informasi Tambahan"
  static const String infoJudul = 'informasi tambahan';
  static const String infoIsi =
      'saya adalah orang yang rajin ibadah, suka menabung, dan tidak sombong :)';

  // Lokasi foto profil. Letakkan file foto di folder assets/images/.
  static const String fotoPath = 'assets/images/profil.jpeg';
  static const String infoGambarPath = 'assets/images/info.jpg';
}

/// Fungsi pertama yang dijalankan saat aplikasi dibuka.
void main() {
  runApp(const ProfilMahasiswaApp());
}

/// Widget akar aplikasi: mengatur tema dan halaman awal.
class ProfilMahasiswaApp extends StatelessWidget {
  const ProfilMahasiswaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: const Color(0xFFF3F5F7),
      ),
      home: const ProfilPage(),
    );
  }
}

/// Halaman utama: Profil Mahasiswa.
class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar: ikon menu (☰) muncul otomatis karena Scaffold punya drawer.
      appBar: AppBar(
        title: const Text(
          'Profil Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal.shade100,
        actions: [
          PopupMenuButton<String>(
            onSelected: (_) => _tampilkanDetail(context),
            itemBuilder: (_) => const [
              PopupMenuItem<String>(
                value: 'detail',
                child: Text('Lihat Detail'),
              ),
            ],
          ),
        ],
      ),

      // Drawer: panel samping yang dibuka lewat ikon ☰.
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const ListTile(
                leading: Icon(Icons.person),
                title: Text(DataMahasiswa.nama),
                subtitle: Text(DataMahasiswa.email),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Tutup menu'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),

      // SingleChildScrollView: halaman bisa digulir jika konten melebihi layar.
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const _FotoProfil(),
              const SizedBox(height: 12),
              Text(
                DataMahasiswa.nama,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const _KartuIdentitas(),
              const SizedBox(height: 16),
              const _KartuInformasiTambahan(),
              const SizedBox(height: 24),
              SizedBox(
                width: 220,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => _tampilkanDetail(context),
                  child: const Text('Detail'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

/// Foto profil bulat. Jika file foto belum ada, tampil ikon placeholder.
class _FotoProfil extends StatelessWidget {
  const _FotoProfil();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
        border: Border.all(color: Colors.teal, width: 3),
      ),
      child: ClipOval(
        child: Image.asset(
          DataMahasiswa.fotoPath,
          fit: BoxFit.cover,
          // Dipanggil jika file gambar tidak ditemukan.
          errorBuilder: (context, error, stackTrace) =>
              Icon(Icons.person, size: 80, color: Colors.grey.shade600),
        ),
      ),
    );
  }
}

/// Kartu identitas: tiap baris berupa Row [ikon, label, ":", nilai].
class _KartuIdentitas extends StatelessWidget {
  const _KartuIdentitas();

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _BarisInfo(
              ikon: Icons.badge,
              label: 'NIM',
              nilai: DataMahasiswa.nim,
            ),
            Divider(height: 24),
            _BarisInfo(
              ikon: Icons.groups,
              label: 'Kelas',
              nilai: DataMahasiswa.kelas,
            ),
            Divider(height: 24),
            _BarisInfo(
              ikon: Icons.school,
              label: 'Program Studi',
              nilai: DataMahasiswa.programStudi,
            ),
            Divider(height: 24),
            _BarisInfo(
              ikon: Icons.account_balance,
              label: 'Universitas',
              nilai: DataMahasiswa.universitas,
            ),
            Divider(height: 24),
            _BarisInfo(
              ikon: Icons.favorite,
              label: 'Hobi',
              nilai: DataMahasiswa.hobi,
            ),
          ],
        ),
      ),
    );
  }
}

/// Satu baris informasi dengan format "Label : Nilai".
class _BarisInfo extends StatelessWidget {
  const _BarisInfo({
    required this.ikon,
    required this.label,
    required this.nilai,
  });

  final IconData ikon;
  final String label;
  final String nilai;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(ikon, size: 20, color: Colors.teal),
        const SizedBox(width: 8),
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Text(':  '),
        // Expanded: nilai mengisi sisa lebar & teks panjang turun ke baris baru.
        Expanded(child: Text(nilai)),
      ],
    );
  }
}

/// Kartu "Informasi Tambahan": gambar kecil di kiri, teks di kanan.
class _KartuInformasiTambahan extends StatelessWidget {
  const _KartuInformasiTambahan();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                DataMahasiswa.infoGambarPath,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                // Jika file belum ada, tampilkan kotak ikon seperti sebelumnya.
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 70,
                  height: 70,
                  color: Colors.teal.shade50,
                  child: const Icon(Icons.image, size: 36, color: Colors.teal),
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DataMahasiswa.infoJudul,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(DataMahasiswa.infoIsi),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Menampilkan data lengkap dalam bottom sheet (dipanggil tombol Detail).
void _tampilkanDetail(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (_) => const Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Mahasiswa',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _BarisInfo(
            ikon: Icons.person,
            label: 'Nama',
            nilai: DataMahasiswa.nama,
          ),
          SizedBox(height: 12),
          _BarisInfo(ikon: Icons.badge, label: 'NIM', nilai: DataMahasiswa.nim),
          SizedBox(height: 12),
          _BarisInfo(
            ikon: Icons.email,
            label: 'Email',
            nilai: DataMahasiswa.email,
          ),
        ],
      ),
    ),
  );
}
