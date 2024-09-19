Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FEE22638
	for <linux-s390@vger.kernel.org>; Thu, 19 Sep 2024 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726772887; cv=none; b=hzffHZvXAh69AzyWvOVPhp2Uu03aqayrrLYye0R2H1VhjNPWSxZaHH7ejlGSqYaWPt9gLfTWjXHt5pavZFnFMPjQG1ydsJkKAWwZquo495mXd7MbLAHdcut2XwrzS26Us86QbRw3UJYn2zHqgwuG7HggpEqD/HguSdlQ2N4ggtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726772887; c=relaxed/simple;
	bh=5Y45c2QmHSpUy9kSzxpEB6TrwN4M0m5LC0e0soV2VJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IXw8e3Ne35CIMHOibhELUrnVzFRUu5FmOmsd4xrVmcWSMfy9Bwk2BRBUVJ2XEdzHKi3rZp1mJCU56hlvCeeGpIra3mXOJv4wawzWdMzL34Sck6mXd8RkxYanVosx8NAI7osDBAEuaC9jeIw55w5TP0U/lsYw/ULE+SAKLIbIVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oyh2vFMi; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oyh2vFMi"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d5235d1bcaso19407367b3.2
        for <linux-s390@vger.kernel.org>; Thu, 19 Sep 2024 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726772884; x=1727377684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1u8+tIRQu1/+Yzznd3YfSwPNzKiT5HV8vjSuz+hJEoI=;
        b=Oyh2vFMiWvUXg5ftd0Ep7utGpNzGlpVZ4DcEXZsyQt3R923CGfXJ06TYw2psB2JGAk
         5tTkq7mhnjiwVurO5LFasyhGYICWZE+q4DEGaDkTX0gTNgSzfLRDlScTyVReo7UQnd+T
         7MOKKR7fcUMnmzowP5+yK7SqSGNUh3yQkDaMxWQ453auhkbN9vUSeDQPd+COdhB1nttY
         u4RbxrZLJk4Cg2zy7L0d8CX0mNOw1yHv5DeFDDrZhQz5ZC8spcGd0HHIIVUzojT/PgXL
         P4ARHF6KT+EHZQ/tTKrLk8pNa5cOGx5DrH1fky1BoMvbYWxeNMapvvy8RXq91TYli6dw
         3Wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726772884; x=1727377684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1u8+tIRQu1/+Yzznd3YfSwPNzKiT5HV8vjSuz+hJEoI=;
        b=bShIYfSv9h7hdv0nX0Q/lRN5J0Z6eJCY5/0Rh4KEB0edklF/jKo5s/p3JpOnr28e46
         /Q6clzn51dOi7HWeQGaa756tpHHfJdNB1/xU4KyWfYrsN1ezQ7yDFEvvhHh5SeUjuUaq
         Uzy96AV3ZTREJQIYfoj8VgrMpF54sdsuJiYZE+Rmaf6dvzG89AoALInvxrIeYdRJa/2B
         CQMzsJ/UylN0riCAG10vzHskucORZBZU789DQGzU95o/YBcAJLNGyJ29Xhoe+XQJwgb/
         RjwefgvxEzvEmI1excU7emJKvccCmE2wNb71m02rPfXSWaod/u2m123zO1Ib4ZQRe9aL
         xpug==
X-Forwarded-Encrypted: i=1; AJvYcCUmLm6uGckS5+7gSOS7CSUn6UdlL2xDZsZZT48G8wA8lh5xoFdXwwxmmg9rczEVvab4BlCBcO0k8Zmm@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0CNGy+s5hxAP8eBK4TerSB+oSHIZ0jA0keCuen8YF9lqByrO
	iI5FKrlmWxGjwEstxu1AId1KJmygUzq3ak7EquZ0WQIEmjYe/sSxuvuHT08vUiBSncNMm0biGgS
	b+nvzNrdM6YDlTDbP11Snsw==
X-Google-Smtp-Source: AGHT+IGDiKrctQsFm0erPBgmwBCKnufFRGsSs3qB+YNCGyJVR/2h6144NBut+d+5hRqNGNQ/pKN4LdcbFv0AmZEt/Q==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a81:a88a:0:b0:6db:c6eb:bae9 with SMTP
 id 00721157ae682-6dfeed1dec3mr31057b3.2.1726772884551; Thu, 19 Sep 2024
 12:08:04 -0700 (PDT)
Date: Thu, 19 Sep 2024 19:07:46 +0000
In-Reply-To: <20240919190750.4163977-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240919190750.4163977-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240919190750.4163977-2-coltonlewis@google.com>
Subject: [PATCH v4 1/5] arm: perf: Drop unused functions
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

