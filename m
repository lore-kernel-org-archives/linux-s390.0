Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E52ED165;
	Thu, 26 Jun 2025 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951935; cv=none; b=DWAPj7YD7QjbyrG9H9sFjPaCM7874FnhgMYHOEEYqmFKiE4FZygwh5JVb3m+d79j9++y+voEtJw9HScLI8PxSLp7N4mKonxpaEIqZLoPfkUlQ4XIgki5EXulPK+yjkxk2HH8rz5k8bnBt9NoTGFTitiZvFenS6y4K+KgEXgZew4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951935; c=relaxed/simple;
	bh=kQk1v9s1banQZEyMdVJIVhKwmVBmTThWer/Uh1qqD6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPOSzpOkqah2dP0dn3eidWwa41fMZXgp7TRnkuYHnC0+pX+y2LvKLcmshgCwgd1QRAeNGj5xG6Zw80kAmErCdzJOgvlGVqTZLrrayszcdzztASdm+ZuASOu2pRrR98ak7bGdZh3ucXN73D7LpVl5puKE11s2NXQQu5b5w42iI7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwDBI305; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwDBI305"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553b3316160so1020727e87.2;
        Thu, 26 Jun 2025 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951931; x=1751556731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WWyylL/OQDZN+BQlllp9O148iIrISnZhKRdMW4Il1I=;
        b=LwDBI3059uJjDEZzFG7vzvFcL/Nhgvo7rcaanPP/re1sJ8fN88cyxjhNssj1UJbtEV
         dgYbM8yEv7N++1tEaSsziv/TxqVOLfk6MkI9gWvDB4UHhaSa+5lOxoMlxQRdCRnth+p7
         7imIECqp05A4eChUX9oj1LIZRT6zbgl3GaRzbGzJfH9iKNOv0PgJn84VvyesNMSgAkdC
         F3P7hrmWvXlQsBtIl1xIGfwplIKQgFSDBkeuW32ofewuRnTu31RkETvHXfP34BkZtnSq
         3zEQo0qra6q+YDRu+dKz6cv7BpfTTM9qhQPiX5jygnmxwKu0aQMPaZCvOj2+6fgtGlBE
         5F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951931; x=1751556731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WWyylL/OQDZN+BQlllp9O148iIrISnZhKRdMW4Il1I=;
        b=fmBJM8xQEucd3EaiOBg0Z9AuYx5nFKDwz+fs0PeFBGSMx3CYUKi/O5hts40gO9B3sS
         OwLsmH9OjyN72z+yCslOowA08ztJlLz2o5+KG4h55b1CYpyQnSqARk23HbYzEyAXPmvb
         h1haMgN+1dmPQLnfFS2yTwzv0ydtCU9MPLwrQvzMgPAwDw15Sims8WWZKzakBWHz7YHu
         eYGqeF9wDwlocmgQkTxbkDzBHQzopIDaF4lPpywVbzkDt7hW+eHaeUiGLPA7HGdDueJZ
         0kZOajIjB75WqnvdzWeC/aiZZaenJ/7FRaxHXdVV9C65/l5aAtUCb5rN7mu/ax2JKmCf
         vvAA==
X-Forwarded-Encrypted: i=1; AJvYcCVxR4rye00TbNm/NZzkrc+Hk+ffbOLzTJW91XIeKh7/JPQEHNKZaLaLv4fm1tsqOtPxzlzwTEIWLcvn118=@vger.kernel.org, AJvYcCXjBhqsh+Gskjwe1Kj96pRdVvj8vbpfmgtcJS3theBIy5VGjX0RRgNNvqAqnHEPtJzHkWteU0sLXxdEzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/sRYJgocF4CjBh7hrK2teVixNQjHxah5m2AwAyzRufGX1A/x
	vpPbChTFa0lGoxuG2N7RSzdXnhA9mHQtZueeDQRl3jfykz+ZFzJh9OLY
X-Gm-Gg: ASbGncufBxeH9GQOWtFysej0ut7Lw081KY1C6ooNqNShqJfCU/dr/8MR7F8LNy61jo6
	3eckO08/1cUcdRa+GI2v/Yxv9GAeNLUtfZ0YcDCyRbJrymV/0HMB9KCTyv3zXNAF38ERwJ7MZy/
	OZshsj118RKuMCrPyU8JYf2TapfkeQa9vQFt0MnXUFoOx5QZj2ISik2Pn+/ZZvE+BnBH8YEz9pI
	j3B3wPraaw7OFM4Pg2gJXXbSOHLNUZssS5A5g5/PrW6nydx37uL0O7yxbB3NSWZJ6ybvsTIs66y
	g+4oOnQ/tjjnYdvJ2qZfEDdgBRv6YDWI3lPp9OaxwPTy6NK0tMRryUigy/0Y4ZOZqG6ShfRAbDS
	4Ay7Y8LNr5J4MswG4t3Her0rHIc8zl2i7ZOQOzpi7
X-Google-Smtp-Source: AGHT+IE9GYxLiOYhxIA5Ev3WJWnszBqvgVmZmVZpoI4KzTn4pH5uj6GPwII6Blv/6T015vTzfPK1pQ==
X-Received: by 2002:a05:6512:b91:b0:553:adf7:e740 with SMTP id 2adb3069b0e04-554fdd1d728mr2765576e87.28.1750951930696;
        Thu, 26 Jun 2025 08:32:10 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:10 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
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
	akpm@linux-foundation.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: arnd@arndb.de,
	rppt@kernel.org,
	geert@linux-m68k.org,
	mcgrof@kernel.org,
	guoweikang.kernel@gmail.com,
	tiwei.btw@antgroup.com,
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	snovitoll@gmail.com
Subject: [PATCH v2 01/11] kasan: unify static kasan_flag_enabled across modes
Date: Thu, 26 Jun 2025 20:31:37 +0500
Message-Id: <20250626153147.145312-2-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Historically, the runtime static key kasan_flag_enabled existed only for
CONFIG_KASAN_HW_TAGS mode. Generic and SW_TAGS modes either relied on
architecture-specific kasan_arch_is_ready() implementations or evaluated
KASAN checks unconditionally, leading to code duplication.

This patch unifies the approach by:

1. Moving kasan_flag_enabled declaration under CONFIG_KASAN (all modes)
   instead of only CONFIG_KASAN_HW_TAGS
2. Moving the static key definition to common.c for shared usage
3. Adding kasan_init_generic() function that enables the static key and
   handles initialization for Generic mode
4. Updating SW_TAGS mode to enable the unified static key
5. Removing the duplicate static key definition from HW_TAGS

After this change, all KASAN modes use the same underlying static key
infrastructure. The kasan_enabled() function now provides consistent
runtime enable behavior across Generic, SW_TAGS, and HW_TAGS modes.

This maintains a backward compatibility - existing architecture code
continues to work unchanged, but now benefits from the unified runtime
control mechanism. The architecture-specific kasan_arch_is_ready()
implementations can be gradually replaced with calls to the new
kasan_init_generic() function.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 include/linux/kasan-enabled.h | 10 ++++++++--
 include/linux/kasan.h         |  6 ++++++
 mm/kasan/common.c             |  7 +++++++
 mm/kasan/generic.c            | 11 +++++++++++
 mm/kasan/hw_tags.c            |  7 -------
 mm/kasan/sw_tags.c            |  2 ++
 6 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 6f612d69ea0..2b1351c30c6 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,9 +4,15 @@
 
 #include <linux/static_key.h>
 
-#ifdef CONFIG_KASAN_HW_TAGS
-
+#ifdef CONFIG_KASAN
+/*
+ * Global runtime flag. Starts ‘false’; switched to ‘true’ by
+ * the appropriate kasan_init_*() once KASAN is fully initialized.
+ */
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
+#endif
+
+#ifdef CONFIG_KASAN_HW_TAGS
 
 static __always_inline bool kasan_enabled(void)
 {
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
index ed4873e18c7..525194da25f 100644
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
index d54e89f8c3e..32c432df24a 100644
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
index 9a6927394b5..8e819fc4a26 100644
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
index b9382b5b6a3..525bc91e2fc 100644
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

