Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16833347BA9
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 01:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375122; cv=none; b=t5MsXCxjLjUlrRzRMlr27B9z7D+O13L90iz3e5AuMqubrWFI1UOBFuJQNKZFM0+EA+7voBkJuws12d93v3KYd6XuT6hX/Z/gImAqZrUwo2voj1eR9hWGt4zzSA7ysXmNWdwBmz/z4WETfWC4yUM/ocElYs0C6CMREWmEYH64NgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375122; c=relaxed/simple;
	bh=J5mMuI/2gP0v9ch0ANotvYhKJbiRS7t/s9fMyFsvGlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQeKxU8Ka8IonPXdj9lx6799fzGEIl/sve9YluH2Gic7d0Abh42d0N7c5Yy7Zbh3a+WRnVLmvDdei7P6NX1AvhVxCo/fdeH5PlfzT8hjwdjt/adhGGQFdVpZcFTFI87K5imMk3zOo8ZXIjTHJM5sdqqxeLCkUzysgKJW2xdhjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEm+MKtx; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEm+MKtx"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so3275650eec.1
        for <linux-s390@vger.kernel.org>; Sun, 18 Oct 2026 18:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792375120; x=1792979920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eX3gFXGtK0qFC1+jmqNQ0ZBmFVgyc6CU75RzS6mT9B0=;
        b=hEm+MKtxGYdBQVuoQgTh2WX0Qa0qpPJ96tGhdiMZijcVuKqWcUXJukO24kGlJtGQEv
         MVoUQ7B/kzItelKX7K1NFaQ3F9zVcqEW+P50ei1uqv8YgBbl4iEeWLw/bdFfPFWXOGFJ
         e28i6BB+2w/qbWoWARaJvQOE4axLFJHuhO4nuKNzXUy/j7fjL9721/eKTBi+9mPPRPqV
         +2Wo3jE21ypjO6F2tfwQqMBlr1U1X+NDZXDikosaZWjfmDAXDxhyrf8aUcQZexT/kid8
         Cb+aymvn3O6EiAX2KdlRV7+22yqA0N316FiFJ156HqNQDUA/vkw92ZkrkAvmgPIeP/kL
         WN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375120; x=1792979920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eX3gFXGtK0qFC1+jmqNQ0ZBmFVgyc6CU75RzS6mT9B0=;
        b=EkMdA5KQHSk2YsnQPUQestOhjEu/6hhbCtz65AzxxLGORoqlMHGtB48E5TIkKW1BJj
         BlApIJ6okzAHDscjbQgtvDolhEKG/NuK61IESln81NpfT0VRolMPZ9GkKIMOywLh+AIa
         3iOXf7Q+O2g6KqGwsnxKfUyR8Km7TEJKC9qQhoa/Qn44QUorlcK/DcjB5NQU3IPjQJpQ
         hiNwE9agBvAgmF3E27L+aAstpkp48LudnFDwm1mIbb1qjzQiHtfiEJrOjAW0Uo/WFCxd
         m0u1oW+GG73+WdE6B8EdMSISnNa+Qd34c0iu9ECJ8Z2fFQU3f7uWr2H1gdVIXug0w7DI
         AG+A==
X-Forwarded-Encrypted: i=1; AKwUvBz1OjodCGDA8sq87rzckCChTsN5YjxC5g0Nw51VtViGEo6i7Ju6F2Mu8kcT9o80HNqjnaQWJbbHiWcm@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2w5cZqvYE8Vn+sOwJqKkK/Avg6w4OYg2pqiLtXkF8AAogCLax
	UB8rEY8s3EB/YQcVYncE+TfQCbuCzGtMJN2UZNaRjSROeNHZrC/eruHA
X-Gm-Gg: AYBFou0bq4sg26z2mn6FjnD/tsahmRTb5tb/7AiasSScAkpndk/HdR9LcY0kD2AfSIJ
	bTKIu/CH15QQqSNoBVarWXg+IPCZb5mS3E4hQR1hsIdSb4YKad8eGrBjNnKD/PMmwOH3MnR4mdl
	bKZCsJIjKTK3US7TgPCaH1oEXwxbX+smsKiDWrQZTFR0Sb9iPzloxIqhmL/iwdPHDCSWvd9Kew2
	0odBd/A8Tniqr67S4O784Bd+f7cIedg3OHo/y31EictbiIqLfAWcb5pTi05TmBp0UL9yqfJ/QW1
	gE3xsHsrYv/aiueTc9M5bK5XTG58EOArycPF1b+++CfnmwR7VxcJilMphDcRGGATK4IyGhl50Im
	CEOXPoRzl35puFAbbCenF5Qwoa/x08Uqi8BWEeaIwTEw17POsJ4wmgVUx3oxca8JiufKkNyS/PO
	NLh25j/Xx6QwL/JnGkRPR6YC4NDjWhkt6afNFAowIwfjzlM+2twvGXI9LrXoVScoG3tA==
X-Received: by 2002:a05:7022:b057:20b0:18a:d0b5:fa42 with SMTP id a92af1059eb24-18ad0b5ffc8mr1432273c88.19.1792375119985;
        Sun, 18 Oct 2026 18:58:39 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm24177311c88.17.2026.10.18.18.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 18:58:39 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 19 Oct 2026 09:58:10 +0800
Subject: [PATCH 2/2] kasan/test: cover load_unaligned_zeropad()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-bug-word-at-a-time-zeropad-kasan-v1-2-f21a3ed6a477@gmail.com>
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
 Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

On architectures with CONFIG_DCACHE_WORD_ACCESS, load_unaligned_zeropad()
does the word loads of the dcache name compare and of path name
hashing.

None of the KASAN test cases reads memory through it, so nothing
noticed that KASAN did not check these loads at all.

Add a case that reads a freed object through load_unaligned_zeropad()
and expects a report. Skip it with hardware tag-based KASAN, since
arm64 turns tag checking off for this load:

  kasan_load_unaligned_zeropad, x86_64, generic KASAN
  without "word-at-a-time: check the first byte in
  load_unaligned_zeropad()"                                 FAILED
  with it                                                   PASSED

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 mm/kasan/kasan_test_c.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index b9e167ed5be32..c791512f6fc49 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -28,6 +28,9 @@
 #include <trace/events/printk.h>
 
 #include <asm/page.h>
+#ifdef CONFIG_DCACHE_WORD_ACCESS
+#include <asm/word-at-a-time.h>
+#endif
 
 #include "kasan.h"
 
@@ -1673,6 +1676,26 @@ static void kasan_memcmp(struct kunit *test)
 	kfree(ptr);
 }
 
+static void kasan_load_unaligned_zeropad(struct kunit *test)
+{
+#ifdef CONFIG_DCACHE_WORD_ACCESS
+	char *ptr;
+
+	/* The tag check is turned off for this load on arm64 with MTE. */
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
+
+	ptr = kmalloc(64, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	kfree(ptr);
+
+	OPTIMIZER_HIDE_VAR(ptr);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test,
+		kasan_int_result = load_unaligned_zeropad(ptr));
+#else
+	kunit_skip(test, "Test requires CONFIG_DCACHE_WORD_ACCESS=y");
+#endif
+}
+
 static void kasan_strings(struct kunit *test)
 {
 	char *ptr;
@@ -2264,6 +2287,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kasan_alloca_oob_right),
 	KUNIT_CASE(kasan_memchr),
 	KUNIT_CASE(kasan_memcmp),
+	KUNIT_CASE(kasan_load_unaligned_zeropad),
 	KUNIT_CASE(kasan_strings),
 	KUNIT_CASE(kasan_bitops_generic),
 	KUNIT_CASE(kasan_bitops_tags),

-- 
2.43.0

