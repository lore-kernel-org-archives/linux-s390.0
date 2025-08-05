Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915B27E7DD;
	Tue,  5 Aug 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404013; cv=none; b=ckmHfuQjxh4cx+7AY/dUPmamxCAro5zjZhCiLxbN4VNBF6J5nKaisAzTM35eNfvtk/fxGz/mB4CPgdVZeKX4NWLCIj9KhEQHfYhW/Hh+eQd6bQz9p6X122zuO0p00+DTBGuA6gPHGwawET1CM8wdauWVRCVt+9uUhsNUWjhrrf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404013; c=relaxed/simple;
	bh=+oDLrDvMYdcW7Q2MYvDnPqqaPmQC/lb+cp7H6kYc8ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLCT7nBAK+LN2dfZHUCu7LWAr2K7s7P+vt2EuW+eRzr+HoAvTl7BW8EyrXgQmOYEFLO+1V6Ie5oQvYk6C9UObe0Yav0x2a57hrOiXcd6skfUzpQBBXV7UDVqJVZ7BjurYYninmRLhe57GqkSFy8CJzFd7ZQuNTbdYZw1gQr2Lg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMnqbvWA; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMnqbvWA"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55b7e35a452so6931474e87.2;
        Tue, 05 Aug 2025 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754404010; x=1755008810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axtwyv1QW9Jl3sEVwduJUxW6lENRlEEn6jAlKX1Xswk=;
        b=bMnqbvWAo/I/f06myuWLnF6t6jjlfvGzxUgvMX5R/5uPJygMvhf+Ww36g9a0REqKsD
         wAuaflweSajVS/p/VVy0t43jsnFLKs4XhM6vCVbnSIE/LkmVNU3wcC44to//nmhjsswv
         nmz5SfxgxTO13Dc3AspV8hx7frEwJf8jn73w4Wr/alEdpD8N/Kzm7SI105GStBfV+gAK
         Iu82q1ufv+GcETFVaUQ2jIUragA4pdfjUPO4TmzCvXv6PrRGY1I4adiumVEDVk5IBI3W
         s4Jod4p6vq8hAk7sbTOAZ7w5Jsgy9g5eImyO4fEh8kd8r4ZtBCofZxyISX3b8ScVvZvE
         LgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404010; x=1755008810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axtwyv1QW9Jl3sEVwduJUxW6lENRlEEn6jAlKX1Xswk=;
        b=BW7bRTj4pRT7QZtoW9xyHrFQ9jA0hn8HpgazQJMhgUEfuUFdlMPFtduIyxz6hbO1qR
         RgO50JxDq2VozYo+5j3Ih3+vvJlj17y/pmlHpTH4hmTg8N/GR5424VHz0iWZQfYYOGdM
         bVRYlcU0koKdc60msCjFIE7sSk0R07FZYU77pKcUkjSqM6UwLD1UobTYkJZxp2TM516u
         8ezBkXGpWr9Rw/JlzrlC079+19PD6N41jB+2GlKDiE8R3PK5aIDJSYEvMG2nUF5AJiOK
         P9q9djzzO/qTZdkTmdVjTKOFckggPmQ1xDW9LHriz9Gf/BzF2Gat2uZy7ONSbFBLuVEB
         s9iA==
X-Forwarded-Encrypted: i=1; AJvYcCU8f0L7A+VMzTDI1yNgAWBXebRfEA/b9SrC/8dSFePy0hUE7pb7wDUkFr8mo+SyK8D8vlcZMTT7abzRTg==@vger.kernel.org, AJvYcCUcYe87fT+O+Tw3QW2JMQMFTE8fAdy6LNhKGNyBzlVO/TR1RwAZXAhp9Xw7rt2eH0nMf1w+h+XGuwfZT8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXpXHGqrEDOd9ASSnK1PN9rl0lIZ4wvnOSQJWHKOqdoR/pWZey
	PqgLVOTqkXdotcABnfOrxD2Q9u6IVnSPXAGUkvUJUwpD43ClkXybUHg/
X-Gm-Gg: ASbGnctaM2anWLiL26J6T9AHGpj8bzfKxNxNEa9qdVyXQ8kMEG1rYVL0iVrIw/8ZkRQ
	VAx/fpJx4uOPE9V0jfFp6ZbF1Umt+pmVpjfizxFB89prIwbracyNs4bJB4JCWLk3mZ+vkJkOVqM
	zX1txgjKqFgZjcQVxh939ZZ2Z0ZKy/Oa9kp007f9f1drdp5VsMoZKsPbGOM5o4lVGM2PPlRvPkd
	zelJ3xiItl1StYVBQYl55usew64RQDPh7N2UhNK1WUXCcQREkt08LDCSr3UY6Rf8oSmPkuj2jNf
	WxigtdY+Z6X6/JaUlzAQTaZP9Kl4oYZt6/5wV+Z45JNvPG6eRPx59p88FQNsqfwCW92NcGDCds1
	eJ3zHsPIaHMW6XN7zRuolADPQWK1xV0X7kRulXtM8jrvUsnsErbl+OoODHboNZPNBx9sdRQ==
X-Google-Smtp-Source: AGHT+IEuo6xaqIABZcTJ/AY4HFbxdZ3CAT0b3T807lmpaRovzDFMVVkpiUz/KiBR8yrsIvUCLLc9/A==
X-Received: by 2002:a05:6512:3e1d:b0:558:f694:a65e with SMTP id 2adb3069b0e04-55b97b41812mr3194986e87.34.1754404009682;
        Tue, 05 Aug 2025 07:26:49 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:49 -0700 (PDT)
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
Subject: [PATCH v4 9/9] kasan/riscv: call kasan_init_generic in kasan_init
Date: Tue,  5 Aug 2025 19:26:22 +0500
Message-Id: <20250805142622.560992-10-snovitoll@gmail.com>
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

