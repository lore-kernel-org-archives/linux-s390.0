Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60727B4F7;
	Tue,  5 Aug 2025 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404006; cv=none; b=CpaIbCwIto4EZEmWuLyJEi2MAbqj+kRd19fuuIKHZ3VLHuZqUSTV/Qv3o+DmoMdOM6+J92fxCs4wZckx+00vA1OUtgCX6H799qyla5r2z6l8+Qo89MuSSqz7QCodM3NJaUjTebZbnfQ0MuzIlwHljb+KOJA6DGUTV5d0pAhIvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404006; c=relaxed/simple;
	bh=0+YxMXVG8MURIRmahEKn+nTfC5J8vQnslz9SF4x43H4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faEELvYdBomi9sZlul6iwIakfHnj23XML6vl4mdgm5pN+tFb79Z/fDmWiBf7y3AIBBQHpy5/VHNHPOOk7+hZZjtA95uuw3kAq5Rglly65sZ4igXBfGSXkpqpH1SYY9u6Wx1SjeY4huv+4l1gVOeGkzmFlNUV1GOlfp58YWV2YnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y87AjhHy; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y87AjhHy"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55b85413019so6016399e87.0;
        Tue, 05 Aug 2025 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754404003; x=1755008803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pl3xBvbmXoSLjMyBTIqb051cyNY5upcj2qfXScxGTG8=;
        b=Y87AjhHyUou+tJhv43AkRByseg23fFi3J3KHHq+vK2Ob4+SEpLPdi5vqLPtfZ1AtrD
         bfXg6+1cGmpe/SZ/XffLJwAgdOA0470rD4dEkedtXHqbfsRlmA48OqZli9XoXDKw/fmW
         SaYS2gaVhd35qK4VTkcoY7p0nDZZcxPTKXx8ViRcL7mTMuNYgSAaEIcuEMvjDCbeTqjD
         csJK1Vl/XKZqNkWWxgZOtn/PIuUPSYrwQJ2ui74kaxvN1rinFvxY92FZGlnvXeotW4l+
         30kTz0CNcrIB69T/55FfZghh1CPQPn7N/gENnsTabprlndcFy6DQ0pg2EFA/45SELJlb
         rCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404003; x=1755008803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pl3xBvbmXoSLjMyBTIqb051cyNY5upcj2qfXScxGTG8=;
        b=TLZEBdSGN1uSixXsTm860cQrDLRMfxDIBjlAlW1NjWXMPImUXJCJifiSKYjSO3s2m+
         54+JU8SOEeqxY+MeJr+FN9HnIerss1na8NtGiAiVYDjR6feeFe+qfBeIlngbS3LU/o8G
         sJNVZGbbG9ujiJ+WeZPlkgkAqs0mqa7fu6F0t063h/69gb6yCcvdkGhhdfB3v9109Sfy
         ZewwWsRkax611nAVAhxGNwpgVJboTHphVJ+segtkpdIjnE7Vq73hG6Rtka87u71eEGaC
         BCpN3w7xXy9G8hxHgomXeZEqSV9LmuIMn08o5lh9syE0g6mgTsesBPMDklmOe8UpY4mv
         AuTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXseex/SLYgtUyg1QjMLIb6sjPhR/yFO45Xc7JtalYc4upFWvGg1Grih3kCPQmVzncw62zoin6Vutyj/w=@vger.kernel.org, AJvYcCXuGZxQ6Bt2zo1DRTddBOJ7DPDpFYb3CrvKgBAdWGubZOmCQSCHJ5garAZZnY9yQwneBdlSwtWW7R0oXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDPEYNUpg9zJe/FF5gOxt7YaP7Bn47HEEa7Mx1vKcG4XcajRCE
	EF3K7OcwifQw4P1g9GgMaP38pbZYIKxI9JfkTA8OBsNUm2wc7eX9Zoow
X-Gm-Gg: ASbGncsu+HdOk8G5+uf9OPJLE+rJLNMa9ODp5U6WN2gQHQWfvEUmbSA1tHWtJi3dfnr
	dt7ss2A2ZTNhVqkMaQEKhgat+s9AT/pBLCOuM8j1pnFih2EFQZSh/IstvWOnwnsyWKjw4db8myR
	Tv5xwr2p2efSFa9KsMkesHyB3agNpSI+IhMRtJ44G/KoM0Bocr0g92ny/C1raTIAUindMUKc9Sd
	YkldkTW7rGxUcZUWGG76dkTjdzv45LU+dWBCYhUG1wfx2erWstP9NmF0+008oBPwyE/Slo9YN9M
	1jeWV4yRhxaXYvsm+IkBeqkIJFA+/EvvMg4gS9bQR0PefFKVQqCveq57rIFCiEAtpnJpx1pgY96
	NhB8IvDI6kACpR4G8FfdR5eTW4GyXESfouUtgM69tTNb5bzY4qfZ0Wjz8xvT9k2H0EpQ0Pg==
X-Google-Smtp-Source: AGHT+IGVveeqR4Cp++JX2gYkKHclckYO0JnGR061NIJDmvQ7jhspWng2d4EVRtNzF0MnSLGE8X42Dw==
X-Received: by 2002:a05:6512:ba8:b0:55b:8e3e:2be6 with SMTP id 2adb3069b0e04-55b97b2971dmr4253074e87.24.1754404002655;
        Tue, 05 Aug 2025 07:26:42 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:42 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	zhangqing@loongson.cn,
	chenhuacai@loongson.cn,
	trishalfonso@google.com,
	davidgow@google.com
Cc: glider@google.com,
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
Subject: [PATCH v4 6/9] kasan/um: select ARCH_DEFER_KASAN and call kasan_init_generic
Date: Tue,  5 Aug 2025 19:26:19 +0500
Message-Id: <20250805142622.560992-7-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805142622.560992-1-snovitoll@gmail.com>
References: <20250805142622.560992-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UserMode Linux needs deferred KASAN initialization as it has a custom
kasan_arch_is_ready() implementation that tracks shadow memory readiness
via the kasan_um_is_ready flag.

As it's explained in commit 5b301409e8bc("UML: add support for KASAN
under x86_64"), if CONFIG_STATIC_LINK=y, then it works only with
CONFIG_KASAN_OUTLINE instrumentation.

Calling kasan_init_generic() in the end of kasan_init() like in other
arch does not work for UML as kasan_init() is called way before
main()->linux_main(). It produces the SEGFAULT in:
kasan_init()
	kasan_init_generic
		kasan_enable
		static_key_enable
			STATIC_KEY_CHECK_USE
...
<kasan_init+173>    movabs r9, kasan_flag_enabled
<kasan_init+183>    movabs r8, __func__.2
<kasan_init+193>    movabs rcx, 0x60a04540
<kasan_init+203>    movabs rdi, 0x60a045a0
<kasan_init+213>    movabs r10, warn_slowpath_fmt
	 WARN_ON_ONCE("static key '%pS' used before call to jump_label_init()")
<kasan_init+226>    movabs r12, kasan_flag_enabled

That's why we need to call kasan_init_generic() which enables the
static flag after jump_label_init(). The earliest available place
is arch_mm_preinit().

kasan_init()
main()
	start_kernel
		setup_arch
		jump_label_init
		...
		mm_core_init
			arch_mm_preinit
				kasan_init_generic()

PowerPC, for example, has kasan_late_init() in arch_mm_preinit().
Though there is no static key enabling there, but it should be the best
place to enable KASAN "fully".

Verified with defconfig, enabling KASAN.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v4:
- Addressed the issue in UML arch, where kasan_init_generic() is
  called before jump_label_init() (Andrey Ryabinin)
---
 arch/um/Kconfig             |  1 +
 arch/um/include/asm/kasan.h |  5 -----
 arch/um/kernel/mem.c        | 12 +++++++++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9083bfdb773..8d14c8fc2cd 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -5,6 +5,7 @@ menu "UML-specific options"
 config UML
 	bool
 	default y
+	select ARCH_DEFER_KASAN
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_FINALIZE_INIT
diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
index f97bb1f7b85..81bcdc0f962 100644
--- a/arch/um/include/asm/kasan.h
+++ b/arch/um/include/asm/kasan.h
@@ -24,11 +24,6 @@
 
 #ifdef CONFIG_KASAN
 void kasan_init(void);
-extern int kasan_um_is_ready;
-
-#ifdef CONFIG_STATIC_LINK
-#define kasan_arch_is_ready() (kasan_um_is_ready)
-#endif
 #else
 static inline void kasan_init(void) { }
 #endif /* CONFIG_KASAN */
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 76bec7de81b..704a26211ed 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -21,10 +21,10 @@
 #include <os.h>
 #include <um_malloc.h>
 #include <linux/sched/task.h>
+#include <linux/kasan.h>
 
 #ifdef CONFIG_KASAN
-int kasan_um_is_ready;
-void kasan_init(void)
+void __init kasan_init(void)
 {
 	/*
 	 * kasan_map_memory will map all of the required address space and
@@ -32,7 +32,10 @@ void kasan_init(void)
 	 */
 	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
 	init_task.kasan_depth = 0;
-	kasan_um_is_ready = true;
+	/* Since kasan_init() is called before main(),
+	 * KASAN is initialized but the enablement is deferred after
+	 * jump_label_init(). See arch_mm_preinit().
+	 */
 }
 
 static void (*kasan_init_ptr)(void)
@@ -58,6 +61,9 @@ static unsigned long brk_end;
 
 void __init arch_mm_preinit(void)
 {
+	/* Safe to call after jump_label_init(). Enables KASAN. */
+	kasan_init_generic();
+
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
-- 
2.34.1

