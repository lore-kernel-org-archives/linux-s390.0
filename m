Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593E918593A
	for <linux-s390@vger.kernel.org>; Fri, 20 Sep 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726854469; cv=none; b=ItrmkcW/Z60bdNbBOwEAjqD6nQMy8ufh+kF1Wk0qpykrlC7P4LYjbJhvEuU7LViQ6zPVcVtD4s/Jl6LG3hDqu1pJhNlZkgYnOlaZ5nkd43DmsajP8CFOCnu/70dco/jv+hhUSLlSalj55nirr3Sb86ozpUvQrp4C1PUgQz0ovcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726854469; c=relaxed/simple;
	bh=5Y45c2QmHSpUy9kSzxpEB6TrwN4M0m5LC0e0soV2VJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DchvnLg9ZedNsRt1SM/0pBbkY/TU6B/nN8bG5jJ/tqFEPX6kNuRXqBjVkvaYpahczFAhPEFYRjw5f5npY6H4UGkCBsRscRPK8DryCzDIq8p6oRv2pQULZS+/RTolIrZEryRKu7ICJp08aTHavckzcRyMxMVOA9HX62VHxgFL/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XOes+V7b; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XOes+V7b"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1a8de19f5fso3299076276.3
        for <linux-s390@vger.kernel.org>; Fri, 20 Sep 2024 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726854465; x=1727459265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1u8+tIRQu1/+Yzznd3YfSwPNzKiT5HV8vjSuz+hJEoI=;
        b=XOes+V7b4gcvPGJspGP/yH66Z4ldoO9nIrNChrXsLrhCuEtyeliuUNM3uo1n0Nkfec
         fZd914OwYo/S2uChohP9eBbReV7AJGywg3H9WZGDshYYwiC2Ko3X9S2CIv9GMZtfTwJT
         tJfKFuKg7jWDcpUFHnXZuqzmRrnJV4sSxfn02GhwgsytbVqwYtTMuuF7LJN1ZbFTd+sB
         MfD+/eQwCL9H+YbLx/409agznXm0j6rH62balzvCzPoS3ftzBZZM40+MQVTDnSyMd9K5
         y16wMbpxQ9IaEULEDZ8/RV87CIiEeEQByb7Dz5mmUIgDlm7owP3b2cssGpfNJlNb1G0M
         UOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726854465; x=1727459265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1u8+tIRQu1/+Yzznd3YfSwPNzKiT5HV8vjSuz+hJEoI=;
        b=mtn9n0mNfkW8JYwADSqZZ61JGA9a+unc4+2AzGLmF+mR6O8dQuqD9LFNq/Zb5Yfa06
         dpADLEhQ0ujQkVoyWq4iQoRXTxAONAYtW6zasu/+RBdOyVBBfn879yztDP6HMr2fdnEc
         koU/tAzDcOvDamRAtSOF5dfpNS3HrYaElLbyglULJgu3/PD2yzCO2VcpnBmnuOEhQWZM
         z71l/NNwOibaq9jRQv4nKZ+W6Ywx1kuInr5GH32bf9Ry9Xs6tzdfJHgQ/krA/eKPOUEK
         ySmR0IKc+jW50BUIPc54KuQjmkGJ0A4i4pNZFrTCwh2XiEv92TfxPWOmnDEkwE0jEQUZ
         tw1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHykVDgRo8Cy+TtiadaSR9RsIRIO5dR6OL9w61wOgkx6PvPPLFiUEfaUJyncqFSt+vrfaOXBq+708a@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQZEzwBXzkhSFufZWliLineiW6yUoYfQtiOBIxZCsKgSyDDy7
	ugkOV8HKespKQhqlvxwPEgi8lQTrFF1rr/9izG5lhVYKojLmzDIJoFNkdGhw1uhvnPVSylAIlY3
	s8HdeGM8BIYQirCEneJCvig==
X-Google-Smtp-Source: AGHT+IEMZpgFL+UVav7e6/78nxxqsZh8RtB34P8KhO4E9lrAtqCCPkLcHN7A2NJ63pZVH3cqvvVs3DKnxU1JZod0ig==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a25:c503:0:b0:e17:8e4f:981a with SMTP
 id 3f1490d57ef6-e2250cd6079mr6801276.11.1726854465133; Fri, 20 Sep 2024
 10:47:45 -0700 (PDT)
Date: Fri, 20 Sep 2024 17:47:36 +0000
In-Reply-To: <20240920174740.781614-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240920174740.781614-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240920174740.781614-2-coltonlewis@google.com>
Subject: [PATCH v5 1/5] arm: perf: Drop unused functions
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Will Deacon <will@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

For arm's implementation, perf_instruction_pointer() and
perf_misc_flags() are equivalent to the generic versions in
include/linux/perf_event.h so arch/arm doesn't need to provide its
own versions. Drop them here.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm/include/asm/perf_event.h |  7 -------
 arch/arm/kernel/perf_callchain.c  | 17 -----------------
 2 files changed, 24 deletions(-)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index bdbc1e590891..c08f16f2e243 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -8,13 +8,6 @@
 #ifndef __ARM_PERF_EVENT_H__
 #define __ARM_PERF_EVENT_H__
 
-#ifdef CONFIG_PERF_EVENTS
-struct pt_regs;
-extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
-extern unsigned long perf_misc_flags(struct pt_regs *regs);
-#define perf_misc_flags(regs)	perf_misc_flags(regs)
-#endif
-
 #define perf_arch_fetch_caller_regs(regs, __ip) { \
 	(regs)->ARM_pc = (__ip); \
 	frame_pointer((regs)) = (unsigned long) __builtin_frame_address(0); \
diff --git a/arch/arm/kernel/perf_callchain.c b/arch/arm/kernel/perf_callchain.c
index 1d230ac9d0eb..a2601b1ef318 100644
--- a/arch/arm/kernel/perf_callchain.c
+++ b/arch/arm/kernel/perf_callchain.c
@@ -96,20 +96,3 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 	arm_get_current_stackframe(regs, &fr);
 	walk_stackframe(&fr, callchain_trace, entry);
 }
-
-unsigned long perf_instruction_pointer(struct pt_regs *regs)
-{
-	return instruction_pointer(regs);
-}
-
-unsigned long perf_misc_flags(struct pt_regs *regs)
-{
-	int misc = 0;
-
-	if (user_mode(regs))
-		misc |= PERF_RECORD_MISC_USER;
-	else
-		misc |= PERF_RECORD_MISC_KERNEL;
-
-	return misc;
-}
-- 
2.46.0.792.g87dc391469-goog

