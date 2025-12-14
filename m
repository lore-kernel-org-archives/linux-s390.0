Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2C2BEFEE
	for <linux-s390@vger.kernel.org>; Sun, 14 Dec 2025 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765739385; cv=none; b=Hi/5Vmb4u/XISTOOWsway+QijNd5+UyynzkdR2/IAld/UYO05++RbJ0CwKqNyOfoDLKwhi6V7B9EbsBXLmo7RXqdDuH75aZRscsqpCYPIgYcvJIEPlVOVnnf6hw85K/3PLVrTG3RB0FJnljCAHGAqX3f0q6QkAsCpCVLdud+ydk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765739385; c=relaxed/simple;
	bh=DKpN2zaUCAninkD0mDIlfHSb+/CVUZ6/kapYpRY+0nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9TI7aa6Dobyi1RRc9adB4KHWj1XEr48b792VBra2IlioPL3au9dCPygrXeWl8ZC3S45E8YT+gg3S8PbjRh8AiIHMOD3uug15DEqPiMLnud1XQS7oWeRsjgUgJC9x0ocUyWI6VvQFtih01LMNlMIGh/uO83FoiQWHLex+MUCjik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YH4jA7uP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH4jA7uP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a081c163b0so15349635ad.0
        for <linux-s390@vger.kernel.org>; Sun, 14 Dec 2025 11:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765739384; x=1766344184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGRylMipBCZAbafLrwEo52FEPB30FFq/2/xIahus1R8=;
        b=YH4jA7uPGcmSeOqO7sbw5I/3QJc6ZqoU8VwvF6i77SORDr/ahiSsLoZUWYUbW/sdv1
         hlvk5guiHXYuY6JI5ImPGnGTPXAd2T5+eRMVtwpDI5rIG0zYZBrqhN52KPIK4U5EEAn7
         GfGlLcEi9yaHH0FIhRO+FctLmy14V0Md8BByvBwXwB3l0YOXnhKeEHJO+LgqV/z6/eLj
         IeNF0YHBffgFm1g677x4P2Nu3EvrdX1UCPWrWmrylX7T3krJRlRQpaqXwHmsCO7W1HeA
         P01Un1X6hab3p4AEycbRg4uyY9IUyg1ZuXHWcp5dJ73wRRIQxIuZ9b8bDcl93zKvTjj4
         yAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765739384; x=1766344184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kGRylMipBCZAbafLrwEo52FEPB30FFq/2/xIahus1R8=;
        b=vbFnphpZEmnsoR5ct3LfRCFVpJ6hP1sxm5XesyWUFt9Je9RD1jWKfh+TlGPKhIuKCe
         xGI31lLq+4wyNVi+BT7bjzm9GmqyUxEfrbuPwE8p7TatbOZuaGiFmptaJZkUL/xIWQxC
         yc6LlT6D/4TW9KuSUwd3y4daiNElv0Imbi4TQxr6Ja7ALZi6FbbPH0JJH7KH9p2f/92c
         gPd8ccb1PMVW0D+Yhh8P8EhjonQZcBE/k1AOqtF1LT9Wl5LF2+BIeia0adqyXqzUMP9R
         PkUf1LvPOLREAeXrAU+HyKJOqYB0OtZlC1PgsXk0AtOvR5/tEZoCDLxku6P7g/I8bhy2
         zKUw==
X-Forwarded-Encrypted: i=1; AJvYcCV1Wa3yXPKSOp6AOcM7Jdk3PA/b9l+exHTVQo2FZXyLw4my6afSUf+r+vReqORqGyzwelhi+OUnk+WD@vger.kernel.org
X-Gm-Message-State: AOJu0YwiR9g/HBhGVbE95FW/8AegC/gqXbXL3o1njHHquAjZ3mZdsI02
	Ll9pWAaFbYPSlMH3mTrdyrZNEqQ83nlkGBznvAj/uubmTJz3s5ErdQ7t
X-Gm-Gg: AY/fxX6tVTlof6DGnVQ8nzjHiq/708sCrILMOd7EQ6p/v7c9bNdAEjFGIAO8u8ucNTn
	xOrSs2eALoHL0TxKRk7nxcuNjB/6jO35kKShpeaCNYRoiqnWo2xNOer4rDr/MnY6zL2SHSu2M6X
	Yf7HIE5CNP3zEjKgMzyXryLSccql84UAtDXm3ZK/hnZtrbj5l69inAacYSpQb5DkjNZqrWLn/fO
	DYw6zbqCQGEbBxU3OUHMgRoYkQ90fEC1+vZdm3sPj0sMco1ihAaYwthwBRs2AeHWa9Wh+N8WxhS
	iY1fdF0ohRlctF192lL8//2tvCuBgaye/WNdaSL1IjD/z/1Lw5dHOS0cFcRsa+RQLtfUiG/JVWY
	uWkUoPPqRR1lREnEVoq6o0C5Wr7pdOdsv6agX5l1o3P15kVk6FB5Y0c9Yf/32ZP1Y4vU53mDYaG
	SZIy2OgYgdVmx3ZuRydltsK3jsf+7lCok=
X-Google-Smtp-Source: AGHT+IFmYzgXFHkbQBQiUvnSACzpFFy+PJ8dOf4i/6tp+rBdDj8hhEPW3StEcaOty+tMnp+I1Z9nyA==
X-Received: by 2002:a17:90b:54c3:b0:33e:2934:6e11 with SMTP id 98e67ed59e1d1-34abd7f7a9cmr6658481a91.11.1765739383476;
        Sun, 14 Dec 2025 11:09:43 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3a1c5esm6909062a91.3.2025.12.14.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 11:09:42 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de,
	peterz@infradead.org,
	riel@surriel.com,
	segher@kernel.crashing.org,
	david@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	anshuman.khandual@arm.com,
	aou@eecs.berkeley.edu,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	justinstitt@google.com,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nysal@linux.ibm.com,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	svens@linux.ibm.com,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	linux@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v5 1/3] x86/mm/tlb: Make enter_lazy_tlb() always inline on x86
Date: Mon, 15 Dec 2025 03:09:05 +0800
Message-ID: <20251214190907.184793-2-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214190907.184793-1-qq570070308@gmail.com>
References: <20251214190907.184793-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

enter_lazy_tlb() on x86 is short enough, and is called in context
switching, which is the hot code path.

Make enter_lazy_tlb() always inline on x86 to optimize performance.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511091959.kfmo9kPB-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511092219.73aMMES4-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511100042.ZklpqjOY-lkp@intel.com/
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/mmu_context.h | 23 ++++++++++++++++++++++-
 arch/x86/mm/tlb.c                  | 21 ---------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 73bf3b1b44e8..ecd134dcfb34 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -136,8 +136,29 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
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
+#ifndef MODULE
+static __always_inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
+{
+	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
+		return;
+
+	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
+}
+#endif
 
 #define mm_init_global_asid mm_init_global_asid
 extern void mm_init_global_asid(struct mm_struct *mm);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index f5b93e01e347..71abaf0bdb91 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -971,27 +971,6 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
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

