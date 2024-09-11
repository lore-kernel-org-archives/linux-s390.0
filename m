Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C51B251A
	for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2024 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093513; cv=none; b=jDZW9f9bYW3451b4jRJ2ISbyBkrYEAllOqv+EbdzXbNRD1qMUxG+syi+9Ax0V3Kn178APlHhuYFZcHZt1GiKCtGf9hBn8DADQKhsprdZdbO4w/c4PzFVQDMwLiBg0Z0vUUuSBZyhcYkCbLpL0+u30rmf5QQ2J4oJP9ADJWHVs3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093513; c=relaxed/simple;
	bh=BVvwBjCzkHKlE+Z/Vr8hTBCRhDHp8hUrZYi0cVtEGEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h0VUsIoVkIm/iugOIaEmYHLgvI9Up78Js0/1Yi+7rUZc4lm19wqy10l3x7vQ4s0fkHCqvEdOWttSX8iyqrKdL+eLw3LpETuvVuEJuAiMcek+AYIMg9FyYpv1cifiw0jCMiCL3mzJjJYOcZNyvqIiklLZPZ8qMVB9ZY41S2mxLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDT6xQKX; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDT6xQKX"
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3a043f8e2abso6168205ab.1
        for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2024 15:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726093510; x=1726698310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=98KHHfZAU1dotPbU8K3avps0YbHY8rCmN7CSHv68LAQ=;
        b=RDT6xQKXlgU1IU55uKT3Oe6xVaZjalM81e8wCsCSoW85vvLpGJ9LfP3+lH8HKP5bCM
         zaOapyjJaXj04+PK5got56QDBb1l9rZFNgsMXDCB2vhAjr4WkZ6xBwxK+muVANwINjH3
         nDA1asHFRGmie+eO6hqlmFoOlO0eGEEuMYRNeufFjpUkGI6bzvJMwu9PKeXpjp3qJ0yr
         nhjB1Pp1HkRpkedBOHT5fx1o0W/p0TBeCMkJCfJa9DI96nCfZpF82fEbdZfkApEv4uu7
         S+75XBCIiK2UkZ805m9Bx8uM/YmzNzpnRP4LHwoWQxiN4mDfBjX2tqIJ5DzT8fk24tgk
         kdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726093510; x=1726698310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98KHHfZAU1dotPbU8K3avps0YbHY8rCmN7CSHv68LAQ=;
        b=Tb8EWi34fUynuwSYoIlHQuAOTCfkV9Txp5Ze38DZ7Q5+ex2AhWsGCg0aKm+YBXVU5F
         Z9IQELQ5ZKvZPEuHfWtwmLWngnYgf+F95QFcB6s0T13uFtWgl3OP1XJ4hTHwZei3t9nE
         lUUAeuko0HAk+dQrBe0FpYLUB4sifCaI6eHLBCsTlos5wDiX5vtXe0YRh/gD72Z51YLM
         Wc1eoA+Lb9IK6qxaTBhMlcffck0WCKPI8Ib8cLAxyqb/I62VkO2jDtjfEfW4LprvIj6v
         TRzW49TVMv2c8cI+J+MJ+z2avksTVuZJaxWOgNVaaLnvjGiXL8XyX9EJmq5NflYOVfFn
         YSwA==
X-Forwarded-Encrypted: i=1; AJvYcCXxUURp++f9wJaaF+AgIzUspvXf9obXUWtLp3u3TFg/4gI1Qpxlw2Q+CF5zEHsdDjD+FVwXCHTdjVMy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/0hygbjbbPRJc1WE+OMKHosatzwMAAbgFXIcWdNCpGGOwC81
	SMkF9QNrR9kB05CLomZBysbYopHP21jSrUQXuS+2x2MSHPqRNCXVacZ6VQDPXt+h7ukOKhIkizs
	BJaMpZuBJcoz2yPVL1U2Bsw==
X-Google-Smtp-Source: AGHT+IHezO/FS6DrvjzqydPLEapvMWYoVJd9AX1NthmyW6WKSgM57sEvRhPyRtAfj2mQLXNB4v5VRUm4UvpIqG0BYA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6e02:1c48:b0:39f:549d:e39d with
 SMTP id e9e14a558f8ab-3a084967570mr302085ab.5.1726093510446; Wed, 11 Sep 2024
 15:25:10 -0700 (PDT)
Date: Wed, 11 Sep 2024 22:24:28 +0000
In-Reply-To: <20240911222433.3415301-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911222433.3415301-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911222433.3415301-2-coltonlewis@google.com>
Subject: [PATCH v2 1/5] arm: perf: Drop unused functions
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
2.46.0.598.g6f2099f65c-goog
