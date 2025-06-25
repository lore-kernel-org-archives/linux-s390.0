Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68190285C97;
	Wed, 25 Jun 2025 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845175; cv=none; b=D7cx/3dUV7EIAIuK1bhBLUO2acc7GMxepsXUwbgBXP06zfbcooKW9i1qngQqfFBmHtnQFcWC+LTJ/wuz8eOLxtvXD3CbK/YNs2g1mbQ23EOt7bzoefCbep9s7rmBdwr17NASLAN6lLCd00y3yLkqghZGhK1/iUrxzeT1LcZEAZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845175; c=relaxed/simple;
	bh=K343I3qAoPHAanfNFChAhUARVvZ/YL0WcDDqgni6Tx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvcA5BOizHUmnh6SyF9GXboNdilT6khFdQWr+5D9kyfwL6UgH9oxoWgPnkZXC7Nbb9kdsXFjHm/1RyboSkpIsspAMKzrbFxlCNYfORlVO24d6O8XNnfcjt25YP77Euzn4Zq2HAgoeBjqL3Ty/cT/AZ+K/ODEyu1VD8Xp3RtZh2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjJF0ydA; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjJF0ydA"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b3b250621so12816931fa.2;
        Wed, 25 Jun 2025 02:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845171; x=1751449971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6SFM5Ezspiku172UK6Utmx+P9PfAPP964pKgViV7lo=;
        b=HjJF0ydANy4dabES77+FV+cu2Re5FdQIHwd8CaP3X7cGW44ZcGchdjBdAOi9oiquZG
         rszgRHSsi8wOZWhVgjXbBFxCjOpWcbTNjk3eutQOFFwozaCpXgT4GTSS8bc038IgN2lD
         6FjmHlwUwsCX3G7J1z6IClgxCldam52TY7Q/tsRNK7rBmjhzDtHHuxiU1GCqIPG+WmvG
         jx6EgFiQeymSpqEq0/Vcu0gOZX2IqQfc+seJtcz2CKvOzR+0wHmbQFE3EYPMGlgifDta
         Nh7Rj7eW14tQhjUKY/be5veQKrHI2OYbdFaHXt7piHnuJyKpa0NE+yzAj05bHXEwh2ck
         GHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845171; x=1751449971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6SFM5Ezspiku172UK6Utmx+P9PfAPP964pKgViV7lo=;
        b=ty/oMxfF5sqehbo1HMlWkxh9w7OSbYwRzN0LYz1789yFG6TS6xBFxKxRT0RySzHpLz
         ip+AGTFl5rz3ixM1BFZTaEmby7HJ5DaJK3UO6cmw1VzE9Qa06uVi+p6zT0Odp/tiGiFa
         LdwXY3E7yHuSEZ6vu1+DS0kkySbo/f/zRrgDb9ekUlOYGP27Uk+5DikpiI+ocwhlNcNf
         fC9U4tOaNO2wU3ADcZkRcMZI2H1I/oL/xIEIuRzmW28N1v6yXBbnrVb5krdlWdTovtKg
         +y+pEhMEN2tB9xieVijjMwtSQBe2m6HWK+bBhqbxwFVBHM2U/AN945Misphbi4m3UxiL
         HvSw==
X-Forwarded-Encrypted: i=1; AJvYcCURwI/eFBYSZKptNb49yxLoL5dZe/QU3OUnyD7+VptVisxmy8IKwGto44sdQ3TVe57ttb7YlNk/CGJrDg==@vger.kernel.org, AJvYcCV01QMBRSuf/iR4Udn98xiKYzj+kkas9Kb0++biiUITy9DMmmDtB7TB9ihMvmrKI3ZTR/TxkFBPnO6XXC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi4QgV2FeQnmSFcWMy5v+igTVKcY0c7VYjIkrbL3/ko2dXjKfu
	r9a9se9hqyV+viAueWe4h9wjxUsgPCY3Q96GDFoUT2/VCUXueQz5iT/r
X-Gm-Gg: ASbGncv5/nUNUd9THNcKKtHwigxJaCMcbVrklybI7TZGiEY4wMlvDRbum8cUx0MaTnD
	bEoSLUWzeUDCpY4qaVFtGM8UE9DI+1pMmBESxi5z0ajD4ifI7Tr5K87GQv2sZCCE5B8cWY0SGtf
	eV4FcjkZZCQg0xyHbZhZsH8HC4n5VBps3Mg1OfqAjF2qdtPgqG3qcsS40FoMyvcdXcuO9IO7hON
	t4moDYJPojTKUjUgR/jBy857JdrL8o7Nl5P//Q7FjHgXOfo9i2kR3YSkue9UhEX0PXoneiXuEqC
	7mB2kRpsw0zZuCGSPtWOk4pyjfsUa062cdbbtiTVasShyCanadmbnLTW7rZNdSbt/o2Olcj/Pyk
	BW7kZ45IU3bmw+YiX55iVfSuVtzDwNw==
X-Google-Smtp-Source: AGHT+IEfwLa2l5GETasrkBN6s16G3uwHStgfCUXGV9Vb0lViqA4Rs63c7NBMXwsuNAY9/KPq3s8gww==
X-Received: by 2002:a05:651c:f03:b0:32b:93fa:2c0b with SMTP id 38308e7fff4ca-32cc64d280emr4286261fa.11.1750845171079;
        Wed, 25 Jun 2025 02:52:51 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:52:50 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com,
	geert@linux-m68k.org,
	rppt@kernel.org,
	tiwei.btw@antgroup.com,
	richard.weiyang@gmail.com,
	benjamin.berg@intel.com,
	kevin.brodsky@arm.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH 1/9] kasan: unify static kasan_flag_enabled across modes
Date: Wed, 25 Jun 2025 14:52:16 +0500
Message-Id: <20250625095224.118679-2-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625095224.118679-1-snovitoll@gmail.com>
References: <20250625095224.118679-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Historically the fast-path static key `kasan_flag_enabled` existed
only for `CONFIG_KASAN_HW_TAGS`. Generic and SW_TAGS either relied on
`kasan_arch_is_ready()` or evaluated KASAN checks unconditionally.
As a result every architecture had to toggle a private flag
in its `kasan_init()`.

This patch turns the flag into a single global runtime predicate that
is built for every `CONFIG_KASAN` mode and adds a helper that flips
the key once KASAN is ready.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 include/linux/kasan-enabled.h | 22 ++++++++++++++++------
 include/linux/kasan.h         |  6 ++++++
 mm/kasan/common.c             |  7 +++++++
 mm/kasan/generic.c            | 11 +++++++++++
 mm/kasan/hw_tags.c            |  7 -------
 mm/kasan/sw_tags.c            |  2 ++
 6 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 6f612d69ea0c..2436eb45cfee 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,8 +4,12 @@
 
 #include <linux/static_key.h>
 
-#ifdef CONFIG_KASAN_HW_TAGS
+#ifdef CONFIG_KASAN
 
+/*
+ * Global runtime flag. Starts ‘false’; switched to ‘true’ by
+ * the appropriate kasan_init_*() once KASAN is fully initialized.
+ */
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
 static __always_inline bool kasan_enabled(void)
@@ -13,18 +17,24 @@ static __always_inline bool kasan_enabled(void)
 	return static_branch_likely(&kasan_flag_enabled);
 }
 
-static inline bool kasan_hw_tags_enabled(void)
+#else /* !CONFIG_KASAN */
+
+static __always_inline bool kasan_enabled(void)
 {
-	return kasan_enabled();
+	return false;
 }
 
-#else /* CONFIG_KASAN_HW_TAGS */
+#endif /* CONFIG_KASAN */
 
-static inline bool kasan_enabled(void)
+#ifdef CONFIG_KASAN_HW_TAGS
+
+static inline bool kasan_hw_tags_enabled(void)
 {
-	return IS_ENABLED(CONFIG_KASAN);
+	return kasan_enabled();
 }
 
+#else /* !CONFIG_KASAN_HW_TAGS */
+
 static inline bool kasan_hw_tags_enabled(void)
 {
 	return false;
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 890011071f2b..51a8293d1af6 100644
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
index ed4873e18c75..525194da25fa 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -32,6 +32,13 @@
 #include "kasan.h"
 #include "../slab.h"
 
+/*
+ * Definition of the unified static key declared in kasan-enabled.h.
+ * This provides consistent runtime enable/disable across all KASAN modes.
+ */
+DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
+EXPORT_SYMBOL(kasan_flag_enabled);
+
 struct slab *kasan_addr_to_slab(const void *addr)
 {
 	if (virt_addr_valid(addr))
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d54e89f8c3e7..32c432df24aa 100644
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
+	static_branch_enable(&kasan_flag_enabled);
+
+	pr_info("KernelAddressSanitizer initialized (generic)\n");
+}
+
 /*
  * All functions below always inlined so compiler could
  * perform better optimizations in each of __asan_loadX/__assn_storeX
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 9a6927394b54..8e819fc4a260 100644
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
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index b9382b5b6a37..525bc91e2fcd 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -45,6 +45,8 @@ void __init kasan_init_sw_tags(void)
 
 	kasan_init_tags();
 
+	static_branch_enable(&kasan_flag_enabled);
+
 	pr_info("KernelAddressSanitizer initialized (sw-tags, stacktrace=%s)\n",
 		str_on_off(kasan_stack_collection_enabled()));
 }
-- 
2.34.1

