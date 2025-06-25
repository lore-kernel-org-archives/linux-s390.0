Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19061EA7EC;
	Wed, 25 Jun 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845206; cv=none; b=V92VFf6kPxZ/IH5EKRGcx1XCSvsbv4nxmVU7bfyDYmgyiZFrFpLVPHa0Yg/0Ry7riWYnVf8cyARAC1y3FqsM6bgqUud22f6zfLTr5ujE7dCzrL04jprA2UoJT1AmRkD20vEJhwTFGKW3Dbf4+r4+3ec++fJO0YwrmTIa6VlZFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845206; c=relaxed/simple;
	bh=ZIM5Z8nhsFV5W+hsX3dV876oHiSX20+bmYuDafoyB6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZreZq0/ym3SvbqY3rsIiPc7S2yfZBAIFfB7mtgk4kKju43SsPyfo7Bh+rlD+GH31UdxMjIZ1cn55iOFFJixBHXF4yZX1EGclz2kaNjEHq3HVlMRUXJpKLfetprXNDDIS5iyvr4lSoTepBSGLhT1OSsfAlu/6QtQep9vyYJKsrp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9YFQCa1; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9YFQCa1"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b553e33e6so54954101fa.2;
        Wed, 25 Jun 2025 02:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845203; x=1751450003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HfJTJJcJZY7/fCA0Tiz5Rc62kUV3pDrNC7eedpHA74=;
        b=F9YFQCa1je2jU6cRDtyTB2WZXB80P1fjBHfqbo2jLc/HmZyadHoDdh7DttBJwIwFCf
         z7gFV9QZo1HPDJ1DiGlPgrgIOpNvx1XpLoQNF6Dcz1MvXFv4nbvq372pugKMjxckJiN1
         F9nH+qoCd4g3t6bGPck99mLfUArbmJNwzeTW9gMle0pRdLb3nDRSPWORh4nbKTQGIm4f
         iNoIUqzK5j4VXjBWFv5Jsc2Xr+9VvVsddmDH8U7Qi8TbcZwIOG+z7VTp4ysrPdDQx4pT
         nIWX1plYM/jmbp+9jZXh1AldmvXztaD2R4MPCcaS7Q3WOPgAWYYdPtlPoXxIxaxfrWdI
         Og3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845203; x=1751450003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HfJTJJcJZY7/fCA0Tiz5Rc62kUV3pDrNC7eedpHA74=;
        b=g+JY3GQs2CZanKHAghnYFKc9TPVfoQUHnCerUhwwjmRn2vguHUHfYU+AgNsy06XVzc
         boa0eyZPofob00N+uBrwSSoxmsvdMYiuunokrHX5cpcB/BVl9njWFfUDSXCsqhICJubm
         D4iZo/atB0PEzYbJ7vszz9cTqsTEnqiRTm4QaCYNxAYJvxP+F3SmXrm5BZbwdAJ5J1S4
         Pedh6CpGFznsgzjjuSI8dwSX6gN2mjPgoqN+FBd4v62h8OhICmxOYjlx8fX6aTBK66lw
         kbotvi0R8qk+fVI4Lb3TkbmYvEIvJf7wwBdrozXFLIN2QskG8j19P1StOHp4eFPXIoRs
         1Xng==
X-Forwarded-Encrypted: i=1; AJvYcCVTk+acJUhb7qqYIKNuXiRjKGjY9VRg4yGDI/n6OsOcyttmdutIiT1OeBozPNnzioGK2DlEGlu+jxFcbkI=@vger.kernel.org, AJvYcCVzsGlFEr66x6egrrCLkkxC+WZ+49vk9cCK4zhKvUBzGrmqOwA4qP18bKztyWEcHVz+EM8JoVuZuiNgPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzawgFeRuPuPO+2DkW/4d2qG6V6ZRbJz2055DRp8zeWhiRpellU
	1KgN/oABAYxI02UZbiG1SNuXbJ1D73bJdwHGg9xHnQgQdi0Sruj8lSGi
X-Gm-Gg: ASbGncvdQ2GqPyy9+c8rDNviNgto9mvPnidyCnrS1jKqic8/S306iZBACWIp9elYov0
	eZC+Oxcz8DsGqqHKk21Ypa+w2U0NHG8JLgMWhx5laxsBR8lzXHRH5VghMWgwaZx7y4Bb2Vig81M
	3m98Qu8iJ2v5OHLk4UlxL5SbFHbtTcGea5/zafeQlZbHARfpSEuQcTYQ4oCS5BrMFZ18jsPNiCT
	T4dJu0hF1hb3XXI4y1OQplNHPn6K96cP6RXXOUbafNkdJNI+9j9ENffF3dqgoz6cD20yYa8lBYj
	QwsZyTf6pxquDg45kblSicQrMaQtpByrStac6trF9E8XfDhIB3fX8fs8Wbep/LZHHd/4PDx5Gxu
	wyYho2pqrzBAME7hkqk7kRF+zbnd3GA==
X-Google-Smtp-Source: AGHT+IGryY1FCOgoaOa1ABgKWf+F5LHoFKkqdltui071JTPn8wvOuq6kBWhaIRALdveundDdtHS+Sw==
X-Received: by 2002:a05:651c:31c:b0:32c:a771:9899 with SMTP id 38308e7fff4ca-32cc648af6cmr6208261fa.9.1750845202774;
        Wed, 25 Jun 2025 02:53:22 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:53:22 -0700 (PDT)
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
Subject: [PATCH 6/9] kasan/um: call kasan_init_generic in kasan_init
Date: Wed, 25 Jun 2025 14:52:21 +0500
Message-Id: <20250625095224.118679-7-snovitoll@gmail.com>
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

Delete the key `kasan_um_is_ready` in favor of the global static flag in
linux/kasan-enabled.h which is enabled with kasan_init_generic().

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/um/include/asm/kasan.h | 5 -----
 arch/um/kernel/mem.c        | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

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
index 76bec7de81b..2632269d530 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -21,9 +21,9 @@
 #include <os.h>
 #include <um_malloc.h>
 #include <linux/sched/task.h>
+#include <linux/kasan-enabled.h>
 
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

