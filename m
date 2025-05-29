Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65AA21D5A9
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557184; cv=none; b=XWxCRjJRUHz8rH7zFS3knUTTA6Ebc/I1T+5XF4YfVI3gThjiELdjzxOo+Qof6HSrpUJoLh+iTxArElSfn4dZefiFMhc7CdgO6AkIoeIYZJySen9vPL9vbB3TmHaWiGtx54K63Uck3cRMHQg0QZXSwIj8dDl0uMq8J+tavdx3fFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557184; c=relaxed/simple;
	bh=R5SmfkwxyjvbLpRjEAybIaAQLpf9mthHqTuwr4++6oE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RxbCr46h8fKaUhKUz8acDD4SeOzSflKs75bnBnfBD8UZh+fXN3vNlzsBBcbWEr362G5gE5/YFeYqnV1LyMSqA3LdXWHP7OsVTbgggBdQZJam9HJrhsYy65tGgDDMOcz/16oyQ0t4ULzfnP0KendutMBZBLV0xZr7/clrOISg2NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvXz8Hbv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvXz8Hbv"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-310efe825ccso1331987a91.3
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557182; x=1749161982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rpZO/SNMSsOcnIVwvmjBs9Kka2MdSZSqrGAzddRxVBc=;
        b=fvXz8Hbv89UxSet92pFYHa8TVanX4NiXWffsIWTV7IC6C6uFNU9P58FqwENNVdvS9J
         YuyBkejAM4wqZpl1cVrBn94i1TOKik8og1pjjGns3ElyaBu3+jfRol47CxM7HnNBAVhR
         RXbTXWgm+L/kJ1T7WjbEsbS9OvcXhITX+dPVFdBPr+iJzSneHANuuDR+6UIlXHIFU/gb
         wZz7nA49i6HJu+Z0v1ykElmtkh17WrcLuuf2Bd8oXuYbSluUJkAnapoAd1B4sFGtT8Ku
         9ImngV/07Yb4trmKieFukBg4DtJS8XDdoDOEMhqcZ89VF4zWsQnBnThUNeP1ttgbe6zC
         nOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557182; x=1749161982;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpZO/SNMSsOcnIVwvmjBs9Kka2MdSZSqrGAzddRxVBc=;
        b=ebBsr5RvLQt16DlgZT8sn3UH0hyImtRle+DHsa47b/RJwyQ5Z98WqQB/swYDvzfYQj
         CPCunISHdyQJ7mnLT84Iuva2A7w6lE//YtPzRYgOs/uWetxmRztpEpPds2lbQJN2kiwk
         Xil5lwUT8mZRYXgB7VsTvN1eKUv5RqyI5SpHOBQPLc/7KhNHYZHIi3XenBTBAlgG1yzU
         7m8PLGc8ET7ylvbcRVYbal4EzPtW8+G/xAGX0HYnc7i0UFRHLE2NHL5w1uKeM69oXEla
         LG+dI9GCK+pNOjjQ12uhdn8VQQ8C8NTgVetSdwyfph0C7pBYUqzmNCX86QbToo7z5BHr
         2FSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGAPcKfMsl9bLAK8I4SfTps69+4PLWt35+Ad2dQh2X+p5xIsA6h9MXwtFS+WEsu190tuvh78IqbloM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1DnNrLY6e6TUdP5PpdafXmFqNFixrQ+EkKMpz/2UV0nKX4sXt
	0IW+1P7Vs5ZeDs5kQZdFwHVzD5Ddss4Yi0G0rDV4JlSU9nhfMAmK1Wl2T0Lz/+Do2DQeMz3V33e
	IqTkYBw==
X-Google-Smtp-Source: AGHT+IEFFQIS9pAD1OtOGGAF6xmOZ0qMis9t3+vFz2wQSGrnYMTgXB8pN/6JJfuvmcH9p/ci+jWPOkR4qYg=
X-Received: from pjtq15.prod.google.com ([2002:a17:90a:c10f:b0:311:e9bb:f8d4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:510c:b0:311:e8cc:4264
 with SMTP id 98e67ed59e1d1-3124152923amr1943106a91.12.1748557182148; Thu, 29
 May 2025 15:19:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 15:19:14 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529221929.3807680-2-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 01/16] lib: Add and use static_assert()
 convenience wrappers
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Add static_assert() to wrap _Static_assert() with stringification of the
tested expression as the assert message.  In most cases, the failed
expression is far more helpful than a human-generated message (usually
because the developer is forced to add _something_ for the message).

For API consistency, provide a double-underscore variant for specifying a
custom message.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/riscv/asm/isa.h      | 4 +++-
 lib/s390x/asm/arch_def.h | 6 ++++--
 lib/s390x/fault.c        | 3 ++-
 lib/util.h               | 3 +++
 x86/lam.c                | 4 ++--
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/lib/riscv/asm/isa.h b/lib/riscv/asm/isa.h
index df874173..fb3af67d 100644
--- a/lib/riscv/asm/isa.h
+++ b/lib/riscv/asm/isa.h
@@ -1,7 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef _ASMRISCV_ISA_H_
 #define _ASMRISCV_ISA_H_
+
 #include <bitops.h>
+#include <util.h>
 #include <asm/setup.h>
 
 /*
@@ -14,7 +16,7 @@ enum {
 	ISA_SSTC,
 	ISA_MAX,
 };
-_Static_assert(ISA_MAX <= __riscv_xlen, "Need to increase thread_info.isa");
+__static_assert(ISA_MAX <= __riscv_xlen, "Need to increase thread_info.isa");
 
 static inline bool cpu_has_extension(int cpu, int ext)
 {
diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index 03adcd3c..4c11df74 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -8,6 +8,8 @@
 #ifndef _ASMS390X_ARCH_DEF_H_
 #define _ASMS390X_ARCH_DEF_H_
 
+#include <util.h>
+
 struct stack_frame {
 	struct stack_frame *back_chain;
 	uint64_t reserved;
@@ -62,7 +64,7 @@ struct psw {
 	};
 	uint64_t	addr;
 };
-_Static_assert(sizeof(struct psw) == 16, "PSW size");
+static_assert(sizeof(struct psw) == 16);
 
 #define PSW(m, a) ((struct psw){ .mask = (m), .addr = (uint64_t)(a) })
 
@@ -194,7 +196,7 @@ struct lowcore {
 	uint8_t		pad_0x1400[0x1800 - 0x1400];	/* 0x1400 */
 	uint8_t		pgm_int_tdb[0x1900 - 0x1800];	/* 0x1800 */
 } __attribute__ ((__packed__));
-_Static_assert(sizeof(struct lowcore) == 0x1900, "Lowcore size");
+static_assert(sizeof(struct lowcore) == 0x1900);
 
 extern struct lowcore lowcore;
 
diff --git a/lib/s390x/fault.c b/lib/s390x/fault.c
index a882d5d9..ad5a5f66 100644
--- a/lib/s390x/fault.c
+++ b/lib/s390x/fault.c
@@ -9,6 +9,7 @@
  */
 #include <libcflat.h>
 #include <bitops.h>
+#include <util.h>
 #include <asm/arch_def.h>
 #include <asm/page.h>
 #include <fault.h>
@@ -40,7 +41,7 @@ static void print_decode_pgm_prot(union teid teid)
 			"LAP",
 			"IEP",
 		};
-		_Static_assert(ARRAY_SIZE(prot_str) == PROT_NUM_CODES, "ESOP2 prot codes");
+		static_assert(ARRAY_SIZE(prot_str) == PROT_NUM_CODES);
 		int prot_code = teid_esop2_prot_code(teid);
 
 		printf("Type: %s\n", prot_str[prot_code]);
diff --git a/lib/util.h b/lib/util.h
index f86af6d3..00d0b47d 100644
--- a/lib/util.h
+++ b/lib/util.h
@@ -8,6 +8,9 @@
  * This work is licensed under the terms of the GNU LGPL, version 2.
  */
 
+#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
+#define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
+
 /*
  * parse_keyval extracts the integer from a string formatted as
  * string=integer. This is useful for passing expected values to
diff --git a/x86/lam.c b/x86/lam.c
index a1c98949..ad91deaf 100644
--- a/x86/lam.c
+++ b/x86/lam.c
@@ -13,6 +13,7 @@
 #include "libcflat.h"
 #include "processor.h"
 #include "desc.h"
+#include <util.h>
 #include "vmalloc.h"
 #include "alloc_page.h"
 #include "vm.h"
@@ -236,8 +237,7 @@ static void test_lam_user(void)
 	 * address for both LAM48 and LAM57.
 	 */
 	vaddr = alloc_pages_flags(0, AREA_NORMAL);
-	_Static_assert((AREA_NORMAL_PFN & GENMASK(63, 47)) == 0UL,
-			"Identical mapping range check");
+	static_assert((AREA_NORMAL_PFN & GENMASK(63, 47)) == 0UL);
 
 	/*
 	 * Note, LAM doesn't have a global control bit to turn on/off LAM
-- 
2.49.0.1204.g71687c7c1d-goog

