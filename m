Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33A166F13
	for <linux-s390@vger.kernel.org>; Wed,  4 Sep 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482553; cv=none; b=IEWkNjyNLW2Ak0o18RmjHOooPc9r4d5PnfDMUBlKRQ+3wUqmA4PFmTuAlY0Z34nwMTLUngIbrpr90pndcUHzLrW2wi0KvFtJY441OO1Et9a+8/gRYsBAnjDtasYRlsmot9X/ptkMjEmTYrm19+v5+HyHv0rgNXInnCWnS7zzwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482553; c=relaxed/simple;
	bh=03a6lGwIb8EWUW/4KBYQo75tG5sBT5AYfr3dT9mgeS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WGCx2xZMIUTlbHrFmWPRBS7ztjbsWX9EDSkUMUr3LDA8tAJChxIrXDGYzd2yn0sZTzbkHPoO6G9dNrxS98LMZ7i4iJKxTu4ySb6ig0ysWq0OHBz/srUbf3hoINaZxpsc676bXtQvsi/9NGZFeQzBQAtS9qOHQzCBxc1Ge10ZjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0UMIRO1R; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0UMIRO1R"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1a892d8438so184256276.3
        for <linux-s390@vger.kernel.org>; Wed, 04 Sep 2024 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725482550; x=1726087350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i72PSOIXWhCeY4HgM9YgFlmZggdii21Cl4McUfu+68c=;
        b=0UMIRO1RHKYuT4Dp3PVwJXHcefZXwUBh7fK7+/lU+5DSvgwEjyuJHIGuihb0l4oTSe
         c71pJ1VvgLysFXjTHjuqgB/Oa3oEVlBu+kUfrKNtwY35oA7xlqyufR3s/mgTAdlF0GtG
         QCFCR5461OPCBYBksZLnNTmmEZvTWJBM7/cMFXjV/LJ6+7lzp6GR1VG09tv9qk7+9emT
         Zxic+qlDswZEjVQ2883MCwrQRA3Xy6FDfE6+n8GZ1BqXG4aKLnqx53gDhDUiN9+DaVYR
         EsIeKKQFnKlp32V1ADbwjmYoQRpyz+8V6w64agEmAW2qoIvosrvT7cdMPLrOqSSOtR17
         H+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725482550; x=1726087350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i72PSOIXWhCeY4HgM9YgFlmZggdii21Cl4McUfu+68c=;
        b=sCX2IbCE0mqQ9dHvu+MPivkVVaiE3ocu2dy8c+80IKbDLc9DgCsEQuaMCQdEfSE10w
         Anim7K1S4ZcifYWAEMfuA5P81X5f0zV3IRKsJdSfsDTCoLH4wbIoAfAmvyR+O2r8iRy+
         EfYnGUfZZpyAhZeiuz13DWZI+F9twrEw5MqiHVNAsOAdcbQv7lUyF3HlAWrPTKzc8P+k
         7MSGI36LRRET+1Dxcku8csoF/w3kKgiTy8z5d4I7hLSIEs/pItV5tPRn7hP4DRJRt3rj
         hVntt3LlcFY0blmY4GB+kaDp6PVRDxbQGP/rem7XOEorW7SjBte/niiiHjpfKvNoDDSa
         XnJw==
X-Forwarded-Encrypted: i=1; AJvYcCV4sw0v2p2XhPnbPEc+W19XwaVI6QTqLQX9qQCosLMtyxMXY2B6bBfR8IPjMOCke66PXDeKNZrTRrj0@vger.kernel.org
X-Gm-Message-State: AOJu0YyR14nELTb/O62EI7P8tvGYWqXMRcgXLbh0xwIknAEzACmhrNLR
	V43hYJ/WX3WyLlE/bwFAH1N5gGphZgOyLWr1WiJ21vML+klsjxF/9vB7KPxjw17euyZ7z6Ft8NH
	owSAo9VLXfImhqfFzmtktuA==
X-Google-Smtp-Source: AGHT+IFmR24uVrOJthtOJz6K2WVb+jtHXjG+hacdDNR8Ql4EFrmp0GPrZ3zw2M5BxgYPY6TLAf+W8lj+BLe1iw09KQ==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a25:361a:0:b0:e0e:445b:606 with SMTP
 id 3f1490d57ef6-e1d0e58575emr4988276.0.1725482550264; Wed, 04 Sep 2024
 13:42:30 -0700 (PDT)
Date: Wed,  4 Sep 2024 20:41:32 +0000
In-Reply-To: <20240904204133.1442132-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904204133.1442132-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240904204133.1442132-5-coltonlewis@google.com>
Subject: [PATCH 4/5] x86: perf: Refactor misc flag assignments
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
index 760ad067527c..87457e5d7f65 100644
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
+	unsigned long flags = common_misc_flags();
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
+	unsigned long misc = common_misc_flags();
 
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
2.46.0.469.g59c65b2a67-goog

