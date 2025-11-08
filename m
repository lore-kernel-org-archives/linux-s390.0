Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DD24677C
	for <linux-s390@vger.kernel.org>; Sat,  8 Nov 2025 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622719; cv=none; b=AHxf5SxhTnWiYkB0aTv0MGYX4HFg6pZAUUIJjV74YqgBZu8UAwV9VKOFtQSFnPkeFcXv6gKAkM4Wlbv3HHjaroxzaj3mCyPpjPDBzc0oYtBLI/4oGYfxvZ3lVr9U4QX4Cqypmw/qxE839SeNlRiYqBSRCt936wf0Fzblqh5zFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622719; c=relaxed/simple;
	bh=tAQlIEkwJ2sCMsvaNedkWALZ2aqqsCV85XAAJBYBRUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sd1DbvO1heW0sq9NRAjc5C3DU43Y3PRFz/pj17qpIs5cAOGoR3/A6kL3bgYBKZe/uPp1AsDlCHRjgdZ3e7qffqH2RIOLTWTVRPfmHFIPJLzMQiU2d1egZEUzR45f5lHQzNcwwXcOBjn0A2f6HjL+BOKWSVbO4hCnBDMqprMUbqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L25qxfg1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L25qxfg1"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34374febdefso464509a91.0
        for <linux-s390@vger.kernel.org>; Sat, 08 Nov 2025 09:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762622717; x=1763227517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TYL/KcboSr09KpEpWrRMXlQpJhItw5S/fTw0hxpRX4=;
        b=L25qxfg1QceuUxnxHJ7LB/0AgBxYHj02BlPf5l3LQ1xd5WG0LqJXqj/Hk1Ff5G1Rty
         10twnLyuPMoYXliuE0/Yy5ICrC7hbdz4gImElIy4ED4oZNPXgUfkpRC9IGoAU2/oDm9g
         hnv7SXmPP0l6FN4+K64h9mJPVEzaiTYTd6X6Boznm35kEmTld4VPJLKX/VdxL3+E88/X
         En+lnSMcwx3gvRbNZJr8LlHzI4doOU0LsNucpAW2Cxhfm2J3FRb0wNGbBU1BIRWjLK/X
         1zQ+Uf2XXTQ3dgFqSzeCSZp4Jpi9qkL+BZBp01m1klPUk+Ok3OFk1rPH/ZEgynWPffgo
         G2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762622717; x=1763227517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2TYL/KcboSr09KpEpWrRMXlQpJhItw5S/fTw0hxpRX4=;
        b=YYTw8O9KNeHwYmDtY9OduU2QTTTXqxr+5PAPWtYpeGufhnBaCwtNPFeh3pm2YiMKAU
         Xm5gvjgWeqZuhaZFV3WvOFv71SWKVWd+ppPdmZ6EdW8EJOCUBePNCEhnaAI4LN7TMeW8
         4/oiM28gkqhaU0/xeV/O0f80OygOgwrh8k6+HGRhfYYZCSYZQWLFZ0syaaxkhJsmFgBY
         EMSMjmBBZcUbPQ543jLIPnAwPPXdx8AGAJmQBRBr4WM1weHagdrnGwsGKY2SGDRO5BNV
         1//VbGSWQKfxoerNnB4X3wNtEX7eyAC0p/Lzl36GaBiQ3mcXRhFHbmovDHzSE31wiJ9N
         lc/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUt3ZrMf/BxlHz6q++7VRM2uo54BfoSVPgJOGIs9U9bZzr9xer1c0TcYfyqCKkrZg61vXMBZVs2Bpwy@vger.kernel.org
X-Gm-Message-State: AOJu0YwDYz4ZVUw8uqN3JFC/miAGokmbZE7f1lntzol9BgAaROb8+RNr
	NtwL4ss3GA1hrbV1theaW+0D6sSqekHPXFeeXq1fgSVufs3bjYIhpE+O
X-Gm-Gg: ASbGnctNlAEhiGC0g54cC7OhrsQg8kONFrngaq8WvZR+L0ZeUCjzqIGPPNFTmtzJdBz
	/JPY0ttrYqTg930xH9vHH6naT4mhHG3MD3i8jgaOKMXMDEzhgeHH7YaMBtV1miTz0wTLPUaP1EI
	Ew22QH9taWGc4hX7noP6Gso52Iw97Ko216GbtzZ1sC3DYr4rbmT7Fv5seqIYUDJqy6FAGiZJ0Sk
	+hZ7qsDyQ2kjqjOORe2m7RBTjc/GJU1UHOCnR3XmTLgH6eJ6NCMOZ4ujeD6PJH8hyey/7/H5l1g
	PTOlk9kbKAM4LwhXqbyaldX83XsrKxb3DrlQLT0V2nyZAU2iCjPlL+HXLf9dT3jRndC0pckB4id
	8j9w8SyazRDJ3H0aeBE7NYzfy7k0QUQe9lz8aYCrnebOKYBLk7n4l03K5du7ZgOird9BKL9OfoV
	KOwOo30lu7rb15i2+Df0axmFtj
X-Google-Smtp-Source: AGHT+IGemHZA9SPXtNLFNdfrNqoZlItf/gue2FL3ckVQhHVRtlGuWtaylquJOH87biMGuXkZN384xA==
X-Received: by 2002:a17:90b:1b12:b0:338:3d07:5174 with SMTP id 98e67ed59e1d1-3436cb7cfbdmr4095192a91.5.1762622716706;
        Sat, 08 Nov 2025 09:25:16 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436c3d7dddsm2769122a91.7.2025.11.08.09.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 09:25:16 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: david@redhat.com,
	tglx@linutronix.de,
	segher@kernel.crashing.org,
	riel@surriel.com,
	peterz@infradead.org,
	linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	brauner@kernel.org,
	arnd@arndb.de,
	jlayton@kernel.org,
	aalbersh@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	max.kellermann@ionos.com,
	ryan.roberts@arm.com,
	nysal@linux.ibm.com,
	urezki@gmail.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev,
	will@kernel.org
Subject: [PATCH v2 1/4] Make enter_lazy_tlb inline on x86
Date: Sun,  9 Nov 2025 01:23:43 +0800
Message-ID: <20251108172346.263590-2-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251108172346.263590-1-qq570070308@gmail.com>
References: <20251108172346.263590-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is very short, and is called in the context switching,
which is the hot code path.

Change it to inline function on x86 to optimize performance, just like
its code on other architectures.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/include/asm/mmu_context.h | 21 ++++++++++++++++++++-
 arch/x86/mm/tlb.c                  | 21 ---------------------
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 73bf3b1b44e8..263e18bc5b3d 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -136,8 +136,27 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
 }
 #endif
 
+/*
+ * Please ignore the name of this function.  It should be called
+ * switch_to_kernel_thread().
+ *
+ * enter_lazy_tlb() is a hint from the scheduler that we are entering a
+ * kernel thread or other context without an mm.  Acceptable implementations
+ * include doing nothing whatsoever, switching to init_mm, or various clever
+ * lazy tricks to try to minimize TLB flushes.
+ *
+ * The scheduler reserves the right to call enter_lazy_tlb() several times
+ * in a row.  It will notify us that we're going back to a real mm by
+ * calling switch_mm_irqs_off().
+ */
 #define enter_lazy_tlb enter_lazy_tlb
-extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
+static __always_inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
+{
+	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
+		return;
+
+	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
+}
 
 #define mm_init_global_asid mm_init_global_asid
 extern void mm_init_global_asid(struct mm_struct *mm);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5d221709353e..cb715e8e75e4 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -970,27 +970,6 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	}
 }
 
-/*
- * Please ignore the name of this function.  It should be called
- * switch_to_kernel_thread().
- *
- * enter_lazy_tlb() is a hint from the scheduler that we are entering a
- * kernel thread or other context without an mm.  Acceptable implementations
- * include doing nothing whatsoever, switching to init_mm, or various clever
- * lazy tricks to try to minimize TLB flushes.
- *
- * The scheduler reserves the right to call enter_lazy_tlb() several times
- * in a row.  It will notify us that we're going back to a real mm by
- * calling switch_mm_irqs_off().
- */
-void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
-		return;
-
-	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
-}
-
 /*
  * Using a temporary mm allows to set temporary mappings that are not accessible
  * by other CPUs. Such mappings are needed to perform sensitive memory writes
-- 
2.51.0

