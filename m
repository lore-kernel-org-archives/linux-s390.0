Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720211;
	b=hTY/X0k5Bq1eD7TZ1/G5fGELhvgh6BUNGsinIug/dhGa4bhYXV1q+y1Z4bDVNfkQ3MCo
	 BG7sjpSb/bvOvVOFUSB+oVry75Iv68BJhVQoGGXtuxXk07X2h99JkGhERqW4QOLyShevc
	 DWDlR/L+yT/WH/YNiOcDuoaCg08B6RDhhtBbw+Bim4FsiVWvHx4ULqm3WfNV1e6+2edYT
	 AWE9ZQOge15BdwgWYokAKVM+99vBY8r96K9dVHfZlbY9xcEyrXNiQF/ghbJ14rT5Q0HDC
	 m0LQfN3GPczDpUb6MqGXpogn/9oFhU6CyzicxVJJOd/KB/on8X4CIlYX3HxwN5m0/yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=a5VOHmm+k0IBj8x+32bgCpnZFpHRZVbIyYT6tTI+jX8=;
	b=cZNLdusBP//UKlK7nwmNcYCe2/eUTLH7rpYZBulrZCjFET4H4pmE9bkOER1nq0nOt10M
	 xocPP9UxzIoo2XZ76e5xUVx8LAHFRY4lEvgT6jloCZ/aX9QebrBL3IwmqIrmpfsoLG1iA
	 nK24JohCnQvISbZV/M2n9I0Oup78wUuUqmjsPT8mahXTmqBD7GoGlhSYLTClbjF/J/dTw
	 N8dUkNZzvR2LNFtXwhkGt9rJR/IHQbDC4jViZ1j2mi8Snof3W88CUYdgq4qaeEZqbWRYh
	 hhef45VG7g+tDcSeZ602kF8NJh5YUJAkm91rmy9XhTgUoRnTZRu+Paxa5QxLO3ZUHrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=chuleG2m;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91658606A31D
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 01:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91658606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=chuleG2m
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-354ba08cfd1so726170eec.1
        for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 18:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792720210; x=1793325010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a5VOHmm+k0IBj8x+32bgCpnZFpHRZVbIyYT6tTI+jX8=;
        b=chuleG2mqYsZpysPV118lsqPdYBWOF4FaSzACMLo93aMADnN9ZrBS3g9Y+ikdpiPLQ
         lRqFe//O6GXVreemEE1aBEZUEQz8l6Hl1uTybyZBAmq20Ryo4IVpU67AU2G6t0vs3tFF
         jm/qfxjHeTI1lK2ogdHx68wRBc9xwbf9AhgU0qkBmBEBI4clSnaC55Wu4EduATAc2nof
         ukliFRDBtraHkFxR+P7zG+XksRv4qJgm70cuELBW35mWCb/wH/YkVG8uVvveX149Fr7w
         BdpVed8ZlnlyrbhOo+rQowOChJzHbK1yb8a6wS9oWOHFbAL1IL7+fSs+YaOQ6aqS1j3T
         KtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792720210; x=1793325010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5VOHmm+k0IBj8x+32bgCpnZFpHRZVbIyYT6tTI+jX8=;
        b=2cKAoGV+neiLLdkU3fZ3EBb/Hm2auAKLbSLDcw7mbufr4lMhPsaTyN8zq2WWVoMBb0
         3IhysMBVtjY3UDQGe6cBccKRAtA926mmqw8+GAgtebtOGWJnxIfoEfJgfVYgoD0aDwVW
         Btszd5KwkcUaj5/NwkgRExmIoaQNrHzbEAVXqde8r7UbwyxoC380NxxzenuZhBPcboOY
         9QIhtJeGKaPhinAkO7QFSs+XnxiB8VkKzyNe9MH4OdiBOApW8xeiCX9CyY/Ht6SFeWSG
         RSLRPODG2e6hVjdajSEOHre28+48TZb9Dm+0i/JREB8PBVU74W7EmCvZlKrhA/nouLwQ
         ATMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxutd6tvEhPY5ey8g58i0IIekzz2KjVnGglXgsJy8fBsTIbpQx8hwItYTKS1o33eRaCwXIoer7uW233@vger.kernel.org
X-Gm-Message-State: AFq9FYIE7nRB9ouJW6I2qII9U9SogTj8upP0hI2xSsIhfSSdciYksNFC
	QiF5GCQxm0ml04myGv0tKn2nYEf3a0o+FJLfn5AteUlu+xs9TPnyR6JU
X-Gm-Gg: AYBFou08QFu1JvFOTPNcMSNezhRmHVRNhV4MczA6tboYHTtC7ysgcD2GDlxCk7iPAR/
	DY0JAKaHH777dAeQdkzubxuQSKEhax41DlAE/enR9Dgi6Ny/+wrMMWJ7yt1hea3NJnXVhkk2RLr
	RlnwXAqPQvnpqMhGnutv+tt8j47WJNsFj+Fa/m2Z2drcruv+E6oZqW8zYyEzQSDPeI/YBg55FZE
	S0zh8JlAm3J56XfUD24C6UH95JWCiFYRqbI2MAIiVpvpWlVTAZh0xm3gZiOArGLgHrpKMzxg8jW
	X7QzzK3oJkiwXydvvUaRr4c6+PUeMyMq+2ZAMAECj1dHMsPRycm2XpbVCobZkSWRZbj0yNUnQPk
	B0Eh7+HV7ZB4wkkAS5WFS7mCNxI9iXhlYG/6d0kdrL23hpuEIaMl826oDreUSmXL3Z98bXBIxm0
	YcZKRpkQYBX+XoA+anWjoMOBEK3EE2R+qL3/QhY5IQIr8mDApUljK+dKIw1wq66szo9IrMZH0z0
	yKtEkzrZHaCJXddrUKt1kg9+rw9h7QdXGfO/rQbTWUd252ih2yP
X-Received: by 2002:a05:7300:fe81:b0:33c:e74:4624 with SMTP id 5a478bee46e88-369d977beeamr1247908eec.27.1792720209507;
        Thu, 22 Oct 2026 18:50:09 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9c0e60dsm1971091eec.2.2026.10.22.18.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:50:09 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 23 Oct 2026 09:49:48 +0800
Subject: [PATCH v2 1/2] word-at-a-time: check the first byte in
 load_unaligned_zeropad()
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-bug-word-at-a-time-zeropad-kasan-v2-1-be0ecfbae847@gmail.com>
References: <20261023-bug-word-at-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com>
In-Reply-To: <20261023-bug-word-at-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com>
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

Check the first byte with instrument_read() at the start of
load_unaligned_zeropad() on every architecture, as read_word_at_a_time()
does. All callers only load a word whose first byte belongs to the
string or buffer they read, so the check does not flag their intended
reads past the end. Add a no-op instrument_read() for the powerpc
selftest that builds the header in user space.

Suggested-by: Peter Collingbourne <peter@pcc.me.uk>
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Reviewed-by: Marco Elver <elver@google.com>
---
 arch/arm/include/asm/word-at-a-time.h                           | 5 +++++
 arch/arm64/include/asm/word-at-a-time.h                         | 4 ++++
 arch/powerpc/include/asm/word-at-a-time.h                       | 4 ++++
 arch/riscv/include/asm/word-at-a-time.h                         | 4 ++++
 arch/s390/include/asm/word-at-a-time.h                          | 4 ++++
 arch/x86/include/asm/word-at-a-time.h                           | 4 ++++
 tools/testing/selftests/powerpc/primitives/linux/instrumented.h | 3 +++
 7 files changed, 28 insertions(+)

diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
index 5023f98d8293d..361771f178699 100644
--- a/arch/arm/include/asm/word-at-a-time.h
+++ b/arch/arm/include/asm/word-at-a-time.h
@@ -56,6 +56,8 @@ static inline unsigned long find_zero(unsigned long mask)
 #include <asm-generic/word-at-a-time.h>
 #endif
 
+#include <linux/instrumented.h>
+
 #ifdef CONFIG_DCACHE_WORD_ACCESS
 
 /*
@@ -69,6 +71,9 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret, tmp;
 
+	/* Check only the first byte, the rest may lie past the object */
+	instrument_read(addr, 1);
+
 	/* Load word from unaligned pointer addr */
 	asm(
 	"1:	ldr	%0, [%2]\n"
diff --git a/arch/arm64/include/asm/word-at-a-time.h b/arch/arm64/include/asm/word-at-a-time.h
index d7a3b69dc8c6f..37d45e716c11a 100644
--- a/arch/arm64/include/asm/word-at-a-time.h
+++ b/arch/arm64/include/asm/word-at-a-time.h
@@ -8,6 +8,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
 #include <linux/wordpart.h>
 
 struct word_at_a_time {
@@ -45,6 +46,9 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret;
 
+	/* Check only the first byte, the rest may lie past the object */
+	instrument_read(addr, 1);
+
 	__mte_enable_tco_async();
 
 	/* Load word from unaligned pointer addr */
diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 54653a8634149..1660b2e3e3a8f 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -5,6 +5,7 @@
  * Word-at-a-time interfaces for PowerPC.
  */
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
 #include <linux/wordpart.h>
 #include <asm/asm-compat.h>
 #include <asm/extable.h>
@@ -168,6 +169,9 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret, offset, tmp;
 
+	/* Check only the first byte, the rest may lie past the object */
+	instrument_read(addr, 1);
+
 	asm(
 	"1:	" PPC_LL "%[ret], 0(%[addr])\n"
 	"2:\n"
diff --git a/arch/riscv/include/asm/word-at-a-time.h b/arch/riscv/include/asm/word-at-a-time.h
index 3802cda71ab7e..761fa2734b7f5 100644
--- a/arch/riscv/include/asm/word-at-a-time.h
+++ b/arch/riscv/include/asm/word-at-a-time.h
@@ -11,6 +11,7 @@
 
 #include <asm/asm-extable.h>
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
 #include <linux/wordpart.h>
 
 struct word_at_a_time {
@@ -60,6 +61,9 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret;
 
+	/* Check only the first byte, the rest may lie past the object */
+	instrument_read(addr, 1);
+
 	/* Load word from unaligned pointer addr */
 	asm(
 	"1:	" REG_L " %0, %2\n"
diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
index 0b7779c8d5a4e..f3caa4959cc87 100644
--- a/arch/s390/include/asm/word-at-a-time.h
+++ b/arch/s390/include/asm/word-at-a-time.h
@@ -3,6 +3,7 @@
 #define _ASM_WORD_AT_A_TIME_H
 
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
 #include <linux/wordpart.h>
 #include <asm/asm-extable.h>
 #include <asm/bitsperlong.h>
@@ -52,6 +53,9 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long data;
 
+	/* Check only the first byte, the rest may lie past the object */
+	instrument_read(addr, 1);
+
 	asm_inline volatile(
 		"0:	lg	%[data],0(%[addr])\n"
 		"1:\n"
diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
index 422a47746657a..5374e08372253 100644
--- a/arch/x86/include/asm/word-at-a-time.h
+++ b/arch/x86/include/asm/word-at-a-time.h
@@ -3,6 +3,7 @@
 #define _ASM_WORD_AT_A_TIME_H
 
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
 #include <linux/wordpart.h>
 
 struct word_at_a_time {
@@ -71,6 +72,9 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret;
 
+	/* Check only the first byte, the rest may lie past the object */
+	instrument_read(addr, 1);
+
 	asm volatile(
 		"1:	mov %[mem], %[ret]\n"
 		"2:\n"
diff --git a/tools/testing/selftests/powerpc/primitives/linux/instrumented.h b/tools/testing/selftests/powerpc/primitives/linux/instrumented.h
new file mode 100644
index 0000000000000..114ef9284f69b
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/linux/instrumented.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* There is nothing for KASAN or KCSAN to check in user space. */
+#define instrument_read(p, size)	((void)(p), (void)(size))

-- 
2.43.0

