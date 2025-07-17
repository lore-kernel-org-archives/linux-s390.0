Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69782F7CF5;
	Thu, 17 Jul 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762484; cv=none; b=hGXnhfz6yacoqYHZ3xvS1KRtzLVpYS40/a2a8ESBb5MiHL3eLh83MXcfZ6VZe1hn4KQCidPK+ABNElp5fV7w2Gm5ZN+Dqs/XMojWLbrNkTeICBz7fakT0RcX26QAU2JsNhNkovTnnsfDRpBb3iHcUr2rXK0a/3grw1pVW+6DYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762484; c=relaxed/simple;
	bh=dUvJbK84nrPOQrC8AFlAi1Pi4GwbCctj5hOdwNI27js=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvjoH//bDErRvYZ3SnI4aru5cHNhrmTYikkXdafAVCyineiVHlVAWXWpZtPvTPlPP3dFl9uq/JtIzPUUp6NnRW0SfHDSLoU3qSck+srnLC5si0WG4FILVyBfNSEj2mf/FIf7pnnBpMyywoZDgU/pZki/VDr7l2nLVGNYm062UPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cArtB6XJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cArtB6XJ"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553b5165cf5so1236536e87.0;
        Thu, 17 Jul 2025 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762481; x=1753367281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fypRqRD7duJ7p6/XnMiehAY4t+I2qqoeS7XCKLtEaPI=;
        b=cArtB6XJiJa7omxjrrmbVZew7KYwXsNCqZlr4JcwLi3oLNYvt631IrMkGSbKte45ux
         eRfxFrznxpBgGulGhWqlTXz/q5p3mqsx7UNfVmdMeMdkgkdL0mQHN8fnwVnU/FUZfpqW
         t9XXuihGBugh/WFq+lQiuRTkZJ5wgATcaoDRZ4n8wHrhba0iA8gEDG6wPGtiPKQQE1L5
         /WFeMDCZiT1ooZyIdWc5ufYy3uw+QRbMKQ2h6o1sTTxOeR76ghHsLAp5cgPGGHzv2ujS
         WcQX64opZYmgH+/MuSi8X93Z68hSC4gL1o6N3CuRJMLpO56YhYnxtKGNkZ9AwTD0hXc7
         9ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762481; x=1753367281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fypRqRD7duJ7p6/XnMiehAY4t+I2qqoeS7XCKLtEaPI=;
        b=qszIE5eot97Ja79n7UbgvnlVHpiKTxHzpJ9086oceoT/LLnUuUN5b4FC0B6lWYgDmG
         AdxHpjqQdqqa9mqbByEWXTX8drYx18dfiE56zLEI6Vy0BOy62+8Xv5dmSW+1F3vWuyT8
         phlY93YoNhoD/YWxQbtrc3wAwj1u2Y7L0ZaJ+c1qDq0Ad1Zy4vJzrhegC8BRRxY0IHMa
         FeeuQH0vDo+ZkdLC0tMerq4opkJUK5/L8c5/p7m25yBzZ0iMJnJI9SYiSy0mGiSAQJqx
         GTrwI7mYDgjf+CB3bUPrVyOaVDHMoaAuMvAHTs+1nJeBd5byVp2Twc25yZ6SgKHRMmSO
         s5+g==
X-Forwarded-Encrypted: i=1; AJvYcCUP/yJuG2MQo55qvRXzpUlyKIvAtsN1XpKXxaAR4gdpPXTiaCT8b54gPc/FD4PK1U9JAxtHQHynhlq1oQ0=@vger.kernel.org, AJvYcCWNZbLv8vZSiHVs+XVQomsEYBnrDioI+4Id383Db9ooKORQ2MCQwWIxIMsiL+fQ9WO4DRDIb0yBTwhl2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zIUr3AE0wjbiV100TfJ6hnI+MD4eobzsyiwSNMq1Y3abHYI6
	U1qvmwFhg13eJeJn3s3FwD4ha+55fk4SLF0ra5njCuVkAt9nwfe2noHh
X-Gm-Gg: ASbGnct0fub9Likggb/J7+wDoRlO9nd6liAX6DMcBVv5iENvTXAl8YWtvQc1z7ZB5hX
	JvunbEakm9YaEZkiKvbuHTZP4Gk3v3gH2y0YIqZaf4Sgm7ZAnctZscCT9TT9METv59FuE8ARa+a
	6AoXNtlm7O4rc7eLQuoWuy5H2rKM8JoIl5Heu0mgULAtJ8mSVm/GQJYB6hPcGDvN722ainqA1P5
	cI3ZbmDpWYZdRTkpp1CDtgbGeBMenx1SJzw5YD4uc/rByRsHaIeRPQ8hg0T3XFCFvwhWMliVJcg
	6CfMDgpj0EjECbpcoHaJsRjFj62ggugPO+dCj8d6AbgVly72BvqZSsLpKLXhzptQWTT7Bfx0rfd
	RK4Fr5t1hq36818ONpIWGNcJmBOhjgGvONTFcf2LdVPoFEKT9cd6osCIbihr4wc4sa00j
X-Google-Smtp-Source: AGHT+IFLVShq7sQke2+sS90z+vGxECzG8DIPcMIPlB0XqE9wZj6ZkLlHMF4FaDTA86AkwLv8/0lA9Q==
X-Received: by 2002:a05:6512:63c4:10b0:553:ae47:685f with SMTP id 2adb3069b0e04-55a233b1914mr1997025e87.38.1752762480616;
        Thu, 17 Jul 2025 07:28:00 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:27:59 -0700 (PDT)
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
Subject: [PATCH v3 06/12] kasan/xtensa: call kasan_init_generic in kasan_init
Date: Thu, 17 Jul 2025 19:27:26 +0500
Message-Id: <20250717142732.292822-7-snovitoll@gmail.com>
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

Call kasan_init_generic() which handles Generic KASAN initialization
and prints the banner. Since xtensa doesn't select ARCH_DEFER_KASAN,
kasan_enable() will be a no-op.

Note that arch/xtensa still uses "current" instead of "init_task" pointer
in `current->kasan_depth = 0;` to enable error messages. This is left
unchanged as it cannot be tested.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/xtensa/mm/kasan_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index f39c4d83173..0524b9ed5e6 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -94,5 +94,5 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages. */
 	current->kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 }
-- 
2.34.1

