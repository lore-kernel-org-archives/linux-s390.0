Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877802571DD;
	Sun, 10 Aug 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754830695; cv=none; b=hqSy8adwnt0tJ/aH7EaiHkz/K02/nF68/9poUag98NBlNKqp5RkehhMgtHdH7237SmDAxY3yrnuRjA5BjiYKSKmIpBSJmVn85Z0pX9kACdbxNFGtdo0z7V45/blVZVMbbzq/uDNgOMjKwSsecTVipuWp6t/FNQhj3x52Pj+hlGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754830695; c=relaxed/simple;
	bh=MqwKQc2JPJBB2GNaC3gYzjQZ5bv/gUTQatKs/70juhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQazafVavYrs80pzOthnQ6mTjvakg5Zp1v1PGw5EObwEWQXlb8emG+wl6y/7mBG4WkmeYFezHY7k8nsdWxX2w6kwoYZ1XuZVRROrDinc/tXkD93AqZhpmkeauE0ZLKB2I3/eKSKyjmODbp9ki38AZaRcWaG0j72dQg+uJT/OA8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AH7eaSgM; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH7eaSgM"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-332426c78a2so27844701fa.2;
        Sun, 10 Aug 2025 05:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754830692; x=1755435492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPUEdIdCRmt+MYJsQtBbxjY1GnPuX9CU1RwbVybqcDU=;
        b=AH7eaSgMHF9Q+2Or7UcBXZXSh3j4uUpeZhbhFzdgzTtcc+meDEA4XilEObalA8QYA1
         AP3W95u7cxgpku5Ax+C/3olW31oSRRb206lc9AjrM6w5C9yCvGOVnyzLNEoxy7T9Da4d
         NOOk/c9BV2OVDEc31HwyVt2mmmC6IqSqYhzn3UVJOctUDQK4AuSIhEHGy8ezm0Dy2JdW
         OshW1xNdxYApAuRZxGAsnbZQtV8p/OJEAMVrSPRUzkp4wE/Z1hAx73IEaG+AtLarJUdT
         IwDltR25JAhNBkDea1Tz19ypE5M8/5m4sCg12ZFM7EVSPsIQ0L4xLrYM7elHvYZb7mm5
         eoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754830692; x=1755435492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPUEdIdCRmt+MYJsQtBbxjY1GnPuX9CU1RwbVybqcDU=;
        b=dMSJzSzy+IkgMV0KwJVuo69FwJx84l8V5KjX6mZQ4L3/NvXWmV4FaM+COdZAvl5X64
         gzEHVDUyA5D67sf9kkroMve98EUarP8TbkoeV1j3lk7thPURBfxBf/VtJHbIhcv/25Ar
         iDFbzI6wYn6mKrcVffN6nlacJI9E5PxKWgYpn3pWbf+OW6asCUXhWanisxMPg+E1gKjT
         09RfmAgTqcDUJmWpeGhD1VYcujk65grV3VTxlUBbxVHtWNFvJ7hbVUVDxAx2FzVTmbes
         DStYpJr99IAD5KqO+hOMI73lSnWq0BE7ZqmTWfPW7XYmqg1vS11JHlVfp+Sfa84oD1mV
         J3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW13U0+I8G7jnzXHrBxVhe/h0J+/4IuAo4UIlucrdyLYxRdW1e+98dElgMP9V9Q6U4GRKWvspTQQhkCLY8=@vger.kernel.org, AJvYcCXiWSh7SxhRHLBJNHW6ZsgiKiYtDAIt3P2vRV/PIORzcYk/tYnpiHSFojKq/1UpRk3ivYAiiYbtn8zs9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUBL2h0ESM37p6JWRoE587AS49hzWtvtVwFFm0v6tGPQISPH3W
	gHrLdv/64+XeKrbzd0IuwwUr5XvUSythUDqpsdf3/j2WnsHJjD+p87gJ
X-Gm-Gg: ASbGncukUyuxppTH+wf1jd9DRuRUv/nPTTGF890nwhkT8mhHaJQs1AcGU45lhHHnuMP
	KrLKMeP+8gm2LZt/fUZTHqqBdmSTfiSmlR6Jp5CPA40525GRuKsPATXidZ+XiP1UNiFlAOYuRyb
	TeP3BweS4l0xRT9XXqmnyE0zaqDaI49zc3zWm8g/Df5TleUCsS9jixU+8kktZJw1SdEym8Fa6wY
	5HCVNAaUcit7mPXIi8EOoEWhIKPqIUYfNxxHkT1Wg4vPWIeYFWywSHW2Dt53Z+3059RJRDX/ZMd
	OPHMdI04/PLCFVFn9GMZsfQIqABAjfYD/mKSSHMaYViHLqsHGLgkFFTwQmaiMakYY690bVho1YE
	4jNp/0wF+TzlgZSKRTsBm5IH2hzNntX26NqZ7tw==
X-Google-Smtp-Source: AGHT+IFrIl3eJCoqqHt0ANltzYIq2yL9Jka0mZA2tOEeoGsTnUPJed1OxDGIgQlZCm+SP4loyYZbRA==
X-Received: by 2002:a05:6512:3502:b0:55b:732d:931 with SMTP id 2adb3069b0e04-55cc00b14c8mr2560689e87.12.1754830691289;
        Sun, 10 Aug 2025 05:58:11 -0700 (PDT)
Received: from localhost.localdomain ([2a03:32c0:2e:37dd:bfc4:9fdc:ddc6:5962])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9908esm3804561e87.76.2025.08.10.05.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:58:10 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	christophe.leroy@csgroup.eu,
	bhe@redhat.com,
	hca@linux.ibm.com,
	andreyknvl@gmail.com,
	akpm@linux-foundation.org,
	zhangqing@loongson.cn,
	chenhuacai@loongson.cn,
	davidgow@google.com,
	glider@google.com,
	dvyukov@google.com,
	alexghiti@rivosinc.com
Cc: alex@ghiti.fr,
	agordeev@linux.ibm.com,
	vincenzo.frascino@arm.com,
	elver@google.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH v6 2/2] kasan: call kasan_init_generic in kasan_init
Date: Sun, 10 Aug 2025 17:57:46 +0500
Message-Id: <20250810125746.1105476-3-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250810125746.1105476-1-snovitoll@gmail.com>
References: <20250810125746.1105476-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call kasan_init_generic() which handles Generic KASAN initialization.
For architectures that do not select ARCH_DEFER_KASAN,
this will be a no-op for the runtime flag but will
print the initialization banner.

For SW_TAGS and HW_TAGS modes, their respective init functions will
handle the flag enabling, if they are enabled/implemented.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
---
Changes in v6:
- Call kasan_init_generic() in arch/riscv _after_ local_flush_tlb_all()
---
 arch/arm/mm/kasan_init.c    | 2 +-
 arch/arm64/mm/kasan_init.c  | 4 +---
 arch/riscv/mm/kasan_init.c  | 1 +
 arch/s390/kernel/early.c    | 3 ++-
 arch/x86/mm/kasan_init_64.c | 2 +-
 arch/xtensa/mm/kasan_init.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 111d4f703136..c6625e808bf8 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -300,6 +300,6 @@ void __init kasan_init(void)
 	local_flush_tlb_all();
 
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
-	pr_info("Kernel address sanitizer initialized\n");
 	init_task.kasan_depth = 0;
+	kasan_init_generic();
 }
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index d541ce45daeb..abeb81bf6ebd 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -399,14 +399,12 @@ void __init kasan_init(void)
 {
 	kasan_init_shadow();
 	kasan_init_depth();
-#if defined(CONFIG_KASAN_GENERIC)
+	kasan_init_generic();
 	/*
 	 * Generic KASAN is now fully initialized.
 	 * Software and Hardware Tag-Based modes still require
 	 * kasan_init_sw_tags() and kasan_init_hw_tags() correspondingly.
 	 */
-	pr_info("KernelAddressSanitizer initialized (generic)\n");
-#endif
 }
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 41c635d6aca4..c4a2a9e5586e 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -533,4 +533,5 @@ void __init kasan_init(void)
 
 	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
+	kasan_init_generic();
 }
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 9adfbdd377dc..544e5403dd91 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <asm/asm-extable.h>
 #include <linux/memblock.h>
+#include <linux/kasan.h>
 #include <asm/access-regs.h>
 #include <asm/asm-offsets.h>
 #include <asm/machine.h>
@@ -65,7 +66,7 @@ static void __init kasan_early_init(void)
 {
 #ifdef CONFIG_KASAN
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 #endif
 }
 
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0539efd0d216..998b6010d6d3 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -451,5 +451,5 @@ void __init kasan_init(void)
 	__flush_tlb_all();
 
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 }
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index f39c4d83173a..0524b9ed5e63 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -94,5 +94,5 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages. */
 	current->kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 }
-- 
2.34.1

