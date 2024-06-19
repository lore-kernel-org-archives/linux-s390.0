Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569F78B4C;
	Wed, 19 Jun 2024 21:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718833639; cv=none; b=fuOG3GKNQA/Pqyk/wlBaClwmLZE1xvIV+Ysaij5Adn/A85sNtlVt/9kxSh2dSTRRR5A3o08orRHG+ywbN/9HGiG/yBtireAIT+1IoWApQkwtNjIkiXJeKlw94yfQk9QgA8EHEa/Qc7BRCSbN/NQ4KmjTDURe7oFkO7ZOi5diDmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718833639; c=relaxed/simple;
	bh=3fzkEaKVOM0rPfJQM/UHilxDpBmn0DVx7ju0tzyEiz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EJvjOAFoXfJoTVXN+oaZ3U7yQP5RES7K3imCXIyDt82cUXdTv3SRIeo4KTdXsoVqXJLKndrWDTmy7/XxPATU+/NheFKYd61DoWHUlm4Ktk6iSCfErA4mlh/TYTQ5gFb3PE3VcPZtSamSsnvx8e4vHOF9tAqtWCXNo7KeHf79SDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXuPV0mI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXuPV0mI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD0BC2BBFC;
	Wed, 19 Jun 2024 21:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718833639;
	bh=3fzkEaKVOM0rPfJQM/UHilxDpBmn0DVx7ju0tzyEiz8=;
	h=From:To:Cc:Subject:Date:From;
	b=LXuPV0mIsBj2qUfpSxvieqd06Fz6R5VdBEik7h7WormVirKGrCPB2ZUVJZNgKOXZA
	 WTcfhM3u2a3vjFG6BmIZTXy9j7E25BAIAvkt80G6FC+wu7cAhi8ltsLTAl1Bmi0NJt
	 CQ9NNWHxXODJsY9JrLmUmdJSpPHPgiLPMB42YvNFrzGVS8cHVSGAoIhfGwMlO4tf4a
	 YO3aKsG5EFsGmqB4QVPVdD09eSEErHDASmB2N1CtgIO3JhDBgy+M/gWrLmA3q6rv0N
	 eByLm+/iLxS6CsbuPHP0NcCRlAc4avSe05qczj4RiEOYtG/YNEd7WVJZ1A+quYOUTx
	 yYoPy/jOLBfMw==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Yuntao Liu <liuyuntao12@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Leonardo Bras <leobras@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] randomize_kstack: Remove non-functional per-arch entropy filtering
Date: Wed, 19 Jun 2024 14:47:15 -0700
Message-Id: <20240619214711.work.953-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5074; i=kees@kernel.org; h=from:subject:message-id; bh=3fzkEaKVOM0rPfJQM/UHilxDpBmn0DVx7ju0tzyEiz8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmc1HjQzLtUraLFY0fw8Lpwy7N4xRnsdRhxQd/8 4zvmodGt6aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnNR4wAKCRCJcvTf3G3A JqdID/4gaYRTL6XxwSJgN0Ke28oaRPsAsFVq9Qopz5AkOGog7U02ED6us24dYtFeDM1Jd3D2YRG Xm5Mw6A+GTYv9xIie6yTzBrhFPaDd2iTQlo7LUmvfBBHbWtHZwg+3+aVFuGkzl+y6FXeyPhrEuL VJt8i+n5Jik8P6oDknx/GvrASYcgFi4oQbocJz4GeLwU5r1nykAzm0HNLnOIoW6cFDYXDYDqZYN OA99ZSEo37ZzyDVXRJM8T3AK5gzROfH+iLIu4S9EzmRTGZURfexwO8l+tPmLpUOqDs34c3NswTC NsHeJeZkWxGjZ8YCQXczZvgpQNOfCX7WSGWGqu9u0g5RiSKc14TMWVwa1eE3LATdIpTQqaLWXvu v6XKuf4EIxC81nbImXRM9AasBVWbSnOEGTz2MOgSukBvnwZSw1PNL0+wz7iT8vm8Qn8uwVkGtIc E1UNMIZYfmTdEe1oy58MUbpsl/kt2LoMw/zRX4iPgAwrdCIXBHWeutPbGyomypJAglLjv8hezmR 9sfkf+C4MrIqKpPYoEK82uhMsMZvT9jrL9UaUMgTQgC1hMKcs5xe5g0av7lc9Bnrs6eB0GWCAaL kEiDuXB19XmIj6NHXMaPErMRZFetU9cbFWU0qvguvN3e7xJ3nqM8DUBXqIGb4q5IxLMnUZjFbAP YBeQwwWVgzlfJ
 +A==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

An unintended consequence of commit 9c573cd31343 ("randomize_kstack:
Improve entropy diffusion") was that the per-architecture entropy size
filtering reduced how many bits were being added to the mix, rather than
how many bits were being used during the offsetting. All architectures
fell back to the existing default of 0x3FF (10 bits), which will consume
at most 1KiB of stack space. It seems that this is working just fine,
so let's avoid the confusion and update everything to use the default.

The prior intent of the per-architecture limits were:

  arm64: capped at 0x1FF (9 bits), 5 bits effective
  powerpc: uncapped (10 bits), 6 or 7 bits effective
  riscv: uncapped (10 bits), 6 bits effective
  x86: capped at 0xFF (8 bits), 5 (x86_64) or 6 (ia32) bits effective
  s390: capped at 0xFF (8 bits), undocumented effective entropy

Current discussion has led to just dropping the original per-architecture
filters. The additional entropy appears to be safe for arm64, x86,
and s390. Quoting Arnd, "There is no point pretending that 15.75KB is
somehow safe to use while 15.00KB is not."

Co-developed-by: Yuntao Liu <liuyuntao12@huawei.com>
Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
Fixes: 9c573cd31343 ("randomize_kstack: Improve entropy diffusion")
Link: https://lore.kernel.org/r/20240617133721.377540-1-liuyuntao12@huawei.com
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/syscall.c          | 16 +++++++---------
 arch/s390/include/asm/entry-common.h |  2 +-
 arch/x86/include/asm/entry-common.h  | 15 ++++++---------
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index ad198262b981..7230f6e20ab8 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -53,17 +53,15 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 	syscall_set_return_value(current, regs, 0, ret);
 
 	/*
-	 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
-	 * but not enough for arm64 stack utilization comfort. To keep
-	 * reasonable stack head room, reduce the maximum offset to 9 bits.
+	 * This value will get limited by KSTACK_OFFSET_MAX(), which is 10
+	 * bits. The actual entropy will be further reduced by the compiler
+	 * when applying stack alignment constraints: the AAPCS mandates a
+	 * 16-byte aligned SP at function boundaries, which will remove the
+	 * 4 low bits from any entropy chosen here.
 	 *
-	 * The actual entropy will be further reduced by the compiler when
-	 * applying stack alignment constraints: the AAPCS mandates a
-	 * 16-byte (i.e. 4-bit) aligned SP at function boundaries.
-	 *
-	 * The resulting 5 bits of entropy is seen in SP[8:4].
+	 * The resulting 6 bits of entropy is seen in SP[9:4].
 	 */
-	choose_random_kstack_offset(get_random_u16() & 0x1FF);
+	choose_random_kstack_offset(get_random_u16());
 }
 
 static inline bool has_syscall_work(unsigned long flags)
diff --git a/arch/s390/include/asm/entry-common.h b/arch/s390/include/asm/entry-common.h
index 7f5004065e8a..35555c944630 100644
--- a/arch/s390/include/asm/entry-common.h
+++ b/arch/s390/include/asm/entry-common.h
@@ -54,7 +54,7 @@ static __always_inline void arch_exit_to_user_mode(void)
 static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 						  unsigned long ti_work)
 {
-	choose_random_kstack_offset(get_tod_clock_fast() & 0xff);
+	choose_random_kstack_offset(get_tod_clock_fast());
 }
 
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 7e523bb3d2d3..fb2809b20b0a 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -73,19 +73,16 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 #endif
 
 	/*
-	 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
-	 * but not enough for x86 stack utilization comfort. To keep
-	 * reasonable stack head room, reduce the maximum offset to 8 bits.
-	 *
-	 * The actual entropy will be further reduced by the compiler when
-	 * applying stack alignment constraints (see cc_stack_align4/8 in
+	 * This value will get limited by KSTACK_OFFSET_MAX(), which is 10
+	 * bits. The actual entropy will be further reduced by the compiler
+	 * when applying stack alignment constraints (see cc_stack_align4/8 in
 	 * arch/x86/Makefile), which will remove the 3 (x86_64) or 2 (ia32)
 	 * low bits from any entropy chosen here.
 	 *
-	 * Therefore, final stack offset entropy will be 5 (x86_64) or
-	 * 6 (ia32) bits.
+	 * Therefore, final stack offset entropy will be 7 (x86_64) or
+	 * 8 (ia32) bits.
 	 */
-	choose_random_kstack_offset(rdtsc() & 0xFF);
+	choose_random_kstack_offset(rdtsc());
 }
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
-- 
2.34.1

