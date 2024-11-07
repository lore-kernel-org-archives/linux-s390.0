Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01DF2178EE
	for <linux-s390@vger.kernel.org>; Thu,  7 Nov 2024 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006269; cv=none; b=u9/q0+bZbk6ABgVMBOa2C1RoFp0kBob55uG4rD9+WgEperAcwqxWZJ8b04tdBqDZ0ARQKXZTJZB5OgDrZ3mAuC6iYB7jg9LDvur7p0ExZe5yUeSIDn8CYrIB8GOB4G90vRYm7Y39BMd1EdWl4c+rSO/Mhub25LMlQ81Rhi36vy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006269; c=relaxed/simple;
	bh=KDOpYvQvaexnS4ROlfUY/AOVb+PMrJotsVbv9tdnmmk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JnKzfQMLzibxTyOTsV3qa0Pk16GeBV0OvYhMhCjdxTLdkxDDOfmYPd/ITBG7hmHTT1UElDu9rkQZohYQMarZHQvnCSiCOWf65Is3u0iIwG6IGS3lVTwXeEbD/SO1daUvWj7vDuZRUlx4NfCgGUg0lS6TcemLXCxi14iWrAfGivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lb/QGDWn; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lb/QGDWn"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-83ac3fe1cf4so142293739f.3
        for <linux-s390@vger.kernel.org>; Thu, 07 Nov 2024 11:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731006267; x=1731611067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8sUtURqCyFCOn8JOOFBrrh4KEoVslcfr90vq+LFgUg=;
        b=Lb/QGDWnLPqNIYp5cyBBAcApr667uZhyLg2fTzDMJsDrrs1HWoIdKtXf6ltPzIKOtQ
         0bq8NWVYL1ehknHtwM2sRvdIsZpbxpWfTyzSCn6GyFYyJlPK6US3IEr+m999I7EUAe2+
         WbTJ5h/ERzD+NnbeR3RgIIASHkiIiZcLotDfQlj/pS5wlhDHLfeowpTi5UguVmez9Qg6
         k1N//SkjZUGPSXNa7Jrcx5Dg/NB5ZZc+gQPtJAN8JO6B0Pxx6Ftf/5dIBi5gAemStEu6
         CJwlj2zQk5YJjPxwguiEvwZMqLvuSssyqEhnoV/cpF4wmcvbbxnGgicXdoKvB/WzoFjf
         ONsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731006267; x=1731611067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8sUtURqCyFCOn8JOOFBrrh4KEoVslcfr90vq+LFgUg=;
        b=IpCAZmwXV8T4RE2HR7tIh5UbKPxiuLEIH8QgxajQkbHOmKll7hcgad2Y358TeUMP1M
         ueNCucAqL6bAZZnfvxecXY52r5I88sBBpwRHejxSXh44Y2Mlkjkl5a3sTiWPQvmOvQpW
         3TbjxW3hp739lOrOaoyaYAN8kVGpryNxEMlqeGXD3B54UnaNGWBGpapDRRsuuA5UJcjP
         NT9pLvITD8+wpyOrrBldEynaIUX4oeDPaFPTXrLzGyfFLPQvssKF9WLodvMaD+mn3Neu
         Etxq99f9/aN46ONgBigvMDXZmUQDHuIm6JwQzAwrA0HtN6RYT/4mKLSrQtKN0xJ3LrKz
         S/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxMTJtGqL0uqFUXbX/Vb8vk6jCvPZg+kQvj2RIWcNONXsNk3Ie6SueWn3hI7v6/iozAoMEOwoqLEI6@vger.kernel.org
X-Gm-Message-State: AOJu0YyVpLVz3G6ABZIpNv2TuQZGKoIIxDzavGZNw2M7+d4XsTOZ99tU
	9/mpbPECaiR4fDEqDNf5gv4gUMmBVwBdN0tQQFeqIKKerNdTOpBvOc+ArCfgf2LGGdUQlW5PFn+
	G095lvh2ZWXNlfsentgCa4A==
X-Google-Smtp-Source: AGHT+IEPRr/IQdodyqcpTfvB5PFu6DqvhssHdY7ZGS0GFH2h0T2KiHTqbilJA81LBD/MlyV7/G5K+PfGhK0HNCVbEQ==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:890d:b0:4db:e85c:f17 with
 SMTP id 8926c6da1cb9f-4de6a5fdc31mr24173.4.1731006266688; Thu, 07 Nov 2024
 11:04:26 -0800 (PST)
Date: Thu,  7 Nov 2024 19:03:34 +0000
In-Reply-To: <20241107190336.2963882-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107190336.2963882-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107190336.2963882-4-coltonlewis@google.com>
Subject: [PATCH v7 3/5] powerpc: perf: Use perf_arch_instruction_pointer()
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
	Colton Lewis <coltonlewis@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Make sure powerpc uses the arch-specific function now that those have
been reorganized.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
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
2.47.0.277.g8800431eea-goog

