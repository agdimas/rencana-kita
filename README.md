# Rencana Kita — langkah publikasi

## 1. Siapkan database (sekali saja)
1. Buka project Supabase `agdimas's Project`.
2. Pilih **SQL Editor** di sidebar, lalu **New query**.
3. Buka file `rencana-kita-supabase.sql`, salin semua isinya ke editor, lalu tekan **Run**.
4. Pastikan hasilnya sukses sebelum membuka website.

## 2. Unggah website ke GitHub
1. Buat repository baru bernama `rencana-kita`.
2. Unggah `index.html` dari folder ini ke akar repository, lalu commit.
3. Buka **Settings → Pages**.
4. Pada **Build and deployment**, pilih **Deploy from a branch**, branch `main`, folder `/ (root)`, lalu **Save**.
5. Tunggu sampai GitHub menampilkan alamat Pages, biasanya `https://NAMA-AKUN.github.io/rencana-kita/`.

## 3. Izinkan tautan login kembali ke website
1. Di Supabase, buka **Authentication → URL Configuration**.
2. Isi **Site URL** dengan alamat GitHub Pages yang tadi muncul.
3. Tambahkan alamat yang sama di **Redirect URLs**, lalu simpan.
4. Buka website Pages dan masuk memakai tautan yang dikirim ke email akunmu.

Website memakai Supabase untuk menyimpan checklist, tanggal, dan lokasi setelah login. Aturan RLS pada skrip membatasi setiap baris data ke user ID yang sedang login. File publik hanya berisi template umum dan `Publishable key`; jangan menaruh `Secret key`, `service_role`, password, atau data rencana acara ke repository.

