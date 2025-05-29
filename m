Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE9223DCB
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557196; cv=none; b=IjHsXfnm9uXb3ix68WCiDP5LZV5QaxgT2HAPrsBOmiz2Ru4vNwH/MyuTNzyb7h4rqdLErJdVy12OcUcHZIfxeax1fohIwMIfA8P3U/4yzYCtoYdE8mV00GkWWaXhluYY6BiBW2Gy0gTXXh+kwFjvhSLuz+Hnzwq81WqriweVskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557196; c=relaxed/simple;
	bh=A4LFvqZ5ENWY34mGIemBrERpDHvc2DqMGrkrdUc+6to=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RjIMcopGcJHk10lMDJjmjyicPgEjND/vk3ID4MbA4cug5Ze2FXlMukYETcOvBzyslB63JWpX43IVJ/mKsbqgaaGjZZzml8UE9el7oQL1Kk7quOVlaIkyuWaCWkl2myaBzfkKp4B6RQiUwBNVJqvrGVDgXeYiqZ4KHRuzmPL2UAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T+AUPhT1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+AUPhT1"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742951722b3so1056441b3a.2
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 15:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557194; x=1749161994; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nX98HJbRuSQ6xNdc0MwlmdF7eZrXWtOe+GKwLLWx4iA=;
        b=T+AUPhT1snCB9zW1C3cw9aF0FwU5iVrWGUbe+WRjw2l2nUQueDMl2mKWuEg0N9tgPX
         Uw94XsFoiFlrF/qqbzjRRPOCUwOduKKlUJ5QAI/JCMbo+5wWw+3bg0WTHW+OIoahO+FK
         XQiZVOhQ5Gg7DFUjx45bp6/NwtQi3OSehPqa4vJhIa3QNxISiU3Ahw8ex4+3a2X60Bbw
         PpHcmXjKJUgqxxOz1KR4ykaQXzIus44rP/nqBC3pLJrskHZNMwER6ETYhjDr9b2Ql1MD
         DbQRzqsE67BffYGljZ49fELQ5udE8DLKjzws2g9L6v+NEP7hGZNDgk7ZQaj/DB47SXaR
         UiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557194; x=1749161994;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nX98HJbRuSQ6xNdc0MwlmdF7eZrXWtOe+GKwLLWx4iA=;
        b=ekSU441I14xM1FlwPqe808fFWsv8F4RP05Fk8Tw5shupplKJPj+fWCAIFKQFnLULb7
         fBZ3ClyFdmVgipP+fV2LIAq2upfN4dZmwoLVeMBhXe5TESsmBoTn/NDVvUWJ/ROc9ox8
         3RLi/DlbTrnCFhkAKSks7CP16bBqZ14UU2piQVlqnWlvhlZLQB8lqoLc4enSa2fKCtyc
         L30VsCo6c8WISEWvPm0Nryqe67oet5I4SD3itTSrivwIsmJ1LUYQaIoB4zAML7YS209+
         Jm0troHvnsD4wBgBVAK/waYf1ZDcWW88A5cS6QD6GvFaDDRQ1tJz+CLN/JhqixcDl4Z6
         YLcg==
X-Forwarded-Encrypted: i=1; AJvYcCV5RJhvDksh/QqMQ9KZLjilZnlTFGVJixOcUpq5OyTLsjBKwgHLyNxbrdd4t2Kkr+61BrVI1uLerHJi@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZV3vR4jrqiQAe02+aqxbBdl7hf7k0kwJESKwc4dReTFXeXfM
	u+OL/yOTmoON/NGUhK7BUYIccEtXu9zU3Q1iqrg/o2c4EQRhupoZ5j005xnXZxV8OYGk1FKED8q
	oPwdvPg==
X-Google-Smtp-Source: AGHT+IEBKjriVgxGk+BKu71J524sscOYWEh1dyyHEKyqWyY/JG1UDmL2b6mDtP1ardICqkEsw3RhMdZ0TiQ=
X-Received: from pfjg6.prod.google.com ([2002:a05:6a00:b86:b0:747:a049:d575])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:928a:b0:740:4fd8:a2bc
 with SMTP id d2e1a72fcca58-747bd958bb5mr1298997b3a.5.1748557194299; Thu, 29
 May 2025 15:19:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 15:19:21 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529221929.3807680-9-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 08/16] x86/pmu: Rename gp_counter_mask_length
 to arch_event_mask_length
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename gp_counter_mask_length to arch_event_mask_length to reflect what
the field actually tracks.  The availablity of architectural events has
nothing to do with the GP counters themselves.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/pmu.c | 4 ++--
 lib/x86/pmu.h | 2 +-
 x86/pmu.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/x86/pmu.c b/lib/x86/pmu.c
index 599168ac..b97e2c4a 100644
--- a/lib/x86/pmu.c
+++ b/lib/x86/pmu.c
@@ -18,7 +18,7 @@ void pmu_init(void)
 
 		pmu.nr_gp_counters = (cpuid_10.a >> 8) & 0xff;
 		pmu.gp_counter_width = (cpuid_10.a >> 16) & 0xff;
-		pmu.gp_counter_mask_length = (cpuid_10.a >> 24) & 0xff;
+		pmu.arch_event_mask_length = (cpuid_10.a >> 24) & 0xff;
 
 		/* CPUID.0xA.EBX bit is '1' if a counter is NOT available. */
 		pmu.arch_event_available = ~cpuid_10.b;
@@ -50,7 +50,7 @@ void pmu_init(void)
 			pmu.msr_gp_event_select_base = MSR_K7_EVNTSEL0;
 		}
 		pmu.gp_counter_width = PMC_DEFAULT_WIDTH;
-		pmu.gp_counter_mask_length = pmu.nr_gp_counters;
+		pmu.arch_event_mask_length = pmu.nr_gp_counters;
 		pmu.arch_event_available = (1u << pmu.nr_gp_counters) - 1;
 
 		if (this_cpu_has_perf_global_status()) {
diff --git a/lib/x86/pmu.h b/lib/x86/pmu.h
index d0ad280a..c7dc68c1 100644
--- a/lib/x86/pmu.h
+++ b/lib/x86/pmu.h
@@ -63,7 +63,7 @@ struct pmu_caps {
 	u8 fixed_counter_width;
 	u8 nr_gp_counters;
 	u8 gp_counter_width;
-	u8 gp_counter_mask_length;
+	u8 arch_event_mask_length;
 	u32 arch_event_available;
 	u32 msr_gp_counter_base;
 	u32 msr_gp_event_select_base;
diff --git a/x86/pmu.c b/x86/pmu.c
index 0ce34433..63eae3db 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -992,7 +992,7 @@ int main(int ac, char **av)
 	printf("PMU version:         %d\n", pmu.version);
 	printf("GP counters:         %d\n", pmu.nr_gp_counters);
 	printf("GP counter width:    %d\n", pmu.gp_counter_width);
-	printf("Mask length:         %d\n", pmu.gp_counter_mask_length);
+	printf("Event Mask length:   %d\n", pmu.arch_event_mask_length);
 	printf("Fixed counters:      %d\n", pmu.nr_fixed_counters);
 	printf("Fixed counter width: %d\n", pmu.fixed_counter_width);
 
-- 
2.49.0.1204.g71687c7c1d-goog

