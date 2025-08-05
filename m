Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB3027C875;
	Tue,  5 Aug 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404008; cv=none; b=esqXcvVLOWRcJs3Egql8yx3awArefvwuVT2jK4MD8MCWwQoCTtBzdYIgUCQf8C1vQDPPTH1u5NEzM8kpUY25yMwJNNimgAjLHYZePpB8AaUBzNbFrEl0xY9jhrRjf2FpNMgUjj0ypuC3LhxVm1U3GZX+TvYcp3MuCYN2+1BTo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404008; c=relaxed/simple;
	bh=Xk0SjVcNNZnQp2HkpSSqHyE9VWiAO/AKIvYCRFHkldY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DkZRsnkNiS/bjPtInil4wGbDOG8D18blZQsRxsubLgyxduri/gYG/1Q1lViY+9xQzZu1GkYYCT/64UUFhRaxsaAlmSjBtwUtepOsAStF5t89CG2K6OazEUFh2OZ3CcD5wBwJm6cMgVFRFX9ZK7LTkwYFEbe+VPuVgaNXZvbv6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzaiKv9f; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzaiKv9f"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55b8b8e00caso5506168e87.3;
        Tue, 05 Aug 2025 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754404005; x=1755008805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lUgc2mQ1RFMODut/DxjH0e3nH7UxMqXiDg2xTFsSSw=;
        b=QzaiKv9fZ2mb9TCLImhQ87pLbcWYgGxS+AbljjVv5LAir1N39Oy7o2yWRrCSfpfldy
         1v0VRhLTgCLwETLLr5PevEMu0Sw8RSbtmdE4avv65FXW9yhcZi0kqlGH+tebqF0pdrHt
         H51Xykiw43+Qwt38WskU75gGvt41yk7rjJV04xYFYTTM3oK2j0xCR7pObzMh4sXUr5Rd
         9O36I7lJr+f/TBTwmMRmQl0UQUt94l4GJlrJjmrN9/4cofP54El+BI0l68VW8dQijr9r
         hkvouNNfgTHbriK6INfVaX9nYafJMUhTsAS90X49KehpMJYNokbCVCDQhk8JMZtN6FZS
         O2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404005; x=1755008805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lUgc2mQ1RFMODut/DxjH0e3nH7UxMqXiDg2xTFsSSw=;
        b=Ibuq89OktNP2Vp1uYnPqUVaFBgEx+bMIDr20y8JmaZ2VfQK+zLwA65LGPXYNfPdNCa
         A3uiXHx9Zr7dQ2knACqJKrVWaCWyOlMfzJaFX9X2lRbe2P9mrab/YgBELYWFX1VPn0Su
         G5MK2sGW93CSGLxgfJ2P3nd+JeWH6In6BRtauyUjHEWjJre+hRXpas+jeX4r3XhDhsDn
         v12VCkylSGmg0nAZgDFM53B6JYS2lAWqhIxR/YuUbWItGc1and9+lxwusAiozJG+RiBy
         TgsObEf/Vyoxe9svgq4mtkJsCcsdjvmq8bf60qJYd6tzsA2VG7VStelzamoGwB8zOMus
         ovig==
X-Forwarded-Encrypted: i=1; AJvYcCU4if002mmlvu7jjD0GcOXBBtVTPb11LpVlD0SJfU53icp7C+hxeS9+TNM7be4J4J1KRLEAuypw05e+FA==@vger.kernel.org, AJvYcCXC+gyLUI6CAnITRbOVgiyQkQBIncUuFvR+t/4bspOCsuHQtnCIMK8xgVhm0mr8B3Ert8eoCZaDNSjxgqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzRQ2DVsjwOGGClrczJEKy6LWjoU5x2diWHYiA0buykH18aiA
	RYsfy2nDPbtifLiojij1fyUZRr3Ywc3pnt0ZMCdOZx2WeH1Y+We5AuIC
X-Gm-Gg: ASbGnctgt72uBePKznrmuwOwH+vdvqH1FE7qu8+G6+9xfTdlA05CZ3p4fOdzvItoW3D
	RHc2jMYdlRy7Hvqxz2wSiyyljjihPnr7WjnihattTE8N7KPwvC9wSJKx1NQXer9OopBFwSw0ts0
	ms96sotW7gVDrR/3FPPVQx0ARnqbcyRHy9E/E/hszAa58XWMRmVYwuaXESTOSuUEr5EqawkQyG6
	MziDbBo9fgDXGpCg6zFRwmu44Wprd3SKFuPJG6QHNOall3X16Vr5j8qRmfjXIUMFln8qKq1pMWC
	Q/oQ9NBCU8oNby2YnN24lJzymcSpr8K6ePAk+JRlX/i2O2u3TqRK+0PQVNR3k7WW0F355IYfke/
	RSoGrDbUNc+rnIWCBaIDGobhN9NrKVuOJ6O8zGHcM9S7+tZIKpgYwimer7VC86xBkDOVZ1OEx0D
	d+yQCx
X-Google-Smtp-Source: AGHT+IEfdK6xUGSau1shbIGz1OserWC83V4+ELanbWHlOwkRpBjVR9Bm+3vZR0IX6iJXBqrfn1b6mA==
X-Received: by 2002:a05:6512:3c97:b0:55b:8277:22a2 with SMTP id 2adb3069b0e04-55b97ac64ccmr3140519e87.21.1754404005154;
        Tue, 05 Aug 2025 07:26:45 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:44 -0700 (PDT)
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
Subject: [PATCH v4 7/9] kasan/x86: call kasan_init_generic in kasan_init
Date: Tue,  5 Aug 2025 19:26:20 +0500
Message-Id: <20250805142622.560992-8-snovitoll@gmail.com>
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

Call kasan_init_generic() which handles Generic KASAN initialization
and prints the banner. Since x86 doesn't select ARCH_DEFER_KASAN,
kasan_enable() will be a no-op, and kasan_enabled() will return
IS_ENABLED(CONFIG_KASAN) for optimal compile-time behavior.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
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

