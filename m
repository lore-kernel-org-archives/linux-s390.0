Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87D2EBDF3;
	Thu, 26 Jun 2025 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951980; cv=none; b=jsP4/orhHTkhj5Bnwp/1gKeOZFOsMagYTpXMytUjfebQzl1IWDERbbkoz3eSM6faaGxH6+scRqC+qvEnkR4oYEcOiLoYVxLfHnzpUpE7OTJyxLS/yuFD4AYj5VQrnB4j38EunDNYDLfG3d211u9VqsAje1ISFuo9zGSdLnQTyJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951980; c=relaxed/simple;
	bh=afvhZBgmT2YwrMa1SlTy5Vlucrmbj6usF3J+30vljzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M07e4kCletBe1Errbzb97Wn+mLITJd8xDgz0G4+sviEOVajonP0UId89tJ5hfBbsgRgvFMLaLuejXFUBQuIEENtkE3qWx+INBAwNgJrgw9AjAmTYUtMQMkLFIVUsY2x/qD0IojBWJPT/tjrSj7PTCEDqQ7foRgNfUiz3S6ectWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzC7JWai; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzC7JWai"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55502821bd2so1198625e87.2;
        Thu, 26 Jun 2025 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951976; x=1751556776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBJYqNEFUsGcSKAGhcxt9dDlG97Ga+bpIV5ghyvlETw=;
        b=mzC7JWai+DeW2sv+oxGa1KqEQXXNvPg+ZDYh7kge8D9G9faiCCL4ksMDkB3DxCQtOx
         L6oBurdbQp47DsyhwOpBmKv9zYvFjAwx0NvlWUAlMqmIR0CTi6Gu/DAxar6nrfCK7Q39
         yJjP0o6bJKnGdQk+1tP1WiWGh8kgikv8+J/ElxBRA3br9YUA6ohhIqjF4O3EciUpH093
         MvxRQs+lGs0joCbB7hmvU8C3K/SxVX+o6DzGoJhZ81UgYlRB4FN7GiXtSHbbUhy2le5l
         C3UTQ8QwHz/rIfuyvy18uPHvQ3k5cmLTe85MCTdWxsOjUx4HtQt/eImh0IHBD+qsr8/X
         wvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951976; x=1751556776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBJYqNEFUsGcSKAGhcxt9dDlG97Ga+bpIV5ghyvlETw=;
        b=MxS409HiYJ6eSew2lWEnI9GpJGUq2B1qsqnf4pqtoSkmivkfyrlXnHwQ7zK/i0V84R
         Ep6xedj35eYQPM2IG+6zr/AobXQdbKo4q275bjdtVVBWMiCs2bypoF3L1kMj0ujtHjVZ
         gs8Ty+c0jk2TwH0s0xw59aKj2cY/RiJhny5VGuV6AcvfECKjQ+7M/+raDtJhDmxUwB03
         bpw5gYY8V4uo+ugxljczzXhL3+RW/ckh2DwV2N9cJ+JXRabbuK0ZhXoyShSTUGmGRJG1
         eTaWUavp0mcVPI+VwFZxpPACtIWHckmHyhdA9SDu7yIm9h2ztNROZOM5PqVhz5lu/69P
         bBfw==
X-Forwarded-Encrypted: i=1; AJvYcCU9ySy9sF7Wlmo67O4k2BQ1n/eqB2D5ZY45tYd8zDH5xPO8lLpUSyRRjtqocCd87encT7f4kRBvo6diK8s=@vger.kernel.org, AJvYcCWnjAG+gp90nklTJKwuMcxWcU/XvK/K7UI3FsKs6KH/CzPRNwEmPkPfQU7FVywiFuaSX6cvBr+o3rXr9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJiMmanHIjA8MIUjm0k95ZunGcWyW5tqBQDHjcerjy66xBlAGR
	IHhHH7BqLVALSLGZE0hQ4IwUfHegVbsMKH4G4jvsaMj7Klisio5gqWnH
X-Gm-Gg: ASbGncthXusMHTNXTfH3sJT3wC5GFju8IbAc1O/O++JAT4G4dRnqUV4BtOpWmw2fujH
	QE8jc5EOXC3m5gApHablTn/Pxlwaayv+Se920xtTP5lmI0AmQArf/ErdN5FD+lT6S5/IZsqSDVg
	krZh50tNopC6XVpFoOpSFvzTq2Mw8rwjZN34qevKQgTBELrGC3IcfMpAZ5QJWzedOX6wtmI2Ujc
	MIHx6UToRHGGAu9xjcvl4gj0THLIU5t1XRhD/nhr7KonKNS6bxpGwm3mcug4Zlztytw48QFhiSf
	INdR2LhLde0TqmQ85gPBcGLrx+6CnE5IsrAaWj/dFCONvunFDGk4TNKwYeBAxNSMdH9q6yIjnMt
	KWiWryYPG6j+P+YD6uSe1IrboTc7fXnBLZFNhfTUG
X-Google-Smtp-Source: AGHT+IEFT2kc8D9hjhRCI4Kut+1atHj8fN6ClIv95YfFL1i2Q+3r8LuVnLNmbJZfRzfJp4+oWdZNgw==
X-Received: by 2002:a05:6512:3dab:b0:553:26f6:bbfd with SMTP id 2adb3069b0e04-554fdce00cdmr2633203e87.8.1750951976245;
        Thu, 26 Jun 2025 08:32:56 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:55 -0700 (PDT)
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
Subject: [PATCH v2 08/11] kasan/s390: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:44 +0500
Message-Id: <20250626153147.145312-9-snovitoll@gmail.com>
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
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/s390/kernel/early.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 54cf0923050..7ada1324f6a 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <asm/asm-extable.h>
 #include <linux/memblock.h>
+#include <linux/kasan.h>
 #include <asm/access-regs.h>
 #include <asm/asm-offsets.h>
 #include <asm/machine.h>
@@ -65,7 +66,7 @@ static void __init kasan_early_init(void)
 {
 #ifdef CONFIG_KASAN
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 #endif
 }
 
-- 
2.34.1

