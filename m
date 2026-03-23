Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1547529AB02
	for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2026 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270292; cv=none; b=vApzf6U3c7EPB9OPjzta+J2a8ZSBh9trgwV3ZnZp6ELO80ODpMv2Bep9UVaatpPLcTpkMHYQSXcb8Q8u0yWIaui1umO1KiSEfhpX+Mx6StPgZqR9KF8chGz+l3ssl+7wzwByH4l9IVlbSBLme/Sk/U0g2E40wMDvyHvc9jla+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270292; c=relaxed/simple;
	bh=uFyKlLtSyw1/cdP0q3mRvXw58X0n37TGgixa4z1zU48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DrVh+Jtb206MYsTiNrbWQYdQmpdh6PVwou5aaIh/uHHtIj0d8u1jBEHPShwYDG5aLxi/YR2+Nbx9o/h85rcskf5jNEtQHHCESg7pvs765W2ce+uCOxASvSRppdLuX787N3UW1UOK5THDpBUnkoPq0YIihoIsdzlwOjCDsf2WihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNqTxZPs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNqTxZPs"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486b9675d36so33764245e9.0
        for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2026 05:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774270289; x=1774875089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kCPY0y7tsCy9xAZvG6iAVGJ0rvdXUfNtyW9vqE0ZmgE=;
        b=YNqTxZPsoGroQ/eMFQTCuuMOl5mC0oEbwnZJrPpue7A9ydKmR36LygyZlN0KhOexf3
         utkcJ3pmaVf1eMNfek5Sqxv8NnTZ7kOye/Fezds1/Tzi7sC2FiHd1n0eEfEV472+Jo1w
         llAP++xTH5fKV+9o4qLqvR4y2mHrWcaKru32kBVQOU5i8z/bi6aQpuLVSLv8glP/cjQ0
         aDISDXgsSpB+AH03nTWTiS6L4CGnn72JrWFeLaTc9v1V1db7iPdzsGnDkyO2mHlnZtZy
         EoRpELVpLGS4yYkombogJpOEL4NeOUsPVbXeW39ZxshsdW1iBUBV3S0BG2HmzEX9BLGA
         PUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774270289; x=1774875089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCPY0y7tsCy9xAZvG6iAVGJ0rvdXUfNtyW9vqE0ZmgE=;
        b=Lo9hWVHzLFoema1UyGnNy2+qOLnAX1IIfXnyfDV7hXiCLs8VvpXUp95tLHoA5Zx+rZ
         znr3AUPRzy5hc2G4yXtmJqgp0NaQ4GbhlDEChZSaKWi26SmdMAjfNvaJmj5SOPzCwed5
         KCy7YWx4CGXSlS0yRubv+IrQrQG5PIfubkNhr4gOhtOHvpKjqR1temb4CELGHsWUuyxv
         lJ3GpT5Ba74Yzt/GMyBUU0ivyBu1N3u2oSxqV0zKQWqEooL5Iw9bWRrzi4qYYu3390Fk
         SNvlr1VBm+XPZ7B/YYk4uHXci65+zMObZqTcU8V9dt12eyiqwVO0OLAiMnP5vrqRz1GX
         sgmA==
X-Forwarded-Encrypted: i=1; AJvYcCUD2bBaOuWMRKcJtqy6Ew8vIQScPTChj++qH/LHmqxAMBW1T10csaKNfsoC3pCXnGz2NK+lekkQfTB5@vger.kernel.org
X-Gm-Message-State: AOJu0YxLDJDbS35BObYuqTprIAlmkb09QRf4jXNN/n8z/OJr6VpGhI9r
	MIYGP2MS/IYDqsqVaCCsfLT27ZbVDpbyhE3p+expvr7SDBF7NKMGPdS9
X-Gm-Gg: ATEYQzwrkwOOWuOtBELW5Vl5pXCQE39xlcbkczsy5jgMyh5PZ+vKlYxk+gSAVcZMrB3
	r6JngmaZSuv7amBTA4gDfI4mZXnJaiSounmy2iWaWxGv1fYYrWJ7RMgc+B886vlPMNjT2XvxSiN
	NPMAymapUHp1cal8xS9k6DmloLM0aseJ/m+oSWKv+mQI1kKQ97r6qk8lvN1AGre0Umdzvh2+0Ua
	4Z+RHyd7gXogD2u1q1IHpqx3r3j+TCd0Us8ZLVVBD+Gc88+gAYKs7YiGfBF6ks28V4sQ1dqh7yP
	FyQH09rDK1RHEeGhOQuicxjIbZpSBoDZg0GFVnYU7Pabrh1lselaFllyc6uJp3EJH17TjkY2xHK
	y8X1SnKEGlJJahIiYyx4ml/JXq5cE93f/CqGGjtfYN7uevqSgeZ9UZGox0UE1gZfzRPkxdpWcst
	u0DMHjdp610Hkf2GXRjkqZ+c5m4A==
X-Received: by 2002:a05:600c:524e:b0:485:3dfc:57a with SMTP id 5b1f17b1804b1-486ff020bc4mr161858675e9.32.1774270289169;
        Mon, 23 Mar 2026 05:51:29 -0700 (PDT)
Received: from nixos-office ([92.250.99.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe82a030sm301539135e9.10.2026.03.23.05.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:51:28 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: gor@linux.ibm.com,
	hca@linux.ibm.com
Cc: agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] "s390: include S390_KPROBES_SANITY_TEST with KUNIT_ALL_TESTS"
Date: Mon, 23 Mar 2026 12:51:18 +0000
Message-ID: <20260323125118.1417455-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on similar config options (S390_MODULES_SANITY_TEST and
S390_UNWIND_SELFTEST), I think S390_KPROBES_SANITY_TEST should be included
with KUNIT_ALL_TESTS.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 arch/s390/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 1b3afe89cb00..0d456d0c50e8 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -1010,7 +1010,7 @@ config S390_UNWIND_SELFTEST
 	  Say N if you are unsure.
 
 config S390_KPROBES_SANITY_TEST
-	def_tristate n
+	def_tristate KUNIT_ALL_TESTS
 	prompt "Enable s390 specific kprobes tests"
 	depends on KPROBES
 	depends on KUNIT
-- 
2.51.2

