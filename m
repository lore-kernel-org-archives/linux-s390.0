Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3D02F85F2;
	Thu, 17 Jul 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762474; cv=none; b=N0q41ohyN4ljiOhh4OrJGot4+SsdpZbrOySdkSCj9pPU19eYKasyAnvnLCPGXTedcT/I5vgXvqslXJ5q4BjkkzeF2v2L8glRwRn7lv0wChcPZ+88Nu+V8ioySw/CB4EH7lVax5562o95fw+tbUvXN3b74SN4JrVeCKAJwUH41dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762474; c=relaxed/simple;
	bh=ESmhSIrQQTFnMHkO8fddR2vJBJBoLh1uTvlGgl5i9Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tM7eZzA4pCysybphqYh9mUjLwufaSwKW3Qwqs/8zoIX5UCV2W9LdB4BtOQHuY/cMLhawPbehjU4wyMhPChHfRFgdoDeW5yPnovkmV+bwa26CrhZ8eDnfB0LW3j0cWfr+XhLoorcD3UxLRrUUm8LpZCUC4YAxk85hwHg6HhVquNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWGN0p/6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWGN0p/6"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553b5165cf5so1236392e87.0;
        Thu, 17 Jul 2025 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762471; x=1753367271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9U6pXPOm17QNJUh3dL0X5SvDfkuBM+kFPXcpz1Z7hWM=;
        b=UWGN0p/6SI1YYj4B0toUTlnd3iElp8QkgaxbipSbaAs6ub9xjdvWzzFihFQHJtu1TQ
         mIQfdKYmMGaJJRjyhXGBezLRSmjvqwYo560GM6XYiYQGgqI+K0Rc5AlxXlJ3B6TMGdaO
         VFelgmRUoQlRQ19wWbM0XvmOS2G++9fGrmQVnreaw67zO3z3LmQIrTK6qDxh0FadA3Pe
         wmRhYqlHtsTYxNMajcZyQfvXJqsSO62gQMjzTF3iu7ir42ZTI7frvfzvM5aA8kxtucVR
         4tFEbY/9+08bxL3lOfkZpN6fIvKT6gKYBVATyaMXWyXL1Eg02HzBlBv/ekN7tu4MWBtp
         5lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762471; x=1753367271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9U6pXPOm17QNJUh3dL0X5SvDfkuBM+kFPXcpz1Z7hWM=;
        b=dSNJOfpZWGfsY4MrMBgLrr0BYZcH0yGCftgtyBZbstKtfE3RI1yhmaDS59HFouZuIQ
         ShB6FVRpgTpX3B4o+V/49hxlnwwTxa24iN+4Ag7etRj0elo/zLZ8zCXuTw+/HMud+VLZ
         ub+qObVLAwX9WgC8vC36lgjqU9bbDa8ycyg/6+AG8EO9ngN1FeSpcYV+189mHMqAvQoy
         c0lhVuS6n9CK7nKOiGgeA9iyK2kSN0SxR06dQ0WCc6Jbd8u+wSElrRu6J8cIvOx816zs
         JHjqg8Vi8Vsr3htct6jmDRP9GGKKKw3mUChPpqaigt7vsbjqaDsNqSOt/Z62y2dz0jeP
         6rog==
X-Forwarded-Encrypted: i=1; AJvYcCWMh0Srj127/6YJqweew4x0bCujSOrEWJ6I5AyDyQlXjD8ozF2ILSMOu3cUEiRV9RIKSUqlIRJhVIEteQk=@vger.kernel.org, AJvYcCXL7tfSntmf75wg38LdjQj5BoRfC+bG15GetCrbmnoEZOKZO1GFHeLXIdTbsLFtjRFGVEw35Qe6tLMhVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJNW8zyUfrx2aC4yPlsFjlNw60PUcxe6Wx/xrRE+xq7CwnVAhi
	iTTsLXaot1540x26HmUIeWwVDxs/8sroMMJGhQ4Sp27sdPUtuDlT4nJj
X-Gm-Gg: ASbGncuh4z1o9DirgaS0DCdfiSXVNbhMduT9J5fgIhq6utALqIslk631ZoX/Wl8nJj3
	hpVXdLlPsTJTefBO0v9HWeAHQH0/zTBDCmY6inq9hyHK6b4xybylNwy4fuyp8Es+OB/RFf+1Qxp
	n7D6/oMZsoyiV+RFL0MgROKMRBzS1FK7Zf5pt5c9sh8NxbUX5oUHaoy2K8ZxPQaNfotlEZWP7OL
	m78L7QuYT2vUq4FEtK9XDeas1U1gT+PigEIxMgzcOoVKL0EQB87XvNp9yU25ubYV6JZJhQNDc7T
	rliVTvWhohD5m1BzKGQfd+ViZcPm5TpkvNvb+XpIHIvIB2zqvh9R5GwdcqEfJCI5EY2N9R28FMn
	X0NP9ZSeqnUfh1ic887ph8fkQa3ahmSuliWaAPeTqPpryhd9Nvt7tPx2JqX8SZKFIf/IK
X-Google-Smtp-Source: AGHT+IFxg66CFuCFZcq7YEHf2jsYRpZfJ3opYk2GjZt6qN26RYtZXaN505yqdxOnxSgHLvlINQObtg==
X-Received: by 2002:a05:6512:78a:b0:553:2868:635c with SMTP id 2adb3069b0e04-55a233db5f5mr1804298e87.48.1752762470559;
        Thu, 17 Jul 2025 07:27:50 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:27:49 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org
Cc: ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH v3 03/12] kasan/powerpc: select ARCH_DEFER_KASAN and call kasan_init_generic
Date: Thu, 17 Jul 2025 19:27:23 +0500
Message-Id: <20250717142732.292822-4-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PowerPC with radix MMU is the primary architecture that needs deferred
KASAN initialization, as it requires complex shadow memory setup before
KASAN can be safely enabled.

Select ARCH_DEFER_KASAN for PPC_RADIX_MMU to enable the static key
mechanism for runtime KASAN control. Other PowerPC configurations
(like book3e and 32-bit) can enable KASAN early and will use
compile-time constants instead.

Also call kasan_init_generic() which handles Generic KASAN initialization.
For PowerPC radix MMU (which selects ARCH_DEFER_KASAN), this enables
the static key. For other PowerPC variants, kasan_enable() is a no-op
and kasan_enabled() returns IS_ENABLED(CONFIG_KASAN).

Remove the PowerPC-specific static key and kasan_arch_is_ready()
implementation in favor of the unified interface.

This ensures that:
- PowerPC radix gets the runtime control it needs
- Other PowerPC variants get optimal compile-time behavior
- No unnecessary overhead is added where not needed

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Fixes: 55d77bae7342 ("kasan: fix Oops due to missing calls to kasan_arch_is_ready()")
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v3:
- Added CONFIG_ARCH_DEFER_KASAN selection for PPC_RADIX_MMU only
- Kept ARCH_DISABLE_KASAN_INLINE selection since it's needed independently
---
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/kasan.h       | 12 ------------
 arch/powerpc/mm/kasan/init_32.c        |  2 +-
 arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +-----
 5 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c3e0cc83f12..e5a6aae6a77 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -123,6 +123,7 @@ config PPC
 	#
 	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
+	select ARCH_DEFER_KASAN			if PPC_RADIX_MMU
 	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index b5bbb94c51f..957a57c1db5 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -53,18 +53,6 @@
 #endif
 
 #ifdef CONFIG_KASAN
-#ifdef CONFIG_PPC_BOOK3S_64
-DECLARE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
-
-static __always_inline bool kasan_arch_is_ready(void)
-{
-	if (static_branch_likely(&powerpc_kasan_enabled_key))
-		return true;
-	return false;
-}
-
-#define kasan_arch_is_ready kasan_arch_is_ready
-#endif
 
 void kasan_early_init(void);
 void kasan_mmu_init(void);
diff --git a/arch/powerpc/mm/kasan/init_32.c b/arch/powerpc/mm/kasan/init_32.c
index 03666d790a5..1d083597464 100644
--- a/arch/powerpc/mm/kasan/init_32.c
+++ b/arch/powerpc/mm/kasan/init_32.c
@@ -165,7 +165,7 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KASAN init done\n");
+	kasan_init_generic();
 }
 
 void __init kasan_late_init(void)
diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/kasan/init_book3e_64.c
index 60c78aac0f6..0d3a73d6d4b 100644
--- a/arch/powerpc/mm/kasan/init_book3e_64.c
+++ b/arch/powerpc/mm/kasan/init_book3e_64.c
@@ -127,7 +127,7 @@ void __init kasan_init(void)
 
 	/* Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KASAN init done\n");
+	kasan_init_generic();
 }
 
 void __init kasan_late_init(void) { }
diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
index 7d959544c07..dcafa641804 100644
--- a/arch/powerpc/mm/kasan/init_book3s_64.c
+++ b/arch/powerpc/mm/kasan/init_book3s_64.c
@@ -19,8 +19,6 @@
 #include <linux/memblock.h>
 #include <asm/pgalloc.h>
 
-DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
-
 static void __init kasan_init_phys_region(void *start, void *end)
 {
 	unsigned long k_start, k_end, k_cur;
@@ -92,11 +90,9 @@ void __init kasan_init(void)
 	 */
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
 
-	static_branch_inc(&powerpc_kasan_enabled_key);
-
 	/* Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KASAN init done\n");
+	kasan_init_generic();
 }
 
 void __init kasan_early_init(void) { }
-- 
2.34.1

