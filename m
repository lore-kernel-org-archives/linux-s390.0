Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE452F7D14;
	Thu, 17 Jul 2025 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762464; cv=none; b=g6yyg2Sjg3ivSCDCQtMkRenVJDiPDACP2+4icWxxS2cHpVBm+FN8EEEAglTFPRE58+Buxf9TRsQq4k4NWY8o/GR86oCUDAyUnQ4GgDx1UBil/Uz7teYeKJII8Rml3ibqKm6rLHgB1WSdNe8bpivDdCg4CSWf0rKPlIRKKg3xUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762464; c=relaxed/simple;
	bh=EUPMir7V/4ODO/tt4hKA03zaC19z4MvzPvg1EHzPsOg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZwtKOpHuclSAzCeoxNt3aLq3Tlrwasnn9S0h9XD8oyLgQGH8fvuwMhdiRNgwtWXOQgTJt/2SkAyA4uCy06kzTG311AUz3UzoZ6S8hktiP8ZY6WC0+wiYJiyuSbXBDE0Vlaj2J73gZeS83I9L7Xw/YlGVHFCctuWhc64XKw4Bmxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnZKF2Aa; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnZKF2Aa"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553e5df44f8so901692e87.3;
        Thu, 17 Jul 2025 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762461; x=1753367261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S1+MAZvM+N/4+avawJ7fodWecsPBgKeK+9BQEGE2Ung=;
        b=AnZKF2AaaBQXXKMHWeLBIO1G+6mCesTVdDK+MkbndIFZ7gsfQIdcYez7KzjbNNEq00
         U+bjCI62wut0CYXoZaG7ji66xuv/P77ZYvCFZ6KbPU/Y6jHVqo3RC+GgjTlY1h32fXJl
         uG2UEYwHGUSVOiwGO7TYB3qYAUSCTwef+0AUUrP0Kt6ymij8erbmvZQhIDs2TQw3bKiX
         SilliKP/6ihrzAFuTgx1OpfqsO9hKygxJ7Go+o++z+Q+POWq/4bTJzL0DAdAomKWea5b
         JbkS4CRnCTdqkWkNm9hre2y/jCIhC25PF6jfVge894NXMQH2UMeKr7UmKUr/6FPcdZJS
         CPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762461; x=1753367261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1+MAZvM+N/4+avawJ7fodWecsPBgKeK+9BQEGE2Ung=;
        b=fYOxBovkueCh4oVoyaN/+XMUyOLXGwFlQWN5f7urmdKPvoY9zeblSI4+leM1Mk94UB
         Xaf97ZXTIsNoyuQNKQ230NHRbCnqtUepcHVs/QIFpCF0Gzkqn57Dc98FOl+tQ5qb/ny9
         XUWCaIhG89Y54qn6rpCx0aWgLaUUPMaeMVKkxLrBDfgjb4x4om6/rArGW24RpxiM5ak2
         6r/zKTDgOPtKVemIyq2EarPAsa7k+Swre9plOuFEAXlmNbd80/lwQOEK8L9H9wXbMYKP
         pGntCWMwYUud0ukwPM4GSeHhpJb4hCyYZpeK3ahCaxVJqQl6OjAFdyOVWssdCFrzBgRc
         O1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAVXFobFPJsTi/j8RaeWNNG01M1SRX+nI4BbdjBFUVVzFk1m6Ii/BhTdvCbijuY4vyn6QSBpaa/slkWg==@vger.kernel.org, AJvYcCXus1EaCbzRxXEMeDmsBZv9ut91Uk/7ErzFRbCILL9Fhh7XT5s9lvTBeunfCmJHvsveWvSA20JZIBHL7qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdfjh0Y26whxn1wsWXt8wSe8xwB64Yz1XQowo2xwHIdv7LVKIc
	UHLPyaVBSI2qpJ51ki+1OzeVH4713NIEbR+m0XXkpADCcau9ZogHGP0E
X-Gm-Gg: ASbGncsafNnvflq50bOdJBWHAeNn1OkzMogAc1fMRH9pvd4fACWyhIC9efifAt1AAKS
	Nl1/NT8FKW+B1pcr2dcivt0+c704remGC8LSdD3rVTYzyWYdDlm/krf0wH0PkHfXyKBSkT1NGdI
	MBKLPG4AiSnHnyV+u8IkTmQwcEh5laQu6aQxacsRa51WyGedXlZv0THJ/joxz7GjyH7J1pD7PQB
	4Da8LXp6WuHeBQZOoy2ZOdnOM5CDYL621EBOuYHAnaCaD1PhyuarebTBAEeTHEw7CZsUHnlKAvf
	9JkR1cUK6+eebnVZU3pzMXl7NdntZTFgdbXbGcozbp4nVR4ntrljecWpH+HQl/p23OyNmNHvsJn
	NLOc4Bgc/6EteT7GACH6QLmUhHTi2kyceZ5hX/9IJmSYKFGp3PPftPONVS9Zdvd7FgHi9
X-Google-Smtp-Source: AGHT+IHqw++1wkJOZK6ynl4Q5tnH7hMmNdvDCLMPwyvX9yJ+k47Bz9P2wFC8+PCgt0lXOF+TLWoP4g==
X-Received: by 2002:a05:6512:b17:b0:553:ad81:4de1 with SMTP id 2adb3069b0e04-55a23f2d227mr2243765e87.24.1752762460660;
        Thu, 17 Jul 2025 07:27:40 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:27:39 -0700 (PDT)
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
Subject: [PATCH v3 00/12] kasan: unify kasan_arch_is_ready() and remove arch-specific implementations
Date: Thu, 17 Jul 2025 19:27:20 +0500
Message-Id: <20250717142732.292822-1-snovitoll@gmail.com>
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
- PowerPC, LoongArch, and um arch, each implement own kasan_arch_is_ready()
- Only HW_TAGS mode had a unified static key (kasan_flag_enabled)
- Generic and SW_TAGS modes relied on arch-specific solutions
  or always-on behavior

This series implements two-level approach:
1. kasan_enabled() - compile-time check for KASAN configuration
2. kasan_shadow_initialized() - runtime check for shadow memory readiness

Key improvements:
- Unified static key infrastructure across all KASAN modes
- Runtime overhead only for architectures that actually need it
- Compile-time optimization for arch. with early KASAN initialization
- Complete elimination of arch-specific kasan_arch_is_ready()
- Consistent interface and reduced code duplication

Previous v2 thread: https://lore.kernel.org/all/20250626153147.145312-1-snovitoll@gmail.com/

Changes in v3 (sorry for the 3-week gap):

0. Included in TO, CC only KASAN devs and people who commented in v2.

1. Addressed Andrey Konovalov's feedback:
   - Kept separate kasan_enabled() and kasan_shadow_initialized() functions
   - Added proper __wrapper functions with clean separation

2. Addressed Christophe Leroy's performance comments:
   - CONFIG_ARCH_DEFER_KASAN is only selected by architectures that need it
   - No static key overhead for architectures that can enable KASAN early
   - PowerPC 32-bit and book3e get compile-time optimization

3. Addressed Heiko Carstens and Alexander Gordeev s390 comments:
   - s390 doesn't select ARCH_DEFER_KASAN (no unnecessary static key overhead)
   - kasan_enable() is a no-op for architectures with early KASAN setup

4. Improved wrapper architecture:
   - All existing wrapper functions in include/linux/kasan.h now check both
     kasan_enabled() && kasan_shadow_initialized()
   - Internal implementation functions focus purely on core functionality
   - Shadow readiness logic is centralized in headers per Andrey's guidance

Architecture-specific changes:
- PowerPC radix MMU: selects ARCH_DEFER_KASAN for runtime control
- LoongArch: selects ARCH_DEFER_KASAN, removes custom kasan_early_stage
- um: selects ARCH_DEFER_KASAN, removes kasan_um_is_ready
- Other architectures: get compile-time optimization, no runtime overhead

The series maintains full backward compatibility while providing optimal
performance for each architecture's needs.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049

=== Current mainline KUnit status

To see if there is any regression, I've tested via compiling a kernel
with CONFIG_KASAN_KUNIT_TEST and running QEMU VM. There are failing tests
in SW_TAGS and GENERIC modes in arm64:

arm64 CONFIG_KASAN_HW_TAGS:
	# kasan: pass:62 fail:0 skip:13 total:75
	# Totals: pass:62 fail:0 skip:13 total:75
	ok 1 kasan

arm64 CONFIG_KASAN_SW_TAGS=y:
	# kasan: pass:65 fail:1 skip:9 total:75
	# Totals: pass:65 fail:1 skip:9 total:75
	not ok 1 kasan
	# kasan_strings: EXPECTATION FAILED at mm/kasan/kasan_test_c.c:1598
	KASAN failure expected in "strscpy(ptr, src + KASAN_GRANULE_SIZE, KASAN_GRANULE_SIZE)", but none occurred

arm64 CONFIG_KASAN_GENERIC=y, CONFIG_KASAN_OUTLINE=y:
	# kasan: pass:61 fail:1 skip:13 total:75
	# Totals: pass:61 fail:1 skip:13 total:75
	not ok 1 kasan
	# same failure as above

x86_64 CONFIG_KASAN_GENERIC=y:
	# kasan: pass:58 fail:0 skip:17 total:75
	# Totals: pass:58 fail:0 skip:17 total:75
	ok 1 kasan

=== Testing with patches

Testing in v3:

- Compiled every affected arch with no errors:

$ make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
	OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
	HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld \
	ARCH=$ARCH

$ clang --version
ClangBuiltLinux clang version 19.1.4
Target: x86_64-unknown-linux-gnu
Thread model: posix

- make ARCH=um produces the warning during compiling:
	MODPOST Module.symvers
	WARNING: modpost: vmlinux: section mismatch in reference: \
		kasan_init+0x43 (section: .ltext) -> \
		kasan_init_generic (section: .init.text)

AFAIU, it's due to the code in arch/um/kernel/mem.c, where kasan_init()
is placed in own section ".kasan_init", which calls kasan_init_generic()
which is marked with "__init".

- Booting via qemu-system- and running KUnit tests:

* arm64  (GENERIC, HW_TAGS, SW_TAGS): no regression, same above results.
* x86_64 (GENERIC): no regression, no errors

Sabyrzhan Tasbolatov (12):
  lib/kasan: introduce CONFIG_ARCH_DEFER_KASAN option
  kasan: unify static kasan_flag_enabled across modes
  kasan/powerpc: select ARCH_DEFER_KASAN and call kasan_init_generic
  kasan/arm64: call kasan_init_generic in kasan_init
  kasan/arm: call kasan_init_generic in kasan_init
  kasan/xtensa: call kasan_init_generic in kasan_init
  kasan/loongarch: select ARCH_DEFER_KASAN and call kasan_init_generic
  kasan/um: select ARCH_DEFER_KASAN and call kasan_init_generic
  kasan/x86: call kasan_init_generic in kasan_init
  kasan/s390: call kasan_init_generic in kasan_init
  kasan/riscv: call kasan_init_generic in kasan_init
  kasan: add shadow checks to wrappers and rename kasan_arch_is_ready

 arch/arm/mm/kasan_init.c               |  2 +-
 arch/arm64/mm/kasan_init.c             |  4 +--
 arch/loongarch/Kconfig                 |  1 +
 arch/loongarch/include/asm/kasan.h     |  7 -----
 arch/loongarch/mm/kasan_init.c         |  7 ++---
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/kasan.h       | 12 --------
 arch/powerpc/mm/kasan/init_32.c        |  2 +-
 arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +---
 arch/riscv/mm/kasan_init.c             |  1 +
 arch/s390/kernel/early.c               |  3 +-
 arch/um/Kconfig                        |  1 +
 arch/um/include/asm/kasan.h            |  5 ---
 arch/um/kernel/mem.c                   |  4 +--
 arch/x86/mm/kasan_init_64.c            |  2 +-
 arch/xtensa/mm/kasan_init.c            |  2 +-
 include/linux/kasan-enabled.h          | 34 ++++++++++++++++-----
 include/linux/kasan.h                  | 42 ++++++++++++++++++++------
 lib/Kconfig.kasan                      |  8 +++++
 mm/kasan/common.c                      | 18 +++++++----
 mm/kasan/generic.c                     | 23 ++++++++------
 mm/kasan/hw_tags.c                     |  9 +-----
 mm/kasan/kasan.h                       | 36 ++++++++++++++++------
 mm/kasan/shadow.c                      | 32 +++++---------------
 mm/kasan/sw_tags.c                     |  2 ++
 26 files changed, 146 insertions(+), 120 deletions(-)

-- 
2.34.1

