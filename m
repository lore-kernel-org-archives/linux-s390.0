Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F00215C6D
	for <linux-s390@vger.kernel.org>; Tue,  5 Nov 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836596; cv=none; b=bbSDmLcq16Pam69rEgeP+5GTg7iGxIyjCnmVYQ1EaaQhfIw4Oy+XD24TbDdqndACE8JxYddQPLVcOb+GzN+wFqhMTI7HS/mARIo7URdJaAeTv9DUR0C7Cyke1H4v7KN3bdzJQBkzHqsbSbMXzKU8DSwuYOvB2YiHqnV42UED+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836596; c=relaxed/simple;
	bh=wSz2wg4Whtfo/EFpwfiSjTtt4Xe91rIimgScnrimpn4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a3rHG39YqH2xMY1+v8BuGTMVsCWwQgkhvl1XZr+eqsc1cfA3K0iEuw5qrMxzmuGAEvO/LC1f57vuOX8TgRA7l+6ZrWFWWYqN8//7G6TupdPsI/zibc+I3p/1Xw0i6LbwphlL0rzyXpUvmn1lRtHCkHYj32GilzEqf4N+q9xXnRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQqo0Ec+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQqo0Ec+"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea9618de40so43428817b3.3
        for <linux-s390@vger.kernel.org>; Tue, 05 Nov 2024 11:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730836592; x=1731441392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sW1pAHD8RX7fvQhBgDL/ivZoJ4MMiFBudzlwbhbqZhM=;
        b=FQqo0Ec+hHd93ayT2azT+kPq4whnCYy27uq61IJFChMD09/8NELNvKIC42NigwCK6y
         n2XKmNDLBRQkoIYPMsE9oWOT+7Nrbl4y5e+dGZefFhav6tIPSXHTUbv7mlYgwO2V1hTI
         YABZZHCFoXwK2qm3my6Ro2fpD2Drg/D2RnRj+1F+ew3OL+sCt0VXpG4gzxJ76Yv8c9V3
         4OE8hiJZA9+ZaYxAiNVPhUYziBQMRm8XBdeUQ+LigSEafNnTPNUDZDaoHn8dqv4oF9YV
         LAKFaDIqF/K6OOPLeORRr1NBNJIW3r4JSIWfle+LBj7cfJQhKgC6VwSVDKMdyV2XbB21
         0ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730836592; x=1731441392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sW1pAHD8RX7fvQhBgDL/ivZoJ4MMiFBudzlwbhbqZhM=;
        b=Ltj6k/k+K06AKknBS7fevd15lSwEIpVudcVn8Tx+1Mrk0gNVV2S6WSPV8pX+aH+2KY
         libemD9lxMKn8CrB2YVyAnkykCOBK8e9/oZb0YaQth0yPgNBVlVimQ4jkpSYdocNcm5t
         T0gNmGMDg8NAwSgFHGjyu3BIwLU/ZTNHZSD3aTikTcofqdWHRMJE5hAztg5GYV+pPk78
         n97MbIP2u3dAhbLS82eXE0qVgotBgt5+T8V1njJEeDs2mOywrtEdD13F0ltQ3hsW4pdJ
         QqolpS4HJLU2wrIAYH3CsOjM4j3joy4xN/bZUqA3wHsQuuPZEXMgFojxAAF0P+bRHzA8
         VKpg==
X-Forwarded-Encrypted: i=1; AJvYcCUeFE4Jv3CvOA+z0Mxbj/q3s3DHUhKVL4/zvD5Chr4XfdU8aPGyOqYimTf+qUJibZ6AKg+qVrFamY2L@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sx+7gcq3e9eOnKi/Ug+w0fcNkTtC+JnR4Dj0CLyuPkSzszNl
	hutj8/TUzwk0E0KO8MwaO64jNkIs+Mg+Ul6eqP6/glXDEAjhOsacZhVtdVHuCEsBFWSmvgcZIZ7
	lxAEDnRGWnF5BTCNLC7qoSw==
X-Google-Smtp-Source: AGHT+IFe5esZfmV8PpNtTKhf67GNSznritdlgCuivBreGx7Lwrw/eQ/PIB8HLPh/Mq6jxCM85J+7ZrWnfVuJw3jbsg==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:690c:4489:b0:6db:c6eb:bae9 with
 SMTP id 00721157ae682-6e9d898f08bmr17263797b3.2.1730836592357; Tue, 05 Nov
 2024 11:56:32 -0800 (PST)
Date: Tue,  5 Nov 2024 19:56:00 +0000
In-Reply-To: <20241105195603.2317483-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105195603.2317483-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105195603.2317483-4-coltonlewis@google.com>
Subject: [PATCH v6 3/5] powerpc: perf: Use perf_arch_instruction_pointer()
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
2.47.0.199.ga7371fff76-goog

