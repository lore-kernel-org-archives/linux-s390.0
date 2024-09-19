Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C724B29
	for <linux-s390@vger.kernel.org>; Thu, 19 Sep 2024 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726772888; cv=none; b=NBlVS5DAQheg7mo8OAiR992WX85wFUqIN/ticqoX5U+LpnWgsQreBoFSdteNcBhRrBKVVFf4To6HsVGsKxIfch+svT/REMoYYy+t1tiRHKr3CJzTQ88fkpZKtVXo3n12hpfqE1SS75UuxiGsGu7adS7jhWggNKX/CPzBSIwkS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726772888; c=relaxed/simple;
	bh=ZyXKAF/kW35s8MdFbY9doBNzwvd6DnYkfIUC7Tv9pZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WYe1XjkxemF/PAHkhMYUqI/hB3xi/z1x2yXeWgrxLpuYKiEt6hogoL0x00IC9R1tmU6tUH8HNbvjb1lnE4im4NtCR+8VEysVp9TkQXPBrjPohdpBvkKef5CgUC8uo4729oZvYvO5aqDHZU+zH6mwKNgURsb8R8SRps2cs/qraPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bOdabKg7; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bOdabKg7"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-82aa9477f54so119425339f.0
        for <linux-s390@vger.kernel.org>; Thu, 19 Sep 2024 12:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726772885; x=1727377685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PI01NOAwUBTbTYBhGD7vAZyLVwWtrbZIdss2qywEk8I=;
        b=bOdabKg7uST7ufTxDnDUe3zyzyMQKxZq9uNVJVzUKykjTRZRsFQ4ZSAGqR7l/cp54Q
         FFQBhp/AjsmARSSlq3prTKexUUi8STWm/qaxBtq81Bb5r9KulTjvLmA4F7klspm3sXJ3
         caO2O137fvPAW2oMTV3twSMgu+6045aoH5I7124dJfysYrRnTiIExTglZQw6YBwKYd8P
         Bn8OpdIEKy9KDkuh7JokOJjOHqRXnDLbjrd2Z1z+8wfif2tr1C47YYdrXDCsUiFZtL3F
         9DgPUI9d/lvJix+bVCmXrWvuR9mBoN+BW2heu66qVDTRyY+dvEVFtTM0hG1fRV7kxZFy
         33+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726772885; x=1727377685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PI01NOAwUBTbTYBhGD7vAZyLVwWtrbZIdss2qywEk8I=;
        b=tK4vYshpM7kbXhWwisNcjn6zHp1jlVqpD1JnIeUQWU7LYaVg2YAxsuRKbhZ7MsVMX9
         BiDfD3zjnlMPC6ilVLb4+pDsHg+c5IhWW5s4/ZlJn4wIue8pqrHcuVNbqKjiUnzMwwp3
         VMqbLUeZWuRwMbwQAuTz+dfZfSVBZnQ0/RDoldFOrdRDh0i3u+wYl6/bACgXTVRLO2cG
         5LUarjxA4LW3oo7W6vNj8zGTp15FZz9FYAZSCRwNs+He0adghQ8I8pqag6oZP4n1jgkn
         u/40Kc/kSkDZXHKumfNqVutLo1nqjiTeok5jgvDNldawKi9J43FUUeta+TgOnV6MzpwF
         q3TA==
X-Forwarded-Encrypted: i=1; AJvYcCUumkT9PeRNrQfWMl4AG882gWnHww0ipsQaUcX/4UmUrLS47AZxja6JSO5p20MIZNRits+uUjKFcbr/@vger.kernel.org
X-Gm-Message-State: AOJu0YylYEXAHU11+leo2T5BmvkiHJUdeFUPGVFgBqTI8Q4pX6chrDpm
	ZSebrJGC0NH/75sSZDGYlul2KD9FNJDTypeIF0IHNaqnZ9rHseoImgCb2Gq8a/dtjFSeuhPai5v
	sg3E57V4nRmOeqP2gGQIomw==
X-Google-Smtp-Source: AGHT+IFXF42PxsE/0eJNPgXYyij53e22bxgy0o5zvBDcPWfeczAztmoWZY1bSRZHpVpQzrCe+MiXIaYy8y/4W5uIkw==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6638:8507:b0:4b9:ad94:2074 with
 SMTP id 8926c6da1cb9f-4d3d684d324mr6497173.3.1726772885573; Thu, 19 Sep 2024
 12:08:05 -0700 (PDT)
Date: Thu, 19 Sep 2024 19:07:47 +0000
In-Reply-To: <20240919190750.4163977-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240919190750.4163977-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240919190750.4163977-3-coltonlewis@google.com>
Subject: [PATCH v4 2/5] perf: Hoist perf_instruction_pointer() and perf_misc_flags()
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

For clarity, rename the arch-specific definitions of these functions
to perf_arch_* to denote they are arch-specifc. Define the
generic-named functions in one place where they can call the
arch-specific ones as needed.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/perf_event.h          |  6 +++---
 arch/arm64/kernel/perf_callchain.c           |  4 ++--
 arch/powerpc/include/asm/perf_event_server.h |  6 +++---
 arch/powerpc/perf/core-book3s.c              |  4 ++--
 arch/s390/include/asm/perf_event.h           |  6 +++---
 arch/s390/kernel/perf_event.c                |  4 ++--
 arch/x86/events/core.c                       |  4 ++--
 arch/x86/include/asm/perf_event.h            | 10 +++++-----
 include/linux/perf_event.h                   |  9 ++++++---
 kernel/events/core.c                         | 10 ++++++++++
 10 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index eb7071c9eb34..31a5584ed423 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -11,9 +11,9 @@
 
 #ifdef CONFIG_PERF_EVENTS
 struct pt_regs;
-extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
-extern unsigned long perf_misc_flags(struct pt_regs *regs);
-#define perf_misc_flags(regs)	perf_misc_flags(regs)
+extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
+extern unsigned long perf_arch_misc_flags(struct pt_regs *regs);
+#define perf_arch_misc_flags(regs)	perf_misc_flags(regs)
 #define perf_arch_bpf_user_pt_regs(regs) &regs->user_regs
 #endif
 
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index e8ed5673f481..01a9d08fc009 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -39,7 +39,7 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 	arch_stack_walk(callchain_trace, entry, current, regs);
 }
 
-unsigned long perf_instruction_pointer(struct pt_regs *regs)
+unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
 {
 	if (perf_guest_state())
 		return perf_guest_get_ip();
@@ -47,7 +47,7 @@ unsigned long perf_instruction_pointer(struct pt_regs *regs)
 	return instruction_pointer(regs);
 }
 
-unsigned long perf_misc_flags(struct pt_regs *regs)
+unsigned long perf_arch_misc_flags(struct pt_regs *regs)
 {
 	unsigned int guest_state = perf_guest_state();
 	int misc = 0;
diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 5995614e9062..af0f46e2373b 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -102,8 +102,8 @@ struct power_pmu {
 int __init register_power_pmu(struct power_pmu *pmu);
 
 struct pt_regs;
-extern unsigned long perf_misc_flags(struct pt_regs *regs);
-extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
+extern unsigned long perf_arch_misc_flags(struct pt_regs *regs);
+extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
 extern unsigned long int read_bhrb(int n);
 
 /*
@@ -111,7 +111,7 @@ extern unsigned long int read_bhrb(int n);
  * if we have hardware PMU support.
  */
 #ifdef CONFIG_PPC_PERF_CTRS
-#define perf_misc_flags(regs)	perf_misc_flags(regs)
+#define perf_arch_misc_flags(regs)	perf_arch_misc_flags(regs)
 #endif
 
 /*
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 42867469752d..dc01aa604cc1 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2332,7 +2332,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
  * Called from generic code to get the misc flags (i.e. processor mode)
  * for an event_id.
  */
-unsigned long perf_misc_flags(struct pt_regs *regs)
+unsigned long perf_arch_misc_flags(struct pt_regs *regs)
 {
 	u32 flags = perf_get_misc_flags(regs);
 
@@ -2346,7 +2346,7 @@ unsigned long perf_misc_flags(struct pt_regs *regs)
  * Called from generic code to get the instruction pointer
  * for an event_id.
  */
-unsigned long perf_instruction_pointer(struct pt_regs *regs)
+unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
 {
 	unsigned long siar = mfspr(SPRN_SIAR);
 
diff --git a/arch/s390/include/asm/perf_event.h b/arch/s390/include/asm/perf_event.h
index 9917e2717b2b..f2d83289ec7a 100644
--- a/arch/s390/include/asm/perf_event.h
+++ b/arch/s390/include/asm/perf_event.h
@@ -37,9 +37,9 @@ extern ssize_t cpumf_events_sysfs_show(struct device *dev,
 
 /* Perf callbacks */
 struct pt_regs;
-extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
-extern unsigned long perf_misc_flags(struct pt_regs *regs);
-#define perf_misc_flags(regs) perf_misc_flags(regs)
+extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
+extern unsigned long perf_arch_misc_flags(struct pt_regs *regs);
+#define perf_arch_misc_flags(regs) perf_misc_flags(regs)
 #define perf_arch_bpf_user_pt_regs(regs) &regs->user_regs
 
 /* Perf pt_regs extension for sample-data-entry indicators */
diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.c
index 5fff629b1a89..f9000ab49f4a 100644
--- a/arch/s390/kernel/perf_event.c
+++ b/arch/s390/kernel/perf_event.c
@@ -57,7 +57,7 @@ static unsigned long instruction_pointer_guest(struct pt_regs *regs)
 	return sie_block(regs)->gpsw.addr;
 }
 
-unsigned long perf_instruction_pointer(struct pt_regs *regs)
+unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
 {
 	return is_in_guest(regs) ? instruction_pointer_guest(regs)
 				 : instruction_pointer(regs);
@@ -84,7 +84,7 @@ static unsigned long perf_misc_flags_sf(struct pt_regs *regs)
 	return flags;
 }
 
-unsigned long perf_misc_flags(struct pt_regs *regs)
+unsigned long perf_arch_misc_flags(struct pt_regs *regs)
 {
 	/* Check if the cpum_sf PMU has created the pt_regs structure.
 	 * In this case, perf misc flags can be easily extracted.  Otherwise,
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index be01823b1bb4..760ad067527c 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2940,7 +2940,7 @@ static unsigned long code_segment_base(struct pt_regs *regs)
 	return 0;
 }
 
-unsigned long perf_instruction_pointer(struct pt_regs *regs)
+unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
 {
 	if (perf_guest_state())
 		return perf_guest_get_ip();
@@ -2948,7 +2948,7 @@ unsigned long perf_instruction_pointer(struct pt_regs *regs)
 	return regs->ip + code_segment_base(regs);
 }
 
-unsigned long perf_misc_flags(struct pt_regs *regs)
+unsigned long perf_arch_misc_flags(struct pt_regs *regs)
 {
 	unsigned int guest_state = perf_guest_state();
 	int misc = 0;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 91b73571412f..feb87bf3d2e9 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -536,15 +536,15 @@ struct x86_perf_regs {
 	u64		*xmm_regs;
 };
 
-extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
-extern unsigned long perf_misc_flags(struct pt_regs *regs);
-#define perf_misc_flags(regs)	perf_misc_flags(regs)
+extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
+extern unsigned long perf_arch_misc_flags(struct pt_regs *regs);
+#define perf_arch_misc_flags(regs)	perf_arch_misc_flags(regs)
 
 #include <asm/stacktrace.h>
 
 /*
- * We abuse bit 3 from flags to pass exact information, see perf_misc_flags
- * and the comment with PERF_EFLAGS_EXACT.
+ * We abuse bit 3 from flags to pass exact information, see
+ * perf_arch_misc_flags() and the comment with PERF_EFLAGS_EXACT.
  */
 #define perf_arch_fetch_caller_regs(regs, __ip)		{	\
 	(regs)->ip = (__ip);					\
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a8942277dda..d061e327ad54 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1633,10 +1633,13 @@ extern void perf_tp_event(u16 event_type, u64 count, void *record,
 			  struct task_struct *task);
 extern void perf_bp_event(struct perf_event *event, void *data);
 
-#ifndef perf_misc_flags
-# define perf_misc_flags(regs) \
+extern unsigned long perf_misc_flags(struct pt_regs *regs);
+extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
+
+#ifndef perf_arch_misc_flags
+# define perf_arch_misc_flags(regs) \
 		(user_mode(regs) ? PERF_RECORD_MISC_USER : PERF_RECORD_MISC_KERNEL)
-# define perf_instruction_pointer(regs)	instruction_pointer(regs)
+# define perf_arch_instruction_pointer(regs)	instruction_pointer(regs)
 #endif
 #ifndef perf_arch_bpf_user_pt_regs
 # define perf_arch_bpf_user_pt_regs(regs) regs
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8a6c6bbcd658..eeabbf791a8c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6921,6 +6921,16 @@ void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
 #endif
 
+unsigned long perf_misc_flags(struct pt_regs *regs)
+{
+	return perf_arch_misc_flags(regs);
+}
+
+unsigned long perf_instruction_pointer(struct pt_regs *regs)
+{
+	return perf_arch_instruction_pointer(regs);
+}
+
 static void
 perf_output_sample_regs(struct perf_output_handle *handle,
 			struct pt_regs *regs, u64 mask)
-- 
2.46.0.792.g87dc391469-goog

