Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CAA69DFF
	for <linux-s390@vger.kernel.org>; Thu, 19 Sep 2024 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726772892; cv=none; b=eQ3+5Aa+u1pgDQ42yeqgbLf/O4hmlZ1Z1U++DbrUaNkG7s5TCpKNPLTJ5xD5qMMIzBux/gsZnUArVF+qaX9XZsmTThNtPBLcT7/SCyIsEwda1MVPd8X9lqfL6y6gi3WNN5A4CCJuFkTRm4ZrEWBIGuzWdkNwmD5jxC5KUgfYYhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726772892; c=relaxed/simple;
	bh=89Zm4mmpvjM/U+CUZDYBSu7yanpawEalqKF+fM/U4wY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n/C7OVhdB1aD3StJQ09hR9ZgIJxyJ4eLkuD8wSr9EqvevRt4vizr3SqjXL4XxXchZF609eVyxWPoy+r6fmzmYfeOBcX+2EAenvl/YN2cIfYyl58bvhJoNls3FwjgL7lb62seWijxfeP59M3tUDqchNX4YxyI09VoQr50bIaq6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fs44Ohqa; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fs44Ohqa"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ddcf7599ddso18954947b3.1
        for <linux-s390@vger.kernel.org>; Thu, 19 Sep 2024 12:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726772889; x=1727377689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=09zZtsyjNKU34RxIAdYq19fo4EG569yh76FDw7B839k=;
        b=Fs44Ohqai4CeB17KKJ+bXMLSxTCuDkBJz96QZX00zzOIHb72UjEOn+tYXE0rj4QiCU
         /9bP20Z4RkBIOY048M83vu7v7p1F4gI/HYJZIE29Sbfi6PX6Gk0lL+LyNih+kK3AvAMx
         XY1glDl1qO/wWHuXJipl6Rg1Ok3fLSOrkk2NTQ7B8X7RfhKHITMjG8KW7suZ9a9+KOtb
         0ddbRxjtMLF6ONelOTcmv2l956R8YYkoLIzyzz9QSQarBoTUGAZqn70d5shQRoUoyweT
         odPhChSS5edW2x61/yR0ewPlSBbEnvF42AZVkfG85KjOS8JSV98hXRCSFauCJaCWBf9h
         Q+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726772889; x=1727377689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09zZtsyjNKU34RxIAdYq19fo4EG569yh76FDw7B839k=;
        b=xG4Qdn1UaT0ZAsGWPbLRtD8O7TD2GgyuijdcyRVBJs7Thr4uZDtPwI2EZ3aEjFYQRT
         t/tflNJKUAFl0DM8hISzHL3Cwuv7a7jIWT0mIG4rPtx57vul+PkasYW/d8pDDHD7oc47
         2YNWrKIdNpTWoYBmXpGtU/feXJwhKnqA4wAnXW7UlRFsEKLfchkJaaXXC8x9on58iZ1c
         if2Q/nQtXJhpX5CXvpUBSsevjlPeTPlJJw+LSIOjVDNpFc6pTMWLlEnsyci5FqFB+GHZ
         pnUoZn7JSHSFnaLX/y6l8jTPSnRvc5/0vRz0G4jYt9Ma3DIehWinOLUhbde0JmnH0F7f
         /TQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYZB0FJy+6LNaLJDraWzZcNdSOGvVQToA6gr4QeSDLYZykVvOvzl42kFQ7ifWsRhlIxDlkkG23slGc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgv64xzI1+Gh3P8C3ny92WITCBazxWp0bKCwEu/P0+yWDKH/A+
	nfsr5BBttlf6YMjXdmOPeQDMwwlhRbLCdfV846hnWF3xq02wK/PC6j7el4xplBGovH7biDeVZ+z
	6c8cSTvHcaw+yIsT4rzEWxQ==
X-Google-Smtp-Source: AGHT+IH7DS+SKBUjwFhvlyrXRx7BdcWzXxigrbQzKIYP4oeDJso13ZKWEUISE2cE3y2zWZHTyZIEgxGF1DgagD7KPQ==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:1347:b0:e0b:958a:3344 with
 SMTP id 3f1490d57ef6-e2250cd2f53mr3552276.10.1726772889473; Thu, 19 Sep 2024
 12:08:09 -0700 (PDT)
Date: Thu, 19 Sep 2024 19:07:50 +0000
In-Reply-To: <20240919190750.4163977-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240919190750.4163977-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240919190750.4163977-6-coltonlewis@google.com>
Subject: [PATCH v4 5/5] perf: Correct perf sampling with guest VMs
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

Previously any PMU overflow interrupt that fired while a VCPU was
loaded was recorded as a guest event whether it truly was or not. This
resulted in nonsense perf recordings that did not honor
perf_event_attr.exclude_guest and recorded guest IPs where it should
have recorded host IPs.

Rework the sampling logic to only record guest samples for events with
exclude_guest = 0. This way any host-only events with exclude_guest
set will never see unexpected guest samples. The behaviour of events
with exclude_guest = 0 is unchanged.

Note that events configured to sample both host and guest may still
misattribute a PMI that arrived in the host as a guest event depending
on KVM arch and vendor behavior.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/perf_event.h |  4 ----
 arch/arm64/kernel/perf_callchain.c  | 28 ----------------------------
 arch/x86/events/core.c              | 16 ++++------------
 include/linux/perf_event.h          | 21 +++++++++++++++++++--
 kernel/events/core.c                | 21 +++++++++++++++++----
 5 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 31a5584ed423..ee45b4e77347 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -10,10 +10,6 @@
 #include <asm/ptrace.h>
 
 #ifdef CONFIG_PERF_EVENTS
-struct pt_regs;
-extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
-extern unsigned long perf_arch_misc_flags(struct pt_regs *regs);
-#define perf_arch_misc_flags(regs)	perf_misc_flags(regs)
 #define perf_arch_bpf_user_pt_regs(regs) &regs->user_regs
 #endif
 
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index 01a9d08fc009..9b7f26b128b5 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -38,31 +38,3 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 
 	arch_stack_walk(callchain_trace, entry, current, regs);
 }
-
-unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
-{
-	if (perf_guest_state())
-		return perf_guest_get_ip();
-
-	return instruction_pointer(regs);
-}
-
-unsigned long perf_arch_misc_flags(struct pt_regs *regs)
-{
-	unsigned int guest_state = perf_guest_state();
-	int misc = 0;
-
-	if (guest_state) {
-		if (guest_state & PERF_GUEST_USER)
-			misc |= PERF_RECORD_MISC_GUEST_USER;
-		else
-			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
-	} else {
-		if (user_mode(regs))
-			misc |= PERF_RECORD_MISC_USER;
-		else
-			misc |= PERF_RECORD_MISC_KERNEL;
-	}
-
-	return misc;
-}
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d51e5d24802b..3c5f512d2bcf 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2942,9 +2942,6 @@ static unsigned long code_segment_base(struct pt_regs *regs)
 
 unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
 {
-	if (perf_guest_state())
-		return perf_guest_get_ip();
-
 	return regs->ip + code_segment_base(regs);
 }
 
@@ -2971,17 +2968,12 @@ unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
 
 unsigned long perf_arch_misc_flags(struct pt_regs *regs)
 {
-	unsigned int guest_state = perf_guest_state();
 	unsigned long misc = common_misc_flags(regs);
 
-	if (guest_state) {
-		misc |= perf_arch_guest_misc_flags(regs);
-	} else {
-		if (user_mode(regs))
-			misc |= PERF_RECORD_MISC_USER;
-		else
-			misc |= PERF_RECORD_MISC_KERNEL;
-	}
+	if (user_mode(regs))
+		misc |= PERF_RECORD_MISC_USER;
+	else
+		misc |= PERF_RECORD_MISC_KERNEL;
 
 	return misc;
 }
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d061e327ad54..968f3edd95e4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1633,8 +1633,9 @@ extern void perf_tp_event(u16 event_type, u64 count, void *record,
 			  struct task_struct *task);
 extern void perf_bp_event(struct perf_event *event, void *data);
 
-extern unsigned long perf_misc_flags(struct pt_regs *regs);
-extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
+extern unsigned long perf_misc_flags(struct perf_event *event, struct pt_regs *regs);
+extern unsigned long perf_instruction_pointer(struct perf_event *event,
+					      struct pt_regs *regs);
 
 #ifndef perf_arch_misc_flags
 # define perf_arch_misc_flags(regs) \
@@ -1645,6 +1646,22 @@ extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
 # define perf_arch_bpf_user_pt_regs(regs) regs
 #endif
 
+#ifndef perf_arch_guest_misc_flags
+static inline unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
+{
+	unsigned long guest_state = perf_guest_state();
+
+	if (guest_state & PERF_GUEST_USER)
+		return PERF_RECORD_MISC_GUEST_USER;
+
+	if (guest_state & PERF_GUEST_ACTIVE)
+		return PERF_RECORD_MISC_GUEST_KERNEL;
+
+	return 0;
+}
+# define perf_arch_guest_misc_flags(regs)	perf_arch_guest_misc_flags(regs)
+#endif
+
 static inline bool has_branch_stack(struct perf_event *event)
 {
 	return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index eeabbf791a8c..c5e57c024d9a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6921,13 +6921,26 @@ void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
 #endif
 
-unsigned long perf_misc_flags(struct pt_regs *regs)
+static bool should_sample_guest(struct perf_event *event)
 {
+	return !event->attr.exclude_guest && perf_guest_state();
+}
+
+unsigned long perf_misc_flags(struct perf_event *event,
+			      struct pt_regs *regs)
+{
+	if (should_sample_guest(event))
+		return perf_arch_guest_misc_flags(regs);
+
 	return perf_arch_misc_flags(regs);
 }
 
-unsigned long perf_instruction_pointer(struct pt_regs *regs)
+unsigned long perf_instruction_pointer(struct perf_event *event,
+				       struct pt_regs *regs)
 {
+	if (should_sample_guest(event))
+		return perf_guest_get_ip();
+
 	return perf_arch_instruction_pointer(regs);
 }
 
@@ -7743,7 +7756,7 @@ void perf_prepare_sample(struct perf_sample_data *data,
 	__perf_event_header__init_id(data, event, filtered_sample_type);
 
 	if (filtered_sample_type & PERF_SAMPLE_IP) {
-		data->ip = perf_instruction_pointer(regs);
+		data->ip = perf_instruction_pointer(event, regs);
 		data->sample_flags |= PERF_SAMPLE_IP;
 	}
 
@@ -7907,7 +7920,7 @@ void perf_prepare_header(struct perf_event_header *header,
 {
 	header->type = PERF_RECORD_SAMPLE;
 	header->size = perf_sample_data_size(data, event);
-	header->misc = perf_misc_flags(regs);
+	header->misc = perf_misc_flags(event, regs);
 
 	/*
 	 * If you're adding more sample types here, you likely need to do
-- 
2.46.0.792.g87dc391469-goog

