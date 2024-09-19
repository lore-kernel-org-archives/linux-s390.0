Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214438FA1
	for <linux-s390@vger.kernel.org>; Thu, 19 Sep 2024 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726772889; cv=none; b=emDZFVBLcvQOtvyLYCAt5nh00Xo53gMWfBPVBlEe4SplfR0+RvPnvLkwYN2O7VU/TRAGiNVzhZurJFSq6lN/WgnVykBc3hRLfkYtjFuIxZcv/EmpVtA46J+GTtpNhBicBvBQm8GDksSY5b4tezRLkDnl47EZ50zXfgFVBNzKO/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726772889; c=relaxed/simple;
	bh=nOGTMAQagWkUZdTqcYtpFuhJmVUFEuPWvMTzi18KweY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nJHkIUrXvfQF+jMrr6QV22kFn/TYJgWxS5QHqofelEAH209auLyBjVrSSqENgmjnOHNM+CGHS7pcEMXshnkarh8/1xr7lYhfFL/fDNk3XpjKiyX3Q21thNuSrIoAX2KNvyUfAoWBz3oQKy05cEu5TWWqb1e2xJNuVqhana53MHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yK9UEe3+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yK9UEe3+"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ddb9b15af3so25706837b3.1
        for <linux-s390@vger.kernel.org>; Thu, 19 Sep 2024 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726772887; x=1727377687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5Qt5np/Ap8e8S56AX/TaOyn++MQC/aFN8Qv/OewSh4=;
        b=yK9UEe3+k0/jouY6yj2w04TFy3zIIsZWPoLEOhgELfrnvKv6m0GvZmNriqgMYkld0q
         iSY35sMIcocsyugvMQvif1KWsj4ZO9ZDR5fH5FY/wVUlmilbhRf5Tpm2C7peIOdDVUMM
         fKTzXDqOSTMoyuVE+NxWJM4dT3GZGvuoy2AeQ0LYUaXcrapTcFiJCCLfdVqkw6HfaODI
         msD0P4vLr/ifB8BHAijX9nNZFJZJiPQtEdkYnL035wSmZtYL3DUVNX2TrcyEqpTc+hER
         BOt/0Iw7+XssR3BxfwtMLGisu4H34kUlVYSLAtioVsjvzfBSfN1NdqVu1pN4JYsad8iX
         c7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726772887; x=1727377687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5Qt5np/Ap8e8S56AX/TaOyn++MQC/aFN8Qv/OewSh4=;
        b=fD2n15FIQ5kY8Q629XGbs1PrxFW3nDBFo6LAGuOaUywyUX+hF34nUsJcDNDUcyeF8i
         YIf/RDt8tBlCE5GGjWMavCADsYHNp3oMQAmsSR+PbN2XeP9YdcvZx+fcShJQUEzEvhZY
         RqWPhfwAqSF8wzBlHOrddeTFOTok6SxRWoc/wUUVCOfMD8OaSvFZsyH75sFRojDwWThV
         kRmp6VzXHVYT5CJrrBOXIw2RlQcNo0ShrPbdPkxL95CUDsrYg+iHvGEdFuBjYyn14MNo
         1AXWKZ80vDusiV4CM3HV6WsoiqzS3fiDJHauI5UHMqn9wLtZwdeplamuUW8fRrolCyPw
         +Tdg==
X-Forwarded-Encrypted: i=1; AJvYcCWZqL07KdKIXIuKhbA0dBWFWj8heuNuq12ssz1yaCNFrVSt5URqTn+SDQJVXiN1FuBDIUZvu5WyRdj6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/GUO61Cerhb06wGQCOkRP8G5nHqPD91IEXhlMxNuuUp4cdx4D
	FaMt2xOC1j2B4EAXDZidjxiNL4/GGLr32rFWQq/qhqMcchNo0dEOdflTwGA6285HeYoQ6nabiYq
	cVbKvfDdVcLVRDAXo9zMUGw==
X-Google-Smtp-Source: AGHT+IG+gWtFXvOjppbknvofQy7F475eldlmwCdDkPmmKXe3fWWYdIxyDCZn7gT+ZyDPYmZ3bf2GZI0Klu7wUcLEaA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a81:a88a:0:b0:68d:52a1:bed with SMTP
 id 00721157ae682-6dfeec11e0amr8827b3.1.1726772886738; Thu, 19 Sep 2024
 12:08:06 -0700 (PDT)
Date: Thu, 19 Sep 2024 19:07:48 +0000
In-Reply-To: <20240919190750.4163977-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240919190750.4163977-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240919190750.4163977-4-coltonlewis@google.com>
Subject: [PATCH v4 3/5] powerpc: perf: Use perf_arch_instruction_pointer()
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

Make sure powerpc uses the arch-specific function now that those have
been reorganized.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/powerpc/perf/callchain.c    | 2 +-
 arch/powerpc/perf/callchain_32.c | 2 +-
 arch/powerpc/perf/callchain_64.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 6b4434dd0ff3..26aa26482c9a 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -51,7 +51,7 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 
 	lr = regs->link;
 	sp = regs->gpr[1];
-	perf_callchain_store(entry, perf_instruction_pointer(regs));
+	perf_callchain_store(entry, perf_arch_instruction_pointer(regs));
 
 	if (!validate_sp(sp, current))
 		return;
diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
index ea8cfe3806dc..ddcc2d8aa64a 100644
--- a/arch/powerpc/perf/callchain_32.c
+++ b/arch/powerpc/perf/callchain_32.c
@@ -139,7 +139,7 @@ void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
 	long level = 0;
 	unsigned int __user *fp, *uregs;
 
-	next_ip = perf_instruction_pointer(regs);
+	next_ip = perf_arch_instruction_pointer(regs);
 	lr = regs->link;
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);
diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callchain_64.c
index 488e8a21a11e..115d1c105e8a 100644
--- a/arch/powerpc/perf/callchain_64.c
+++ b/arch/powerpc/perf/callchain_64.c
@@ -74,7 +74,7 @@ void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
 	struct signal_frame_64 __user *sigframe;
 	unsigned long __user *fp, *uregs;
 
-	next_ip = perf_instruction_pointer(regs);
+	next_ip = perf_arch_instruction_pointer(regs);
 	lr = regs->link;
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);
-- 
2.46.0.792.g87dc391469-goog

