Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A052EAD0B;
	Thu, 26 Jun 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951929; cv=none; b=sDUJUDuT7trz8mnud6E40kCnbmjtbBr7xv8pAmgj9O1RpPicu72dPUMD8z2q6Fxci/i3a0c8Eg0XKWb0rYRPNS1Pl48FFswEJAAAnuY+WjMH81NcyGvdQvivXh6njR2bdlG+8T2PHjcQu+uZiqbk2YK3rkH0c1i66xEYlBSL7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951929; c=relaxed/simple;
	bh=YRTPh4M5vCs+N0uizwmFsKU7yoOODDIMAcYCfmONAgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KMkjO7PchhhgKkwrPiiXSSN377SAKmKmbzVbQ3pYgN3B/F7TZ6TedeJT2UFWgqXnYr7m4KYuW/y7Gfy869AWcvkyV1qniBPtVGzpiWlQrBhtxUEbKr3+JXzOeFww2FXu/mITcdtk+Gx6K2hAi5l0+JSCrUU9kT51nYMGcyoc0a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoXpOmrQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoXpOmrQ"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-555024588a8so1129586e87.0;
        Thu, 26 Jun 2025 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951925; x=1751556725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YMfAvEP2mtW3abNAfjIslAPajM3CO1XTnrCn/94UwT0=;
        b=OoXpOmrQVJ+unHRFdLQBWqXaXpif/JKH+sznifmw1yeGhhsnaF7isH4YKJmF5VQJEm
         lSpkuJc5C5uSga/DNGLzHuVr+zbmBey0yHpHbybpfnBAk4cxuRmMysNhldYmyGEuvNhc
         ZYJ5dcf9NXPZ04+SgUiP/sVQClOM6Qfm3hP3VSt5fAkHoqreE16gQy6CC1Zm0UK/1PTE
         b5BVQgX7SgORbY22/OYXG5rwQO6IFuXVfJJgS9Gf5oNrEsKBL9cXwmlR7l2vb3fN2Oux
         zKqswS36/xzSRVoOj7Zt6rV4d3WNGccEaP/71YyomqF1W7+VPy9l41M+R1O0/nVCjBN5
         SYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951925; x=1751556725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMfAvEP2mtW3abNAfjIslAPajM3CO1XTnrCn/94UwT0=;
        b=EI7B+Zhd/NzWfWp9xCiW1FpWmG5UUyIiEjLLRCi9uqgwb9n4dj6aXC//ijPI7J/puv
         TQUrL0DLdyR9AqPYlO9AzW1UoC/dytm3+C6fFnJZ8ovlLljWKm2AI/O6SMhGyV0+AO9V
         tHeYld2h7GzUK9wg+0aH4AC8WRa4c6hMFfoT+pTSfTbgpYTEWx1Ye6WThzQDKS0rLwms
         ur4wldVkUmeimHfJEjfT4OUUWPBk4aY2viM8KAgARMdsQpOyJcn0f4Rytzf/fj6tFKiV
         Fj7zNzkP4m/dvJ5JKYAxfNojmydbo7L9TD9IGD73KpCABkW86gepQbS4VVtPK4uzQR7Y
         NPnw==
X-Forwarded-Encrypted: i=1; AJvYcCU40v3XIjc73/vfJMK2krpKtsk6PIUgJ/QzybJncq5GeomLqax/9EpHh0cfZTe76NXaVCSX1WQCTbcUbQ==@vger.kernel.org, AJvYcCWSdMleA9l8Dv72+4TETVVVlfGniqkgbvZzlGXa3uIugStFfm2cwCho2Dtwqk9n6ftIJe+cbEV9D4FB6LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPc2lWp3MWc17CFioAZg0PrOCLs9H4DqMjf6AHJduZ6rVlucof
	utuA0p08/ZxL9yamrGpUDJAisUqVysUAn3ZhsN0gKT2yLcUPNXLj8Txa
X-Gm-Gg: ASbGnctOv/IPuJRrZCiTQ9TvbbRnBDvs7vB5GWTmgKpctNF/mV/SozHf3al/Z/nxC4j
	UYzzpEgbDPVeNQxs+wd7PAIvKtEyO6AiolxpCLuJHCTRtdMko8Tn9z3piUOOqoIqZY+dIRCw9/5
	pwE8c5N1IGR3f70VHLKZjPVbh6qH4Pvypo2AGWyMDhfJfw4Wwe58I/lHAcQQZ8zwNyVNEN606v2
	YeaITsW1E3yUywl35Lhmlx/znLF2w5gTgKMJoDJltw5bQZcAlQ1vu41++Dn4Y1PFYaz1tRbs2rm
	qzg1+biw1c6rLEpvkMtArV2ai/c4wKWZ24Ph/so6CDpvz0WqJdwljCjQp2ohCtLS2H5b9CeUd/O
	/Tb5q1YVQ+dG/pHZzNNGJfC3N10rmSMPXlAO1qRQ/
X-Google-Smtp-Source: AGHT+IHpXirYmk7XDZLOi1Ssi0yS8Ocf718QqXqkpNJ7oPQlT+uR1sIDO9gdQg1tyNmCsb6VEaTfFA==
X-Received: by 2002:a05:6512:1589:b0:554:f76a:baba with SMTP id 2adb3069b0e04-554fdcbb935mr2999055e87.3.1750951924452;
        Thu, 26 Jun 2025 08:32:04 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:03 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	akpm@linux-foundation.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: arnd@arndb.de,
	rppt@kernel.org,
	geert@linux-m68k.org,
	mcgrof@kernel.org,
	guoweikang.kernel@gmail.com,
	tiwei.btw@antgroup.com,
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	snovitoll@gmail.com
Subject: [PATCH v2 00/11] kasan: unify kasan_arch_is_ready with kasan_enabled
Date: Thu, 26 Jun 2025 20:31:36 +0500
Message-Id: <20250626153147.145312-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series unifies the kasan_arch_is_ready() and kasan_enabled()
interfaces by extending the existing kasan_enabled() infrastructure to
work consistently across all KASAN modes (Generic, SW_TAGS, HW_TAGS).

Currently, kasan_enabled() only works for HW_TAGS mode using a static key,
while other modes either return IS_ENABLED(CONFIG_KASAN) (compile-time
constant) or rely on architecture-specific kasan_arch_is_ready()
implementations with custom static keys and global variables.

This leads to:
- Code duplication across architectures  
- Inconsistent runtime behavior between KASAN modes
- Architecture-specific readiness tracking

After this series:
- All KASAN modes use the same kasan_flag_enabled static key
- Consistent runtime enable/disable behavior across modes
- Simplified architecture code with unified kasan_init_generic() calls
- Elimination of arch specific kasan_arch_is_ready() implementations
- Unified vmalloc integration using kasan_enabled() checks

This addresses the bugzilla issue [1] about making
kasan_flag_enabled and kasan_enabled() work for Generic mode,
and extends it to provide true unification across all modes.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217049

=== Current mainline KUnit status

To see if there is any regression, I've tested first on the following
commit 739a6c93cc75 ("Merge tag 'nfsd-6.16-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux").

Tested via compiling a kernel with CONFIG_KASAN_KUNIT_TEST and running
QEMU VM. There are failing tests in SW_TAGS and GENERIC modes in arm64:

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

Testing in v2:

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

=== NB

I haven't tested the kernel boot on the following arch. due to the absence
of qemu-system- support on those arch on my machine, so I defer this to
relevant arch people to test KASAN initialization:
- loongarch
- s390
- um
- xtensa
- powerpc
- riscv

Code changes in v2:
- Replace the order of patches. Move "kasan: replace kasan_arch_is_ready
	with kasan_enabled" at the end to keep the compatibility.
- arch/arm, arch/riscv: add 2 arch. missed in v1
- arch/powerpc: add kasan_init_generic() in other kasan_init() calls:
	arch/powerpc/mm/kasan/init_32.c
	arch/powerpc/mm/kasan/init_book3e_64.c
- arch/um: add the proper header `#include <linux/kasan.h>`. Tested
	via compiling with no errors. In the v1 arch/um changes were acked-by
	Johannes Berg, though I don't include it due to the changed code in v2.
- arch/powerpc: add back `#ifdef CONFIG_KASAN` deleted in v1 and tested
	the compilation.
- arch/loongarch: update git commit message about non-standard flow of
	calling kasan_init_generic()

Sabyrzhan Tasbolatov (11):
  kasan: unify static kasan_flag_enabled across modes
  kasan/arm64: call kasan_init_generic in kasan_init
  kasan/arm: call kasan_init_generic in kasan_init
  kasan/xtensa: call kasan_init_generic in kasan_init
  kasan/loongarch: call kasan_init_generic in kasan_init
  kasan/um: call kasan_init_generic in kasan_init
  kasan/x86: call kasan_init_generic in kasan_init
  kasan/s390: call kasan_init_generic in kasan_init
  kasan/powerpc: call kasan_init_generic in kasan_init
  kasan/riscv: call kasan_init_generic in kasan_init
  kasan: replace kasan_arch_is_ready with kasan_enabled

 arch/arm/mm/kasan_init.c               |  2 +-
 arch/arm64/mm/kasan_init.c             |  4 +---
 arch/loongarch/include/asm/kasan.h     |  7 -------
 arch/loongarch/mm/kasan_init.c         |  7 ++-----
 arch/powerpc/include/asm/kasan.h       | 13 -------------
 arch/powerpc/mm/kasan/init_32.c        |  2 +-
 arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +-----
 arch/riscv/mm/kasan_init.c             |  1 +
 arch/s390/kernel/early.c               |  3 ++-
 arch/um/include/asm/kasan.h            |  5 -----
 arch/um/kernel/mem.c                   |  4 ++--
 arch/x86/mm/kasan_init_64.c            |  2 +-
 arch/xtensa/mm/kasan_init.c            |  2 +-
 include/linux/kasan-enabled.h          | 22 ++++++++++++++++------
 include/linux/kasan.h                  |  6 ++++++
 mm/kasan/common.c                      | 15 +++++++++++----
 mm/kasan/generic.c                     | 17 ++++++++++++++---
 mm/kasan/hw_tags.c                     |  7 -------
 mm/kasan/kasan.h                       |  6 ------
 mm/kasan/shadow.c                      | 15 +++------------
 mm/kasan/sw_tags.c                     |  2 ++
 22 files changed, 66 insertions(+), 84 deletions(-)

-- 
2.34.1

