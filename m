Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4261C230A
	for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174302; cv=none; b=urdbjQF4eGrKwUi5topOXomOYgEfjNK0kk5CK854+FhHlvwcCuPgfvN9AeYwlKX8Tm/61NUgpFX9ya/KcBx76RW6bLw7tpHDJqme3SmQHJ/sf5RFjJR+ltTFy3p2NJJv8XlKkbaJ9XnzCOU1MsKXE4A59AQFXkvEJsdbzTjHWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174302; c=relaxed/simple;
	bh=pmE1v3lPafn5e/IdEGvJX2LgNHvxAhIJEOQCTre4Ijg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jNvRBxCSaljclsxZkgUoeuj24CQE/OCTCYPM2wFGy1nQI/Y0UZldfDfPRJk+uCMsBnbdDZ7zl1pARCTqRauM7O/SDYJL9ns+FIf2gqCz6v0oGZ9s3GRcDWO82ALpF7CrLsdcJGENTJ023Om+fln92or9XPG5JFSML68DMrtRHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4KA/Wsqr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4KA/Wsqr"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d54ab222fcso34489477b3.1
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2024 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726174299; x=1726779099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2R8Y3DFBOrXpT6Dp+2pnByuz3JsPwrzU4P/6bkl9CfA=;
        b=4KA/WsqroocPgEf/Kvn1/+NAsnFqu4g+y+EoP5K884ge0R2EhUY2p/Bc66jAEjNg1/
         37WqiJ3J4/y55PhgPCmkESjikU9t+l/LLuk54JX6mRGNKKm5jw+asQkztQ/i+HtNrb1Z
         j5egYrDvG8Lq82fgfzpVao98Q6DrIg43u2D+WnGhWNayX7N0KaKPDcFpPgSN+/yWq91T
         6aHTmxebgGiW3HA6wOjVnWoB93MVEPUNSPsvA+w2lSvbOVXRP/w9nPB2SWvphpUFLTwT
         afyM0U/BtG09tzQZyhFDD3LDYvRezDGv6AOkIyOq3m5E+6e6oNJ3aehC+OLfQDu+B3Gq
         vM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174299; x=1726779099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2R8Y3DFBOrXpT6Dp+2pnByuz3JsPwrzU4P/6bkl9CfA=;
        b=C33dXORvcexvUeW22jGhOX+PbDJBZlaoIZ+KGDJnTVBxQz/dvHFOg7g9BSc/JnZRyE
         bAFqCXu7VhugtLClGNiLwYKuh0BNyhVZnEMspN3KYACqnr5hUZn9OgZmq0BYFqAMgqOw
         tXITnQMR0p0r9/fMdt6Ky2CzY7W9c4wotnnMPg3ngvkEVd9SZC4ZQICfyA0ufQLruJ/Y
         vIXAEMGe8U3Y3JkvyAYdnCGQUJc6IcYhuYUv21J7ByF7EdRhBbRM140wBn+4lFvaQGiI
         KPEOYh6W8lbzLfWw5QHiQjEmTiu/8dPuPAsNnjQ66Wk3BUfYmGDrusEmOiWOUlLnDqKv
         6I8g==
X-Forwarded-Encrypted: i=1; AJvYcCWwhOg44f4DWSoUHT0SmbE+kRbkZTYyjdh0LjKE3/4TlpCTNQtR1uD+t4J7a3tNsvWrr0o2LFwf3Ces@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/3HoHz092vtP9lzOlE15fpid8F3PyHbs89WgiYhYWJ8MunrG
	m+nzIOeaXGtIt5xaxQ8vE8nNsjyCxS+ChbnODq/T07BJfeESE20n/mFvdy0gjrrwjVNTd5fmGBd
	Zz4kxHyI2XOEpd+khPPHOtw==
X-Google-Smtp-Source: AGHT+IFV1m07CCTdDWX2FOgecLasTDjDmm3XH/XZUgTEGDR6/YrsS27OTSnLSt+SciKeVBgsQCat9dX1tnl2/VgIOw==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:1743:b0:e03:3cfa:1aa7 with
 SMTP id 3f1490d57ef6-e1d9db9e1b8mr5314276.1.1726174299130; Thu, 12 Sep 2024
 13:51:39 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:51:31 +0000
In-Reply-To: <20240912205133.4171576-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912205133.4171576-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240912205133.4171576-4-coltonlewis@google.com>
Subject: [PATCH v3 3/5] powerpc: perf: Use perf_arch_instruction_pointer()
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
2.46.0.662.g92d0881bb0-goog

