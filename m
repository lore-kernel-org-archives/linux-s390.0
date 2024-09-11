Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE871BBBE3
	for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2024 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093516; cv=none; b=nWJ6Ni8VHgW12DZfViHWCRvFbQgJ5AxB+9KX3CuuH1E3ri1jITyR0f2AOBf5IfbKy6nfD9E6Y3SIiPLU5EuObNojmEHavtlU0VeVL+/vSaW7DwH6k3F5hwnjBs2sh1Rh2952zK0T0hruzhqfEfBO9qxtFgPV/mVCoelsnNnSxv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093516; c=relaxed/simple;
	bh=Aav80nw+Oj48/H0OfvSqZnp5S221N6H/skMuhsyP0SY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ih+xktlSv6RAQEtwRAflqyP89FVeEKgZv6rWgleyL/SY2rg45Z5+KjZysD+vDlGZiFwxx+mmp3k5G02+QIsdFQGqzfuARwtjTOVwN/rNv5oYFZ2MJODnPjcU56qu7Eog4YUojPrEyxgXitOiUV+R2Vx4dU3tw9go7n5OLvmW7S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oqaIBLh1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqaIBLh1"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso727919276.3
        for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2024 15:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726093514; x=1726698314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qY7jazBJP8pJhg0f/dQ9sIJIXrzux0tRJtWLf7xpCl4=;
        b=oqaIBLh1F8VtMse8EnrBoVRex59kZw6XAZv2ohMMLtReSM8F2bldrwdzIfFXiNK0hL
         4InH02T6Dg/wdUWkanSqAcWpeI755R6TkUUrCIgH/mFFJ+i/glt9N3ZvTlTlUe422cNv
         RFzN6TBQ6gf8sM3OSur9+CtTgx82aZilHRnDVQLkXRrBcea6ZhGkCWJwdWyqWMF0Op6K
         cokS2LfUS7ZgS8Dxkz0R/Lz5nHaZ+ttENoUBCV4Eg9LR3pnh5wSOZRjHeggewpEwApKY
         s2mbThuBr6bkzY4F5TIbjhHihVih/2uEPNsfAH9kKjxm4sxl+0qJiy/z3uLTL3PbgvBI
         YjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726093514; x=1726698314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qY7jazBJP8pJhg0f/dQ9sIJIXrzux0tRJtWLf7xpCl4=;
        b=CIVrkn91u035nEuzRlHULhCRDX/JZnoV1FDjZGiHGLTEFrOUj28k2ZjO8+pCBt6wcQ
         i2m+ScYSNedjECmFi504xEwo6obvvV9yoPlTtux9NMqyhHgLsRcfRqIqFZ4WDE1c/h9x
         YCKIrp5fIaCssfMB/NA5pBLcCy8Yl1hT/MPi4xhRANlNk0X9/0d/aOfyghuKH/jRy5Mt
         mWFPAFqi1zfMQpx4PXqv2xnvTqEw8N0TVhJDM9inlt7qZYjeNjrfEggWusH6QqJs+hRH
         QGAel7YkjTAr2UmvYpxpsWc68fhJCjaSe3fhqRD6XD1vAbaekKHQ4PqkW3PehareqH92
         hNxA==
X-Forwarded-Encrypted: i=1; AJvYcCWk35zfd6maX7gWo0Vav6kFxb4YEcn2chFOtGCqyA3dqecx2h9KnCBs9fcaX+o9C3q3HrTOZmXJ7rid@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmgjxmRK4Zg/unT1uQ3GvMaU2xSjSO2B92wV8PG4hFJY2XtCT
	U7dKkmmzCKBtEhHIT4OfU7F2cll6wz6KelcIxvVvhTapyw3iu5hfJbZi7znuj3i1rc428uKp5Ow
	p0PZeH0PdfRleOSMQH6FaAg==
X-Google-Smtp-Source: AGHT+IEJ4qXFa/RnEyqgs+UMl0d9RUxwmlrJg7JrBYtR4wSiyNcS6y1wcbWXE0ormIQyuX+hDspZQAPbFzn+ORG1EA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:27c1:b0:e1a:22d5:d9eb with
 SMTP id 3f1490d57ef6-e1d9db894c5mr1072276.1.1726093513931; Wed, 11 Sep 2024
 15:25:13 -0700 (PDT)
Date: Wed, 11 Sep 2024 22:24:31 +0000
In-Reply-To: <20240911222433.3415301-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911222433.3415301-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911222433.3415301-5-coltonlewis@google.com>
Subject: [PATCH v2 4/5] x86: perf: Refactor misc flag assignments
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

Break the assignment logic for misc flags into their own respective
functions to reduce the complexity of the nested logic.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/x86/events/core.c            | 31 +++++++++++++++++++++++--------
 arch/x86/include/asm/perf_event.h |  2 ++
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 760ad067527c..d51e5d24802b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2948,16 +2948,34 @@ unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
 	return regs->ip + code_segment_base(regs);
 }
 
+static unsigned long common_misc_flags(struct pt_regs *regs)
+{
+	if (regs->flags & PERF_EFLAGS_EXACT)
+		return PERF_RECORD_MISC_EXACT_IP;
+
+	return 0;
+}
+
+unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
+{
+	unsigned long guest_state = perf_guest_state();
+	unsigned long flags = common_misc_flags(regs);
+
+	if (guest_state & PERF_GUEST_USER)
+		flags |= PERF_RECORD_MISC_GUEST_USER;
+	else if (guest_state & PERF_GUEST_ACTIVE)
+		flags |= PERF_RECORD_MISC_GUEST_KERNEL;
+
+	return flags;
+}
+
 unsigned long perf_arch_misc_flags(struct pt_regs *regs)
 {
 	unsigned int guest_state = perf_guest_state();
-	int misc = 0;
+	unsigned long misc = common_misc_flags(regs);
 
 	if (guest_state) {
-		if (guest_state & PERF_GUEST_USER)
-			misc |= PERF_RECORD_MISC_GUEST_USER;
-		else
-			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
+		misc |= perf_arch_guest_misc_flags(regs);
 	} else {
 		if (user_mode(regs))
 			misc |= PERF_RECORD_MISC_USER;
@@ -2965,9 +2983,6 @@ unsigned long perf_arch_misc_flags(struct pt_regs *regs)
 			misc |= PERF_RECORD_MISC_KERNEL;
 	}
 
-	if (regs->flags & PERF_EFLAGS_EXACT)
-		misc |= PERF_RECORD_MISC_EXACT_IP;
-
 	return misc;
 }
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index feb87bf3d2e9..d95f902acc52 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -538,7 +538,9 @@ struct x86_perf_regs {
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
 extern unsigned long perf_arch_misc_flags(struct pt_regs *regs);
+extern unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs);
 #define perf_arch_misc_flags(regs)	perf_arch_misc_flags(regs)
+#define perf_arch_guest_misc_flags(regs)	perf_arch_guest_misc_flags(regs)
 
 #include <asm/stacktrace.h>
 
-- 
2.46.0.598.g6f2099f65c-goog

