Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE662279DCE;
	Tue,  5 Aug 2025 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403999; cv=none; b=mOnuGyaPLstjoIoVp2t8sBY6MmGIT958DnlG+GMCnWkCmTfyXmdVb9daYrmh40oXqpDLVVpGqM3Fyg1Zf0XwTBFUWPorNpeSTnKaDgFwL1xzyaiL/bcSGIeWezYrtYHVni3pnJtmd/ECpX4yjHP1Fp72ObtCMDShEi0C5RmfMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403999; c=relaxed/simple;
	bh=YT0nUt8CdDH1RB0ycRej74uDxgOkaB3fmmbB8wGyJrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6GOx6snXEteUqtwm+/Z9LynGBF1EWg02pinl4k2dEYL6eaAPWZVpcIP+ab+AdZvUyL2egTiqWcncoPzElrArKJx7PiLL++EiHh/xKFvXwYeUZqpfhkmROkvYewfRa4RCbFRQHFcgOMtgeeBkZ4zumo4aj1L05HmE4AZEnCFNJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDmcSdaG; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDmcSdaG"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55b8e6eb691so5020891e87.1;
        Tue, 05 Aug 2025 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754403996; x=1755008796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUUI2xKZlk5/jtNpSyx53EShjk/LU4/amvgKSzwK4wM=;
        b=kDmcSdaGR3+9xBN5JuUFdj7tlcS7p3Qm1HoD948d2Lw9BmD611LcdRnYuq40uQHuCr
         ZFCxc65qUm4L54T8r7aRCG9AbXYWqIuuuQXu5rStygIGObmTRXa7MIWcBgzc46VYSMWl
         4ATE+QvdyUX1dywK4aNnVG62UdaRocBTvBCb2bojxL78YOHeAOE4A+F4FIWWDZI6amw/
         dtwWENBBdPqnckimnR9FIqSA72jUBwTVM84HGmffRp6KDNiJP3h451kpsW7Y0RyGXV5Z
         PY6yyIhOARijSafHvdpAmPJ5rKoBIl+Y/U4RxzFR1eymAVQUCjMy01aD8RhK2A7moYKJ
         vPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754403996; x=1755008796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUUI2xKZlk5/jtNpSyx53EShjk/LU4/amvgKSzwK4wM=;
        b=gMeELdS/xIpYPJyyG6+Jx0r+plPVLrpHhBw3DZ0w3hkm3C5xNznIbO5/JNSVNjWDq/
         y33MiHyXp8FmvW4xhqRIDHhQIb4F8qqzh70y541Vq63kvAjrOH4L1i9JXl+8PsQFu7Y/
         FECA5Tg1rQCZ5PcA5lRe7AT0uI1HuJsVDzfQF1vAlx3Dm6EDax0vBsRuKKwXxCASyQLM
         H+HXR/5sv0t61BMHxzBhAnaLnZHktHb+Pmjg0DVfeNQA7kK27NzbPDPNiYwErHGFJnl+
         jSKEQmf1Azx+16UqtIX9qTRfvEmOpARwu14qTI7vr3OSRHar19oAlQ/ZPNa6a2vqmCkW
         gllg==
X-Forwarded-Encrypted: i=1; AJvYcCX71DWtx7pRxbRth9R5tFFenjvroEUmcbiLrKyZa0hZzyWnGz0wPGMXVTvwzfM9dIMg/vBai4MYc7mvG10=@vger.kernel.org, AJvYcCXWJCLwDPuSHOICPbZ8NmmYZ3pShp+OlInyYCeZxjnSK45SD9FKEvXX0DYXJAWlqYnpeP9dUcDTKMYaaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMEIzKEhdwktJJOrnel5Xwv/XolvfpT8KuZGrq/K93Evdc3+E
	LprMiTUV3BWxjYYlU6EhE8sEZCDK3mkXn2VivDMB/6DMqksavZRb++ZE
X-Gm-Gg: ASbGnctCFggTglBEyYe+xHETE6hRhDXuo1pCRYvpjve9esR95OxwydYlqN3ecpyOooP
	sN2PjiEjUUmu9Qr1+YODTMSjvRnyjPJnADSu728Lk4vVN/VEkSkut2SjGlr2XXiH0aDHraZiRmH
	7cWPFncLZdzvj3d1DPeoFqyi3wHTLrVBzDIFHbUd0xK2J1L2rlScBwPtkkKIWombdoFER8q6oGI
	NIPT4oU7vVlvqystBH0JyPMA7xQmJdtTudSQqOfAvaliSDFF8lKYVm6TcaOGAMWIy10OXBOFinH
	ZFsBPwmIBVCaA0sb+nrX8GKZ88LG4DqG3tPKG4wumlNZhip+gWIck9qneb/CjI+buoL1INZjJMe
	TNLWfWwfa3dRpH/OttfmEoALFHyTuqtdRK4qzmdQenoOA+/MVCclj6BMK2PX57W+WgG7VsQ==
X-Google-Smtp-Source: AGHT+IEuyOphkquEE1TcD7oJ1sEAoZRW6geJFjdlevxIlBKJ8sCVOgd5wEIObFEm35WGh0DuMN4+1Q==
X-Received: by 2002:a05:6512:228a:b0:55c:ac98:edb6 with SMTP id 2adb3069b0e04-55cac98f040mr114526e87.12.1754403995715;
        Tue, 05 Aug 2025 07:26:35 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:35 -0700 (PDT)
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
Subject: [PATCH v4 3/9] kasan/arm,arm64: call kasan_init_generic in kasan_init
Date: Tue,  5 Aug 2025 19:26:16 +0500
Message-Id: <20250805142622.560992-4-snovitoll@gmail.com>
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

Call kasan_init_generic() which handles Generic KASAN initialization.
Since arm64 doesn't select ARCH_DEFER_KASAN, this will be a no-op for
the runtime flag but will print the initialization banner.

For SW_TAGS and HW_TAGS modes, their respective init functions will
handle the flag enabling.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/arm/mm/kasan_init.c   | 2 +-
 arch/arm64/mm/kasan_init.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 111d4f70313..c6625e808bf 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -300,6 +300,6 @@ void __init kasan_init(void)
 	local_flush_tlb_all();
 
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
-	pr_info("Kernel address sanitizer initialized\n");
 	init_task.kasan_depth = 0;
+	kasan_init_generic();
 }
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index d541ce45dae..abeb81bf6eb 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -399,14 +399,12 @@ void __init kasan_init(void)
 {
 	kasan_init_shadow();
 	kasan_init_depth();
-#if defined(CONFIG_KASAN_GENERIC)
+	kasan_init_generic();
 	/*
 	 * Generic KASAN is now fully initialized.
 	 * Software and Hardware Tag-Based modes still require
 	 * kasan_init_sw_tags() and kasan_init_hw_tags() correspondingly.
 	 */
-	pr_info("KernelAddressSanitizer initialized (generic)\n");
-#endif
 }
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
-- 
2.34.1

