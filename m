Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133F21FF2E
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557191; cv=none; b=I4EnIs1blZ3tNViSAAFUorViBzVW2vZXgXpEiaPdJNfoaoNLYpKE4ZKrH9yBwGzD6S/EkUhMO1TX7uVw8srKMb/YSG3pIx1WI+yS0aPw1kyFmH1oeg6mln/4uvHNGW5QCCvQqZgdWKbOfgZXj3Da5vgGhebM813UH5Z3dHPx2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557191; c=relaxed/simple;
	bh=oYEMXcIJySo9ImH8QfId6rOqp95GJ73rKTfhfbL0RVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l4phc9VBNTXv067Rmw4DfYKB3Z+GDnPNQTKw+muNUKc+N9ICsE8RcY7iOt1CwuN4Pg3ZAItARcxk7aSAJD/7LP2NohXCH1RlXxQ7X4XQnksDnTPMKNLGm1EYaaaqd8LDpGCXxJoMF1yYAp6jk0Y6piCF7i4EKSK/WpoCz91VYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvUfpXqI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvUfpXqI"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7394792f83cso1067190b3a.3
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 15:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557189; x=1749161989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=79QgatSeJLN29Injm6R2SZu0EHopaY7TBBxJACXb4Ts=;
        b=JvUfpXqIMfO4XZq6LG8+kmCBd2yffybEu/h0uVwRe7cvibxJONXauosh11E8glnBnm
         +W9Lilmfim/xf73+4UdfTUaGA7kpxR19Lnz9H/0LjJiX+ONgwDVirNMz9G4QwTiCr7SF
         t0VMZLhraP3DclDs/+QNOAtKOarDCpT6EGQAlux3J9Gv0A4KhhWufWORX9cXCDcuHMBh
         CtNmpHKAMuuAF4B5NwhbT8dP5mx9TLvA3iIK8+ZAwXKln4BFv6BIdHRQ0HjPaw6Yx7Rw
         +8wriuTq/qBe4St3UC576kgs55EP4FioN5IWP1/Qb0zx0cKB7mEUNNmWvXLsAiDISSvo
         A1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557189; x=1749161989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79QgatSeJLN29Injm6R2SZu0EHopaY7TBBxJACXb4Ts=;
        b=b7xcwatmsyc3qik3hfrheGLRK7AEXEE3mgPqEysP1J8Wu0dXXce+x/45wA3R8NlyVD
         SHNOU+iFZuTUyCycyTAVKrFRrdX4O4KtmuoG07NqLRfxhmJ9RwAjt8ZaKbRtSfJq4uCe
         UBfCnJ4XLXSaDdGcQSlo6rOUz87Q0KisOn1qucFabV7Ux+IWJu/bL4cxknFSXg8U8olP
         cEaeAX3rHlO+fmbC5shDKfcq3JtxRWLeVeG1x3USKIOIXl/keJYaNn360FS6+kalPaKa
         5on8VPt4YiUAezRtxPviDNtiHckXQZ7v9U1RimPbf2x/HEdd4kL8yctlWe144tUX4Ycj
         zziA==
X-Forwarded-Encrypted: i=1; AJvYcCX1f0wnxL8MBC+alYmtkKqpIEnX9UP8EaNIyezHKO7wNZPjZMK/4OhK7bxGArb7Cd8gNGJaX0e9qeSa@vger.kernel.org
X-Gm-Message-State: AOJu0YyijWdbKNohCmoF5MWic6ji7nomcSHuVLFHCdyEai+44fpNtcnb
	ethtpeVJjDB9M7hwus3ykSevK53bHiB1xTbhxXtzV4sVn+PPcinhO1kKv6XEQ+Ld8qDuM/OTLRK
	H4pe4nw==
X-Google-Smtp-Source: AGHT+IERht/QFRNHXBL3PGB3MEbLnWa68nmJAExKTfIaTPNzcYbSyNcF1baKmwu1g1rTX4sJ25Ap36OE6mM=
X-Received: from pgbcq12.prod.google.com ([2002:a05:6a02:408c:b0:b2c:4476:f3fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1583:b0:218:76dd:a66
 with SMTP id adf61e73a8af0-21ad95636d1mr1858084637.13.1748557189150; Thu, 29
 May 2025 15:19:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 15:19:18 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529221929.3807680-6-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 05/16] x86: Implement get_supported_xcr0()
 using X86_PROPERTY_SUPPORTED_XCR0_{LO,HI}
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Use X86_PROPERTY_SUPPORTED_XCR0_{LO,HI} to implement get_supported_xcr0().

Opportunistically rename the helper and move it to processor.h.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/processor.h |  9 +++++++++
 x86/xsave.c         | 11 +----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/x86/processor.h b/lib/x86/processor.h
index 8c6f28a3..cbfd2ee1 100644
--- a/lib/x86/processor.h
+++ b/lib/x86/processor.h
@@ -442,6 +442,15 @@ static inline u8 cpuid_maxphyaddr(void)
 	return this_cpu_property(X86_PROPERTY_MAX_PHY_ADDR);
 }
 
+static inline u64 this_cpu_supported_xcr0(void)
+{
+	if (!this_cpu_has_p(X86_PROPERTY_SUPPORTED_XCR0_LO))
+		return 0;
+
+	return (u64)this_cpu_property(X86_PROPERTY_SUPPORTED_XCR0_LO) |
+	       ((u64)this_cpu_property(X86_PROPERTY_SUPPORTED_XCR0_HI) << 32);
+}
+
 struct far_pointer32 {
 	u32 offset;
 	u16 selector;
diff --git a/x86/xsave.c b/x86/xsave.c
index 5d80f245..cc8e3a0a 100644
--- a/x86/xsave.c
+++ b/x86/xsave.c
@@ -8,15 +8,6 @@
 #define uint64_t unsigned long long
 #endif
 
-static uint64_t get_supported_xcr0(void)
-{
-    struct cpuid r;
-    r = cpuid_indexed(0xd, 0);
-    printf("eax %x, ebx %x, ecx %x, edx %x\n",
-            r.a, r.b, r.c, r.d);
-    return r.a + ((u64)r.d << 32);
-}
-
 #define XCR_XFEATURE_ENABLED_MASK       0x00000000
 #define XCR_XFEATURE_ILLEGAL_MASK       0x00000010
 
@@ -33,7 +24,7 @@ static void test_xsave(void)
 
     printf("Legal instruction testing:\n");
 
-    supported_xcr0 = get_supported_xcr0();
+    supported_xcr0 = this_cpu_supported_xcr0();
     printf("Supported XCR0 bits: %#lx\n", supported_xcr0);
 
     test_bits = XSTATE_FP | XSTATE_SSE;
-- 
2.49.0.1204.g71687c7c1d-goog

