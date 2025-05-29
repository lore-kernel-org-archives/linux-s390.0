Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE98F21FF20
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557200; cv=none; b=oTYEhlRSyTW2K11u53OQOOLuTpGRvuihLsjctT0gmLuDLKM9qLEZKZe0IbfOEBnYDWs4dyXHoERI2W6IluWvdC7cWjmmwj/QUibsZU12SbTURjmGuQiF4/Mek/otHgsQxfOuhqErEaWYVsgicpZEicArWpQ9JW78w413HtDfxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557200; c=relaxed/simple;
	bh=PVWqEkBRnDvF161vQMRHqA95hOPhJRH9h33sXL5rRbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bfvuiQzJ2sIZVeGPWhRAd7Qht+MsDVwICvJzqGA6S6rP9zkZXkFb+kH/18tcu4bm4NcgGWOwEirtKTIgXAXZsLRoxG65GNGPFVQOfLr6TE+ABwf1uB0QF4+Agk3lCCHGqxknSC87spivKXYY9/1T7L+VTetMRREMdK41EaKXEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BJfcUuSO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJfcUuSO"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311ae2b6647so1150256a91.0
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 15:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557198; x=1749161998; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vNslUGWw1CMVPjS9VIQPMuWCe949NCq6H3qTd+RjZjs=;
        b=BJfcUuSO4EebjH4RLdr59mL+32ahbpyEl8HWK4RxXxCKU8/Pj/l3fQ7woF/VLx666B
         o9IwnQRP0kSP9m5PMtWIKM9upGTsAUMIQXroBdkhWpA9l7cFP99uHzu2TK+KKkL4DwgH
         C+NkOpVGwF1ZhzubTLlMOEiXBhi35M0meFqR/Nnsy6hrxogQLiElKwdsk4nPZAdGZKeM
         5zxa/60Wy2DfCWoMSh6LhWhx6qJgaK8NUnQPBeUsx4Ikzm5jU6kCQxuLspH83VoC7GR1
         8x6LGH6oRAkXjvVFrYl+WC0i8nAt6Zr6XqmUOKrYc2JMTnxsYi+we3utGpbrgdOjwk+A
         XPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557198; x=1749161998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNslUGWw1CMVPjS9VIQPMuWCe949NCq6H3qTd+RjZjs=;
        b=SzKIBdt0YrDkz+pqqyUO1OK+YxA5/KvcRiqq5lDR5w++OZ2Gsx3U1cuuXwGMM50N6h
         GdFRHqJZQTOqX4ZogVtFUf3WeNsJ0iYyMEzs4Gc5ROUtSJF/KJXnamDlMbjJcctJqRNb
         gNtiSGOvDCKFGRHZavFy7TZSXVPtH1KH5ac9BIkMGmEi7Wo7S/G+udFOcpIlxCf+uhUu
         Sgy60UvwjGBYxA9yNSxHjkffUqdorSxO4/VZ1bONauLWt4t3ik9GIi2myXxqlovRQnda
         /jeAucxE2FFRuoEQ0qhj8cMBd1ZhBBuEI0akl1DqdKCAp0gGbZZtMHN+87x0GXH0iGVI
         RudA==
X-Forwarded-Encrypted: i=1; AJvYcCUrSxh9v5Phem+vwF/Ra13ibyWL1PtkNDI+UCZQKhkDlvE61ASW1sXl8b1K6cWx6zUISNjHbxaOesdi@vger.kernel.org
X-Gm-Message-State: AOJu0Ywurks6p90b5xJTvZHON40h8L2NqNMOC3hWfTYN/UzxMnKDjo9w
	0Lk5dNOHzJ9u30rdBVqaVOcVB0ZlmGsPHiGEB0DK0/ZzcGF1oCAwQwKqX/YtWaCmi+yREqUB/ux
	efB4Kmw==
X-Google-Smtp-Source: AGHT+IHrGNPA7Fjoti9Yh7zCMe8Ut+1HXp93j1eoloOFL1oI/TXxq/AiO9jim6fDWY8a2L2xOX3pv7ki0x0=
X-Received: from pjbqj13.prod.google.com ([2002:a17:90b:28cd:b0:30a:2020:e2bd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c90:b0:311:c1ec:7cfd
 with SMTP id 98e67ed59e1d1-3124198ae5cmr1481581a91.26.1748557197961; Thu, 29
 May 2025 15:19:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 15:19:23 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529221929.3807680-11-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 10/16] x86/pmu: Use X86_PROPERTY_PMU_* macros
 to retrieve PMU information
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the recently introduced X86_PROPERTY_PMU_* macros to get PMU
information instead of open coding equivalent functionality.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/pmu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/lib/x86/pmu.c b/lib/x86/pmu.c
index 44449372..c7f7da14 100644
--- a/lib/x86/pmu.c
+++ b/lib/x86/pmu.c
@@ -7,21 +7,19 @@ void pmu_init(void)
 	pmu.is_intel = is_intel();
 
 	if (pmu.is_intel) {
-		struct cpuid cpuid_10 = cpuid(10);
-
-		pmu.version = cpuid_10.a & 0xff;
+		pmu.version = this_cpu_property(X86_PROPERTY_PMU_VERSION);
 
 		if (pmu.version > 1) {
-			pmu.nr_fixed_counters = cpuid_10.d & 0x1f;
-			pmu.fixed_counter_width = (cpuid_10.d >> 5) & 0xff;
+			pmu.nr_fixed_counters = this_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
+			pmu.fixed_counter_width = this_cpu_property(X86_PROPERTY_PMU_FIXED_COUNTERS_BIT_WIDTH);
 		}
 
-		pmu.nr_gp_counters = (cpuid_10.a >> 8) & 0xff;
-		pmu.gp_counter_width = (cpuid_10.a >> 16) & 0xff;
-		pmu.arch_event_mask_length = (cpuid_10.a >> 24) & 0xff;
+		pmu.nr_gp_counters = this_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
+		pmu.gp_counter_width = this_cpu_property(X86_PROPERTY_PMU_GP_COUNTERS_BIT_WIDTH);
+		pmu.arch_event_mask_length = this_cpu_property(X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH);
 
 		/* CPUID.0xA.EBX bit is '1' if a counter is NOT available. */
-		pmu.arch_event_available = ~cpuid_10.b;
+		pmu.arch_event_available = ~this_cpu_property(X86_PROPERTY_PMU_EVENTS_MASK);
 
 		if (this_cpu_has(X86_FEATURE_PDCM))
 			pmu.perf_cap = rdmsr(MSR_IA32_PERF_CAPABILITIES);
@@ -38,7 +36,7 @@ void pmu_init(void)
 			/* Performance Monitoring Version 2 Supported */
 			if (this_cpu_has(X86_FEATURE_AMD_PMU_V2)) {
 				pmu.version = 2;
-				pmu.nr_gp_counters = cpuid(0x80000022).b & 0xf;
+				pmu.nr_gp_counters = this_cpu_property(X86_PROPERTY_NR_PERFCTR_CORE);
 			} else {
 				pmu.nr_gp_counters = AMD64_NUM_COUNTERS_CORE;
 			}
-- 
2.49.0.1204.g71687c7c1d-goog

