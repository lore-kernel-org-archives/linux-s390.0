Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214862F8C31;
	Thu, 17 Jul 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762477; cv=none; b=kyTG8kI3zRhUhIcypXHtswTZkFe4N1Wmn911j5FvTuQljfQY2I2XqsZoEiKnRQwyueTNr0B8q9cH2kzbdgrzLD/oMyTcWktUvJHr7uuM8lzvhDwdV4MNooP+JJV4iGM9Q1dd5w+xz1by8NdLE079XFTS75G8Y87MQQP9pS+jPhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762477; c=relaxed/simple;
	bh=y2h7T4ppakA0lW5KEjIcMv2w/pJN9DVxFk/7JsnNCno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e9AM9MK8flkeGIDPu39W+F/Cfb0WEztTF0QTjoke8eqG1nAh7UHsgPUOmo42ibV198i9uDOf7pj1thsRhUbUBD9bzzlOvgC3j9T7t4cPCckIdR3GsPH8srs2wQd81ISs5GKO75xDvIJcYevnnp06JLLzRmPwg7XcSXo8Q4oukyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=julCJgj+; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="julCJgj+"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55a25635385so1157247e87.3;
        Thu, 17 Jul 2025 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762474; x=1753367274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bku05+DNIlaPeHqRJ4y/c3E9v08tlUqoZ6kZCd1AC2c=;
        b=julCJgj+59JN8jflldPHTiSYv1uXDEby8irv79STcr2A9h96Q+C2dm5GWKkvT+6wVL
         ZWgtHzks7h1PY1B1IKz6W7pvjFo011Mo8F16kNIHMGHUtJDRkTixKWtCqWb+5mNpqgMA
         I+nuD+ksyAWCFE4wig9INq7jZKJD2ntmzQvmvMwb5d+CA+qghQEsgzqlAHI5wfnM1nW/
         wD0APADLEziZJv+KTmPo3r5XlrNjLGgnErfHFFI8Qih85AwKa2lHehvjr3AiS97g0nWi
         kZdPHSf99CkfAYN6bqzZH3UZ+L3hO5eIbemaiXm7B+KpaRBx07P6RIuG7ljZ4bpv9GmO
         Jcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762474; x=1753367274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bku05+DNIlaPeHqRJ4y/c3E9v08tlUqoZ6kZCd1AC2c=;
        b=EPeMdxCMcz4YmaqVuOpdWMKq8Hv8rXk81RtOwpzr1Xff51B7JFHVrlg7SoZaqkEz4F
         CzPhKeiU2Ke8KBQf0ZjSh7Nph4YIIN1R2X+rQDoDdnRl358xO3n4M5Y8MWadRpfvD4gd
         wky9BpCBoTZIggllPJrONx7LU+k5FojHtgT6/QK8u/xMHUhQxkiMGDMdix9jcB/Xd/Wf
         uUK15MGrd7ps8mmTXn0/SI0oOUGOe51+Scj7XWTAtdzalnAG2jiNSSFv60ySzQ0YZfzk
         6lwfL9+bOyflDveTg65NFOG6vEldvkmZoEEAAHEYeR8lWpyX/RQc9pjF46O75CtBuRHt
         Q7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8Vfen62xs9zdwlZeaU7mTQW0UfBBy/gBpRC2rTtQCh6qlMIdW8bE7QkWsE+6oK6aiPsRswAPbe8F+ig==@vger.kernel.org, AJvYcCWw+Zu3LyC1q2W0r3qf5JS9XldMQ82FdaeItaZF59JJ0ipOhmextE8Tt/pG/9FOPjNY8Elkg4WS6UrX8yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr15CYNS4gCrdCp5q8vWEqxiljIncfY3jrRSm8ZoMFGQyX7ICV
	numQJFaQGpK8INWmdJYC2P9Ijrg6O4TmCs027FGWxiplFPNmpX01Gc53
X-Gm-Gg: ASbGncv54YrE+/5nYFCQd/REGlUBUv1KBqjfV5OTxqZu4X3pHNgVzUeZ2yJubpHx9e1
	8624qRYE+Ql2d2PTVa+u83AMzII62IS2Eg5vfb7rdZyCsXV0eCGlv5mTWnNYsO+FEYS6l6mrUuP
	sAvsnFQGxzHKatsnkRonl2DIaILStfljaoQ9+WfDQZRF/euurjhTwC45XwqYjlK3+SopGhHWX6d
	GC3etNl+r779s/cfABkaKVDZK2NIp/Ivff1WMEYsc2yw6wS52UYKUgp8ai3QVtiWqyKfMgzwqkX
	Ac0OsbJXtUp3vIEUYg+xTn2qQpHLPFtuY5D9QU9fbE9kbuC+1dJG4RE3s77Ss8swwNBPorGm0Pq
	kCnbSh0MQx/csDEPMCFn0plT1dvz7Gwh/7F7Q+dfNuVvtbi6F9TJQcq2QrPQijsjIs3Pj0zyAtx
	JCWxk=
X-Google-Smtp-Source: AGHT+IG3RRCZYJkrl0IFxNTcXHaC63cFJOMHtvbXLWcJf3SefCDeVNa3EwWa0HZJEZD2h7TP1+bY7g==
X-Received: by 2002:a05:6512:1452:20b0:553:af30:1e8b with SMTP id 2adb3069b0e04-55a233affa7mr1874039e87.38.1752762473999;
        Thu, 17 Jul 2025 07:27:53 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:27:53 -0700 (PDT)
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
Subject: [PATCH v3 04/12] kasan/arm64: call kasan_init_generic in kasan_init
Date: Thu, 17 Jul 2025 19:27:24 +0500
Message-Id: <20250717142732.292822-5-snovitoll@gmail.com>
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

Call kasan_init_generic() which handles Generic KASAN initialization.
Since arm64 doesn't select ARCH_DEFER_KASAN, this will be a no-op for
the runtime flag but will print the initialization banner.

For SW_TAGS and HW_TAGS modes, their respective init functions will
handle the flag enabling.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
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

