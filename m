Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA74AEE2;
	Thu,  7 Aug 2025 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754595623; cv=none; b=kNHMBFMwd6v01T3wJDK8Zp5JT9PVDXJFTt/4/zSQ+Agj34R3TCXjt7MDrbswWIgQnfolZ2RVT7vSE7vyRsfDSDl16pGuM8uNnPsNeRAJaPm8qKby/h1jt74fYIWrYrljC3qotgcIJct/4x/hyfkjBTzBk6xPRjirX4qZlbR5ebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754595623; c=relaxed/simple;
	bh=SNgRUuXsM+/JAIsgLn5lkTKNqSnmIVr4NG3YvOWD4gg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WMtpCuQg/3VmXimAV7LPv7JpktzfVegQZqtuenk4RHMuhOSJTogC8ur8cxwsKE9nZswv2eKAVulKmiUT7tmX8/S3AkdM2rVKzMXTTj+6W5nMIs+y7StxZdnVh5HkBeerK32CbAlNgCXZ1LkVADbIRjuV3yJKkE+1zp05Szwmys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCIb83xm; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCIb83xm"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b5931037eso11126641fa.2;
        Thu, 07 Aug 2025 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754595619; x=1755200419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxujgbgbPZueP+pnQ5s6H3MUryeO1an975QxEYXuWHk=;
        b=eCIb83xmagdITxOChQ4WUm7j0a/kThTL9mQd5YM1R1wanYRoePYc2IoFh0913/P2vK
         kncSbb4eKEpCk3RGScqrEx6uUL3t/LVT5fBWvlf0bOFCCWVxln52jA8XSmdoQW1m47Qp
         7qooNAEzABNkVfPvEaKhJef4U137WNKHocQviNgeAOvMt4w8CcI5oMQYZ3shFjlM/aLl
         AKutFrh0GjK/+P9qSIzRxTQADIA5bZaYOZy3xsz7sEQBOS+puZLkBZbKVxnGRo99/Hkz
         GtGTvPhaqxNbe7jf0l7lcLmM4LBDqI6w6vQY7IuOgtztNxanuC43gH6oWOeRyUczb30Q
         mmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754595619; x=1755200419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxujgbgbPZueP+pnQ5s6H3MUryeO1an975QxEYXuWHk=;
        b=kDG8e3JfAjJ9SEW2sV7238wk0ocYlZnKh8j1wJTUV9E0SF1f+TIluY4E8DrhwJ2yfV
         iHtRfXbBr1eITeMEAcKaPa6lWZIXcfJuSvL7Xj08GRyZdjUBWHYzU+RvJ5o5a9pcxPFT
         hQ0oKz+jBcVZgRC3bCjjuh+bTgCj/HeuZWIDVovj37mmqAwF+MtIcbyL9J2Ox2VMSAqI
         7T563By/0vyzMYK2aV/B5fM/gABj2ZbHF7fTqams6zGxOrzq53+fza24QgLXI7T4DvqK
         oiqfrrRjAxLALsvbSvMwEt1AbN8/vmaz7Lv8bwHKDdoRKgAA/TIYzKyeC6iSf14KgVtc
         bu3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTMC5EPUQU0SrryfGQ0qvPhJnCYjLz42+wl+8O4uf7nXOLOpcUz97qhHuBF9oEkQFjCVcu+1BrMCcx1w==@vger.kernel.org, AJvYcCVy8IdmzuuercM4SMQMGF6N0OV6HHYuP94rNYe3mBjowdc0TxMh/UjYTlTHMI794bDlXfOsnBo/oJ6gS5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJqpxDJbiVO8Uf4a4GEbShL/GoaEIe0vOa3YvIgwv2BDStQ9t
	6F1PV3w1cbOyEG4JXiToUQXj/4eyXd8sJV+qToOjWE68MNNjokjLuNvwFFBogaS9g/5oAQ==
X-Gm-Gg: ASbGnctfs4922fwXpJ69XZEhTcDTyZx/AyyNLxYkNfBJZImKoOVcFf+H6tAOczlhEIe
	L2XvXXrm/EmVlJM6D2AXwwdtMzsDvmeUvA1/dX1TsjqzBAkH6jCjlavM6s0XLyusN1jI5Vf6Of2
	kSFQEav1y8cTE4UbcKVYIQNni3v8XIF0gFNbU4glsdy0btU2UbRJwNwYLG0LZttESnSD11b51y1
	fapcRSRHJc7az9lRXywSoS3TIC52ZkHHAxbD5whUM5b9DuRBkhNvY6VmQ1FSXwseXpbBD9op5Y+
	ro1BmNdU6NI3fogco3A8A2+oLzOBj+Jidv+FB1rjtEqhzJ2DGq10dv1ZcT9yfPYSYAAQFFxvS0C
	NsHv2mKKwkuekUytXbvkGCKPgkHq86xZyuq/CzcEP/vZM/SLRPl+7NJ4OohgDoPrCiDK32A==
X-Google-Smtp-Source: AGHT+IE3k4ZwCdWcT+X+hcq7vhHbrmZfaduJaslrnOP/WdlfOXcdLd8Kfq+JS+ZAkrsMnQsJjZ39NA==
X-Received: by 2002:a05:6512:3d09:b0:55b:57e8:16c4 with SMTP id 2adb3069b0e04-55cc012c003mr7357e87.30.1754595619107;
        Thu, 07 Aug 2025 12:40:19 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98c2asm2793570e87.77.2025.08.07.12.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 12:40:18 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	bhe@redhat.com,
	hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	akpm@linux-foundation.org,
	zhangqing@loongson.cn,
	chenhuacai@loongson.cn,
	davidgow@google.co,
	glider@google.com,
	dvyukov@google.com
Cc: alex@ghiti.fr,
	agordeev@linux.ibm.com,
	vincenzo.frascino@arm.com,
	elver@google.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH v5 0/2] kasan: unify kasan_enabled() and remove arch-specific implementations
Date: Fri,  8 Aug 2025 00:40:10 +0500
Message-Id: <20250807194012.631367-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses the fragmentation in KASAN initialization
across architectures by introducing a unified approach that eliminates
duplicate static keys and arch-specific kasan_arch_is_ready()
implementations.

The core issue is that different architectures have inconsistent approaches
to KASAN readiness tracking:
- PowerPC, LoongArch, and UML arch, each implement own kasan_arch_is_ready()
- Only HW_TAGS mode had a unified static key (kasan_flag_enabled)
- Generic and SW_TAGS modes relied on arch-specific solutions
  or always-on behavior

Changes in v5:
- Unified patches where arch (powerpc, UML, loongarch) selects
  ARCH_DEFER_KASAN in the first patch not to break
  bisectability. So in v5 we have 2 patches now in the series instead of 9.
- Removed kasan_arch_is_ready completely as there is no user
- Removed __wrappers in v4, left only those where it's necessary
  due to different implementations

Tested on:
- powerpc - selects ARCH_DEFER_KASAN
Built ppc64_defconfig (PPC_BOOK3S_64) - OK
Booted via qemu-system-ppc64 - OK

I have not tested in v4 powerpc without KASAN enabled.

In v4 arch/powerpc/Kconfig it was:
	select ARCH_DEFER_KASAN			if PPC_RADIX_MMU

and compiling with ppc64_defconfig caused:
  lib/stackdepot.o:(__jump_table+0x8): undefined reference to `kasan_flag_enabled'

I have fixed it in v5 via adding KASAN condition:
	select ARCH_DEFER_KASAN			if KASAN && PPC_RADIX_MMU

- um - selects ARCH_DEFER_KASAN

KASAN_GENERIC && KASAN_INLINE && STATIC_LINK
	Before:
		In file included from mm/kasan/common.c:32:
		mm/kasan/kasan.h:550:2: error: #error kasan_arch_is_ready only works in KASAN generic outline mode!
		550 | #error kasan_arch_is_ready only works in KASAN generic outline mode

	After (with auto-selected ARCH_DEFER_KASAN):
		./arch/um/include/asm/kasan.h:29:2: error: #error UML does not work in KASAN_INLINE mode with STATIC_LINK enabled!
		29 | #error UML does not work in KASAN_INLINE mode with STATIC_LINK enabled!

KASAN_GENERIC && KASAN_OUTLINE && STATIC_LINK && 
	Before:
		./linux boots.

	After (with auto-selected ARCH_DEFER_KASAN):
		./linux boots.

KASAN_GENERIC && KASAN_OUTLINE && !STATIC_LINK
	Before:
		./linux boots

	After (with auto-disabled !ARCH_DEFER_KASAN):
		./linux boots

- loongarch - selects ARCH_DEFER_KASAN
Built defconfig with KASAN_GENERIC - OK
Haven't tested the boot. Asking Loongarch developers to verify - N/A
But should be good, since Loongarch does not have specific "kasan_init()"
call like UML does. It selects ARCH_DEFER_KASAN and calls kasan_init()
in the end of setup_arch() after jump_label_init().

Previous v4 thread: https://lore.kernel.org/all/20250805142622.560992-1-snovitoll@gmail.com/
Previous v3 thread: https://lore.kernel.org/all/20250717142732.292822-1-snovitoll@gmail.com/
Previous v2 thread: https://lore.kernel.org/all/20250626153147.145312-1-snovitoll@gmail.com/

Sabyrzhan Tasbolatov (2):
  kasan: introduce ARCH_DEFER_KASAN and unify static key across modes
  kasan: call kasan_init_generic in kasan_init

 arch/arm/mm/kasan_init.c               |  2 +-
 arch/arm64/mm/kasan_init.c             |  4 +---
 arch/loongarch/Kconfig                 |  1 +
 arch/loongarch/include/asm/kasan.h     |  7 ------
 arch/loongarch/mm/kasan_init.c         |  8 +++----
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/kasan.h       | 12 ----------
 arch/powerpc/mm/kasan/init_32.c        |  2 +-
 arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +----
 arch/riscv/mm/kasan_init.c             |  1 +
 arch/s390/kernel/early.c               |  3 ++-
 arch/um/Kconfig                        |  1 +
 arch/um/include/asm/kasan.h            |  5 ++--
 arch/um/kernel/mem.c                   | 10 ++++++--
 arch/x86/mm/kasan_init_64.c            |  2 +-
 arch/xtensa/mm/kasan_init.c            |  2 +-
 include/linux/kasan-enabled.h          | 32 ++++++++++++++++++--------
 include/linux/kasan.h                  |  6 +++++
 lib/Kconfig.kasan                      |  8 +++++++
 mm/kasan/common.c                      | 17 ++++++++++----
 mm/kasan/generic.c                     | 19 +++++++++++----
 mm/kasan/hw_tags.c                     |  9 +-------
 mm/kasan/kasan.h                       |  8 ++++++-
 mm/kasan/shadow.c                      | 12 +++++-----
 mm/kasan/sw_tags.c                     |  1 +
 mm/kasan/tags.c                        |  2 +-
 27 files changed, 107 insertions(+), 76 deletions(-)

-- 
2.34.1

