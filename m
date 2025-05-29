Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C5219303
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557199; cv=none; b=iFwA6HxrZcicEU8nXAN9pyr04yu6SuDCR7ksv97mxyQZzvnn/IWsY7IW+uXnMrRLumLFFPG0dvVqq9xmbKIy9j38DvA2jUQVIRAckWyXzGDBht3Dz9lDUQO6jk9UlE99n8jf2/2W3lxzIvxrmhjaS7KCglZKszEbfgXwVLX34HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557199; c=relaxed/simple;
	bh=xD8CaSmWHVco43IcwheB+/1JP29rOKkKM0+y6oEr2XU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GYo3JFhMg708eLuJ56gA7xPx2xucKNtPgW2q/5GuqCsXP1KrGubvlxHvebUP7EduF8rC8+0c/ulB7KYF3F+wfrebNN5A1paa6FuPznX3PEHrwgKLCNlqzcIXK7P4LtmVLZ82xPrf+G/J2ROM8g1NQYgmY1LO/3szxU33/nbS+X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EsN/k++M; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EsN/k++M"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26cdc70befso845009a12.1
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 15:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557196; x=1749161996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gxZgXphd2adbipZSwhEJv6yb2Dq/xt7bO+6gJulJvt8=;
        b=EsN/k++Mxg52GdmJqAumVuOopn1j544MnalL6863jyTdBN4HYR0muRwrP1rt7GPbOu
         fKNQRzKMJz8Wmq0a+mqBVdUZXe0nvlos0jLpTE+dQP17SCdDmfSw4h99tiuvKXcOhW6h
         92McO9DGpK5U79wg8ikNgSFMfIYZ2s8+4VFme9FqdytKAZ1fztURXZkoQBKV2JBA3z2D
         VJPwKQxhEQiuSDUi3lEoTwqwoBgF4cpyObZtarB3rjTRkqGMJsB1zGbytOIbS857seL9
         +6TqKHWL0mYbwpd5wvXj5Yyb/yxkJo0bBx9aCgaBziBrYzTu3csGCeACXCUbLm3Tnf6S
         X9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557196; x=1749161996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxZgXphd2adbipZSwhEJv6yb2Dq/xt7bO+6gJulJvt8=;
        b=Obc6sTDV8qgiXNncFLI89jwuXKx+9zC4ouyk9UsEFnpkOCvYNPORCDOVX381NyVL/o
         xJGswEfuvh6lk7y5V+Pl8dVUytSHPVuNIT0NxNiuCBo7LImybMhnZDITx8CfiiAqQEHd
         lw4d4cvtWSkTVhrin86UYi+i0pCm8LwYfQ7wUM8uOmcekV+uUjnSoftSQZxrDtnTBqb4
         FbA6tOWxSxMqwk0oYRn9yMVJV5SFl9DDuWlW1ytAZKBJwbKff7pRaN9fQbjsWoojoCif
         3VWSxuYvxn0sSUu3o8bGLQH9cIhLvCL9E7hcI9JzkL4ksA+l+TR/uFNYuVOfa9cXJlOb
         1nAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1/cYtANFNcbSCf22ZGq9E6tR1Vzu+4fYpbw06sj0skwAc99wqC5U9soDwkaZp0VbCAu0KFoBG6y6N@vger.kernel.org
X-Gm-Message-State: AOJu0YybxBWjjU6mGTB+RWg0kT5bxwOWn/oC/5bmBewZ6CYJ2D0KrTMO
	qgUUutbG6w58VeOAWsQTFY9nx4HCNswGiiy7onvrc3eWlsX9Re8nXJ4MVS22bgqNpaXmtkNiQGs
	luGGvrQ==
X-Google-Smtp-Source: AGHT+IH0w/roq09Dtn3umfqlUM69m8mqnFe3o9acCe/5LRHUakJnkAfciNzMMbljEJ1XyxaZ7+27T8v406s=
X-Received: from pjbrr6.prod.google.com ([2002:a17:90b:2b46:b0:30e:5bd5:880d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c8a:b0:312:2bb:aa89
 with SMTP id 98e67ed59e1d1-3124173d8bamr1566838a91.20.1748557196086; Thu, 29
 May 2025 15:19:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 15:19:22 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529221929.3807680-10-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 09/16] x86/pmu: Mark all arch events as
 available on AMD
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Mark all arch events as available on AMD, as AMD PMUs don't provide the
"not available" CPUID field, and the number of GP counters has nothing to
do with which events are supported.

Fixes: b883751a ("x86/pmu: Update testcases to cover AMD PMU")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/x86/pmu.c b/lib/x86/pmu.c
index b97e2c4a..44449372 100644
--- a/lib/x86/pmu.c
+++ b/lib/x86/pmu.c
@@ -50,8 +50,8 @@ void pmu_init(void)
 			pmu.msr_gp_event_select_base = MSR_K7_EVNTSEL0;
 		}
 		pmu.gp_counter_width = PMC_DEFAULT_WIDTH;
-		pmu.arch_event_mask_length = pmu.nr_gp_counters;
-		pmu.arch_event_available = (1u << pmu.nr_gp_counters) - 1;
+		pmu.arch_event_mask_length = 32;
+		pmu.arch_event_available = -1u;
 
 		if (this_cpu_has_perf_global_status()) {
 			pmu.msr_global_status = MSR_AMD64_PERF_CNTR_GLOBAL_STATUS;
-- 
2.49.0.1204.g71687c7c1d-goog

