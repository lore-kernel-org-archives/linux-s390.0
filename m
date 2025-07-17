Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F052F94A7;
	Thu, 17 Jul 2025 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762491; cv=none; b=XG9+NA4BKEgmeHVv8MlFnTnMg4wjstpXklqoF3J9q1cgUVh+rKus3YtHjeulPgJcply7d2WmfjvvIna7Uqfj/UXfiQAEfZxBPcbc9aAbrQHrD0v3r9TICLFGdkac0zRLB71jhOG73CJ4OO/Mf1RcoPJK7QMTNdicL05XbMBOWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762491; c=relaxed/simple;
	bh=ni9+MGOPBCWxW978r5Taw8MZty2jgdJNnvPYPhZ7RZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CBtt9KVKL89cz0ZgSZj2VgnfEmyP64Zc6fXqR9av/rj8VPOsA8hUhXIeBaiVg4loY13tlSyYrEdk8Z+zel6Kre/INmA3fOCeIQ2ijMWFF/VTTMJjSZGm9VVmRkNAguqCwHBySFePVELEVSnNG6B3ZHovwoX0cfsqGBHQJ3Vpui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VInyhbSS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VInyhbSS"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5561c20e2d5so1339485e87.0;
        Thu, 17 Jul 2025 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762488; x=1753367288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVh/EioNiM2ei5SEPjKOjjcyR398WOKR4A8RtqUhr5I=;
        b=VInyhbSSa9DKeIvM5XsomcX/WyWLP/H8CKqJd5Nj0gKpXOgsOgQOFPyz/q7/F/I9Ir
         dM8Mu6CGQLXeoh8QFJ9LFCkS2tzib4m11ztTkkSXZBI9/PR2qTE48mpI97IVkLzpyB3m
         a7zOgjGXGs0GyCHLpBkWT6atbX/ySmUfnqAqGxgOkISujZ1jOYHrNjPGhecRdudDyLz0
         bWIC2mWTKNRc1TzhydPkU6sGMrIg0oFU7foXWY/HWxzGo8mxs+vDtbAQtZNNT6h8y5+N
         aCcmY7uwIFNq+2x1WwGForpmvLI1mR+D9lnmQ+oXRiymPXrgTKbGb+CrJ+OpZFPr4Rx2
         dBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762488; x=1753367288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVh/EioNiM2ei5SEPjKOjjcyR398WOKR4A8RtqUhr5I=;
        b=QvomjBVktNsScUGmTYgfRqit/MLgl+0l9bJtMow54uyeZaeuPhUMKYdnIFcipzqkNB
         OqziCkb1w+Llr+U2+MIf/5/0+HLlWO8Gh0h7C59NiwmFvg+SkUGcPgGJSckWaEa+y2Fq
         K70BD3RsyNSKG8aU+SZWSI146WAuAC1+mlzNZbP8BhzAXvYZU2xIwZaEvOx9Nhn06o/j
         OyLZ8hK4NigPTJbM7L2oUGqWHPg0GfKyDrKndlxKSjb9/yvvEFK7VOblPXQEvp1nfnQ7
         nJKRbYLtqIXu8aVKPGkbMJFzOCjS0wL53bxRqanJoItFBudjYy2VcqkqZCTXiQ2kfCVS
         Mipw==
X-Forwarded-Encrypted: i=1; AJvYcCUcm1W+CaQzPPPzis/9dNOCghGNSjnpc1v1NT+ha8f8ep5sd/ViH0TNWfJntrVQbEG8E7DBcCYCh2G+FA==@vger.kernel.org, AJvYcCVyicv+fIbJt9SHEGJT1TGiHlrumbb8Y5IZeSqJ/J9NjmeWsbtZ90oWPgkuAv2EdJ4iuCBHV4eg9y62P1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwascTNh+NwR575Qf2XKwzj6KI2PVwEHS3YU+kF31Mv8cjdsbA5
	k77Ah+kECwisX25yLXKvwlVi81w0BdZKX8QqF3kUG5v4KLIGlkQga7X3
X-Gm-Gg: ASbGncvyh6noTT5O4H0W6Msu7nYoIpNEY9dM9XTCVY5ag8KqSMvB9udM+IBzm44Vlll
	rPu6B3DgB1XStIjErhvSwQALUmeNZq3EWb4xUnpr1G6B1zdO+tMwAKw6lwi2QTTn+7aOlSEtcCY
	Aw2A7y2ZlD3X1OWUvsgsOJteztsypPoPI9OSXMp51GUm7ehQ5WMLdQrH1vRcULQ3smlqNRfTr2f
	JE/UVYhr2E8p4/MRQl5JeQ1o+lerVmkC2kKg/n2gC+aGnGM0IG0QpanVWJwgA5nDcMUHhik+8N/
	8k+Ejt+QQ0miZQUT/pWM+BgZeFGEOOVeX9qV4eoYuaTBvA9joYfBDcHGMte2He6u//PTL7vok9E
	2yKBFz5HFtAxdPc9Q8z489UC0CKr/E0MTAvPz9qeGy6NDoITSQakzwxHa85iYgGYsNqjY
X-Google-Smtp-Source: AGHT+IGxLJhvaMCe+spMW+LE9A946Qy8DaLWnnJJyiUxPC1zU6fBVPq5lHa93m7Tf0WxYYCemaAtrQ==
X-Received: by 2002:a05:6512:611:10b0:553:2e92:2c98 with SMTP id 2adb3069b0e04-55a2339f4b9mr1702111e87.42.1752762487529;
        Thu, 17 Jul 2025 07:28:07 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:28:06 -0700 (PDT)
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
Subject: [PATCH v3 08/12] kasan/um: select ARCH_DEFER_KASAN and call kasan_init_generic
Date: Thu, 17 Jul 2025 19:27:28 +0500
Message-Id: <20250717142732.292822-9-snovitoll@gmail.com>
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

UserMode Linux needs deferred KASAN initialization as it has a custom
kasan_arch_is_ready() implementation that tracks shadow memory readiness
via the kasan_um_is_ready flag.

Select ARCH_DEFER_KASAN to enable the unified static key mechanism
for runtime KASAN control. Call kasan_init_generic() which handles
Generic KASAN initialization and enables the static key.

Delete the key kasan_um_is_ready in favor of the unified kasan_enabled()
interface.

Note that kasan_init_generic has __init macro, which is called by
kasan_init() which is not marked with __init in arch/um code.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v3:
- Added CONFIG_ARCH_DEFER_KASAN selection for proper runtime control
---
 arch/um/Kconfig             | 1 +
 arch/um/include/asm/kasan.h | 5 -----
 arch/um/kernel/mem.c        | 4 ++--
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index f08e8a7fac9..fd6d78bba52 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -8,6 +8,7 @@ config UML
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
+	select ARCH_DEFER_KASAN
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
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
index 76bec7de81b..058cb70e330 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -21,9 +21,9 @@
 #include <os.h>
 #include <um_malloc.h>
 #include <linux/sched/task.h>
+#include <linux/kasan.h>
 
 #ifdef CONFIG_KASAN
-int kasan_um_is_ready;
 void kasan_init(void)
 {
 	/*
@@ -32,7 +32,7 @@ void kasan_init(void)
 	 */
 	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
 	init_task.kasan_depth = 0;
-	kasan_um_is_ready = true;
+	kasan_init_generic();
 }
 
 static void (*kasan_init_ptr)(void)
-- 
2.34.1

