Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48472F85E0;
	Thu, 17 Jul 2025 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762471; cv=none; b=k7BatVBtZU3aNk8RzWik46niMZgQHPJgQiVMrtVTG/DInQvUMgTYcfFUjTFmtIRxGTgf1cUbonsCrW4uhnqGbOJYOsvw6XGYYb1xOgh7FSr3MEZJ/rYgKeYSCaE2QWArCY7SrVTVFVDE4OTUwIkWvNu/8mmiOooEiLXrtb13H/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762471; c=relaxed/simple;
	bh=3XkMQnx15o9Jp1ANPcHB9A6jUuSUcIQueX3v/gt9pfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rk0KBwBrq7JG9H0W59KlvL+IFthXvAXQyUOOjMEH5tLdDig4kfaPqBOJWfYeDxbJ7AOscjHloeQXhdCbaV2qTU6JO2UbPPJRgzlvUma9CxLaNuhNT743E0YlEgsJyopeekINcr/7jnpyoNfsiyt1MWbIbgvYYKL8Z0kyo9cU7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZL0QX5bu; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL0QX5bu"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553d52cb80dso1223050e87.1;
        Thu, 17 Jul 2025 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762468; x=1753367268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtzrgmhXOlDN0Ac+5J9qvgdYRUcauOXxnB1y58JGUsg=;
        b=ZL0QX5buvRMOObkkIbD90TOzgc2hQaOPW68AkQ1XZ6SJ4WQphYXm6tbB9/jTqRJNkN
         pN+XS4sfv9LI2MBlJWwTioqqNpFMS59teBq799N3pkmK6anQhpcBAgr8UvnFt+mDhIQG
         KaAfsKw3fJOrSxB99RICU6GjUq41Q2mOBKF7QFzwYX9XwlM68AzxBVm3c3KxBDKni968
         X9Sq0y9V9nZUF3f/qKpv+Jf15ZlvQCjWIuWl/WuoDO3lsq7dfJ8H/D6/HbZ5ieyt7zFU
         wIHgDC5WGMFnky4uAx+XBi/GfsJYSWYztAqTHnVuIz9YxuAp2G8Bm/nJBN/K8vku6zsT
         TU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762468; x=1753367268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtzrgmhXOlDN0Ac+5J9qvgdYRUcauOXxnB1y58JGUsg=;
        b=DUO4BPGBGx3yS5hLnX4IK89IQJMZW89LhjVlDX9dtBQfA9Hjd/V39TN2yfXoD1a3XQ
         EF2NEhMG4ILb1g8hWznln1I8M2swvQM/+zT2BumNl459kzogN9DJNxJogoYB9d8i2tkf
         jUDnVWJMdDI3oE0864lzvxsZPpX9/4zl0ZcNTY7MhQRPrWq/2ovSSNoAg5xa+bZdLUGH
         vwHqPyBHTodrc/F+ImR5dco2ii8gGox0XxIIPjPik524IQtKRXejKvWdbP24MOaiBgLz
         NihtQvESnW3omh56P51U6aFlxa69CMi7yR2W/nF/bZxeztoTtrKT1LgFQy3p7+LBPh2q
         Fx2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUw9B8SK4DYCgon0CdyCw1zL6ngCOMkyAf+eF5+NiBq1OezrYATQ0ZQ/AskjbWv6HEYSytWin6YFZ76FA==@vger.kernel.org, AJvYcCWTPRWBrSa6w0xgGNvhmKKnax8AWASEYOfT7P2gK1HMGHPKSX8XqcidZM433qSh4ncZ7+TPw/QmtmH/gTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJPKJG6Tn389LdO+iDpQL5wzjFccT1ZlQxH6KW6qkzzuCWqXJo
	/BM9Y47iJs/rKzN8enOPNLL7oYyQtLtrsXys5lrTXslaVY5gJUDkHQEm
X-Gm-Gg: ASbGncur3E8LyxpvOpXpVNzVryjC0icjaDm/FfNal27i+b1AIldvar/w72RNQirXFVS
	Aa5Wo2FoIhzysvwuD8JPXm02B37XwQ4/ytQJ2ix9FGQyjxuJIYl1bHwfBmjYN9OtZiJ6n604gWQ
	ytahONpze09qc8N4e9SgSEX1+JZrHIDptbKnlHl0yYVZPrXzLbeqo+TbunjvuId9/FOq0P3ePpt
	4VTPrKhSmxns27tpF/ZBz5CdqeXX4gwfKb557m7zFeFaefT17f80bxpGl0irbMnNPAVR2uRJ+N/
	91PQ2CgPzFBo1h4K5Hy43gfAZzRVM3jf4GGqlJCGPHEI99qumqguAYLVZ3ndDTjh0ytwyP8EeMq
	aJ+Z8BowHlxFnkPmHIWcfo89gWC5O1N+9Iq8XLlji/aY3LcfU4muibgq0FK+c0icGK6Nh
X-Google-Smtp-Source: AGHT+IGFU/9g3XHsICupAR2OwO3I+VhsbowqxnMbfcNePQa3z69BAqmHMKuwXCkJ+RRLdmWNcXslSQ==
X-Received: by 2002:a05:6512:1254:b0:553:2c01:ff4a with SMTP id 2adb3069b0e04-55a2fdd97dbmr24308e87.3.1752762467575;
        Thu, 17 Jul 2025 07:27:47 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:27:46 -0700 (PDT)
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
Subject: [PATCH v3 02/12] kasan: unify static kasan_flag_enabled across modes
Date: Thu, 17 Jul 2025 19:27:22 +0500
Message-Id: <20250717142732.292822-3-snovitoll@gmail.com>
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

Historically, the runtime static key kasan_flag_enabled existed only for
CONFIG_KASAN_HW_TAGS mode. Generic and SW_TAGS modes either relied on
architecture-specific kasan_arch_is_ready() implementations or evaluated
KASAN checks unconditionally, leading to code duplication.

This patch implements two-level approach:

1. kasan_enabled() - controls if KASAN is enabled at all (compile-time)
2. kasan_shadow_initialized() - tracks shadow memory
   initialization (runtime)

For architectures that select ARCH_DEFER_KASAN: kasan_shadow_initialized()
uses a static key that gets enabled when shadow memory is ready.

For architectures that don't: kasan_shadow_initialized() returns
IS_ENABLED(CONFIG_KASAN) since shadow is ready from the start.

This provides:
- Consistent interface across all KASAN modes
- Runtime control only where actually needed
- Compile-time constants for optimal performance where possible
- Clear separation between "KASAN configured" vs "shadow ready"

Also adds kasan_init_generic() function that enables the shadow flag and
handles initialization for Generic mode, and updates SW_TAGS and HW_TAGS
to use the unified kasan_shadow_enable() function.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v3:
- Only architectures that need deferred KASAN get runtime overhead
- Added kasan_shadow_initialized() for shadow memory readiness tracking
- kasan_enabled() now provides compile-time check for KASAN configuration
---
 include/linux/kasan-enabled.h | 34 ++++++++++++++++++++++++++--------
 include/linux/kasan.h         |  6 ++++++
 mm/kasan/common.c             |  9 +++++++++
 mm/kasan/generic.c            | 11 +++++++++++
 mm/kasan/hw_tags.c            |  9 +--------
 mm/kasan/sw_tags.c            |  2 ++
 6 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 6f612d69ea0..fa99dc58f95 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,32 +4,50 @@
 
 #include <linux/static_key.h>
 
-#ifdef CONFIG_KASAN_HW_TAGS
+/* Controls whether KASAN is enabled at all (compile-time check). */
+static __always_inline bool kasan_enabled(void)
+{
+	return IS_ENABLED(CONFIG_KASAN);
+}
 
+#ifdef CONFIG_ARCH_DEFER_KASAN
+/*
+ * Global runtime flag for architectures that need deferred KASAN.
+ * Switched to 'true' by the appropriate kasan_init_*()
+ * once KASAN is fully initialized.
+ */
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
-static __always_inline bool kasan_enabled(void)
+static __always_inline bool kasan_shadow_initialized(void)
 {
 	return static_branch_likely(&kasan_flag_enabled);
 }
 
-static inline bool kasan_hw_tags_enabled(void)
+static inline void kasan_enable(void)
+{
+	static_branch_enable(&kasan_flag_enabled);
+}
+#else
+/* For architectures that can enable KASAN early, use compile-time check. */
+static __always_inline bool kasan_shadow_initialized(void)
 {
 	return kasan_enabled();
 }
 
-#else /* CONFIG_KASAN_HW_TAGS */
+/* No-op for architectures that don't need deferred KASAN. */
+static inline void kasan_enable(void) {}
+#endif /* CONFIG_ARCH_DEFER_KASAN */
 
-static inline bool kasan_enabled(void)
+#ifdef CONFIG_KASAN_HW_TAGS
+static inline bool kasan_hw_tags_enabled(void)
 {
-	return IS_ENABLED(CONFIG_KASAN);
+	return kasan_enabled();
 }
-
+#else
 static inline bool kasan_hw_tags_enabled(void)
 {
 	return false;
 }
-
 #endif /* CONFIG_KASAN_HW_TAGS */
 
 #endif /* LINUX_KASAN_ENABLED_H */
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 890011071f2..51a8293d1af 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -543,6 +543,12 @@ void kasan_report_async(void);
 
 #endif /* CONFIG_KASAN_HW_TAGS */
 
+#ifdef CONFIG_KASAN_GENERIC
+void __init kasan_init_generic(void);
+#else
+static inline void kasan_init_generic(void) { }
+#endif
+
 #ifdef CONFIG_KASAN_SW_TAGS
 void __init kasan_init_sw_tags(void);
 #else
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index ed4873e18c7..c3a6446404d 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -32,6 +32,15 @@
 #include "kasan.h"
 #include "../slab.h"
 
+#ifdef CONFIG_ARCH_DEFER_KASAN
+/*
+ * Definition of the unified static key declared in kasan-enabled.h.
+ * This provides consistent runtime enable/disable across KASAN modes.
+ */
+DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
+EXPORT_SYMBOL(kasan_flag_enabled);
+#endif
+
 struct slab *kasan_addr_to_slab(const void *addr)
 {
 	if (virt_addr_valid(addr))
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d54e89f8c3e..03b6d322ff6 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -36,6 +36,17 @@
 #include "kasan.h"
 #include "../slab.h"
 
+/*
+ * Initialize Generic KASAN and enable runtime checks.
+ * This should be called from arch kasan_init() once shadow memory is ready.
+ */
+void __init kasan_init_generic(void)
+{
+	kasan_enable();
+
+	pr_info("KernelAddressSanitizer initialized (generic)\n");
+}
+
 /*
  * All functions below always inlined so compiler could
  * perform better optimizations in each of __asan_loadX/__assn_storeX
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 9a6927394b5..c8289a3feab 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -45,13 +45,6 @@ static enum kasan_arg kasan_arg __ro_after_init;
 static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
 
-/*
- * Whether KASAN is enabled at all.
- * The value remains false until KASAN is initialized by kasan_init_hw_tags().
- */
-DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
-EXPORT_SYMBOL(kasan_flag_enabled);
-
 /*
  * Whether the selected mode is synchronous, asynchronous, or asymmetric.
  * Defaults to KASAN_MODE_SYNC.
@@ -260,7 +253,7 @@ void __init kasan_init_hw_tags(void)
 	kasan_init_tags();
 
 	/* KASAN is now initialized, enable it. */
-	static_branch_enable(&kasan_flag_enabled);
+	kasan_enable();
 
 	pr_info("KernelAddressSanitizer initialized (hw-tags, mode=%s, vmalloc=%s, stacktrace=%s)\n",
 		kasan_mode_info(),
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index b9382b5b6a3..275bcbbf612 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -45,6 +45,8 @@ void __init kasan_init_sw_tags(void)
 
 	kasan_init_tags();
 
+	kasan_enable();
+
 	pr_info("KernelAddressSanitizer initialized (sw-tags, stacktrace=%s)\n",
 		str_on_off(kasan_stack_collection_enabled()));
 }
-- 
2.34.1

