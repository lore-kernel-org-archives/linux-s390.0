Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388974;
	b=PBI7Ss8Tsel6dHIhEU/zWB3rdb3btDKCSyBBEHTeimY8LH3en2EjWailQsk398s+MhnA
	 OgZsrJ16io9VAtnC1X0gugvyr71mQmBbHe26Elpkbo7IkAP5EBCPJZBPSuPE67wQc1Aw4
	 VkTsjW0thghjgDVQ9QDDRE8GqXkOHLxeidqNktdN8D91zvV4uVTdAc7ttQ4BIQreTsFB9
	 xXzuQO1tKx8tdXLSoP96CcpSYaQ/dNLyTItCR32hV+EsOouzBoyTC4w0DmxuABFoMoBLk
	 ebeyAyxOyxcCJ6ce7lMdJcxjCJKQm0r1Tje8BtobAu/DJaRA/Z2knduHBgTV9DiMl9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388974;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7b5X+4SjztcHydS5WfCa1q0BYAFZqwdMD8BIV9hhKRI=;
	b=eXuT8DD0ENXFM4/tz/ps6HWgAV0cbW3uNBpQm8tItEK+uSwDo8TGVPEwAn0u34vygCIu
	 WhdllBhEtVJQiCe+Mcg2vzJN2GVeObuovSKWgudXerikHylRuXGAtdStkY766FKPoZiB7
	 06aWbVAw+l6xQq2CGittUGTYrKlCXLb877n1X4eD3UftI2r0cWXj/zT0wxw0cQlw67+3W
	 qeeffxSxY0cAtXyltWrnpuaEmEuHNw0l6no2hv/IYi4IbD0bjTAoNRIn3rmYkcXP/Zufc
	 jdp8+FSQViupJUpA/mYG60OpJJIUXOnM1IgW1oGG1g4P/D59bbrIH7eBdfRQwMstJUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ma+qyGKW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E603C606A321;
	Wed, 11 Nov 2026 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ma+qyGKW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A8C1F00A05;
	Wed, 11 Nov 2026 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794388973;
	bh=7b5X+4SjztcHydS5WfCa1q0BYAFZqwdMD8BIV9hhKRI=;
	h=From:To:Cc:Subject:Date;
	b=ma+qyGKWLh4TZNAaUdEeYWoinDKtueXJVN2fP2E5y1OM6V0uxGGOBrH2nMcQAPyZe
	 9dqZEuscw1CZd30lO75Blugh5oW9HMarIoqzDud+2nTcFWdEzjJwnx1MlHMNX7aOdo
	 JrgOMmpflyEpdwKj+JphfrPE1fHZNMowW1T+5LwCDy1Lz6nHtFceRQncP5FYdH1lOl
	 mTgxOPztzQ410CyG1Rmij08KzZz9JozM4hiazqHpaK6BL+r3ZUuRiHplhYPTDJcdDL
	 QztnNG4oMk9zErC0Lw8sjtaPaiiKfWy1onpGQsc/2akwcnrb7LZwzQ3Z4sakO49TdW
	 9Y7Msma2BP9hQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>,
	Andreas Grapentin <gra@linux.ibm.com>,
	Finn Thain <fthain@linux-m68k.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@kernel.org>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [PATCH] [RFC] instrumented.h: mark instrument_write non-const
Date: Wed, 11 Nov 2026 10:21:31 +0100
Message-ID: <20261111092231.2027735-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

I got another instance of a -Wmaybe-uninitialized in ntfs, as this is
the only place that enables the warning:

In file included from include/asm-generic/rwonce.h:26,
                 from fs/ntfs3/file.c:10:
In function 'instrument_copy_from_user_before',
    inlined from '_inline_copy_from_user' at include/linux/uaccess.h:184:2,
    inlined from 'copy_from_user' at include/linux/uaccess.h:222:9,
    inlined from 'ntfs_ioctl_fitrim' at fs/ntfs3/file.c:78:6,
    inlined from 'ntfs_ioctl' at fs/ntfs3/file.c:246:10:
include/linux/kasan-checks.h:38:27: error: 'range' may be used uninitialized [-Werror=maybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
include/linux/instrumented.h:146:9: note: in expansion of macro 'kasan_check_write'
  146 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
include/linux/kasan-checks.h: In function 'ntfs_ioctl':
include/linux/kasan-checks.h:20:6: note: by argument 1 of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
fs/ntfs3/file.c:66:29: note: 'range' declared here
   66 |         struct fstrim_range range;
      |                             ^~~~~

The problem here is that copy_from_user() is called on an uninitialized
object, but the instrumentation passes the pointer into a function that
takes a const object. gcc deduces that any access to that object is
undefined behavior and warns about it.

The only workaround I could come up with is to remove the 'const' keyword
from these annotations, which of course is not great either, as the
functions do not actually access the data at all.

This also found incorrect 'const' annotations in
arch/s390/include/asm/fpu-insn.h, which writes to those pointers.

Any ideas?

Fixes: 33b75c1d884e ("instrumented.h: allow instrumenting both sides of copy_from_user()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/include/asm/fpu-insn.h |  8 ++++----
 include/linux/instrumented.h     | 10 +++++-----
 include/linux/kasan-checks.h     |  6 +++---
 mm/kasan/shadow.c                |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
index aaf1faeb3dc5..7cd6e9f30485 100644
--- a/arch/s390/include/asm/fpu-insn.h
+++ b/arch/s390/include/asm/fpu-insn.h
@@ -359,7 +359,7 @@ static __always_inline void fpu_vsrlb(u8 v1, u8 v2, u8 v3)
 
 #ifdef CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS
 
-static __always_inline void fpu_vst(u8 v1, const void *vxr)
+static __always_inline void fpu_vst(u8 v1, void *vxr)
 {
 	instrument_write(vxr, sizeof(__vector128));
 	asm volatile("VST	%[v1],%O[vxr],,%R[vxr]"
@@ -370,7 +370,7 @@ static __always_inline void fpu_vst(u8 v1, const void *vxr)
 
 #else /* CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS */
 
-static __always_inline void fpu_vst(u8 v1, const void *vxr)
+static __always_inline void fpu_vst(u8 v1, void *vxr)
 {
 	instrument_write(vxr, sizeof(__vector128));
 	asm volatile(
@@ -385,7 +385,7 @@ static __always_inline void fpu_vst(u8 v1, const void *vxr)
 
 #ifdef CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS
 
-static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
+static __always_inline void fpu_vstl(u8 v1, u32 index, void *vxr)
 {
 	unsigned int size;
 
@@ -400,7 +400,7 @@ static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
 
 #else /* CONFIG_CC_HAS_ASM_AOR_FORMAT_FLAGS */
 
-static __always_inline void fpu_vstl(u8 v1, u32 index, const void *vxr)
+static __always_inline void fpu_vstl(u8 v1, u32 index, void *vxr)
 {
 	unsigned int size;
 
diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index a1b4cf81adc2..d28aa6b0aeb8 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -36,7 +36,7 @@ static __always_inline void instrument_read(const volatile void *v, size_t size)
  * Instrument a regular write access. The instrumentation should be inserted
  * before the actual write happens.
  */
-static __always_inline void instrument_write(const volatile void *v, size_t size)
+static __always_inline void instrument_write(volatile void *v, size_t size)
 {
 	kasan_check_write(v, size);
 	kcsan_check_write(v, size);
@@ -50,7 +50,7 @@ static __always_inline void instrument_write(const volatile void *v, size_t size
  * Instrument a regular write access. The instrumentation should be inserted
  * before the actual write happens.
  */
-static __always_inline void instrument_read_write(const volatile void *v, size_t size)
+static __always_inline void instrument_read_write(volatile void *v, size_t size)
 {
 	kasan_check_write(v, size);
 	kcsan_check_read_write(v, size);
@@ -92,7 +92,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
  * Instrument an atomic write access. The instrumentation should be inserted
  * before the actual write happens.
  */
-static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
+static __always_inline void instrument_atomic_write(volatile void *v, size_t size)
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_write(v, size);
@@ -107,7 +107,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
  * Instrument an atomic read-write access. The instrumentation should be
  * inserted before the actual write happens.
  */
-static __always_inline void instrument_atomic_read_write(const volatile void *v, size_t size)
+static __always_inline void instrument_atomic_read_write(volatile void *v, size_t size)
 {
 	kasan_check_write(v, size);
 	kcsan_check_atomic_read_write(v, size);
@@ -141,7 +141,7 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
  * variants). The instrumentation should be inserted before the accesses.
  */
 static __always_inline void
-instrument_copy_from_user_before(const void *to, const void __user *from, unsigned long n)
+instrument_copy_from_user_before(void *to, const void __user *from, unsigned long n)
 {
 	kasan_check_write(to, n);
 	kcsan_check_write(to, n);
diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
index 3d6d22a25bdc..90b878b876f5 100644
--- a/include/linux/kasan-checks.h
+++ b/include/linux/kasan-checks.h
@@ -17,13 +17,13 @@
  */
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 bool __kasan_check_read(const volatile void *p, unsigned int size);
-bool __kasan_check_write(const volatile void *p, unsigned int size);
+bool __kasan_check_write(volatile void *p, unsigned int size);
 #else
 static inline bool __kasan_check_read(const volatile void *p, unsigned int size)
 {
 	return true;
 }
-static inline bool __kasan_check_write(const volatile void *p, unsigned int size)
+static inline bool __kasan_check_write(volatile void *p, unsigned int size)
 {
 	return true;
 }
@@ -41,7 +41,7 @@ static inline bool kasan_check_read(const volatile void *p, unsigned int size)
 {
 	return true;
 }
-static inline bool kasan_check_write(const volatile void *p, unsigned int size)
+static inline bool kasan_check_write(volatile void *p, unsigned int size)
 {
 	return true;
 }
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d286e0a04543..591c179164af 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -32,7 +32,7 @@ bool __kasan_check_read(const volatile void *p, unsigned int size)
 }
 EXPORT_SYMBOL(__kasan_check_read);
 
-bool __kasan_check_write(const volatile void *p, unsigned int size)
+bool __kasan_check_write(volatile void *p, unsigned int size)
 {
 	return kasan_check_range((void *)p, size, true, _RET_IP_);
 }
-- 
2.53.0

