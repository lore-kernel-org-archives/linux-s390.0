Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E11A3041;
	Mon,  2 Sep 2024 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725304143; cv=none; b=UvBr+YsYTkVczgReuEscjNrSwwveUdHdadvqItSZJNRcVUrAxycYvBQ4u9wyiHySZZ7Yx8G3Y739dCPf02Ao4Hexpaac+JHX/pLbU3AZl+ZHasb3dwlL/uOupP6s2eD8bhXIo6DLq3d9s47ZpW2vFZ9RsFMtl1tAkLxW9jmEadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725304143; c=relaxed/simple;
	bh=nejS97KnA2Qms3Gvgo3SMj9sJCiVfLci6/Mfi/Rsw8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fFkZzs+BSqbpNuqHy5KNDkrw1nMudJxXHYWY0LP/axqg7ozf3y2VbcDzob+6ak6HEVipsyqiGZu/p23gJkQ8amULtDRUPaPc1/jxowI67v6q5LjQD2dzBxhUf2Ye2f6S9GEbUFXy4p/UQZ2t78xff+y5gGADvAuRFV3jcLbAtJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufsKnZLL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufsKnZLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF47C4CEC9;
	Mon,  2 Sep 2024 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725304143;
	bh=nejS97KnA2Qms3Gvgo3SMj9sJCiVfLci6/Mfi/Rsw8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ufsKnZLLQwEHAwpacZdtysRg/9QTknqhrlzPG0gTIS2ybE0mNRT06SNEuUXiZCc52
	 rL+kMleAwcxpyJCXunOkVdq2gkI0N4rXboHt0oCmSgcGWyIDtKyzqE1RLH6FGpCehJ
	 Nca5DzLVoAyJkCzqFoxcM2eyWPTVeaxie9bJU/MGsXST6olZu3DlCT9zPLmzlDYiDo
	 26pYLD97shqH/Vu3qR8DrMi1U/FYh0ChQcfnXrx7ZvWkDhG+mSHja+QAtiFSNdNyh4
	 wOsgcVvHRsT0fJO5jdxMGCUzxcJPTzigqd/TdNVNvI1OlUf5pvD6mFYRBg0yAvRUbY
	 6Q9pMzCUd4xCg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 02 Sep 2024 20:08:14 +0100
Subject: [PATCH 2/3] mm: Pass vm_flags to generic_get_unmapped_area()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-mm-generic-shadow-stack-guard-v1-2-9acda38b3dd3@kernel.org>
References: <20240902-mm-generic-shadow-stack-guard-v1-0-9acda38b3dd3@kernel.org>
In-Reply-To: <20240902-mm-generic-shadow-stack-guard-v1-0-9acda38b3dd3@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Deepak Gupta <debug@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=4018; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nejS97KnA2Qms3Gvgo3SMj9sJCiVfLci6/Mfi/Rsw8U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm1g0v9w9lBiTjIu5lnJumAd7oKheioErj5Av8o9p9
 xjbw4dqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZtYNLwAKCRAk1otyXVSH0FX7B/
 9slZJSbOLk1zaWaFIlxJH7fsKOjdUxsEOGWqCfQQ7SzheizYCzQY9YUFbpp6x55PbW9KNdQ/ikhexU
 ts50XikTINzfTgQ5Nv4584Ko0cc5QH9Vvp0f0XFS3G8wep0Uq6vKMRlTzj2D8sUxFbzP65JLa882Vz
 pTQ7zTU/tzgbq3wMWfLtM/IqmqQJPSikIxU5k6R1bMD0jw/s2LwtAq5lD5a/g30apMg/klNkyAShDn
 JdrvWvSR2DLgHDfOSFSLUlLXNVTd61W01f/ngaSuv3L1ymol4mTPWXexFqqN6BKbYj9tM2RHTYuHDn
 LkE9GrCLQjRp0t+wnKJpiI8cN1kT2+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for using vm_flags to ensure guard pages for shadow stacks
supply them as an argument to generic_get_unmapped_area(). The only user
outside of the core code is the PowerPC book3s64 implementation which is
trivially wrapping the generic implementation in the radix_enabled() case.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/powerpc/mm/book3s64/slice.c |  4 ++--
 include/linux/sched/mm.h         |  4 ++--
 mm/mmap.c                        | 10 ++++++----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
index ada6bf896ef8..87307d0fc3b8 100644
--- a/arch/powerpc/mm/book3s64/slice.c
+++ b/arch/powerpc/mm/book3s64/slice.c
@@ -641,7 +641,7 @@ unsigned long arch_get_unmapped_area(struct file *filp,
 				     vm_flags_t vm_flags)
 {
 	if (radix_enabled())
-		return generic_get_unmapped_area(filp, addr, len, pgoff, flags);
+		return generic_get_unmapped_area(filp, addr, len, pgoff, flags, vm_flags);
 
 	return slice_get_unmapped_area(addr, len, flags,
 				       mm_ctx_user_psize(&current->mm->context), 0);
@@ -655,7 +655,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 					     vm_flags_t vm_flags)
 {
 	if (radix_enabled())
-		return generic_get_unmapped_area_topdown(filp, addr0, len, pgoff, flags);
+		return generic_get_unmapped_area_topdown(filp, addr0, len, pgoff, flags, vm_flags);
 
 	return slice_get_unmapped_area(addr0, len, flags,
 				       mm_ctx_user_psize(&current->mm->context), 1);
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index c4d34abc45d4..07bb8d4181d7 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -204,11 +204,11 @@ unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm,
 unsigned long
 generic_get_unmapped_area(struct file *filp, unsigned long addr,
 			  unsigned long len, unsigned long pgoff,
-			  unsigned long flags);
+			  unsigned long flags, vm_flags_t vm_flags);
 unsigned long
 generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 				  unsigned long len, unsigned long pgoff,
-				  unsigned long flags);
+				  unsigned long flags, vm_flags_t vm_flags);
 #else
 static inline void arch_pick_mmap_layout(struct mm_struct *mm,
 					 struct rlimit *rlim_stack) {}
diff --git a/mm/mmap.c b/mm/mmap.c
index 7528146f886f..b06ba847c96e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1789,7 +1789,7 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
 unsigned long
 generic_get_unmapped_area(struct file *filp, unsigned long addr,
 			  unsigned long len, unsigned long pgoff,
-			  unsigned long flags)
+			  unsigned long flags, vm_flags_t vm_flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
@@ -1823,7 +1823,8 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		       unsigned long len, unsigned long pgoff,
 		       unsigned long flags, vm_flags_t vm_flags)
 {
-	return generic_get_unmapped_area(filp, addr, len, pgoff, flags);
+	return generic_get_unmapped_area(filp, addr, len, pgoff, flags,
+					 vm_flags);
 }
 #endif
 
@@ -1834,7 +1835,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 unsigned long
 generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 				  unsigned long len, unsigned long pgoff,
-				  unsigned long flags)
+				  unsigned long flags, vm_flags_t vm_flags)
 {
 	struct vm_area_struct *vma, *prev;
 	struct mm_struct *mm = current->mm;
@@ -1887,7 +1888,8 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 			       unsigned long len, unsigned long pgoff,
 			       unsigned long flags, vm_flags_t vm_flags)
 {
-	return generic_get_unmapped_area_topdown(filp, addr, len, pgoff, flags);
+	return generic_get_unmapped_area_topdown(filp, addr, len, pgoff, flags,
+						 vm_flags);
 }
 #endif
 

-- 
2.39.2

