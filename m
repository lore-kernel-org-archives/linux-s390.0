Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0948316E886
	for <linux-s390@vger.kernel.org>; Wed,  4 Sep 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482553; cv=none; b=GI01duIINL0EzN9TNi0dNdGb7/CRmOeh7zNSRjbrrFSb4CMTAOMoNRfC1C59lAiDWdj+VuK5wGCUQ31lfVR2qRWH9GsQHlX/7b/m89CWbsK8aHQJ/XBe53bf42GYFiNZfzBpQnNuLgPpcg3ZOrNFUcfT1kYPXvdgnJUYfpkK/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482553; c=relaxed/simple;
	bh=+AZhzeE+TZ65vAr8u0N0Wleqi4qKXSh9vbq6Xw4afuc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gznYtBTteDv93qPvAVyZBMWbmfRx8qV4Hx3F9ZlYp8RPl/rCG8MLz7ml2znkkD2Jrun0p9bScGPPr5cSjXEfGD60goQfCriohbUTTO3aI62/1KgFwtbLXRVLBatNl0RJ4Qm8Hhg3HJwVRIFskeM7iSHQyFtpSc2RxX1gJrS4F0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W9uWlABW; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9uWlABW"
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-82a36f1515cso696314239f.2
        for <linux-s390@vger.kernel.org>; Wed, 04 Sep 2024 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725482551; x=1726087351; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ6pbNS+V/v0w7+0Yvg7TstZGOzD6SJqSq8ykXuoLos=;
        b=W9uWlABWlk6rkslwryzLyKF5lu//qfMqLlhiWx9JDhsF6HXeGtKgxe25z/CYrfcl/G
         CwotkMJjWFrb28DsuqeeprfnAeVXYW+VAfufZ3Lx7/umBWAgkyiasqM+YbrIxZc7P6QC
         TQ2fc099wbS5PaBu8R8QLwRaQ0pOni8ndH8aKtqIZMosNnxWYdlPovtojyoPRrl4f/kA
         f0BelHO9EsjPyxGbqR8fGzeGs4SR+aztdIPJpuxiPqspCXpGy1PXS0VKIr8xYU8aboS6
         zEZXzXq4MCO9oWSRVChkfH5+LbpE25yc/xeYFsRiQw44xTOcC1K4h2AZo6C2IBzrda5/
         y/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725482551; x=1726087351;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ6pbNS+V/v0w7+0Yvg7TstZGOzD6SJqSq8ykXuoLos=;
        b=FDnoDnus1QZo5bTdIk+CLjv/7hOq16bIAEQh7+tI4dmypZRNgBPPaXrv5Zlzl1iHlI
         tItxSnhAkl0NwsrfmTcCeHAjAd3nq+SUvt/gtCX63H/G84lYWiLblUFcaF+R5yCKdNgS
         MPJICCmBIbbwvd62OEHv3hUwN7WZThBO9lXulza4RKpuX7B0KYpvMwHUQ0s5FCykjbui
         zElwpgcQ3qtQsP2uZAlx3oQIgm2SUIF3GDozKw0uI0ijaVxeup3Zj1MX4OmU6uzucB/F
         v2YpyEu48cBB+MRnkb9JsckSZ5yyoRbkuj2FErmIaWFGhHH3tOHxOUdnCr9CciifucGG
         unhw==
X-Forwarded-Encrypted: i=1; AJvYcCWmBtV8KX22Ru2i9GDyl8iGYbBGqU2aFc8cHkJe6Y415gJZozLuPshmuCjsp52zvC0umnKX0M4knv8Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxxWQAXr4pNf69GQY6r/bao2C9XnPenyreCK10Sjkpl9/SI5NE3
	uW7sC1JMqZ6UqHq6fVn9mc2m0QnZBTMgpdx5REUeDhZbrxEfAKFfkVCIZmND9N07s7kC6aMcljx
	Zxodsk9/fYcCpvAqZkO+/Gw==
X-Google-Smtp-Source: AGHT+IH9EBCT8+ykT+OpvYVmgAL1GejG/P9BrG7iuA2P0w+bQDK+bVWQxO99M8Ql2oemuKA/7xEPoMWRBeRAyi1Jng==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:40a3:b0:4b9:ad96:2adc with
 SMTP id 8926c6da1cb9f-4d017e9afc4mr1111520173.4.1725482551325; Wed, 04 Sep
 2024 13:42:31 -0700 (PDT)
Date: Wed,  4 Sep 2024 20:41:33 +0000
In-Reply-To: <20240904204133.1442132-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904204133.1442132-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240904204133.1442132-6-coltonlewis@google.com>
Subject: [PATCH 5/5] perf: Correct perf sampling with guest VMs
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

Reorganize that plumbing to record perf events correctly even when
VCPUs are loaded.

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
index 87457e5d7f65..2049b70c5af7 100644
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
 	unsigned long misc = common_misc_flags();
 
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
index 4384f6c49930..e1a66c9c3773 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6915,13 +6915,26 @@ void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
 #endif
 
-unsigned long perf_misc_flags(unsigned long pt_regs *regs)
+static bool is_guest_event(struct perf_event *event)
 {
+	return !event->attr.exclude_guest && perf_guest_state();
+}
+
+unsigned long perf_misc_flags(struct perf_event *event,
+			      struct pt_regs *regs)
+{
+	if (is_guest_event(event))
+		return perf_arch_guest_misc_flags(regs);
+
 	return perf_arch_misc_flags(regs);
 }
 
-unsigned long perf_instruction_pointer(unsigned long pt_regs *regs)
+unsigned long perf_instruction_pointer(struct perf_event *event,
+				       struct pt_regs *regs)
 {
+	if (is_guest_event(event))
+		return perf_guest_get_ip();
+
 	return perf_arch_instruction_pointer(regs);
 }
 
@@ -7737,7 +7750,7 @@ void perf_prepare_sample(struct perf_sample_data *data,
 	__perf_event_header__init_id(data, event, filtered_sample_type);
 
 	if (filtered_sample_type & PERF_SAMPLE_IP) {
-		data->ip = perf_instruction_pointer(regs);
+		data->ip = perf_instruction_pointer(event, regs);
 		data->sample_flags |= PERF_SAMPLE_IP;
 	}
 
@@ -7901,7 +7914,7 @@ void perf_prepare_header(struct perf_event_header *header,
 {
 	header->type = PERF_RECORD_SAMPLE;
 	header->size = perf_sample_data_size(data, event);
-	header->misc = perf_misc_flags(regs);
+	header->misc = perf_misc_flags(event, regs);
 
 	/*
 	 * If you're adding more sample types here, you likely need to do
-- 
2.46.0.469.g59c65b2a67-goog

