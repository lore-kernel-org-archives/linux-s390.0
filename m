Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3617F257ACF
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557209; cv=none; b=uevOhdlNUjL0PAYeDx3O8a9pkrJuWW6wCF2Z6MTxFZpzMWICVodARV0+meS6s8HZIaNFVa90gt/BziX7rCQJZPivAL3YAYK78pRCLbmsQ7qIvX4FFduZSm+U4YlHtj7vz1HNUlX8EfwCcKlGMiLYlEXA4Ix/rvsNLkXHPkyGG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557209; c=relaxed/simple;
	bh=RvX2iZNZlxxVlbsJrrFpRWGiCNBMJyjPqyAtCV5bQdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EvkT8Qct41igZttiCKvWmpfkIT0ybVMGAQN6+px1WU1wH1z9/tw+z+Q6kElUeUwgRw+dNOFrKnWGU009q+Zl3AbmeAYSN1Z6/8zjcTYqgsWjfiEgkD6Yjy3/ZItExGTZFvEbAuJReRdiAQssAnUCowi2gyAjw9/Cbhh/eIiyqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOy9L0uP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOy9L0uP"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311fa374c2fso1847467a91.2
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 15:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557207; x=1749162007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NK0WfiQ6dMxac+ln2k79b2QCfH8r8iVJ+iQJS1T9rfM=;
        b=OOy9L0uPmyWNJMZVK6z6aj6pAaLTKE9Qq4573Ni0dSm6Tl+i+MgotFkKLzo3KCDihF
         ICbNPqWMhj5d7J8MpxQKpkBfgFWeZg45EtobHmTQXpkjpqM9OiXmRflvkWHxw8UWpuLL
         fn5RyESyqjhmn+WJPszMjpWjhd9sFmGbuFIvLzPu61XXHvXzK85W6K6PPzUZCr2R7h2I
         0j1cCkLaBHSTmsff4VyG85f7Kha8Mz0hZCK7Idqdc1Fa5BYChSbbro5tW5DeJVmlpoTs
         gaLQTIXAQmC7LAjQ7KYl02FmCErD0SUUyCO7bd3yMCKST/WbB1oODZqr/beqM9YMcEuK
         9p1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557207; x=1749162007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NK0WfiQ6dMxac+ln2k79b2QCfH8r8iVJ+iQJS1T9rfM=;
        b=oIGU6hO7sdYdvzGouEw9FEDI1ahfnJ2Qd6EXp59OSUCZYT7wMJqF/nO0EmP8xGnHe3
         +Uh3OwRJWNFp3lMnpJE21XWPfvLOlqjntrmfRACCRQH1jR7gkP/omk1zq2wuBhi2FJb6
         wQeMX9iG6Uf0rNWwDeqdMreePIs5NhDC//k0UgtsDK6kTEq5pMWATuq/B/r9nsqTU5I6
         Q8Y+wjpEXE6ShZodVp/EbM1oyG07eEo+ZsEUVaoIJQeJ+xFc7oJQW2RqbTs7FFTR81S1
         YGJJs5ySf07XcuS1uW9t0KHS4+U32M4C2+REzYqWvoVclejYgTiCVs1xnd6rbGPiJ2pO
         HMEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2kCrxcRc470tkMl3Rr3s5jxHWV+x7/4G8+Hn+0RyD+m3HA9Ojhl2Bmc6TctKRdFcA6T8W5wbXxYDW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wpmWt+SGbROfsorAHiuRJooqj+vQ7SuqIBuycyachqxr0Gaa
	qli7IXTTEztDZVDgAvnI4o4tEm0WUYJVW/BLnV/q1SvjeNIdDSsFV4vvyqVoqzcdy2+C52ENCvn
	xgzsi1g==
X-Google-Smtp-Source: AGHT+IFrtz3sUzxuEz8YBbvvRR3+9tjsalY/Vak8TsELyOUfiAWzp5Y7ZOMIrESTx91f0Vlh2H9ZLU4kNZc=
X-Received: from pjyp7.prod.google.com ([2002:a17:90a:e707:b0:312:4274:c4ce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e09:b0:311:9c1f:8516
 with SMTP id 98e67ed59e1d1-31241518d5cmr1855970a91.15.1748557207601; Thu, 29
 May 2025 15:20:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 15:19:29 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529221929.3807680-17-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 16/16] x86: Move SEV MSR definitions to msr.h
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the SEV MSR definitions to msr.h so that they're available for non-EFI
builds.  There is nothing EFI specific about the architectural definitions.

Opportunistically massage the names to align with existing style.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/amd_sev.c |  8 ++++----
 lib/x86/amd_sev.h | 14 --------------
 lib/x86/msr.h     |  6 ++++++
 3 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/lib/x86/amd_sev.c b/lib/x86/amd_sev.c
index 416e4423..7c6d2804 100644
--- a/lib/x86/amd_sev.c
+++ b/lib/x86/amd_sev.c
@@ -24,8 +24,8 @@ bool amd_sev_enabled(void)
 	if (!initialized) {
 		initialized = true;
 
-		sev_enabled = this_cpu_has(X86_FEATURE_SEV)
-			      rdmsr(MSR_SEV_STATUS) & SEV_ENABLED_MASK);
+		sev_enabled = this_cpu_has(X86_FEATURE_SEV) &&
+			      rdmsr(MSR_SEV_STATUS) & SEV_STATUS_SEV_ENABLED;
 	}
 
 	return sev_enabled;
@@ -52,7 +52,7 @@ bool amd_sev_es_enabled(void)
 
 		sev_es_enabled = amd_sev_enabled() &&
 				 this_cpu_has(X86_FEATURE_SEV_ES) &&
-				 rdmsr(MSR_SEV_STATUS) & SEV_ES_ENABLED_MASK;
+				 rdmsr(MSR_SEV_STATUS) & SEV_STATUS_SEV_ES_ENABLED;
 	}
 
 	return sev_es_enabled;
@@ -100,7 +100,7 @@ void setup_ghcb_pte(pgd_t *page_table)
 	pteval_t *pte;
 
 	/* Read the current GHCB page addr */
-	ghcb_addr = rdmsr(SEV_ES_GHCB_MSR_INDEX);
+	ghcb_addr = rdmsr(MSR_SEV_ES_GHCB);
 
 	/* Search Level 1 page table entry for GHCB page */
 	pte = get_pte_level(page_table, (void *)ghcb_addr, 1);
diff --git a/lib/x86/amd_sev.h b/lib/x86/amd_sev.h
index daa33a05..9d587e2d 100644
--- a/lib/x86/amd_sev.h
+++ b/lib/x86/amd_sev.h
@@ -19,23 +19,9 @@
 #include "asm/page.h"
 #include "efi.h"
 
-/*
- * AMD Programmer's Manual Volume 2
- *   - Section "SEV_STATUS MSR"
- */
-#define MSR_SEV_STATUS      0xc0010131
-#define SEV_ENABLED_MASK    0b1
-#define SEV_ES_ENABLED_MASK 0b10
-
 bool amd_sev_enabled(void);
 efi_status_t setup_amd_sev(void);
 
-/*
- * AMD Programmer's Manual Volume 2
- *   - Section "GHCB"
- */
-#define SEV_ES_GHCB_MSR_INDEX 0xc0010130
-
 bool amd_sev_es_enabled(void);
 efi_status_t setup_amd_sev_es(void);
 void setup_ghcb_pte(pgd_t *page_table);
diff --git a/lib/x86/msr.h b/lib/x86/msr.h
index 658d237f..ccfd6bdd 100644
--- a/lib/x86/msr.h
+++ b/lib/x86/msr.h
@@ -523,4 +523,10 @@
 #define MSR_VM_IGNNE                    0xc0010115
 #define MSR_VM_HSAVE_PA                 0xc0010117
 
+#define MSR_SEV_STATUS			0xc0010131
+#define SEV_STATUS_SEV_ENABLED		BIT(0)
+#define SEV_STATUS_SEV_ES_ENABLED	BIT(1)
+
+#define MSR_SEV_ES_GHCB			0xc0010130
+
 #endif /* _X86_MSR_H_ */
-- 
2.49.0.1204.g71687c7c1d-goog

