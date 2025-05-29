Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BB9256C93
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557205; cv=none; b=f/jJX9eGoAG7Gw1EGhevDVCX7oDSx+h7U4m1rhQiKGhV9nZbqdCpm71x+rIe8lmsqcPpEnKRKnfrXkCb5p12DYDe2OYUIi/pOY1BkCMNtot3hpcegqcu1ugzUlZYAClQMy2q+q5FO+zEOXNqbJnVLCscg1Y7ghVhQ4jdBDPAUkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557205; c=relaxed/simple;
	bh=Lyl3vewjVix2xPFAB4EoOJOuA3lhOivqiAsQEY0yo0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PcSo0DZ7E7ZM8nZ1ZyKYCSvh0PGiekZIiGk7DLR+1swV15gSu/ZS6AkuRmp81EHgtlJg88Sz5xLm/kyuFJ+ej7NLhkOSVmbWB7wG/4cc8QASw/rjqvLqquwzoOTxryvN+DuU8PpUcofA83XPrsrI72QtQIPOiwpwUWjt6xLrXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nv4jRjr9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nv4jRjr9"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311b6d25278so1413511a91.3
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 15:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557203; x=1749162003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=F2d3FMlUAt4L7Za+Jh9OinkPv4ozyteBA1ro5arBIes=;
        b=nv4jRjr9luv6nTlH4PeNdUtcBdNJUqi9zy2OeMMtDsw7KQFxDTKsLk7Cp563MfvSFT
         GLiSnpXlp7RwiD9YBMemZCyyfxWNIRcj4xXq6UbAdFnAvQFhYJEXdPlTFBMsXCsBImFF
         URFkAEUEJEgBvcbOwpiembGAjR1q+PBLqqg410bnwuYcjQIQP45gMI5dES4HZM+cwOax
         AV+p2x8Owolm9gKnk/ykujsQNQrblNsgooTNGqC/8i7Ip63sQ25ahGA24NVz7Kz8G7JC
         vVn1BqCYKSayBQCHDuMD9DJdcC5jYVVNYbgS6CAfQBHeGvU9HOcZQdwekidcxplaV9zV
         hEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557203; x=1749162003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2d3FMlUAt4L7Za+Jh9OinkPv4ozyteBA1ro5arBIes=;
        b=ulcnEYrFTujgExL3+3vZJ6vgV2QpsTCt3RjoWQyhr8LkK7e6l88BxCI4JvqVGVvf5o
         AqvXMJMSyLdjIqB3wg3NuLn9NT9sktFihbt/DrK5zlVIn1/fbvEki84tc3QRlCGaN1uJ
         iCyB2Wl2Iu0z9UvAHzrbvyhNZc87nIAlCJoT4ER88F009DUwGIyf0yHMsy3ZSdTePewn
         BAMUnA66NlCkPUkX5bgAqgFoWyJ6vPBDDBT4I/yLQbIdPoKbsG/PveW0PNMo6gzZUlej
         nMa5uIznenCR0UCLozvyHOOzyGN1MwQlRXlq/JY0E6owZGRdhOjNIshOLt1qUTeBh+g6
         1s/g==
X-Forwarded-Encrypted: i=1; AJvYcCVTPg0sz+QPtiAKrmk6bUXJL2Z2ESfK5SPSew1GEL1M+btrmiP5lxQDACnQe13dF3cuQbd/qkndzzTs@vger.kernel.org
X-Gm-Message-State: AOJu0YxuPdX27jodI+jat0+26y6oR+4vR/f0dxbT2TqLcOgXgghxuoLm
	jwvKSfKCNtO3wOBksV1PadC05egNBgJVnjk0S/Sy5fMHtX6El67mkKfmgGhC/LGZR++as2qjLnt
	8gwthag==
X-Google-Smtp-Source: AGHT+IGoB/vbp1vJwFtNq0D8Lm/f9YbFu83f0096VeeEb6qVMP4bkif1kVwjiObKHv+nfsOeM8aSdayaAmU=
X-Received: from pjbsv7.prod.google.com ([2002:a17:90b:5387:b0:311:e7e6:6d4d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dcb:b0:312:e9d:3ff2
 with SMTP id 98e67ed59e1d1-3124150da88mr1962364a91.7.1748557202894; Thu, 29
 May 2025 15:20:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 15:19:26 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529221929.3807680-14-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 13/16] x86/sev: Define and use X86_FEATURE_*
 flags for CPUID 0x8000001F
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Define proper X86_FEATURE_* flags for CPUID 0x8000001F, and use them
instead of open coding equivalent checks in amd_sev_{,es_}enabled().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/amd_sev.c   | 32 +++++---------------------------
 lib/x86/amd_sev.h   |  3 ---
 lib/x86/processor.h |  9 +++++++++
 3 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/lib/x86/amd_sev.c b/lib/x86/amd_sev.c
index 6c0a66ac..4e89c84c 100644
--- a/lib/x86/amd_sev.c
+++ b/lib/x86/amd_sev.c
@@ -17,31 +17,15 @@ static unsigned short amd_sev_c_bit_pos;
 
 bool amd_sev_enabled(void)
 {
-	struct cpuid cpuid_out;
 	static bool sev_enabled;
 	static bool initialized = false;
 
 	/* Check CPUID and MSR for SEV status and store it for future function calls. */
 	if (!initialized) {
-		sev_enabled = false;
 		initialized = true;
 
-		/* Test if we can query SEV features */
-		cpuid_out = cpuid(CPUID_FN_LARGEST_EXT_FUNC_NUM);
-		if (cpuid_out.a < CPUID_FN_ENCRYPT_MEM_CAPAB) {
-			return sev_enabled;
-		}
-
-		/* Test if SEV is supported */
-		cpuid_out = cpuid(CPUID_FN_ENCRYPT_MEM_CAPAB);
-		if (!(cpuid_out.a & SEV_SUPPORT_MASK)) {
-			return sev_enabled;
-		}
-
-		/* Test if SEV is enabled */
-		if (rdmsr(MSR_SEV_STATUS) & SEV_ENABLED_MASK) {
-			sev_enabled = true;
-		}
+		sev_enabled = this_cpu_has(X86_FEATURE_SEV)
+			      rdmsr(MSR_SEV_STATUS) & SEV_ENABLED_MASK);
 	}
 
 	return sev_enabled;
@@ -72,17 +56,11 @@ bool amd_sev_es_enabled(void)
 	static bool initialized = false;
 
 	if (!initialized) {
-		sev_es_enabled = false;
 		initialized = true;
 
-		if (!amd_sev_enabled()) {
-			return sev_es_enabled;
-		}
-
-		/* Test if SEV-ES is enabled */
-		if (rdmsr(MSR_SEV_STATUS) & SEV_ES_ENABLED_MASK) {
-			sev_es_enabled = true;
-		}
+		sev_es_enabled = amd_sev_enabled() &&
+				 this_cpu_has(X86_FEATURE_SEV_ES) &&
+				 rdmsr(MSR_SEV_STATUS) & SEV_ES_ENABLED_MASK;
 	}
 
 	return sev_es_enabled;
diff --git a/lib/x86/amd_sev.h b/lib/x86/amd_sev.h
index ca7216d4..defcda75 100644
--- a/lib/x86/amd_sev.h
+++ b/lib/x86/amd_sev.h
@@ -21,12 +21,9 @@
 
 /*
  * AMD Programmer's Manual Volume 3
- *   - Section "Function 8000_0000h - Maximum Extended Function Number and Vendor String"
  *   - Section "Function 8000_001Fh - Encrypted Memory Capabilities"
  */
-#define CPUID_FN_LARGEST_EXT_FUNC_NUM 0x80000000
 #define CPUID_FN_ENCRYPT_MEM_CAPAB    0x8000001f
-#define SEV_SUPPORT_MASK              0b10
 
 /*
  * AMD Programmer's Manual Volume 2
diff --git a/lib/x86/processor.h b/lib/x86/processor.h
index 3b02a966..b656ebf6 100644
--- a/lib/x86/processor.h
+++ b/lib/x86/processor.h
@@ -320,6 +320,15 @@ struct x86_cpu_feature {
 #define X86_FEATURE_PFTHRESHOLD		X86_CPU_FEATURE(0x8000000A, 0, EDX, 12)
 #define	X86_FEATURE_VGIF		X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
 #define X86_FEATURE_VNMI		X86_CPU_FEATURE(0x8000000A, 0, EDX, 25)
+#define X86_FEATURE_SME			X86_CPU_FEATURE(0x8000001F, 0, EAX,  0)
+#define X86_FEATURE_SEV			X86_CPU_FEATURE(0x8000001F, 0, EAX,  1)
+#define X86_FEATURE_VM_PAGE_FLUSH	X86_CPU_FEATURE(0x8000001F, 0, EAX,  2)
+#define X86_FEATURE_SEV_ES		X86_CPU_FEATURE(0x8000001F, 0, EAX,  3)
+#define X86_FEATURE_SEV_SNP		X86_CPU_FEATURE(0x8000001F, 0, EAX,  4)
+#define X86_FEATURE_V_TSC_AUX		X86_CPU_FEATURE(0x8000001F, 0, EAX,  9)
+#define X86_FEATURE_SME_COHERENT	X86_CPU_FEATURE(0x8000001F, 0, EAX, 10)
+#define X86_FEATURE_DEBUG_SWAP		X86_CPU_FEATURE(0x8000001F, 0, EAX, 14)
+#define X86_FEATURE_SVSM		X86_CPU_FEATURE(0x8000001F, 0, EAX, 28)
 #define	X86_FEATURE_AMD_PMU_V2		X86_CPU_FEATURE(0x80000022, 0, EAX, 0)
 
 /*
-- 
2.49.0.1204.g71687c7c1d-goog

