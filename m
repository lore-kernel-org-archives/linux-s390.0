Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C331233B6FB
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375113; cv=none; b=Twhz07Yjnog1NegALeb1nHxJ9g8/DrRan3k3Nnv1dVVKC36/vIOKMEreLslN/+TfFGWgk5e3sRp/pxSG/zYDHKBqReS+K5mpXIE4kF7SuT3/D/Swsv7ukxtMyQMknKlrUcdSc7HiOl3QW4+GV/XXa9Xm9PvIJLTW4NgrbLpgjPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375113; c=relaxed/simple;
	bh=+oaAjyEp6ftj/PHhQbqAgc3i6WKxrkECzgHtOsHcZvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m0vTIZhvBURqunGyNyYu0gHcNq/5PMiCL2hyf4nP4CJFi5fvzEV8MDjDu4Z2dDmNdWrQxFYg4P4FONsry28LGPQiODIgJvaNyC61SRrCER4AzpygCkvKFicJ1JYsZFKxucEiLTw1WHhvCZSHu2LI6cVPEtiygHroSZX93LCQyzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGFJS24G; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGFJS24G"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35d7fa491deso1853112eec.1
        for <linux-s390@vger.kernel.org>; Sun, 18 Oct 2026 18:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375111; x=1792979911; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wabN2RpcS9yTy4X+yFbisN0o21RKH0fyf1fEhCrMYgc=;
        b=dGFJS24G2+8l24MB8KPvSCel5scwCuISJ6K+2U/au9gRu4U5UA4FX+BHl5Axj8QA+B
         ZQk7JlxxsBt/YSZ2Wp9j+9MhxrISRoQaouiIQMeqhgNeZtMXcV7kb1xSM4l8LZ/AAHTx
         X94NdGfVcYN5mDGea33VPkdL1Gv0ikgDZXURN0l+ZAwUkjj7y9saxcLKc24sxrWBUzDq
         aUDY0/pT5zDLPTEO7LkpJAzASQWxqMeKEMy7M6q3YM6woibjV4gw46l7H6sERo+yYZeI
         HS6GA9Xo8/ulxmdKMFSUFOof8poRLLpZlYjN9h++KSUJ83tfH5AeTJWHq2dwoaCo3P7x
         ZFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375111; x=1792979911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wabN2RpcS9yTy4X+yFbisN0o21RKH0fyf1fEhCrMYgc=;
        b=mm5nEY/7XH1uviYI8Q4NTTFy9qWPVZpKPVYcnrefKsYA7V39LT+Bd9uWoh0rczFXpW
         hu5lmGeAwtRq/1yX2HRWrkySpW/B0tZ5+HVKyM0/WBzC1uYpm81y26VayUCRx/TBGlzz
         RCF9N5pix4mMc8h5HPyJoflYhakbYZcCDY9afNdIB7agt6GQQWmredTEh1r1R17Ls+xl
         Db4rSLKAziOAo7B1is+SoMruYMVSggdizK1DWDABcyG+K6I857CkXnUGoGCPhrGh3ty2
         aVA1ynOpWNbsSmnwPhqwvs3ob08I3BoF0EkFtXzU59UmDfrBUlqEPk2/+PCfinBbOcuy
         jlNA==
X-Forwarded-Encrypted: i=1; AKwUvBw/N8lusAcMRJkP0ix4Ooj+ciHR4ty/sNdG4itfP6LfPXeIp0LTpj6yHPA9A5dYlClyqtg4hGUOgS/a@vger.kernel.org
X-Gm-Message-State: AFq9FYIkx3dV+VEHI/6j7YpNuy40kE8KrKcxnJM84Jrg4aP3/2RrAHCi
	U502Ckob9COWwrmAh2TM1xvfM1obgCsLqcfJj1QhwKfNhPS7x9DwotIK
X-Gm-Gg: AYBFou2+KyU9XiayzdRvNCHCzHLHUVZ+LQ7mlTTmg3SoMxDskUeuKYB2jrzhjF7E2jf
	oj95MC5mJESAC2BxYR9g+OVGHAvTLNyvlXH1d/f0OM79LLK7Sei5B4LI+vqHyuyAyfKhUUjx/DV
	/cAVXEdK6/rQLu9QbrfzS1LgBkeiTDW47nUi4V5i00TQucN11CHMXdPuUVDZ7C5BRejXE+L37A8
	b2LYlHvs/PR/zut4+EoYodUJZQ/nggA9cmRbduxC1eOJHZUsSagi0r4J5x9Zgx7CZzKxNblnHg9
	/iYiWTQF0M3eVUwlAw++1obMUzFWrlIEU2C6+rKpz7SOQJk/f7XoF1GVaQEvUiDgCqT90QDPXpB
	7kSgzQqU9pSvkJw6l+T+Jg5xw34B6p0c9Ot/jtwCXpLfGZFADTfULPm+aoIFqIuxaEHZjjOJHmF
	UC6/VuySylDuZo3b6FD866MpAn4HwsWhllfQABYcXaM1RDT/X4LiGx4M0sUbElNxFiESOczKDT8
	IDT
X-Received: by 2002:a05:701b:4202:20b0:146:5f73:d45b with SMTP id a92af1059eb24-1850be495b5mr8924712c88.3.1792375110248;
        Sun, 18 Oct 2026 18:58:30 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm24177311c88.17.2026.10.18.18.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:58:29 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 19 Oct 2026 09:58:09 +0800
Subject: [PATCH 1/2] word-at-a-time: check the first byte in
 load_unaligned_zeropad()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
In-Reply-To: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
To: Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Marco Elver <elver@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-mm@kvack.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, Peter Collingbourne <peter@pcc.me.uk>
X-Mailer: b4 0.13.0

load_unaligned_zeropad() reads a word that may run into an unmapped
page and recovers through an exception fixup. It does the word loads of
sized_strscpy() and of the name compare in dentry_string_cmp(), path
components in hash_name() and hashlen_string(), and the trailing bytes
in x86's csum_partial().

It is inline assembly on every architecture that implements it, so
KASAN and KCSAN never see these loads, while read_word_at_a_time() at
least checks the first byte of each word. A use-after-free or
out-of-bounds read of a name handed to path lookup goes unreported, and
so does strscpy() reading from a bad source, which the kasan_strings
KUnit case expects to be reported. On x86_64 with generic KASAN:

  KASAN and string KUnit suites      failures
                                  before    after
  CONFIG_FORTIFY_SOURCE=n              1        0
  CONFIG_FORTIFY_SOURCE=y              1        0

Check the first byte at the start of load_unaligned_zeropad() on every
architecture, as read_word_at_a_time() does. All callers only load a
word whose first byte belongs to the string or buffer they read, so
the check does not flag their intended reads past the end. Add no-op
stubs for the powerpc selftest that builds the header in user space.

Suggested-by: Peter Collingbourne <peter@pcc.me.uk>
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 arch/arm/include/asm/word-at-a-time.h                           | 7 +++++++
 arch/arm64/include/asm/word-at-a-time.h                         | 7 +++++++
 arch/powerpc/include/asm/word-at-a-time.h                       | 6 ++++++
 arch/riscv/include/asm/word-at-a-time.h                         | 6 ++++++
 arch/s390/include/asm/word-at-a-time.h                          | 6 ++++++
 arch/x86/include/asm/word-at-a-time.h                           | 6 ++++++
 tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h | 3 +++
 tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h | 3 +++
 8 files changed, 44 insertions(+)

diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
index 5023f98d8293d..f672aad2e30e6 100644
--- a/arch/arm/include/asm/word-at-a-time.h
+++ b/arch/arm/include/asm/word-at-a-time.h
@@ -56,6 +56,9 @@ static inline unsigned long find_zero(unsigned long mask)
 #include <asm-generic/word-at-a-time.h>
 #endif
 
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
+
 #ifdef CONFIG_DCACHE_WORD_ACCESS
 
 /*
@@ -69,6 +72,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret, tmp;
 
+	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
+	kasan_check_read(addr, 1);
+	kcsan_check_read(addr, 1);
+
 	/* Load word from unaligned pointer addr */
 	asm(
 	"1:	ldr	%0, [%2]\n"
diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
index 824ca6987a516..11ecca99057aa 100644
--- a/arch/arm64/include/asm/word-at-a-time.h
+++ b/arch/arm64/include/asm/word-at-a-time.h
@@ -40,6 +40,9 @@ static inline unsigned long zero_bytemask(unsigned long bits)
 #include <asm-generic/word-at-a-time.h>
 #endif
 
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
+
 /*
  * Load an unaligned word from kernel space.
  *
@@ -51,6 +54,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret;
 
+	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
+	kasan_check_read(addr, 1);
+	kcsan_check_read(addr, 1);
+
 	__mte_enable_tco_async();
 
 	/* Load word from unaligned pointer addr */
diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 54653a8634149..49c6a1f65c493 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -5,6 +5,8 @@
  * Word-at-a-time interfaces for PowerPC.
  */
 #include <linux/bitops.h>
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 #include <linux/wordpart.h>
 #include <asm/asm-compat.h>
 #include <asm/extable.h>
@@ -168,6 +170,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret, offset, tmp;
 
+	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
+	kasan_check_read(addr, 1);
+	kcsan_check_read(addr, 1);
+
 	asm(
 	"1:	" PPC_LL "%[ret], 0(%[addr])\n"
 	"2:\n"
diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
index 3802cda71ab7e..fb7e2904dd7fd 100644
--- a/arch/riscv/include/asm/word-at-a-time.h
+++ b/arch/riscv/include/asm/word-at-a-time.h
@@ -11,6 +11,8 @@
 
 #include <asm/asm-extable.h>
 #include <linux/bitops.h>
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 #include <linux/wordpart.h>
 
 struct word_at_a_time {
@@ -60,6 +62,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret;
 
+	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
+	kasan_check_read(addr, 1);
+	kcsan_check_read(addr, 1);
+
 	/* Load word from unaligned pointer addr */
 	asm(
 	"1:	" REG_L " %0, %2\n"
diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
index eaa19dee76994..59393cf065964 100644
--- a/arch/s390/include/asm/word-at-a-time.h
+++ b/arch/s390/include/asm/word-at-a-time.h
@@ -3,6 +3,8 @@
 #define _ASM_WORD_AT_A_TIME_H
 
 #include <linux/bitops.h>
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 #include <linux/wordpart.h>
 #include <asm/asm-extable.h>
 #include <asm/bitsperlong.h>
@@ -52,6 +54,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long data;
 
+	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
+	kasan_check_read(addr, 1);
+	kcsan_check_read(addr, 1);
+
 	asm_inline volatile(
 		"0:	lg	%[data],0(%[addr])\n"
 		"1:	nopr	%%r7\n"
diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
index 422a47746657a..1319e1d87a9c4 100644
--- a/arch/x86/include/asm/word-at-a-time.h
+++ b/arch/x86/include/asm/word-at-a-time.h
@@ -3,6 +3,8 @@
 #define _ASM_WORD_AT_A_TIME_H
 
 #include <linux/bitops.h>
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
 #include <linux/wordpart.h>
 
 struct word_at_a_time {
@@ -71,6 +73,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret;
 
+	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */
+	kasan_check_read(addr, 1);
+	kcsan_check_read(addr, 1);
+
 	asm volatile(
 		"1:	mov %[mem], %[ret]\n"
 		"2:\n"
diff --git a/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h b/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h
new file mode 100644
index 0000000000000..000c92de6baf2
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/linux/kasan-checks.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* There is nothing for KASAN to check in user space. */
+#define kasan_check_read(p, size)	((void)(p), (void)(size))
diff --git a/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h b/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h
new file mode 100644
index 0000000000000..39c97bc15531e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/linux/kcsan-checks.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* There is nothing for KCSAN to check in user space. */
+#define kcsan_check_read(p, size)	((void)(p), (void)(size))

-- 
2.43.0

