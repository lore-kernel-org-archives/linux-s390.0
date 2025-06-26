Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAFA2ED165;
	Thu, 26 Jun 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951940; cv=none; b=ZkEL1fYFmjr2jeI/OIZ3HPlhBFA6nHHDjsVuGlA13Qw2iiQLVSPdSk/fcfCPsoQVJ5juxbnQj2z/jkhzrO27doGZEsmlw1A5mj3nVwKD7lfsjF/bvohAqa6kZt9uuHxoFel1ifdEp6CKlHSLe4wxhXawSxT4vEVov8Z43boJaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951940; c=relaxed/simple;
	bh=sGXp482ePzEbOSqj6Oo7pSTRt0qdWiaHv14lzRVBHx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u9CpAT8S2SyWpZamPZBEKphwjrZb18pu0QE1IyUlZaRXhrx+lEeMSq0r1pBkuVZl4D0aHwMW+IFARcWElW2k6geYr+eFnebRHcBj5RDLHA7w76xYKR4N62fkB0LCDM5K/w/bcf4HltSfIZ4QRSodfsvtX99WGHU7MvrSOcaKELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzoukCrr; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzoukCrr"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553d52cb80dso1357477e87.1;
        Thu, 26 Jun 2025 08:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951937; x=1751556737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8+Li4ZqAZW0QY7sIIldmBLFf6VQ+4AeP6Iv95ugt8g=;
        b=RzoukCrrVTFKW8tYIs0PLj/Y9sverFKPG+BBJjKifGhvBuiSLogYYMZXLfeIgth4h7
         Bb+PIEC4NePLvx+P6T81z6PL5nE9NnePgkbhv0Zy3G2MpAw59qtODoIHn/08X8T1gnmK
         75HuUswvVNOQnUhfdmDokrEdYtgJ13vCRttHVRmi+DeosN15fR4jQ55kvVPaNh7seZON
         OWrCdmXIf9Ii+TWiKaoS6NxrUF85EL4eCBov5zpI/6r7k/JA+2Q64ZrGSb8SmYLKmNA1
         6+g0i1mXUGux7srOPoW4nfRCn07sQyZxVSHSzemGvyG+kplW0h1WfzkhIb/wuf0QftXW
         x9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951937; x=1751556737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8+Li4ZqAZW0QY7sIIldmBLFf6VQ+4AeP6Iv95ugt8g=;
        b=GA/2vNtwwVdWsYJNY+J32oN6hUzMTNouJ+mCgJwivcuNx3Jr4+UVsdeOECRQhE/W2E
         z+8Tfaut1uS7EIvISj/wxyiXRzusCfr9DaHbdz9H/xOcQL9deWRGBOCf32qIdmowPFi4
         UvBKC/1HKkb5R4pPaVk+92o4gzFMTO8ZlNRUHiKe8db64RM1xJolqbTztMbQ7S8LlqMz
         lUF4hZOo/eaHDhRT1ASxuE//UB+wRfN+LKoZk6unDD3n/Wugduf7nfnir/Ity+8GLvGw
         Tf9kwhH6grKXnl4bgJgjHnRpF076QAw3rNZ+ag5RFnb/eyjoYdTbJWnay2KzHKPG3lFy
         CgqA==
X-Forwarded-Encrypted: i=1; AJvYcCU7gF8s44vkpk8t+Gf7Bfk1GSFAEdMnF62Hx+u3ZsvW/ts3mU6qcYEaPkoBx030kfE6O/ZV4XGkWAVp/f8=@vger.kernel.org, AJvYcCVoGqWo8mbnCVLzh+yYJArNSUuC7/UYA9WMgFd42a2DJ/IlHRm9HfeBNq6lCsTCcy4yDL+d33K3WWd5eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSVKPqcM+QV9HVMMjfOSBNTLyvOiVPV9E+QlQya7SdENsHESwl
	QsxZzwCjJpbM3SqLOOyf8VQ0b/yNyBpdxpu3Irj3PxCDIOYcTsiWvkiV
X-Gm-Gg: ASbGnctuXYOEEX88pMtgfxCOXwmtE6gmfHwWHQyWQOPQUi9Hbac5W1/atQ452evAk4t
	kTnI2hQ1KP5xpQ8vebZHdRHPpzpEgg79mPsYp14w/AObWHCgzLdRt/ZkJbs+xwcpJ4ICdsIQBu3
	BBmQZIZxbFYa0Jg+aSmJgivGb+75fPfi64K0vhsEqNB1bjZy3OQ80EBmMhJE9iJQQVHx6z5TqZJ
	QHXZITQRzBEhVajO2esWu0baajWWIrT+TSB+0YRtug+BxVLDLYR96qADPGx+E/zcgp+Jd4V2aBK
	tPqp6nYkrvyQ+xMiE/WlWjWtxe7rH9aDM6mhXoAUvCpGsfDCJ5Rf9dYiPrv1X+RJTwqMHYZrHAl
	L+FHPL9O+6kdJF+wYHHKJIf2B7A8MUw==
X-Google-Smtp-Source: AGHT+IFV82PjQkEQV8pwkpgH+uEG2XxjLf7tDKt0/XCF6qX83TTzJXquCdeUIk26UtVJ1dwuwllM0A==
X-Received: by 2002:a05:6512:3e0f:b0:553:cab0:3800 with SMTP id 2adb3069b0e04-55502c95046mr1480652e87.14.1750951936982;
        Thu, 26 Jun 2025 08:32:16 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:16 -0700 (PDT)
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
Subject: [PATCH v2 02/11] kasan/arm64: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:38 +0500
Message-Id: <20250626153147.145312-3-snovitoll@gmail.com>
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

Call kasan_init_generic() which enables the static flag to mark KASAN
initialized in CONFIG_KASAN_GENERIC mode, otherwise it's an inline stub,
and the flag is enabled in kasan_init_sw_tags() or kasan_init_hw_tags().

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/arm64/mm/kasan_init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

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

