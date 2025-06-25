Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3078288CB7;
	Wed, 25 Jun 2025 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845200; cv=none; b=i0piOT1RSjW7Z/ciiP42kO6z78FlK2Y9d/+ryDIC0gCb1ez9CRm1c/kXbSUsN4+Wzy7IZrIJozayRU2g26pD6jR3U8cJAdJ2/ay74lo4x/LqRGAUO3FXhXeb23luatIkDFTxdgfLB9k0/D3sYBFpaIkPF2laO0npCL9CPdsuE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845200; c=relaxed/simple;
	bh=YSrfFiO3wmIem/Z+PiAU/NMaBQktcErgh1DaWKXnlpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=huFs8AtA7HCq7nkw3apolZFlY/6b4Gpdz9BG2QjImTjTuv0Wjfl4UFE4R1mdruTrfr3jtbQHZ+TYpEWSFCAPyDFxl718qSml9zhgHF67tOfj5I+kt0eXLUANLQloPqZY23GOpxGFiRDgbVeQRuwnfQFf49RRWNshbcLIsJ0a6Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pan7sCYm; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pan7sCYm"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553644b8f56so1373735e87.1;
        Wed, 25 Jun 2025 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845196; x=1751449996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOegpAuvdkFcZey7AJnC2ppf18uuNZebWg0aRe4Uqy0=;
        b=Pan7sCYmRjD+SsNNft9sNR4wt1HY9qjuesdPh3cON2tr79/M4k3kkQVo84XFlZMVwY
         Ydb4HHolU0G3tSp3SLenF9/JE/GfdgcFJLnvypCdTVNG0KGrFB1z9XXbjZa4T/0wdcwS
         w3LT6glFqfOMVFOdnWBIlbltDlUz25LIU7oAvy8s7AMuQ6yjxT//xWe4NKwk8dHuCGOF
         XLbV04LB/PDYhaO+SHwaKmaE5lwp8sove84ETaz7pfgxJFaLYvFeXb96B/kq0RTO0CV3
         scHzKroI2LLYPN+FBwnYpt1RiqVS0LMuRcKIN8OP5I5edRG9yeY0jO3AQZWSNnXne1lk
         ql2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845196; x=1751449996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOegpAuvdkFcZey7AJnC2ppf18uuNZebWg0aRe4Uqy0=;
        b=wgBlQiu41mm4SBasOA+Zk4vdhVwCzw/mNirmIRDOkbCuVpUA1Zx7SeMd6l5XTb+RBW
         IASad9pfXXsFtP3jrmPlv64bAvLuX2FDP0XzKmPaGEZTJzoWIwbbXnQM3MRE0lAmw1Tp
         z/XOve060iGqjNwisHJCA55IFWcpgOLXPkiSNivmwONBU20XJhXb25DPzSauG6HmJUK6
         aMZ3bkGOH9DmEj507O55LidGTxU5RYHLwoEH6oKUtHOdWvUUCTjh/+Z6uOKjbFy7sWt2
         ElkJca8Zga5/3/yZvZdsDiE1HW++YccO8YSaXmneUWhKAJJY9/KAW3ps0sjvmqtkwmFH
         zdiw==
X-Forwarded-Encrypted: i=1; AJvYcCVzbYxHwBl2jIdmxvI+jFAPmM5J62RfnlahioXAJDQIAUoJUC7IRxouo7bpP+6CzfaVYeq8vPmaV82CKlU=@vger.kernel.org, AJvYcCXeotVtec3t/2hAbUpd9AHEBf4upJUsOn50HPK0Rf3Q859Wqg7lxnqwbRF3oAzGlKTwXmXcIF4rUWPSNw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2HWrnqdbIT3K4vlQAwfqSoV9mJz9PvHbeK02ZBh8E8Izgoipt
	MtqablVsLg1ibLv6kGAir411IjXLDkwvvPY6uDH07cvASfGglWKhNHTX
X-Gm-Gg: ASbGnctMTJzPyFqBoCVWGE5Frh75uA1IUXow9BjiEFc3uYL4cGnqGk1T8WrSlZP5cAr
	c5DvF2Amjt60R7z0q5t4r4jhW8B1wOXVEj4S52oYV/Sh1Ne+THkH0EFmp2z3yN7ZmI10nCImA5v
	7IPYAiz074fchab6TB3opHHe8Ac0PIpeiEsskrt90n5xlIS+S9oWPrUEfhSoO96+UYWPFGv1ErG
	6gF6FJ7mjH5bczoAgw1qP9BJoV1T9zSdWdB41uvFIO4wcBztOHczb8mylvD1iBM0ZiZ2dmylAb1
	CimRm3UaQDYXBi5eJ8gEybyQ84ti3Bh7Y9o5wg8h/GXZv6a4Rd4+/iKEhUT2/1Jl5POcAiuk+xV
	MJvQNcw2+l4YQcey8PSFbx6U/sIdAYQ==
X-Google-Smtp-Source: AGHT+IH5sVpXWqNvgigVbtHVAfe6SjaMuU3V6+6bSDasNHNXTwQEDyYqvBChJ5Rb3116y8fRmuAdlw==
X-Received: by 2002:a05:6512:b1d:b0:553:ccef:e31f with SMTP id 2adb3069b0e04-554fdd428c7mr668464e87.13.1750845195630;
        Wed, 25 Jun 2025 02:53:15 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:53:15 -0700 (PDT)
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
Subject: [PATCH 5/9] kasan/loongarch: call kasan_init_generic in kasan_init
Date: Wed, 25 Jun 2025 14:52:20 +0500
Message-Id: <20250625095224.118679-6-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625095224.118679-1-snovitoll@gmail.com>
References: <20250625095224.118679-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call kasan_init_generic() which enables the static flag
to mark generic KASAN initialized, otherwise it's an inline stub.

Replace `kasan_arch_is_ready` with `kasan_enabled`.
Delete the flag `kasan_early_stage` in favor of the global static key
enabled via kasan_enabled().

printk banner is printed earlier right where `kasan_early_stage`
was flipped, just to keep the same flow.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/loongarch/include/asm/kasan.h | 7 -------
 arch/loongarch/mm/kasan_init.c     | 7 ++-----
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/asm/kasan.h
index 7f52bd31b9d..b0b74871257 100644
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

