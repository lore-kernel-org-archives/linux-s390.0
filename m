Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43E2ED862;
	Thu, 26 Jun 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951986; cv=none; b=BUmKNHGRjVMfwagr83GBH15pt0QMGTGqBHuj2mA/rzEVjvWjROcH5kd07kOUS7fPpUpZ8DPZFGosghFkPzciJlWqZIdTkad+W+fs5hTCRWZ6F/3mAdlZRI7XtYxxc45PLCCL5ORhbpQlxlxmcYtlGdPMtJqguT/m3KwhbJ1zmic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951986; c=relaxed/simple;
	bh=b11LfSCJRGGHkPLLhyUq9TH5cjeD31Z4uJweEL6bcd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XKDyytSsAwIhIybJBkj7TkW+DKeu8cy/IZxIwRWDv8wkCtwXziLHbqWRLqItcdRi/ICuFj6rsN9/KPkm1e0NtmsbAeuOzO1i3hjWSH/1Jz9InKUUSzT5PektpFrrMNdKxeM9KJJlSUEMeFp4atJUXJ+oK3gMmE1i0TCU818Wsf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1tR7bV7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1tR7bV7"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5535652f42cso1256149e87.2;
        Thu, 26 Jun 2025 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951983; x=1751556783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gODL4ePLEui+bgBCtMqPW0nf/RnbL8ytBUu0XwvP9Tc=;
        b=f1tR7bV7IAGKYI3Dg1MBQjMAJRMeqHO199PIjlDO1eXW2BDHW3UUTGMmD4JIap38A2
         WKq5pXnbTy1potmV7ljUh2y9Be5svxJJC13U65VA8VXIqGMSHFAg+D3vmZBjJ03sUQ2e
         VZItSO27ftpDcx6j1aZdOcIoh290dQrQ3gM5gYxkpLEP/8SkNPL2kRPM+KxgaUN/IqhX
         TXrMT+0f2KH2kym9HeAA1KurjTKq6l4hGePZXBDKg2En2LwmZVvy/NF7dMWBA0pmM30j
         UGxruBOVLJHs6F+JPIksu3n+1FovO03R/Uu7geUM8EDnSQfRP2RNTjIKFj7Y15ySxPsB
         z7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951983; x=1751556783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gODL4ePLEui+bgBCtMqPW0nf/RnbL8ytBUu0XwvP9Tc=;
        b=K9g9DSkOH9FdhXV/pgYduh3ftYDW5uOCsCO60GM3k/Sj2HUcVTvJhrn7dlMYDcEm3Z
         HhuQokK6tTrKkl+MEZsYG8rlJcFiIBymBG5fBAjLE8p6cNM/DGwDJavOX5nI5J9NkTW7
         8tDXkMmeNwPLY5nutdPT+6AYgF74ELqTsWTdhMSRFcs7CoLgt1tZgjt74aq4OFucQUo9
         dln6H4+JlTnNwO7lD+/4+JSLsj6sls1WfBssWYPd6H50SK12sqg3HBhS5vA+ki1zHzQO
         ConIUDAC97Cg0X1FZKfBV7T/cR8N6+4ucfgxV0G2R/jfOGFPw4XNtvbwXOgLyxm3f+Sh
         hQAA==
X-Forwarded-Encrypted: i=1; AJvYcCWHUOO68HDijlTk/M7F+Q3rHg1nSMlkbrTjZhGdovzoQr30KcgpLRtTtoXs5+fg9HqUnvfmgLrb5/HCZFg=@vger.kernel.org, AJvYcCXHskiLrhCWuSSk2nGrzMSpIBSs5HqFPCBc6WEfyn3OnLQRJCfoaYRQENTai4tMUbX30QTGKwEFlUQVLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIIREb+tdPF+pzNn0O44z24ZTaQbdAtk7/VOsTc8Mp7kxSOdHF
	rwqxELo46xRzrCx+mJrn3gcC1WQVBC19WqziixyPcnHuUcpxq3v1A0TA
X-Gm-Gg: ASbGncvJnOCcgZITHk++bPopu07AvvTdXVNS8cbgKeS6NjRIzlVwQ/b8MmYJdX4I4AC
	T487M1gTxS+nqRm2bMwfHnKQ3gbWrkEFXp4LcNqLHrLQGkHhUKHFX8tmcZ4lAhxEXSqma8psZco
	DKNr6BDTvjLSucZpzsZDyKavMpRMLqgZv4i/+BorSOKfXugQ3fGGdSnSLtZ71PjXS1Q4tP8KD8R
	u7jHO/XxM4nzOCJ86vQyPAvraRTZUsrOzr0EZJZG0kKp0V5o/8ShcTqqMIlwqxo0dLQ+GuIXe4C
	8VlsrWutGQ7lPDhp6o0ZyT70Oj8eryQQzmZrgKnPTsGMsPWCRJkBR9/v+Ji+XTUujL3S4RSE4D0
	Kg+LmXKytExJLzbc7v0TYMjzxqvxO0A==
X-Google-Smtp-Source: AGHT+IFtokin1pGKu8SGoAO+egXDXmR37EPc9QSc1BH26CQqVKh0GZxc7OuPefULxYvAjMzQKpLkUQ==
X-Received: by 2002:a05:6512:318f:b0:553:ae47:6856 with SMTP id 2adb3069b0e04-5550b474cafmr117706e87.10.1750951982600;
        Thu, 26 Jun 2025 08:33:02 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:33:02 -0700 (PDT)
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
Subject: [PATCH v2 09/11] kasan/powerpc: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:45 +0500
Message-Id: <20250626153147.145312-10-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call kasan_init_generic() which enables the static flag
to mark generic KASAN initialized, otherwise it's an inline stub.
Also prints the banner from the single place.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Fixes: 55d77bae7342 ("kasan: fix Oops due to missing calls to kasan_arch_is_ready()")
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v2:
- Add kasan_init_generic() in other kasan_init() calls:
	arch/powerpc/mm/kasan/init_32.c
	arch/powerpc/mm/kasan/init_book3e_64.c
- Add back `#ifdef CONFIG_KASAN` deleted in v1
---
 arch/powerpc/include/asm/kasan.h       | 13 -------------
 arch/powerpc/mm/kasan/init_32.c        |  2 +-
 arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +-----
 4 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index b5bbb94c51f..73466d3ff30 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -53,19 +53,6 @@
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
-
 void kasan_early_init(void);
 void kasan_mmu_init(void);
 void kasan_init(void);
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

