Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E492FA631;
	Thu, 17 Jul 2025 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762500; cv=none; b=griWsfNFhdK9QzQOqg+NRoK8ZYd9W3aVtbbRVAEGC5Q/0QEjNhBwe0LVKXzLcFZuoOBKy/AjhMahxWHvZPqlQHsZj8kuZ0BjpWUjXBTqakMSi5il5zowI4KCMQ4VuytgXO8saXP+LhId1YZy7NYUFIpXSq9kFwtP8bGfw44W4B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762500; c=relaxed/simple;
	bh=+oDLrDvMYdcW7Q2MYvDnPqqaPmQC/lb+cp7H6kYc8ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TI+w/2/harAWrbA3QNCDMgNVYJQRHrYd1qP/ib+hbhAKHos2tZHxNee2rwCNxaIDoTp0IJLJ3x46KwWreLagOJy8AzVsItfZigKQqb8oW1sHxLoBrEtGEpkA4RZ/rGFLMbIUFH8mVnkgU94wDq44sidD5rtYgYGuob4BJkDuLXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWHZq/5L; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWHZq/5L"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55a2604ebc1so1000716e87.0;
        Thu, 17 Jul 2025 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762497; x=1753367297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axtwyv1QW9Jl3sEVwduJUxW6lENRlEEn6jAlKX1Xswk=;
        b=RWHZq/5LK91KhX+dC66G6bwVjrDABu2iScIEOgUtZezIknZHe2vVz9uf9UWUysDRnt
         h4czaWZEJwbaAvK/qkXJT2ym7Up4MwDKSJ4bnCsxpUOJGseQQrTCpI9Wu8u1N4WOWAw/
         7kQSFDzNRyJzrVEONNbk+KlFGCopHbw41/L8+Dtr4CUG8gGxPbKdklpsCgZAYAjR1SWO
         LMFcwllVSCEhkvuLuf2myMLKu1l/P7HC4OLFgPWO9BBGIMEA7GzUpDzHAZHFaGqCvcMS
         OLURXOU4lKME5H0uk8f5nSzLYIBrmbwZOROmpYOlSPvdXS1uSL5i4XP3rAflFbKujb9u
         GEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762497; x=1753367297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axtwyv1QW9Jl3sEVwduJUxW6lENRlEEn6jAlKX1Xswk=;
        b=cxf/3SCgzJHgraGuNqdg+oEmowXG6isEUF1yUbO69Wb2rSmeCWSsqODJskFv9pfoY/
         G4hcGn2R8Dj7w4YoN13/fNy4A3T6bqebUkFv+kUkOzop4UxpFEd0ghlP0+6Hah685hHn
         kQ5hkIxmI/GBQ5qRFSS33dI/3Eu98xepagbla6oo8QI80C3H+O0FkMcmtLfO3qhB6xwZ
         QLUiw0W0UNyxjyUAg3CzNdlTAuoPZ0/Fed3W8phrTpHJ2zLQEMzn/XGSi6E5oQU2Vq4X
         SajfADwf0vEG6L6aUJR2PTIcpfZtQeRLayLu7abYHdFxXE5ci5+Ou8jV/6MHSFyYl2iU
         G3xw==
X-Forwarded-Encrypted: i=1; AJvYcCWfIcW6T3Rq3nIAnR0HoMwfKjEH00QAzC/F35fb0LF03B9nyLYar+RNGpuCNQKZ+ct+m7Xxid+ljwYrWNw=@vger.kernel.org, AJvYcCX9Fw/HrRnxcB3ukN+7OUefNAKOwqwndNEVP6nX1kimwNnE5GgeHUWGuyLwMekGsX/PYvlJD1TgKeKh7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOzgwtBivjo+2ZHU2hrJawOJbkjhKZYwIGG+aGTQL/OvZ/Bfsg
	EtqOwE0WxlYpSGw9c95UFeSM8eRhzOnSgeIeUvQFxOrz6o08yLe/FAqf
X-Gm-Gg: ASbGncuYRf5Ma+yNEl9N/b34Rc4wDHzFUh0FLJsldXunI37ywZ7rVHBRryi0ETa93PX
	fYwScWQpGHKScO5PJKqnyAE4T2SFTKUCMIqFkZcKU+Rl7V1Pr0WVL7maSTgDwUnRy9XNKQ7fZI0
	g7cwTOcZIdn8BhScnzWrX2GLFjhLJCfRE70cHsyS64syvR/CswDSc3MCNzJVw5X23Li9/8kONCp
	ztfvpJWt/An+zo9CcqVw2J+gI3m1984J4K4tVwTRRvnTsbM144FG77xeQVDoHNuCHkcdfWPdf9U
	2PUkJZBG0+N00e5ui8rpKArjiIa0Jy0E+9Xk83tDz0pisQ9A/wZ6i/Ufwzdv00GLBcjrqsGP0+E
	RZ8SQgE1DeOYPKL4fY4LmZb9WpiQEPBh/ARLWn947TimhswQgYgAB4Q3CZFhutY6RH/u1
X-Google-Smtp-Source: AGHT+IEO/8eHWJm582VzmdIOAIhCMVFXDa+uycN9FWVanpBus9xWQw/+gRsCzypPbNm9nuGJ8ZjzCw==
X-Received: by 2002:a05:6512:33ca:b0:553:37e7:867c with SMTP id 2adb3069b0e04-55a23fb26f9mr2259542e87.50.1752762496407;
        Thu, 17 Jul 2025 07:28:16 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:28:15 -0700 (PDT)
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
Subject: [PATCH v3 11/12] kasan/riscv: call kasan_init_generic in kasan_init
Date: Thu, 17 Jul 2025 19:27:31 +0500
Message-Id: <20250717142732.292822-12-snovitoll@gmail.com>
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
and prints the banner. Since riscv doesn't select ARCH_DEFER_KASAN,
kasan_enable() will be a no-op, and kasan_enabled() will return
IS_ENABLED(CONFIG_KASAN) for optimal compile-time behavior.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/riscv/mm/kasan_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 41c635d6aca..ba2709b1eec 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -530,6 +530,7 @@ void __init kasan_init(void)
 
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	init_task.kasan_depth = 0;
+	kasan_init_generic();
 
 	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
-- 
2.34.1

