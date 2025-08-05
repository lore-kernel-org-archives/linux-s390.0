Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522627E056;
	Tue,  5 Aug 2025 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404011; cv=none; b=oPSNTvOhjaYlWYycjNtLHftsc+PjmyWTqBGjQRooCeE1HOBdSNakZLC83QbLAQ5KMXtKg9TeOiBUKeFYs9NNsDEJIzYnfKCBCgDZCR9dmloNX9Sfd8kPdUS0M8bHz5GRPnismu3Tfe8ZZ3DqVTYR2/uoZ/7I8qA7RV4p6nV2wjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404011; c=relaxed/simple;
	bh=HO6xp1CoFq+jAn2vTPWKpquTWdMBDrwRvZY+n8G972Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HGSUigm5sxjhZ1Zopi+Y33TdA2jR7U4e74fx3ngxPUoIZUcJY/G/73p3yzGc0D35dtTrLa9X/R1RgVSOO7cuxH44I5ukRDlvmpFhYWsDSKrbtoFUAQxnyWmp76I4cluQ3LZycpUfIPQFoKg8jnuv+ERd46lZQhwVR8EjM+SMJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYAhuHr8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYAhuHr8"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55b79ea50f8so5758441e87.0;
        Tue, 05 Aug 2025 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754404008; x=1755008808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdpO03g2oqaaq9F6m1+GGOlZl0qQTOQbdkE3YGqW9w0=;
        b=SYAhuHr8VUAV7c3zFVpwEmhYyBzGUj6fY2v/wB/q93LngaHJ+OoxYu7UBIt0Exkvw/
         5cdDIrUkbwFCFNNydncJOVhRwlsQ3rtkGaQeiU/So3KlcwxUyltHcz+oqbArlx5rAoHk
         f/1rHKOhJp5jrfNam9lKu1kmebksoNPet9MZCOMdyKJgMdUKcmETwc8mOhjFtc7ETt3r
         pDXBLrGR1vrCvBryj8jHxi3D6zw4KfWz7nERu8Xj7IesXriHPsAguQWsQgQMwDLRcCcv
         vcG2KGsbOZANiXMUEqrf0B63w1bK9RUJiN2uomZVTLv5XzgrRvoAw9oUBE5eNXMGWOWR
         wYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404008; x=1755008808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdpO03g2oqaaq9F6m1+GGOlZl0qQTOQbdkE3YGqW9w0=;
        b=aJQDFWivwFnWQNcJd15wrVaWmMJt0dXsWCZllTnYjoO/lhiFja3XhULb7EQMqyE9VM
         p9QwUdX6S6y9jmHLH+/SvSBMhau0UoR0cBo1WPVMgynmz6M8Tq5ZQ+SAxxHhkjHpbn/4
         14Y1VnaWmEf6II8Outp9zG2bO0MLg1jCWkgyPMYzBt4Kmr0Sxkzzpu9ygTQZD+8e0KCu
         2sPSAmNrY8zbLImsaaYfzyuew206tfoHKNV4v4CHfj1xVzx9mKvdCSpaoES6k3n6jqlf
         YFpPMPncdqG8aVodkf6Sy4IQePuyzPILygo/dQWYEG55/jPys+TIlJYsGR5C68y1Bwci
         0kKw==
X-Forwarded-Encrypted: i=1; AJvYcCWmpQOUsG1PAKAzbbJhwS4JM2gj5psnzGEPUFOLatogqzhT5AmPc7HsiqEocFVI6RA5ErvCiynd3+spu5s=@vger.kernel.org, AJvYcCWoWzWDB8FpuiUpPdoHcftE9uD0TfQbIstq3d9tBKS2r6JkqrjHt7tS54DjZnpXtG+duc0I/DjdAkQdIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCakQypsUdUZ8WyuwDd1QCCKafRZEls38Z/sQQ/azHrrpY1s5t
	Yoss6ASqdzenycQ+636Bcsn7fenYQGmp3JzaDXXBsdLKCNZ+IyrPsO/M
X-Gm-Gg: ASbGnctdLOt3mopdZNj7bVbo4Bp5NeU4kojMYVo6j6KUd3lI+jTTaqVjx008YMJtPNl
	qBs0pLZVPFnLzxLevh9tpJwTF9igIF4GsF9jIHJVW044a6l5MD8LhcD9TQP7E9m7BHVUxMyRvhj
	fgbpGaqlWdUZoGMCteFGnqQLlYvm3gAOegllENYbhvlZhaQ8HRKNTaj6jyotVM9lyjPBL4rtCfl
	PqkYxPLT4bpWRVK74DFHFiM2fsFujKvVuDlTJEZgjJLPKgqSNTOPoYk435QuL8E33wa9xtUK70B
	7rk63oySxzjLirJLRAlM8micafkJnc1rvYqf6fMtvpvCBxt70wx5Zl82vHzMiz/EMQ/I/8PSAKb
	PoyMgVhXSRvNSP4BcadzYvpZRjbJvSaT9T4hzcMJuU486dAQQz/2/Zx3KMP2OjuSFp7eO8w==
X-Google-Smtp-Source: AGHT+IEVcUaDrsN/KncF3Ds7Ejr3CDmhOGcodfBsVHrYzHQORJKCgwrZQppnXPfaGPKlSAziWl9h7g==
X-Received: by 2002:a05:6512:1254:b0:55b:842d:5825 with SMTP id 2adb3069b0e04-55b97b9395fmr4615455e87.43.1754404007496;
        Tue, 05 Aug 2025 07:26:47 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:46 -0700 (PDT)
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
Subject: [PATCH v4 8/9] kasan/s390: call kasan_init_generic in kasan_init
Date: Tue,  5 Aug 2025 19:26:21 +0500
Message-Id: <20250805142622.560992-9-snovitoll@gmail.com>
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
and prints the banner. Since s390 doesn't select ARCH_DEFER_KASAN,
kasan_enable() will be a no-op, and kasan_enabled() will return
IS_ENABLED(CONFIG_KASAN) for optimal compile-time behavior.

s390 sets up KASAN mappings in the decompressor and can run with KASAN
enabled from very early, so it doesn't need runtime control.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/s390/kernel/early.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 9adfbdd377d..544e5403dd9 100644
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

