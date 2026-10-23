Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720219;
	b=uTiARSuGx8Al1lrE/4Rn/JZYYkmO1iOfiOYBK3xthB+L3NbuhrBIPXojS7uLdryjqWTe
	 ahDo8BTijoOccX9QwxQ1g4fDAWJscsx6DXvYWqqryXXFab8XHiY/Wi0QkoA0UIweqcXzj
	 +7YpINEZ+n9s0nd7/V4Rzk7RB/YIp+cv+Gg5BZwELtK6W6WfBXQGGT6T1zM7OUoghA3o6
	 aHZ5Zq1mhn+iJncVlV0GHROcmMRExwS/3A1He1DBLCM7VdV57C6ATb1Ylale7hcaA7Ez4
	 nAYJ+LCZ8C/js7ECTMwwS5TJaPFWLu6pMMfSTDNjdQ77JiGULsifv6MsxeuZGSkfSjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=X468p48PfOB0WmzJ6kNGiEZKtoooeWVaYKhSdbR2LN8=;
	b=UjIvi/zK7DiRs72suW/q5Zh+8Oqac5hWuWgT+alBkl/7ELerC2LzasobDlFScOj4LAQ/
	 liYLa2CNmFeVMAuNXqSVvkgVfaT+PekV2wBLyZ/ChueRnvKserNPm930BMH9fSh+pvQSH
	 I3vmrka/aC1q2SZMZBUxMLF7Z6vLMWXI8N6UO+cImq8SlIZJWxIq/GvRxcvaBZ0dcZUm7
	 llMmG1bWq+PE+AWTqGbYAgNrI+qcQb3TfTov/K/jslCZqr4d4k69ZQoAq2nd8IcyFUq9j
	 9St2aWmycyM7McCQk+z4DWGail2/hEJbqM8JKsA8R4wbKdgfmzCnzQzmy8tTav5iogA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rp8a0nB0;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42F606A31E
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 01:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B42F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rp8a0nB0
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-368581df789so369540eec.1
        for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 18:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792720218; x=1793325018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X468p48PfOB0WmzJ6kNGiEZKtoooeWVaYKhSdbR2LN8=;
        b=Rp8a0nB0sJ+TJDR4hlmpgIpdVyGie5oBwLC0PFdydmMtqnyLfTvFup4nWx4OJIpd2D
         /0nqKXWsIu5jqq4imY11lyfjYev/8OExuK7Q/OxHuhOu+pzzZpTTeTiYx/F49RMSUzmt
         GccSr96gdC2DqGPOsPztHQgBSqn1ACJig8rztK0kgxx6Gea9Ck+5Xlj61UOtcZIedsp9
         2K8Mmg1SrottEj+86QdTk9X5iO+xMAXf8q0Rsd1uy/ZXcFhOOPsyHifwcG2ONoxKcfEW
         CpkDdF+5YUGAXHkpwXQORt34Ay1acS1LK0wiHEEbMpZhAYUW7HX3YNCtZr6OkoJjolGz
         H5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792720218; x=1793325018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X468p48PfOB0WmzJ6kNGiEZKtoooeWVaYKhSdbR2LN8=;
        b=R4KfZO2aDE8pYeStXB7rzxs5UlL9jQ95P+L8VJ+PKGAfUH1ocK1+AFCm5NIt1vx0Wb
         3ntsWAq8xI289CIeNoLHBAl8NgA5Zrt6qCmmgG+584qJqI0MtorGOc14RSyL1zd1qtYl
         /q1iZrIvDjTf4wCxCGw3LSaT3Gi8UcCJmopzaCyZDXYaXDyHJUdunO7Ri1znqbgb+v2P
         DSq8w/bISIMQ7AHb37sF4X4J1ne2c1sEMD5w4nQOHxuS8A98Vo4Tc+UPP+cSa80lp2WY
         1BErFPbXFwMi2MFaScDia3r2UnMZXM9tLbAR1FrK9m8U66gGGQAuWCZlPuAgx7+6xadu
         rC1Q==
X-Forwarded-Encrypted: i=1; AKwUvByT4GZrbDeg0gxKWIgj+NASoRYWyKw7aEg285qqj2pPzfmHiehBrInCAnESwmn0WOMdD4nw9HPrtoQX@vger.kernel.org
X-Gm-Message-State: AFq9FYJqLqnDHbkcm/SDKIpA+fDRRhJJfDVXkBMY5vU/4GAl3K0duNW8
	axVVpqZtCnahVJREC9f0JsNYPaNm79UkjRJoWnQEFEwYfXkyDkoQPtZW
X-Gm-Gg: AYBFou37ucNF/ukgo2lSyTU2htm9hhTw/o5ytapolGlLRmAyAXpp6qNnpIP7xUJmxvY
	tvJ3LXDdsGO9XMGsXpTPh4dflte7BQTjFglC7Srj05GIv1PeWOywfBEmak5bDMkjvN5IAj1iNyf
	9KgeIoj7QTLM+sE2dlD+bzcZGgY4od60XaAnPg2Uel9bCJyYp+B/y6UN64hI+3iKJw1wFd7gnKd
	fIwKDAbI//J4xCp9uymmjriK4zmJU2VggvHBAtLDa6/VtaZ32xXBNDrWeqvZyrLur3HhF8M6aXQ
	iuRID+9pxBu1CyW+eyc4y9MaQeWsleL9ns0iDGrXCA9i98xSJKGJ+VcPUGuT9b0idkbfuUb3xRW
	5bFFEMeToouAkbavQncWLasjmLuavC+GUyaqB8jZt1vFgbE61LaGYvxWIZ/z5MALt5I96MI+B+t
	Tb00gWD+uaWB0Iqlfk6dnasBX0sxWQhy3wvBH3vvck+UAZ1wCnWzLh19km4Xp6BuSevSNk7ojeb
	9Bspp0NAHLhdRCYpm8+2HIPkhyuw/TPTOQDZom2/ajdAoFeDhc=
X-Received: by 2002:a05:693c:69c3:b0:368:2c6d:ddfe with SMTP id 5a478bee46e88-368afd86765mr4796119eec.9.1792720218428;
        Thu, 22 Oct 2026 18:50:18 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9c0e60dsm1971091eec.2.2026.10.22.18.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:50:18 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 23 Oct 2026 09:49:49 +0800
Subject: [PATCH v2 2/2] kasan/test: cover load_unaligned_zeropad()
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
Message-Id: <20261023-bug-word-at-a-time-zeropad-kasan-v2-2-be0ecfbae847@gmail.com>
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
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
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

