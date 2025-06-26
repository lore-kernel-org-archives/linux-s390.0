Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD5B2EF280;
	Thu, 26 Jun 2025 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951967; cv=none; b=hCzqqIT62cj35hDcpjqxAqjE6aU5hCyZUgIn/k2c6jumuFbiRRK3Ap7Haml4J8TbqqmAHJjl7/pOQA2l6ZeB/VRfYQAabK+FWwWJQz5jrf6UEM4HHLVviea05Vc5TXyPC09mOcjqQOh+Xk72RoGPFbqfefHWb0EnzSBEgfFo/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951967; c=relaxed/simple;
	bh=1bsIoJnTa3HRlOHipkzCrnkofhvWQ1TFV1zo7BXGqvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjNeWL+0HlbAHGTt3XDYnNvOf74+3L5OMzoevMloI5j4q39TlCpFi2CYwggBRCDyK+t0LMcp/MC/cC1uJKehR8Opm9r1sIwdgyzEHjOWeBMGGQH55EOwpP9Cu4HEYGuEqoSXYL25x9N6136C9Sp2DaLn7NQZTIAZ3g96lq863UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmIvk6V7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmIvk6V7"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553bcf41440so1196618e87.3;
        Thu, 26 Jun 2025 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951963; x=1751556763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAzHyennbJbJNQdO/m8GiAxn8DKdiS3FDiXvLMA3BPc=;
        b=JmIvk6V7etbHn+4i4q7vdFpsIVkvicBGpJkqzYQwmmoMlR/OeztNL80iO3Mu1ZVwlq
         vrM6vWtfstPvWHN7ktZe9ac7mCKGIhZ76KUJ71fXrIjmQqULX7YwByT0Uv0djVlKvXFj
         VXX50pq0fkhkDDX2z+XCveIEPxc1vinIagHg3U8xCGgyW1tZlKNIdOKK++nGXppsh2AZ
         oE9DWKpwYTXtMi6Si4NH8Wji/oFC3W1qsQI3yNihGOkijVF3mW9sRtJ2lZ4+iOczaYuM
         +j53rz/cybg4+KIh1tr7gxUFcumBlRS1BVQv/aiZRpG8eT/RoLkKx6wsLhQYbC7ABWrE
         A/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951963; x=1751556763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAzHyennbJbJNQdO/m8GiAxn8DKdiS3FDiXvLMA3BPc=;
        b=qarDQOYioLnKJVZU3/FFy5LFqqr15yofECCLu2d2pJGrvOTBOX94XEf7QD/mSrw0g7
         YlB6eH8d13IvfJNJpqbfqf88N1KO/jCK+un4IhcN/yBY5Q3FaU4qj2RUidmskLO4/Y/g
         UBQjLiPu64UTM62rvQs/6ifiFR7nTzbDRb6qA3mw6RqXSJoKrA1/z2Jw+JVEy/TwC9zP
         JjVedBj/5jLItBt/PLZzbbJOQPQcd+GfBb2qgVc+B5u5L+9ntobN77Tmk3E6vwAnDE/I
         QSpARjwEtocLMbwKMLq4Px/vXoeXJOToP/tdLYKnk2UmfdkYNkYANtkTm5guqhZk6++O
         1TbA==
X-Forwarded-Encrypted: i=1; AJvYcCVFO1JPRBPPc9/Njy8KVPzC8KRD7OrpoDO0QqYVnXaAN1wKowUNPdN/VQuOUyTS94Doe56FoPgmcwdSHQ==@vger.kernel.org, AJvYcCWJFxe1MC+L/J0HRj3toZnsLKBIxIuniswO7pW8fN9jeOUU6lZHYv9zP4a+6GklGPD2m2q58gNhqSXIkGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiEGjNFArD86aJY6QhN6/Vy0e2JnwoIphQNCesHUMX9Xr6Hn7J
	D7L3UFXkSuOGrdheat/7C6DmpMVnmgB23bc59bF0Jn3mcC/pmMpiaFJR
X-Gm-Gg: ASbGnctWzbsPQwu0o7C4/lKOC/reeu2LaJ4s53f2eaZNFO2/c/jdt1iPrKvAUByYxns
	f8V/ROmNsz7vSIJD9/fK9L6VID1ooVQmUuaDYpkTw6+6P6M21zmMnod0P4ZBUAzD1Vy6h+2BCqU
	46M5SjEfqnVbyAT3ANKn9w81Dfv1AIyBLu+EYQlNVIkH0L3yNuuPRqyyV584SxXzpiRuIKaDpzi
	UHs6ZCCz/tHE+u+FKrczf/MwilBNtOBhbS7YVXeCd/DE1mFXamLe/HdsftbDBhBWdV5OA4oSrLp
	jvmS6qpO23I+samwLTSU5OT9jhTFLSBRsK1gC7v1XNMkf3Igv47qrZTz8NlwWKFb+SPiDqc5tt6
	cMa2eu4QCsR7lszc+Op2TNGXVVuiCrg==
X-Google-Smtp-Source: AGHT+IFtddewk+sZIWQ3c8HpfmVyVU50AdMchy9LvQ1Hdy+bQ74fAWulfETp69JVrreL6trc7kJUOQ==
X-Received: by 2002:a05:6512:2392:b0:553:5d4a:1ce4 with SMTP id 2adb3069b0e04-5550b467d15mr132805e87.2.1750951963311;
        Thu, 26 Jun 2025 08:32:43 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:42 -0700 (PDT)
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
Subject: [PATCH v2 06/11] kasan/um: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:42 +0500
Message-Id: <20250626153147.145312-7-snovitoll@gmail.com>
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

Delete the key `kasan_um_is_ready` in favor of the global static flag in
linux/kasan-enabled.h which is enabled with kasan_init_generic().

Note that "kasan_init_generic" has __init macro, which is called by
kasan_init() which is not marked with __init in arch/um code.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v2:
- add the proper header `#include <linux/kasan.h>`
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

