Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2DB2367A0;
	Thu,  7 Aug 2025 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754595630; cv=none; b=bmHQbuZMJjgIeRjybjJ0xeKIR9ODYTnQhWlgyxeO1hrtU4m6C2lpkCCt1OknBHQBZ0WVJnYaPmemAzLQc9XYbR6KH2OCSP+kbWFek+UcM7+/w0BQBwTmI8aGN/jKQXZpuymJMsdFyx4RulYVWoxYvyZl8L5W9XL2kPdEjPk4KjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754595630; c=relaxed/simple;
	bh=6hmaHEjviM+XvjcMBDP5iVfHBmu+Q4FRdIjRj4xU29E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XBHHPM0PuvFdWJMDJnoi7zFR98kqld65ufLAZ5Er2H+E/2Qr8PK47Y4y8ptXfpeOVMVMceq7Li3m6+pzAkwEAnPjI1A9jZZcyJ/B1RtIXJGAXwHYgShCgN2AUCb/eGDDeQeVJ6I1JIREPapXmjfqrFdpDtxYXgoAmTv7ITZZJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE5Gny7U; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE5Gny7U"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55b9375d703so1373081e87.3;
        Thu, 07 Aug 2025 12:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754595627; x=1755200427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNdBwl8v2OqAa3v0ByxYoV2FZHtZfSuaaApNKvSqvMU=;
        b=IE5Gny7UxH8bkSENuEsgNvFAQKnH5pwo0SfNEJ3NO5Ir8zqBFMFInUzxj3a+tleRvS
         zOicgIVSVSM107jZhStUgnZi84YsiRqlVN9HyGXzbYRiUzflz3yXsGz1znSQyNmOtv3S
         ssK/tnugraZP7Ji0nJuEzUqi4j0+jPQ9qkEjbXAd1Q48cSfVEQZOha75TnMEwmgwCBys
         63Whs9DvBQX2tsj8vp1kkq+cXYLV5P3H6ZI1K+zMzI7pEetkkQX4ogZSXP8kFgKOoxXp
         WeCr08ropb+KF6ofjHAxjthpTBCoQkv0HmvtMkDMtb2hCMDrI15/DAyWaeGGeT8eWCvz
         mjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754595627; x=1755200427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNdBwl8v2OqAa3v0ByxYoV2FZHtZfSuaaApNKvSqvMU=;
        b=CwTZZzMkGF6gOdZBr7y/afyxrDFNxCzU2Yy2+oYgBbBRVKPJ4Q4qiIh0KZxYTm0V6u
         1cBBdbOaQVnstV5wsUGxWt1Zl4h+Dcot9X13ETFqFJgV/s/BzxRERYuKKd84oT+cVNJ3
         Z5xV4cf4YPLiguDRktPUleSme1qZMT8ViF4LmQfU67KOHU2EXJdz4EOVPnjDr8NUCE68
         /07CGUXhPV65oDUecg8vKT9B3NRSx5F/D/vjENfn5H6ZR32e0TWHsOJ1TcdDDdesaC5E
         /ojbjL8EX5bCzHhJ0l31C7ncY6JXhGJchOOOcd/K3xwnjBWNwTqrixHmbvKNvG0jxxHf
         kCvA==
X-Forwarded-Encrypted: i=1; AJvYcCVyw2GRKS8s27Gdna1FiRm888iXjevZUvEpEAZ/M5qbuxRYyg5W24m/NnYfBydqBYn2JUnHj/yVJFmZYA==@vger.kernel.org, AJvYcCWCdpoSLeTiueJpIEgGELqkMKd0xQf23ZcHAOUVbac2DKUdiZRZwIS1mbV03J3ZVXgqbF7tfs/EjPYZH34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLxueQFNLruGU34kc8+IHC+LtWO1P67V9KslcEnEO2E/OH1qDX
	q/OSSBYOXd5KmgElszcssUtXPxtTjB7BYLFVLhB4navIqT91MN6hzljb
X-Gm-Gg: ASbGncv3dZmXF+a1/HZWAlcZPjpk4vIdMd6hptTKNQWEaOye1aExAkqGnpGzeBS/8Ev
	nHGzwVvVaS/ixNuwxoVnuEHlvlm+g6uQTsMCOrleJz/9OODo9PEP6FzzaXYSXf/FImYYt5ZIc9h
	sBYJkzkNbckHpcWksYgjxEBAuQm7MX9xWpYvDLJxVXYfxtMn9Kc84Djo7ZO3uLvl+gULbskii+Q
	1wHSLl/olAalETkC6eEoS4sM/WTR6rwpRZfEZ3r/RAb9v2WRrAsl35JhE/r6IH29AG8rkgDIiPB
	oza6L+wPlaW2nlktvi9pmF+JVhXt5FpyetJxxneaifkLp879MhxSdcwX5PaYIbl+EwvYNOz8AW0
	48tsXIgiSWdm8bolc0nR9oGcnnAFkf602E0xI2TTvunHyh2UVOJXXQLkIHiBtYyvTqg0avw==
X-Google-Smtp-Source: AGHT+IFy1K+04TTf6HeQynR9tEb65FcTbYVkR/07BpvyTspaDpSD1TTrgV/AzkLRIY/TwnnFAN629A==
X-Received: by 2002:ac2:4e14:0:b0:55b:8f46:80ed with SMTP id 2adb3069b0e04-55cc00e3a66mr10263e87.21.1754595627098;
        Thu, 07 Aug 2025 12:40:27 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98c2asm2793570e87.77.2025.08.07.12.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 12:40:26 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	bhe@redhat.com,
	hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	akpm@linux-foundation.org,
	zhangqing@loongson.cn,
	chenhuacai@loongson.cn,
	davidgow@google.co,
	glider@google.com,
	dvyukov@google.com
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
	snovitoll@gmail.com,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 2/2] kasan: call kasan_init_generic in kasan_init
Date: Fri,  8 Aug 2025 00:40:12 +0500
Message-Id: <20250807194012.631367-3-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807194012.631367-1-snovitoll@gmail.com>
References: <20250807194012.631367-1-snovitoll@gmail.com>
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
Changes in v5:
- Unified arch patches into a single one, where we just call
	kasan_init_generic()
- Added Tested-by tag for riscv (tested the same change in v4)
- Added Acked-by tag for s390 (tested the same change in v4)
---
 arch/arm/mm/kasan_init.c    | 2 +-
 arch/arm64/mm/kasan_init.c  | 4 +---
 arch/riscv/mm/kasan_init.c  | 1 +
 arch/s390/kernel/early.c    | 3 ++-
 arch/x86/mm/kasan_init_64.c | 2 +-
 arch/xtensa/mm/kasan_init.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 111d4f70313..c6625e808bf 100644
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
index d541ce45dae..abeb81bf6eb 100644
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
index 41c635d6aca..ba2709b1eec 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -530,6 +530,7 @@ void __init kasan_init(void)
 
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	init_task.kasan_depth = 0;
+	kasan_init_generic();
 
 	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 9adfbdd377d..544e5403dd9 100644
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
index 0539efd0d21..998b6010d6d 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -451,5 +451,5 @@ void __init kasan_init(void)
 	__flush_tlb_all();
 
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 }
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index f39c4d83173..0524b9ed5e6 100644
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

