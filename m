Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B22B27A455;
	Tue,  5 Aug 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404002; cv=none; b=YipKYIVxGeeqw27FvnUS9h/sSlzGludB82Mcw0Mb7vyfVvVtSSh38pum+omQgZQ/OkVakTB/IeJYLhfh2ZuX3P/Z3ai4mk1SpF06A5Un6v1vH0d6fqk7URkdEglRzkwbX4eY8V2aPpRa3MLeT78IzZt37X2qi/dNqkqpAlIqZEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404002; c=relaxed/simple;
	bh=dUvJbK84nrPOQrC8AFlAi1Pi4GwbCctj5hOdwNI27js=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wv8Pm8ZuVpSKF3SwfMHuy7+Zb51RyPFtiGt4ncLFi53HAnkDcxRfG11bjKZ+UmKzyguGalMMDFBAasIFrMYjeXfYAcU1+z6OOK7715O0rLJphqU8QGJbCzktXiLvsV7E3Ik5ZW9xXeEpD9BSgxWeVq3w9bGPvnyCVvTdxn53bA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElA1QoS2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElA1QoS2"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55b975b459aso4176913e87.3;
        Tue, 05 Aug 2025 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754403999; x=1755008799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fypRqRD7duJ7p6/XnMiehAY4t+I2qqoeS7XCKLtEaPI=;
        b=ElA1QoS2w+f+V/HU+2RlA4jEmFeOVUeDEG/+TGR/4UkQwdvqPIGBGYsPMHCWea68+b
         OR9jxSfp9mQZfPgIePuOk2WI8BsyUkQbKBybZUMpQ+w/MXmCwcunafRbBCgq+0bydaXM
         Q9a2XqkXpAcOZMgMEDMYBgx4InEgAW+J8HWtpGFGi+DjOAB7LXAAqT4tOQc3Qz0sjVmD
         bvTYCxrud38sF2axzqbrcsMcZkYHMCu6Vy64yHBKCvvo1gpUaGNoTMY0+tjWEYb/S/3U
         2k2EAjxzBRiT7+LiGXkeCC6XfD/3ac4oI8u8NgZUsYSCtU5BHHs2t9GAFUy9jDyV2dTc
         rXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754403999; x=1755008799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fypRqRD7duJ7p6/XnMiehAY4t+I2qqoeS7XCKLtEaPI=;
        b=iPIgnaoPnbwRkbmnWvriFu6I7S9UHC1+L3hdZnxaM4bckF/8+zWNFIovuo9vzJQqmf
         US3ENn5lvt86KFuURpNJE4Mk9xiTydCK3w42fky2OOm90LG9DQEToNwNYNIg2/BsI35R
         Hs6782aXE5GjGcF3MSfQ1+rMew+j1Jo9TGOBJ0r+AL1bn9auh+EE892x/udq/F0O8yEv
         oFhgyZtWSuFLjC3sZ94TG8Kn3UCRvmb7pX6gsb03Mj+RJyrLSK1x8y0uFTYKz5pqMm6u
         ki6lCDiL5Jnr3CRo6n34Cqfe/dkBlll4yRePT/laHOHngazwQ2YoC3I+vFbz3FuvnNMI
         rzBg==
X-Forwarded-Encrypted: i=1; AJvYcCU7i1cWHytCYr/hrJMaj3bi1MGxoUZb3JaukPBdJ1dgEOfymak3jIQTGm2iyJumd9CAr5Sl2v3M8+E6Kg==@vger.kernel.org, AJvYcCUyih6k+N3HH5fAbdQk9eSJ+nImuoWgYFL2FCab6B2NLdwZYWG+1am3mn9/5Ft7Q4qy613sBSpAuanqCUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyStoVJEU6aPCTvIryDQhKKwwtJVu5LGJeYdcaDPt7vNv1vKIql
	Zs6dbMcb5Tg4yyR3QEIXm/WuzkFTmcUuGaJUPdGkfhaqinimJWREmvd6
X-Gm-Gg: ASbGncue4QE+ZOvREhyqmvxM03oMP/ESIr7fqxvLaDk3yl1FAIRpRVzuMgpI9gV0C5S
	8qY7TKqPnC7Eazjr04gKQsjbtpggJDOfZ5oTN22FhFMwr97H8sEPqeyLsaJWzs8C+NMxxkk+05p
	d+qH92mu6QSb/53eP1nXpmnXoSXpDeSDeszFRxLe0Bg6F6eQeWxL6YPQsqY9e8pcp4Jvm6NmS/k
	cSn19xmzdCOt+TsCVyA5Tdq3ZJVO70UAK+kLh6FRm+QXoVQkvOHH8eDBY6RQf9aMd8goq/z/5vn
	CnyjgN4fQUvnoA5yxYVL47U1DvMgazvDa/B5oH4w9Gz5K9nEmvqeSzhS/YnMg7XJOojpGhStfLZ
	yR6o9pMZhKRjqLS3lPwUCM6WvH5jTALbBGetgl4LUUV+h/AVvlWg/q5yf4b0Q4nPO4BWqug==
X-Google-Smtp-Source: AGHT+IE4tVfY0GDnGQOdh7BehbCQ960f1sYrnnyIro3xm6jwPaApab0fDljnNDBd9SZqMzry0nuyew==
X-Received: by 2002:a05:6512:a8e:b0:55b:5b29:61ef with SMTP id 2adb3069b0e04-55b97b89544mr4329067e87.56.1754403997895;
        Tue, 05 Aug 2025 07:26:37 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:37 -0700 (PDT)
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
Subject: [PATCH v4 4/9] kasan/xtensa: call kasan_init_generic in kasan_init
Date: Tue,  5 Aug 2025 19:26:17 +0500
Message-Id: <20250805142622.560992-5-snovitoll@gmail.com>
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

