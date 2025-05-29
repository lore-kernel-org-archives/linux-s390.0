Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21154256C87
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557203; cv=none; b=Xht8HOP+b1XzdUjPMOOeVIBTG17lAg1j51kuBJZzmvM0qFs9P9BvswTti/mEej2OyhQ3jJfu0BFCQCGoU+2Z5VWijgCfJokumMsLKFvZlmjy+NlGgTYX6tILRy+435Cpxmg6Z4lPr5YjJz/RSRpp9e31IlgMyW2Ww/ePJ8Mw4ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557203; c=relaxed/simple;
	bh=u5iff4gYUfJbV7gg7JGjHZ3YNRLHSbfTUIqRJoKJYyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LxeiqagcPzLTWJqmQr3AlTsu+V/Cp/LjAEl6RjehJCexaiSiVfsS/DlPQ3UKgVxJyoV08Rt3kR56+KuiNTSiXVB9uJgoY6UjgQM/ZNlTqZ7jNeAahORMoMIUlj+e5qXJPMve97JwdNYFgpIunnkuMkbRTNUUkhwqk7fIxVVNJ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TCPlUSB4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCPlUSB4"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-234d9b03dc4so11691435ad.0
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557201; x=1749162001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=h+zxmynRuus8JTcz4oQ0nDPY5j7Ch469QosRqaeXlg8=;
        b=TCPlUSB4AfzyENxs8SDs4BVl7Pkpnzl4WlVAw4U9toSx+JQ3vvkDSLEmS4bjXBUysS
         ArVBsvMt/FIOVWl0uz9225DQouYxR9hQ/Ck+0NHE9J/w9Mm8U5mMDDJpLVZAluDRfzFG
         N2eJJw3IlIF18TaQmL+JO2WQVOfscLPx8kzd02Ue9AafkqrNvI82K9qaCILoqbeNhdzY
         okyu/TuLaQ4SZu9StgGHYJbCr1oPMenJ7cZOT/GW2/FAXfBgEhNmT+df5//DWIGL6xR4
         j/SNCzkYmLJNzN3xkLeYfxrJzYCWmTMQ8Ymf7H9R8p2mdmOzgmhy+xnibdMggvMtsnYs
         BpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557201; x=1749162001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+zxmynRuus8JTcz4oQ0nDPY5j7Ch469QosRqaeXlg8=;
        b=bAXm7z5qrIfv2Q1dfeRqP8Xk/KTk7K0sDu+9avKj+E+wp2RU/lIjAPy4oGhkfjGGRq
         HqBzlmSxmV0a3NCfLermZ9JDL4FeSsfr3012BtM/Bi8qmKCua1tAGO1v/ZsSnn508CT5
         S0i5sw/qLMCTTzCApDxluHSWYkdlqfWd8YBjAn4nIsBY7jdIoB4Jv+g4P1a9p7wol7cT
         XSkeICb4TkoPWWsQ/URqaBMMuklCmsjbFDnmH5XyTt+0tRThUMDGdRocPkysMdS2sGnp
         N+0bpjh+kEc6oa82pbYrywli8p8dk64s0ZZQiGHEq9gZeEDjLLTevAn/Q+qopU901XhL
         8pwA==
X-Forwarded-Encrypted: i=1; AJvYcCXN5U2BtUyELfwUe+Q3ilYz0DLQKUWFHL1lFtT4Wr932dXepZp5Bcg6c9F98yJMASAA3QApIj2fM2cs@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9bPxOFwAyqejHkLRMsPaiE7qN6Z5hqv0mmT4VTzz4XkwblO3
	04g66KuKmktxIYP1iMjU/LGcB5S/LxvjtZsui9NDoCpvHY5zuIK2+SnjBMHxxvPTP20nG5+amwP
	M8Tye3w==
X-Google-Smtp-Source: AGHT+IGkWRHpejvhd2ldNGU9YUglc3/C3NmA+k/oaq+HdU4jZaE1V6i6HKiDHjwmfVv91+C2M/Od+vROETo=
X-Received: from plblh14.prod.google.com ([2002:a17:903:290e:b0:234:d2a4:ddf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc8f:b0:234:cc7c:d2fc
 with SMTP id d9443c01a7336-23529a0f482mr14516585ad.27.1748557201422; Thu, 29
 May 2025 15:20:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 15:19:25 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529221929.3807680-13-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 12/16] x86/sev: Skip the AMD SEV test if SEV is unsupported/disabled
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Skip the AMD SEV test if SEV is unsupported, as KVM-Unit-Tests typically
don't report failures if feature is missing.

Opportunistically use amd_sev_enabled() instead of duplicating all of its
functionality.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/amd_sev.c | 51 +++++++--------------------------------------------
 1 file changed, 7 insertions(+), 44 deletions(-)

diff --git a/x86/amd_sev.c b/x86/amd_sev.c
index 7757d4f8..4ec45543 100644
--- a/x86/amd_sev.c
+++ b/x86/amd_sev.c
@@ -15,51 +15,10 @@
 #include "x86/amd_sev.h"
 #include "msr.h"
 
-#define EXIT_SUCCESS 0
-#define EXIT_FAILURE 1
-
 #define TESTDEV_IO_PORT 0xe0
 
 static char st1[] = "abcdefghijklmnop";
 
-static int test_sev_activation(void)
-{
-	struct cpuid cpuid_out;
-	u64 msr_out;
-
-	printf("SEV activation test is loaded.\n");
-
-	/* Tests if CPUID function to check SEV is implemented */
-	cpuid_out = cpuid(CPUID_FN_LARGEST_EXT_FUNC_NUM);
-	printf("CPUID Fn8000_0000[EAX]: 0x%08x\n", cpuid_out.a);
-	if (cpuid_out.a < CPUID_FN_ENCRYPT_MEM_CAPAB) {
-		printf("CPUID does not support FN%08x\n",
-		       CPUID_FN_ENCRYPT_MEM_CAPAB);
-		return EXIT_FAILURE;
-	}
-
-	/* Tests if SEV is supported */
-	cpuid_out = cpuid(CPUID_FN_ENCRYPT_MEM_CAPAB);
-	printf("CPUID Fn8000_001F[EAX]: 0x%08x\n", cpuid_out.a);
-	printf("CPUID Fn8000_001F[EBX]: 0x%08x\n", cpuid_out.b);
-	if (!(cpuid_out.a & SEV_SUPPORT_MASK)) {
-		printf("SEV is not supported.\n");
-		return EXIT_FAILURE;
-	}
-	printf("SEV is supported\n");
-
-	/* Tests if SEV is enabled */
-	msr_out = rdmsr(MSR_SEV_STATUS);
-	printf("MSR C001_0131[EAX]: 0x%08lx\n", msr_out & 0xffffffff);
-	if (!(msr_out & SEV_ENABLED_MASK)) {
-		printf("SEV is not enabled.\n");
-		return EXIT_FAILURE;
-	}
-	printf("SEV is enabled\n");
-
-	return EXIT_SUCCESS;
-}
-
 static void test_sev_es_activation(void)
 {
 	if (rdmsr(MSR_SEV_STATUS) & SEV_ES_ENABLED_MASK) {
@@ -88,10 +47,14 @@ static void test_stringio(void)
 
 int main(void)
 {
-	int rtn;
-	rtn = test_sev_activation();
-	report(rtn == EXIT_SUCCESS, "SEV activation test.");
+	if (!amd_sev_enabled()) {
+		report_skip("AMD SEV not enabled\n");
+		goto out;
+	}
+
 	test_sev_es_activation();
 	test_stringio();
+
+out:
 	return report_summary();
 }
-- 
2.49.0.1204.g71687c7c1d-goog

