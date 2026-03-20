Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3D13F6602;
	Fri, 20 Mar 2026 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774035549; cv=none; b=C7J7DUADCi4vyWeuBO7Ecv92Ype7NxDCex/KLx9Y9QlsUh0/6nssx2cCTDuZao72KEcrpR+/0pEAfFTHnRRDBrTNzjw3zP6nNc/vDkUtNPVq8aVy4Pnl8VPSPo0yGgJdt0EdmbcWYrJwAz63KK4I+aqVM810MENe4598BKbiFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774035549; c=relaxed/simple;
	bh=9aWXzHQRv4gbTjT9rqsyf0H1rogJGGwItdb5fmQ3ask=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGyiCGxBNftR0pDVNWKkARyNaKF/D9sAdShKtdGl2Efqlq/wb+/vPsUb+4e8Dufeg3LnhxJoaAYxjYPSaVAB0VrvlzEs8VZQyrgmNtfyLXh2Q0h5EAngWNKtSLR5K+SWmRJkWh0DWeCMpyaC8muVGM7vt77/rH0uW9Vwcz1dv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8fVFJ3G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8fVFJ3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1B1C19425;
	Fri, 20 Mar 2026 19:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774035549;
	bh=9aWXzHQRv4gbTjT9rqsyf0H1rogJGGwItdb5fmQ3ask=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8fVFJ3GCBEUnRthGRP1kE/0URQNcl+KsRUsadd+fIhbQe/2gfYOv2D5S6mV0FVNZ
	 IqByOoFx7gjlJH8WMXXirBT0TLE71Xaz7p3bBKO2IbHx1lWWFZj1nAedZ1DZN2fB3K
	 BwlR7td0TPqdBqMNbeWCVoPUdCXxwwoNW1Nw9yUZyKVkBywUnZquLJ4ohjmSFySN6r
	 7AGiYC8+L/ouGqqrMeqCtyGU6zBcUM0LT5S8L7egr7xFVMOju9p4zYJrNsSsk7SXqw
	 SdHetqFtTo5raiZKWGQELIBuTzc51Mq23jvzKPe/a463OBWqpA4GP30daza6Swf3tW
	 UthlC5Piprkdw==
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Brian Cain <bcain@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v4 10/25] mm/vma: introduce vma_flags_same[_mask/_pair]()
Date: Fri, 20 Mar 2026 19:38:27 +0000
Message-ID: <4f764bf619e77205837c7c819b62139ef6337ca3.1774034900.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774034900.git.ljs@kernel.org>
References: <cover.1774034900.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helpers to determine if two sets of VMA flags are precisely the same,
that is - that every flag set one is set in another, and neither contain
any flags not set in the other.

We also introduce vma_flags_same_pair() for cases where we want to compare
two sets of VMA flags which are both non-const values.

Also update the VMA tests to reflect the change, we already implicitly
test that this functions correctly having used it for testing purposes
previously.

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm.h                 | 28 ++++++++++++++++++++++++++++
 tools/testing/vma/include/custom.h | 11 -----------
 tools/testing/vma/include/dup.h    | 21 +++++++++++++++++++++
 3 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 42d346684678..b170cee95e25 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1207,6 +1207,34 @@ static __always_inline vma_flags_t vma_flags_diff_pair(const vma_flags_t *flags,
 	return dst;
 }
 
+/* Determine if flags and flags_other have precisely the same flags set. */
+static __always_inline bool vma_flags_same_pair(const vma_flags_t *flags,
+						const vma_flags_t *flags_other)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_other = flags_other->__vma_flags;
+
+	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+}
+
+/* Determine if flags and flags_other have precisely the same flags set.  */
+static __always_inline bool vma_flags_same_mask(const vma_flags_t *flags,
+						vma_flags_t flags_other)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_other = flags_other.__vma_flags;
+
+	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Helper macro to determine if only the specific flags are set, e.g.:
+ *
+ * if (vma_flags_same(&flags, VMA_WRITE_BIT) { ... }
+ */
+#define vma_flags_same(flags, ...) \
+	vma_flags_same_mask(flags, mk_vma_flags(__VA_ARGS__))
+
 /*
  * Helper to test that ALL specified flags are set in a VMA.
  *
diff --git a/tools/testing/vma/include/custom.h b/tools/testing/vma/include/custom.h
index 8f33df02816a..2c498e713fbd 100644
--- a/tools/testing/vma/include/custom.h
+++ b/tools/testing/vma/include/custom.h
@@ -102,16 +102,5 @@ static inline unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
 	return PAGE_SIZE;
 }
 
-/* Place here until needed in the kernel code. */
-static __always_inline bool vma_flags_same_mask(vma_flags_t *flags,
-						vma_flags_t flags_other)
-{
-	const unsigned long *bitmap = flags->__vma_flags;
-	const unsigned long *bitmap_other = flags_other.__vma_flags;
-
-	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
-}
-#define vma_flags_same(flags, ...) \
-	vma_flags_same_mask(flags, mk_vma_flags(__VA_ARGS__))
 #define VMA_SPECIAL_FLAGS mk_vma_flags(VMA_IO_BIT, VMA_DONTEXPAND_BIT, \
 				       VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT)
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 802b3d97b627..65f630923461 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -954,6 +954,27 @@ static __always_inline vma_flags_t vma_flags_diff_pair(const vma_flags_t *flags,
 	return dst;
 }
 
+static __always_inline bool vma_flags_same_pair(const vma_flags_t *flags,
+						const vma_flags_t *flags_other)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_other = flags_other->__vma_flags;
+
+	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+}
+
+static __always_inline bool vma_flags_same_mask(const vma_flags_t *flags,
+						vma_flags_t flags_other)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_other = flags_other.__vma_flags;
+
+	return bitmap_equal(bitmap, bitmap_other, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_same(flags, ...) \
+	vma_flags_same_mask(flags, mk_vma_flags(__VA_ARGS__))
+
 static inline bool vma_test_all_mask(const struct vm_area_struct *vma,
 				     vma_flags_t flags)
 {
-- 
2.53.0

