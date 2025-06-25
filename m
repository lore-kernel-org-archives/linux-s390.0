Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7155284686;
	Wed, 25 Jun 2025 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845166; cv=none; b=JOI6A18xKYgvTMSHQzV8oZF9im//kZ05pt9VSVt9ImuLaFakF5BR5vXswve9NHUDFVJaOoftYYrOelwRGL2FP3Li5pRMN1TdCxWStqBWNKXFQ1CurLgNyC0akNcmc3yNECR2y8RRCb5lJBP8GQXAJzgq9mCBNfKQjPw28eRLwWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845166; c=relaxed/simple;
	bh=ayHAWnJ4zAM8Uxay2AHX7vMtSuGiCPetlz8IAlBI+nE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gMr05xZzJ4znndR6/QbHygZj+1K4MMeAjAwAmwKuyn+H0dpE6r8QqTTjtAYnx71spijlObcGDajArdPrfZLqSM9qCTYAPnB1odLAsqDiEun4uLd0EsjyH2ZNYjkjStEuw8R1CKvjWPuSXnA7Qomf3QdiC7ZIIbrWO3Q3Q3FoKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QP1plxyA; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QP1plxyA"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553b60de463so6902476e87.3;
        Wed, 25 Jun 2025 02:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845162; x=1751449962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7imy3yTxK1noZpQDmXpRegf9/Y5dUmZKs6ukLVxlc1E=;
        b=QP1plxyAYHZ+Q77ZQgix9nsX83jnpgMNx6Ewa256QKCWbfIxaRSTkEioyMn5ai9ogd
         mk0u8NmMnx0T81K3MpVf24esYm9v+9AQ0cajf2DT4lSX4NgX7FeB0fgvclxHpCZStBW2
         w63/xvIqNDO4Y635V8OqCZ3+LmrNFSSwLeD/lMtsZpq+khuk3+1+xn0vNIFhEkkp9Voz
         QDixxHSrsBRUZKodGxdUYLkATD7eGG8ddNy+4Q8fEs9Flab/jPeGAcVmsWilyW9pKH7D
         uNUHnzkknq260K9I5l6HL0n0KnLzRfrKCeFQKhLayn2a22yyaHQFiQ0n+GRGYhq05CSK
         RHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845162; x=1751449962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7imy3yTxK1noZpQDmXpRegf9/Y5dUmZKs6ukLVxlc1E=;
        b=FVxatbDE33RlVbmmJzmfWV5naQXyoXlE2DPkNO589wf3sWCThuG1436YIzDOEAgjCL
         PWdn9xEenioI9+uQxUFvTYAikm7FD2wBV3DQhViyC3Fp8qtIB2MvXcJ0JH1Lrqeio1Bi
         mVT9Rj1W8ZJ1A+C0wZ8EbYP5cY15SRr+jQ1ZfpzBkG9jxnNGCLySK2Vcv1Ku7hsTD/WU
         fjlpLP5BoFYITLh6lmxrT3wK0C8V6dCqa3tmA3R5Pag86K/9aFhEVCNcvzWD8bPlhnQ1
         jje29ZkBbU4/cQouB8uEc4bxNz4jdnUHQTnbDAvu9OchBARtvqzEeI2HWUKumoj9dV/E
         c5vw==
X-Forwarded-Encrypted: i=1; AJvYcCWJqUzt4R1pP8HHljL8T5dDfBE9ngisDwlminHnEwWHpU2TB2HF/X7mc3WLfGiyn9P5tyiatdcDDJKKGg==@vger.kernel.org, AJvYcCXDZedeeM1Md8aarHbR6wOs/Y1m4rzoWcfyn8Ue3aqcN2egsBrB97PUgwmkJvzDMBtGRsc4Tkwl78TiJu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Ue+RWAXoL16HIVweaRqxQuXs4UeEMZbKPX2PGizQpzBL+P6o
	Tu7yscJwmJFecOrW3rFQGFHaM2bLImcy341R2fcDwC/bILALTPQi32f4
X-Gm-Gg: ASbGncvXJHvp/cxPJVDVSBq+NCzf74vdW91gqzCD/EaiKQsNRmm9ifmSeRZseLPw9tc
	1sjhusnH/rCEBST/NTZSRXACwewVdchebQQlMuwWhPPGqNpIHQH77PKgIGhZfNP8dOABAkZv48a
	CN/gGJjaa82cazZ4nAVn4VwKL2YCm0X6IlKL81BGDn8Eciiu6aaJmVAd+m10+lAZMDSyTLtN1p4
	F6/rGHbiOR/nm2c4jR/lSx6dQFlxkmq4khoPPJqWAks9QN/a6h3v0k/FmJZ/zQhA9M+AWIN2Rz7
	KGc35DpslIk3zTqf4flD+5cfg5CdO8yPQM/kowR1+uB9/6/VQfrUMhWvIT10oyQUmKJ/2kM0HiD
	iYqCcwv+ILQ6qhEKQ0E0tUAcNJR8qtQ==
X-Google-Smtp-Source: AGHT+IH5ApOZ+lbBvE2ggWIBLKt7ZlvSOrm/LIiyhhxX4cx6KdoLX4TpLfXvTX3dCD4pGEuZuPz4ow==
X-Received: by 2002:a2e:be03:0:b0:32b:3879:ce7f with SMTP id 38308e7fff4ca-32cc63451f0mr7075061fa.0.1750845161589;
        Wed, 25 Jun 2025 02:52:41 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:52:41 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
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
	akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com,
	geert@linux-m68k.org,
	rppt@kernel.org,
	tiwei.btw@antgroup.com,
	richard.weiyang@gmail.com,
	benjamin.berg@intel.com,
	kevin.brodsky@arm.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH 0/9] kasan: unify kasan_arch_is_ready with kasan_enabled
Date: Wed, 25 Jun 2025 14:52:15 +0500
Message-Id: <20250625095224.118679-1-snovitoll@gmail.com>
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

=== Testing with the patches:

* arm64  (GENERIC, HW_TAGS, SW_TAGS): no regression, same above results.
* x86_64 (GENERIC): no regression, no errors

=== NB

I haven't tested on the following arch. due to the absence of qemu-system-
support on those arch on my machine. So I defer this to relevant arch
people to test KASAN initialization:
- loongarch
- s390
- um
- xtensa
- powerpc

Sabyrzhan Tasbolatov (9):
  kasan: unify static kasan_flag_enabled across modes
  kasan: replace kasan_arch_is_ready with kasan_enabled
  kasan/arm64: call kasan_init_generic in kasan_init
  kasan/xtensa: call kasan_init_generic in kasan_init
  kasan/loongarch: call kasan_init_generic in kasan_init
  kasan/um: call kasan_init_generic in kasan_init
  kasan/x86: call kasan_init_generic in kasan_init
  kasan/s390: call kasan_init_generic in kasan_init
  kasan/powerpc: call kasan_init_generic in kasan_init

 arch/arm64/mm/kasan_init.c             |  4 +---
 arch/loongarch/include/asm/kasan.h     |  7 -------
 arch/loongarch/mm/kasan_init.c         |  7 ++-----
 arch/powerpc/include/asm/kasan.h       | 14 --------------
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +-----
 arch/s390/kernel/early.c               |  2 +-
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
 18 files changed, 61 insertions(+), 82 deletions(-)

-- 
2.34.1

