Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922B43CEFC;
	Fri, 15 May 2026 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836866; cv=none; b=WSpQiJLlwkM47GQnw3kiWCBEB+5wkz+GOaY7APGS+KVeWsQ6p6ZuhhsBS3oACoqkdp099HKpyJb3y0GdUkMyuIZpmbL1Rhe5mCQDBA/OsPknWbw8zYwbsEdGo/ckJp76yreP0kEzBN0nxk26MKyNngm1m07fG3sgPa4PJb0PgjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836866; c=relaxed/simple;
	bh=SxzE0nnibdkJFjlkvbsIyW+y7Yp7ydupQKVnqN+i4Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ddx5JwdIRiEffnuCUMza6s+A7AzMdVY1g1N1U7sqnweFoMVPDf0LcoYvxgP45B+N8l1Xu4bJpJUS6aP4Rq2S52P3lEle4dFzqZL4jAzyzQ+na7IeswfQL0qsfvdX6gwuSOfG2w/8MWmhdrLTN4jRDdi4mq9rlHm7UBo6ht8O6lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmRVv3IB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmRVv3IB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A35C2BCB8;
	Fri, 15 May 2026 09:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778836865;
	bh=SxzE0nnibdkJFjlkvbsIyW+y7Yp7ydupQKVnqN+i4Vo=;
	h=From:To:Cc:Subject:Date:From;
	b=bmRVv3IBSWvvodL+hDM9uN3idz/usl7CJmPAK3w4fMShzzLFYPzOxNZO6uSUMl2ZM
	 vk2eKivZ41mVSVx8SHIBme4RAEk7g5y1CuZVuBYdpeTsp0ojXWgOEqv3sf8B7h0X8b
	 WoRM5LIe4i56CzC1dD640NHCT/iKN40IkeXKaCjdZ1JoCusB6QcxnKffvYrhKwUgMU
	 lO3vsiv/3U+RhyPmMDMiLLAr4zpnKTiaoPEd5sWPeEM3GgOIcpPFKQsYNTC01t/sHl
	 d6QqF0raZNvhZ6Fqft0zD+IVU3p14oEQaj7KDJ9HhwC3AT+DJbJXgvyeOVbQ5vZNic
	 uVFy+9Lkk33iw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-hardening@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] ubsan: turn off UBSAN_ALIGNMENT on s390
Date: Fri, 15 May 2026 11:19:54 +0200
Message-Id: <20260515092057.810542-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Testing randconfig builds on s390 with gcc-15, I came across a number of
seemingly unrelated build failures that ended up all being caused
by the -fsanitize=alignment option:

s390-linux-ld: kernel/sched/build_policy.o: in function `thread_group_cputime':
include/linux/seqlock.h:1286:(.text+0x1f738): undefined reference to `__scoped_seqlock_bug'

lib/tests/overflow_kunit.c: In function 'same_type_test':
lib/tests/overflow_kunit.c:1008:13: note: variable tracking size limit exceeded with '-fvar-tracking-assignments', retrying without

fs/fat/fat_test.c: In function 'fat_clus_to_blknr_test':
fs/fat/fat_test.c:33:1: error: the frame size of 4736 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
lib/crypto/chacha-block-generic.c: In function 'chacha_permute':
lib/crypto/chacha-block-generic.c:65:1: error: the frame size of 2000 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
lib/crypto/sha3.c: In function 'sha3_keccakf_generic':
lib/crypto/sha3.c:175:1: error: the frame size of 2248 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
lib/zstd/decompress/huf_decompress.c: In function 'HUF_decompress4X2_usingDTable_internal_default':
lib/zstd/decompress/huf_decompress.c:1512:1: error: the frame size of 1352 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]

What I observe here is a huge increase in generated calls to
__ubsan_handle_type_mismatch_v1() that ends up thowing off a number of
compiler optimizations that the kernel relies on.

I have not been able to figure out why this happens on s390 but not arm64,
arm or x86, if other toolchain versions are affected by the same thing,
and if this is a problem in gcc or in the kernel itself, e.g. some
variable being identified as unaligned when it should be aligned.

This clearly needs more investigation to figure out properly what is
going on, but turning it off is currently required for randconfig testing.

Cc: Kees Cook <kees@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-hardening@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Kconfig.ubsan | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 1ecaae7064d2..3fc03a6b5af4 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -152,6 +152,7 @@ config UBSAN_ENUM
 
 config UBSAN_ALIGNMENT
 	bool "Perform checking for misaligned pointer usage"
+	depends on !S390 || BROKEN
 	default !HAVE_EFFICIENT_UNALIGNED_ACCESS
 	depends on !UBSAN_TRAP && !COMPILE_TEST
 	depends on $(cc-option,-fsanitize=alignment)
-- 
2.39.5

