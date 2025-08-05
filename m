Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035627A47E;
	Tue,  5 Aug 2025 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404004; cv=none; b=m8r8BKfJSRJ8iRBHUnTrtUw3m7/H4STst0w6vvSp9c9KaXBgbMQjDebfO+Qolh6LrbDQCLCGOulsXEDmI9zJs1L0RO+raJYacB99rhE5ZAlxTKwMVvzH7blcOdsUHnc1E+jGwRp+jOFgAte7qWJjvGXBsVmJkPxUjxl6bBi99pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404004; c=relaxed/simple;
	bh=7epp5zkqN4XDShph3ucilCsVpuCVnzjWU33NaR7AXbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H8Mfj4HCdXy7OHfn3QwBut5EIbadFbCSAkoVaJzj1LngPlwOG3/DZpNe1RgkooNcURGM7TaidtqxJ5fwtr2BOmRu0s+3K4antl8N+b1LU5ylF4j/JwLkGneMIQOrXZIHEiKt8tYmEnheUVTU59xQKBnuiSx2cZ5Lxn6IFy9PBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkETZsJN; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkETZsJN"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55b827aba01so3852348e87.0;
        Tue, 05 Aug 2025 07:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754404000; x=1755008800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DndoJEoEU+djai/jF18bii/cwZvYONRQ0C6xs3DhJyU=;
        b=ZkETZsJNq2TD6twfQnvTBHi8qv5isC9D1kAUj5jc4TKGyiOQmwz1pPyUxaz023x7wl
         olurgpvRMNQrw5tDRmnZt2cXivnEakVU2UBcb3EQq9LArQHhrlvBRTtpeLyDO07GemWf
         j8puVw0g59OppkqIs5a1qzcHCv4zO7d6Wr4lGsMzzaIfTtidkgOGzKkHkVj3J8eyMMlK
         BfhKGC1tiooLxk/SxmugJ+4Pa5XNU9eUJ1YDMTeXomHARzcVaPr/Ia4nmuw+P9TTFsSp
         RVETXZBzZuw01/icpB7UJctPO37rePy2lc+LcvtN75URps7eW4U+JoW2oK7ZA6ldaq5/
         1xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404000; x=1755008800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DndoJEoEU+djai/jF18bii/cwZvYONRQ0C6xs3DhJyU=;
        b=LysKlHEgjY9g730W1KLvalq9lfoIQKvhjrkHab7DB5oMYRxcjtxbq0kBCoXely7cus
         FTQdqAEVtiX2pCl8B8td4ffQlHL+HCpJYOfVWJ642hRg1QeU36amhDkUW6kNlGhSI0bo
         5cVfafFotu8l8/+Kve4QxyR29XMKYX7Dx1ljCZcebeUhMDJJrIt4fbrFKiFkQ6O0HBMY
         75kM7ggQfdrQKFjxmT4c1KmTkF9zJxxoCYum3D+6nHaMPHvZmw95+H95EqFW3tpWPSTi
         ndHF/T8gb4fVl0oIqBcREY3zZGy5t0hgJzCAIO9XqsfZb3lpnsXtMapaCCyotplAVBmc
         GsmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf0J3hucLoPUpRQQEqqok77mNkDuoAmkhNT8ONC9A9zOC0tMEt+8xk5bXUi+eTaxea5HE6QnXe/MJp+Bo=@vger.kernel.org, AJvYcCVbJ5VrgzhrR03U3DcAtLQRW4GQx+WALNNa6iQ9sr7SdkVMqVJAcSJn1CzgzJiPP5pLpwyHWlj8KGd9qA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhJBpFKTGKA8GxbNNgjWk6/JyxfM7bpKG6YJW/qwteL53fEDC
	HwUZCUWpz3rOvj00NWrZbFt4ULkWGSddEznL6+pzH0GJ09E58qY0NJhr
X-Gm-Gg: ASbGncvg4HK6ux4yUjT2pov2aVj/2Lfpq2JCe9xlKMScxWJKUFGguvkR/+gZEW8blN2
	qXdvulF8uZIJGiG6PnoE1w2VN5nYTaKjzbVcE8qrBYjAMjeOKcDhUg57/HjiSMbERg0sdlM+wL4
	Jl5FNv+1MAGYhbaTM7mxmi58O5QcZxStU7oCywTRvy9RW+54N+serhSbvh44GVjgOCAG4un3dCa
	wr6zR87KpqF9fIajooTNksfrPNkWYTjYwOJcAuLqW/A+UCq6GlepuQsvpTpn18jlKLJQ2iosXaI
	+AtF8WbcELqyjOMLktNH3PAmDun6LwQPMfcnk499HshNnhmczJbDMwK7lCe+Ml9OOu9J3V5fhfN
	RGPk+mJa40o+3t4leo+xb3yFM/FkRDTcgJ3oPE15eATrgrPtoxqHwTpQheK3PhiKZdFSXAg==
X-Google-Smtp-Source: AGHT+IG8YXFpsfEvWLWpJ0j6eFW8/n9npKWJxSkpHVdxT2hyDgxCfNXo+mPOdolEzpL3+MkF6IOdvw==
X-Received: by 2002:a05:6512:1387:b0:553:25f4:695c with SMTP id 2adb3069b0e04-55b97bc54b1mr4200362e87.50.1754404000307;
        Tue, 05 Aug 2025 07:26:40 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:39 -0700 (PDT)
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
Subject: [PATCH v4 5/9] kasan/loongarch: select ARCH_DEFER_KASAN and call kasan_init_generic
Date: Tue,  5 Aug 2025 19:26:18 +0500
Message-Id: <20250805142622.560992-6-snovitoll@gmail.com>
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

LoongArch needs deferred KASAN initialization as it has a custom
kasan_arch_is_ready() implementation that tracks shadow memory
readiness via the kasan_early_stage flag.

Select ARCH_DEFER_KASAN to enable the unified static key mechanism
for runtime KASAN control. Call kasan_init_generic() which handles
Generic KASAN initialization and enables the static key.

Replace kasan_arch_is_ready() with kasan_enabled() and delete the
flag kasan_early_stage in favor of the unified kasan_enabled()
interface.

Note that init_task.kasan_depth = 0 is called after kasan_init_generic(),
which is different than in other arch kasan_init(). This is left
unchanged as it cannot be tested.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v4:
- Replaced !kasan_enabled() with !kasan_shadow_initialized() in
  loongarch which selects ARCH_DEFER_KASAN (Andrey Ryabinin)
---
 arch/loongarch/Kconfig             | 1 +
 arch/loongarch/include/asm/kasan.h | 7 -------
 arch/loongarch/mm/kasan_init.c     | 8 ++------
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f0abc38c40a..f6304c073ec 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -9,6 +9,7 @@ config LOONGARCH
 	select ACPI_PPTT if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_BINFMT_ELF_STATE
+	select ARCH_DEFER_KASAN
 	select ARCH_DISABLE_KASAN_INLINE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/asm/kasan.h
index 62f139a9c87..0e50e5b5e05 100644
--- a/arch/loongarch/include/asm/kasan.h
+++ b/arch/loongarch/include/asm/kasan.h
@@ -66,7 +66,6 @@
 #define XKPRANGE_WC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKPRANGE_WC_KASAN_OFFSET)
 #define XKVRANGE_VC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKVRANGE_VC_KASAN_OFFSET)
 
-extern bool kasan_early_stage;
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
 
 #define kasan_mem_to_shadow kasan_mem_to_shadow
@@ -75,12 +74,6 @@ void *kasan_mem_to_shadow(const void *addr);
 #define kasan_shadow_to_mem kasan_shadow_to_mem
 const void *kasan_shadow_to_mem(const void *shadow_addr);
 
-#define kasan_arch_is_ready kasan_arch_is_ready
-static __always_inline bool kasan_arch_is_ready(void)
-{
-	return !kasan_early_stage;
-}
-
 #define addr_has_metadata addr_has_metadata
 static __always_inline bool addr_has_metadata(const void *addr)
 {
diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index d2681272d8f..57fb6e98376 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -40,11 +40,9 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 #define __pte_none(early, pte) (early ? pte_none(pte) : \
 ((pte_val(pte) & _PFN_MASK) == (unsigned long)__pa(kasan_early_shadow_page)))
 
-bool kasan_early_stage = true;
-
 void *kasan_mem_to_shadow(const void *addr)
 {
-	if (!kasan_arch_is_ready()) {
+	if (!kasan_shadow_initialized()) {
 		return (void *)(kasan_early_shadow_page);
 	} else {
 		unsigned long maddr = (unsigned long)addr;
@@ -298,8 +296,6 @@ void __init kasan_init(void)
 	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
 					kasan_mem_to_shadow((void *)KFENCE_AREA_END));
 
-	kasan_early_stage = false;
-
 	/* Populate the linear mapping */
 	for_each_mem_range(i, &pa_start, &pa_end) {
 		void *start = (void *)phys_to_virt(pa_start);
@@ -329,5 +325,5 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized.\n");
+	kasan_init_generic();
 }
-- 
2.34.1

