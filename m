Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C82EBDF1;
	Thu, 26 Jun 2025 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951973; cv=none; b=p0JMehmB7Di/pD2PMW+zXBbjufBCK0apaGBVPQ6T+E1c/dTmEPUYCb6tbtL9JhXK4rqyJBBEoByaoUdmwruTTjZwKDzrIPpj5Q+u29UXY/gWZf2DG8Hel6AE6MMPe2VbEL3yq+yadEes5zruDow75FUwWV/OFwstvyOw0txu0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951973; c=relaxed/simple;
	bh=lhF1+oDAAfZTQLsvxX1VmCxIOVKQmNCDXyIFJsn0eiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UVzSsedLWe8sRM8a65/ZEW+a3bj3E8+8lPko0CpNuWWbHyLLcX9ii8H5tkqkzY5XF/VRXj92EFYu1HYfCe8IJ5UFRX4OzTO6kjDWtd5YA4gJ1KWo1MTUbACoIBH3vpsISz8EjXSuE8DmolhP2bvh4vc22cLhXZ5zGl9rO4r3uxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfo5DLrA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfo5DLrA"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso1330173e87.0;
        Thu, 26 Jun 2025 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951970; x=1751556770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNdRW1IbQwaJLK3IU9ZGilulsvtFwP6FJhql802bOZE=;
        b=lfo5DLrApADYanOYH81NntFNlRyPLp4YsdSQ5AztJWGjYBCSsjsP6/QKLsHYSagDwr
         Y1WZgIcPjmuN5tKNdNCZixwEXqjNkmVJyrDarBz2+wFJVl50WEM6OPSNmgclbW7iTTrM
         3Ub93HL6vcA1WRO0jWnosJrvbCnKTVCkTuQAA/a6iH//YrempYmuiodQhcqw2tzT7e4k
         yg7ITZ7XIBaTdX+q4YYntq1UzdO7PW0XGBiBULxR2fFKSLJ75eBSNG4dL2XEVyH9ZgkP
         zuGKWdSXJlZCTIit9CVBMOg6hVUjnGozyfiGYqTidr/MuVbWAeMRIrJuTVeYzk8RvZHT
         ni7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951970; x=1751556770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNdRW1IbQwaJLK3IU9ZGilulsvtFwP6FJhql802bOZE=;
        b=DiBUlDpJOF8Kz9sZ/tkzgI7w8GSEoWzVs1pEOBfwptNGx1mT5EuB2Fdhp+G7iCEF13
         s9nmnT9gOQIGnfAd02DR4JVkKuOXp3S8QLM6l8VCQVazrqwiUkCkH8nE0Eidy60UJ9uK
         4rhORtrcnLUJGycYcM8BDqe5qkMqXtvUQyWlWvRs2kHk5UO6OcJqCswpEdQ9EALe9ug6
         UkC9qs60vzXgtr5+CLojNirQ5uWX2+Z71JB42VX+PnZegc4ig0nXy150mCD64UdJDSyK
         Ve2ks2QBHDAterujiaVNWUzy4hzdy4yqDyf4snHoWLzq/oOhK0k9jQkUELmStQiAy/jg
         LfxA==
X-Forwarded-Encrypted: i=1; AJvYcCWqL4tf4awpoDYXJgHrEXuyoosGiDmtyCFCHo2cLqY8hPVbIyYUYcvIBfZkrtk47AMBraMZJd0+flchPrk=@vger.kernel.org, AJvYcCXMj7xqq7gk51NHe0mUL7emPCXupv2u5kAZ4mGsTDJjcctyj0C25T726AJkxXKWl50rGMYuXoHQRbDecA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5GVVDmGH+lRv/KoUXWdkadb3Nu3LVEOH3XCpqvpdKl3+CkML
	IkHI2dJ4OSKGwMUmlY9Vkd3YKdVjGEvBOb3DphiVsQL6tgPjmqaYlRRz
X-Gm-Gg: ASbGncuJulIl+RZwAAYcvrkIL/h4bef4k8s3xD/gqru/QQcxa/PGrWgxPJFU9Av/7OG
	5hWN5Zh+DixtliBDSzB38VKoQUwBF0S/B+iEvs7mUwLVwZfQYKgb4RedyatNNeCHbONoYKe/19O
	tooev1EgLBLngS0HdlZE6/b11JqqTZEaxOx562k2mfhIzbvtHej4E2MyQ9oLqfC0XFEinsQ7fnv
	flQ5hznB/0RM3BfzlyMvukeh7XT/mHuwn4KykWioxSVHUGzlJfD3T/VguDyCWZ9XvenuZObBumS
	JgQMROIJLSO7k6ew5DMxjS1NbdHGSkukUlB6UjJwPMsLhvNgLJuMmT3Keq/OOwF4UO8aazRzAkV
	FW+j8KQug0P0aWU+rboGAJiKZSu9ghg==
X-Google-Smtp-Source: AGHT+IEJ8rUJC6ORRfCQpyeVpgt13wcImWaXJ02l+Sh7w1+4iNgFiJrQa6DpXH1RNUwTGuIGr0B3/g==
X-Received: by 2002:a05:6512:3d8d:b0:553:d637:1e96 with SMTP id 2adb3069b0e04-554fdd1d556mr3088387e87.31.1750951969599;
        Thu, 26 Jun 2025 08:32:49 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:49 -0700 (PDT)
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
Subject: [PATCH v2 07/11] kasan/x86: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:43 +0500
Message-Id: <20250626153147.145312-8-snovitoll@gmail.com>
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
 arch/x86/mm/kasan_init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0539efd0d21..998b6010d6d 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -451,5 +451,5 @@ void __init kasan_init(void)
 	__flush_tlb_all();
 
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 }
-- 
2.34.1

