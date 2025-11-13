Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D43385A3
	for <linux-s390@vger.kernel.org>; Thu, 13 Nov 2025 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031203; cv=none; b=Whdog21ydrbn2bSGjTsKTCbdVGpd+hT4AZ4OpZJHINJa89/jLjBEKUjkBAgLbWN61E3fhXwdguVP3aNCOSpEw7IhcXlP8erVSS7SyS7L4gCr7rkLhebZmXP7mPT2qCem+WHdvrkuKwlgcIIsEJnXUYCzLtNTw6bOQA1TscwRoo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031203; c=relaxed/simple;
	bh=1E2mId5k7LQtvQtsMUhfWzpkQGYCGnS/GTmR184+ESA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulZZZZ5BhFuqvURtAU8JQo9WKZgrzp4D3GorYIsID9fe5xQ8RXbLWF8D97JFKFvluSbiBSEXGQBgNAyW6XUf6XyFH33TXUT70IchLfra3NfrPYQkgMuHAaiaK+sTCb0UDrrIovpS4OymGN8kRrrk0YVIlueNUdNCI/e0pCe8LXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=espvAuQi; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="espvAuQi"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3436cbb723fso557777a91.2
        for <linux-s390@vger.kernel.org>; Thu, 13 Nov 2025 02:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763031201; x=1763636001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXzDe/lb8LBcXrcioYpdWFUmDINGA7jRuKL/XW2h0KY=;
        b=espvAuQikWN6NSnmwCOum6JjqIfIBu5G9N+yhIlFVJVRUJbJedPBR66aNff5UgCCaM
         D9l/v464MIErTzsjWaPivsY1lLLEew29Tiipuh65h54Ztlz93nLpLmT0lRrQChGj1TTx
         se5ARy7ojP0jc6p8GLMZ+V5G+1xB3xtlS+5wo9K+uc4zhqBRgwcoWzLyL1F/pCVCf7q0
         3yNtFJDGPPqH0HM6bK31553jyf7WNPNBEaT9Xmd8BKywsL8Mx3zcAuLnXmE5eGBibhwU
         QyeKyHG9bvtyVGcha2eCS/ujzXDA0zzL0CrfBwp1qiUHyeF9dK/Nq8VXFQ+Z/8PVhPZN
         sQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031201; x=1763636001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iXzDe/lb8LBcXrcioYpdWFUmDINGA7jRuKL/XW2h0KY=;
        b=wBiDLWfZJBrUCyO06HxL98Np0e078fzGsSnDUwbZ5gcgzeaKybCqXheNWCu65xmJhU
         lTxWoXBO58ujZX4LIQ875h+WImrRNJ9ML6em0i2VDvv9dHOQnLHf7wMCiyrKoeKSO9ri
         UrVT36Eg30DrumK7nNYf4zECaerKwc/L+CiIxTHf2m+KZ3I7Reags4vnjtQDS3mqwYxN
         SWDolF++Ylfr9N/slYTCVFNxI7dOm9CLeP5SHAHoPuhLaAV9OahyJuUTT69v3B0iuBM4
         lJEWUEydPAvHV9ib0ZsQDC6+IRQbABVdMIGxFX89um4WGfvbxD9h51xAMbJIk27hnEf5
         OTEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj3ubyNjPocC5FHnDwgkmR1/BgpkleKYODsghd2CCKaQc9AE4D7rU4cqmahjupS98j1oQagleaJuUd@vger.kernel.org
X-Gm-Message-State: AOJu0YzTRQ2OQgffwB76AO1OXGhae7L1RWr0eJ6TsrN1sOG9E3JAHfU9
	HkuxyOkuc4tdj3gwfIpVSoi2OcpXoozf9EApLOIyMBM5jmseSdwVVwk2
X-Gm-Gg: ASbGncvyv/iSunZZJpLjcDMA6+lV87xFVZ2AHfot3PHZjxZtCRd/T5t9oc8HUPoEdGd
	VulSeO1X1JziiqrR51bu9kEedKDdhlXh0TXnNbX1cZ8jCtspsp12FpJ8zwLH0JHueO5HbaEsTQl
	qKskuD6Wa+/7OZ3VbmY7pZ8y22MwErLeUMRA2NSsv/gvd/ENJIMEBoHLWDYFSa1Khn6qKeUlYJN
	D6QJDPW9Vy3oK2vdTXHz/EzJBItMsj0J4M695CXmnfMlkGY40A6fOXwaq5tvvUMPg/xc8aZ6MPd
	YIlAr5jZtE3CFmff0rrS3G4yqBb6CcJRJb6k2A7xjjiEuGzCdgaFl4jO7Yo8I7VOKoTzJQFswqj
	c168jXzbP6/Tf8yqojrWc382ftXNZcSGQZYQrQ3Z7+8bFOWm929zDWZsU2NJFccg/C6yQLEdmRq
	Zx5PwirwUAcxUt4tX+4QLpK0QvvBO5kKxO3BE=
X-Google-Smtp-Source: AGHT+IGjc7/BLrmluqoR0wCBX6JW+io2uPlNPbBrwMmM01hCccHJSoZKJTWfi0yRonMDUz3bgaA4Iw==
X-Received: by 2002:a17:90b:4a4d:b0:33e:30e8:81cb with SMTP id 98e67ed59e1d1-343dde14c3bmr7915421a91.13.1763031201314;
        Thu, 13 Nov 2025 02:53:21 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed4c939dsm2139616a91.6.2025.11.13.02.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:53:20 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de,
	riel@surriel.com,
	segher@kernel.crashing.org,
	david@redhat.com,
	peterz@infradead.org,
	hpa@zytor.com,
	osalvador@suse.de,
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
	sforshee@kernel.org,
	mhiramat@kernel.org,
	andrii@kernel.org,
	oleg@redhat.com,
	jlayton@kernel.org,
	aalbersh@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	baolin.wang@linux.alibaba.com,
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
	will@kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/3] Make enter_lazy_tlb inline on x86
Date: Thu, 13 Nov 2025 18:52:25 +0800
Message-ID: <20251113105227.57650-2-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113105227.57650-1-qq570070308@gmail.com>
References: <20251113105227.57650-1-qq570070308@gmail.com>
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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511091959.kfmo9kPB-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511092219.73aMMES4-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511100042.ZklpqjOY-lkp@intel.com/
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

