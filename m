Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D22F85C9;
	Thu, 17 Jul 2025 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762487; cv=none; b=OFhMksDyCCi/gUKUoTv/Q1MkHL/dZxx/okLPrfXrk9NmRjKfIs4gL8qJcbEZaeZWXbhDFgrJG/l3Pq1hAIDuYAJUd4sgl6YLTLtMtUbXMbebFWvtSH4bbI502ECAoG8FEOQAKi+a0R1loP2h8KEZgQpAHXZkZiyvRrlYLYn+3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762487; c=relaxed/simple;
	bh=iyvyFShSw2tQpFiJjfhyr1CCv5Bxv6uDVr/sKPG3O90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQb+I6Au8ojLaJp9RDOfyws3FxMjxFzxbpaf5x0QThejEBpdwbFQQicw+k057e5JuAG/DiSu5e1DoNshRTh42hhBNSj2N31aDKyhM42a+jiAeG+vOoFbHTMSZjCkcNZ0zOEqvKRHxIyTXwa+Xi3Clu17nq8pM15MKb3owFAcXsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX1EMAJK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX1EMAJK"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-555024588a8so978353e87.0;
        Thu, 17 Jul 2025 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762484; x=1753367284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQlEQnJy2HJRDhHnfkaTRfud2Lma6wEowy/1dG9z9wI=;
        b=FX1EMAJKpoA2KgntDmsiKmt4ZjauUyuFZp5BNT/RxPe7RTW+gbFDIeEMpc4duP+PIB
         eq00apycPJCes4v3FZKkwvhIYnE1z2wIHVLB8JSPL2Zzq3fGUb4Z30C+xvFOr80gZj8i
         yqLUr6uCpwA8Tv0NHMU54D+bmAGjD/K56QTMp3X5961Y6JoQxA2W4POubSz4kops4CcE
         SgpXvWEKPkMXnMBx33dyKiv5aTzk4kHLrVEexjMveIHDJoqz4xf8h5brx23TZEt9e+q0
         ftTsFbIxra7ym9tOxiUG3YuQjYcpusnVFN/u2Hn3v1YvNy2cf7GY8Itku3/jhRwjSmku
         QUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762484; x=1753367284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQlEQnJy2HJRDhHnfkaTRfud2Lma6wEowy/1dG9z9wI=;
        b=QZ5TiYzvwBq4QQhySFREpIUZ/rg1DAldGRwoqbE3XM8SqaXnjuClZbYsP53kKc69Ws
         FdgspPXRz9vpeJCG1Xj9A68k5WyVgtmDJgvMwXsejnk9kWstLQlt3e0NiOcQDCzoKgMy
         wy44niZz+td/TQh/kFu3GsD8nTwKbxvGbk/ErsTYPGHTmAg+Zx8/XykVQNR3+J/B6v9D
         kKuvR5T48VSir6tfkBHJ+cCSwgH9i9fgeCgKuedpaZSMGP2bqYD2in0VxXz1W/WJI4oL
         +Neb79LObwJshwmkpZ2o6hKecaD1iZUwE00dXRkMaiVnhys3whj/64NPknEhyVEzJU02
         SpIA==
X-Forwarded-Encrypted: i=1; AJvYcCUFaHpVOF6AJw/0f8gaCOWVdYlc3dUDHTHrD4v+VTDxoDycSttaWE73aljnMQWKJaUgZ8PAFh9cjy3YPg==@vger.kernel.org, AJvYcCWry9LSLZo/bzVX7oA2iCasaK2om2Tv8ydblZKHQftHa4ahIw8sJPgWxm0pBTr55B1t9kisP0MNsCJPeOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3yqNfmpa1vWTilyZlkXiRwuADJJUeQ2CF2Cy6YDzDa7sCiRl/
	MKh28u3S1exE1SZM6v2zar+9IPLGASc5lKc4vHaVjSiWtcybhTPPo1zo
X-Gm-Gg: ASbGnctztnfXTNfmg1fbj8n3u0QUXle5Rcd0wxaa+/SDhSe1oQ92RJCcNiqOB+hiQem
	uQddzNs8X+M8SFZiZZtGk2BwMy9arKHy+FFdvXYtSI8kK2bdSXCaXo+zayW6H/SDKAzaZNF4TfY
	14UMUZsa0OOAulJZhPz4O9kmQRdwi2Rj/nYAgmjcjAz68xPO4J2UkgJVBcsqwvwMx6MB0RdBEvU
	EnGtKD2DGwgr4NeodTjTr//tE8E0qluQe14dT1mcLzFxZlz2eC9BIw0eR3l5d5/k6ZDEYvtyiMP
	LFrd15i4jiD0ovnhRitKLKTWZsvhPtr76YhXo6K8UDWZaAAdm0fhpjDaQ2vzLxNVtXyasIKxTsS
	tu7/3K/ZYvRCWbpPBsKXWyySArVG6vmhPNtdfebgKYwF7kE3rkRFDcPtaxQErzDKSUBcF
X-Google-Smtp-Source: AGHT+IGXa3L1SWxkZTnlyx1w4BEvo8LnYJCQl11jQhxF60PeWT+4RjpJebmC/Vi8BeBawEBpCpZoXA==
X-Received: by 2002:a05:6512:2310:b0:55a:271e:965c with SMTP id 2adb3069b0e04-55a271e97f2mr1332318e87.55.1752762484050;
        Thu, 17 Jul 2025 07:28:04 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:28:02 -0700 (PDT)
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
Subject: [PATCH v3 07/12] kasan/loongarch: select ARCH_DEFER_KASAN and call kasan_init_generic
Date: Thu, 17 Jul 2025 19:27:27 +0500
Message-Id: <20250717142732.292822-8-snovitoll@gmail.com>
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
Changes in v3:
- Added CONFIG_ARCH_DEFER_KASAN selection to enable proper runtime control
---
 arch/loongarch/Kconfig             | 1 +
 arch/loongarch/include/asm/kasan.h | 7 -------
 arch/loongarch/mm/kasan_init.c     | 7 ++-----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 4b19f93379a..07130809a35 100644
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
index d2681272d8f..cf8315f9119 100644
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
+	if (!kasan_enabled()) {
 		return (void *)(kasan_early_shadow_page);
 	} else {
 		unsigned long maddr = (unsigned long)addr;
@@ -298,7 +296,7 @@ void __init kasan_init(void)
 	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
 					kasan_mem_to_shadow((void *)KFENCE_AREA_END));
 
-	kasan_early_stage = false;
+	kasan_init_generic();
 
 	/* Populate the linear mapping */
 	for_each_mem_range(i, &pa_start, &pa_end) {
@@ -329,5 +327,4 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized.\n");
 }
-- 
2.34.1

