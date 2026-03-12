Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56EE402BBD;
	Thu, 12 Mar 2026 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343036; cv=none; b=RNw7fiZi2RiOlY0Tz+5v3zcSg++AlNhreyMNgcBTgNYZ+UaM2n7txgUr1yzttIVykrUQU2QWMuEW4Ufnkahtvcjp121xEcOX7o5J/4HzH1CBBlSFOJLYzjlWc396VD2B3YTOvek5GW11OBzu40h0s7E68XSIpmlIFiAC6GWnr50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343036; c=relaxed/simple;
	bh=7VXWMMb8aKJSoBfGPrIqO8IUEnKlulnIJYLzAvN6j+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GF7yDiEt0IU9wZf+avpViNvFEZvXHSTjnn0EJU66FIGB35Meu8SL0kDoHb2FloBhtJfSqajnBCG3agmY9DDrbMOg+E3rP/O/VdaTcFQ5sQQ2RHoyXs2aSGS/MMEY90o/cxHHFUYbBie92tmQ8XldDTR82uVJO+N+WwhXA4d+oxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6biTYW5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6biTYW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B21C2BC86;
	Thu, 12 Mar 2026 19:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773343035;
	bh=7VXWMMb8aKJSoBfGPrIqO8IUEnKlulnIJYLzAvN6j+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S6biTYW5jbYbTepby7X/BkqorLcHBb04qPmImr1kZ3nSuHLOZ/ZrHAZMp7JPqfDIU
	 93qlU0/T7LPgAQM4z9toGawMEUM2zu9NNeM1y8fElbpKwQ1pcdqqqVlyJhZ5zp9jxx
	 eHYm4l+oIEImlYHb7YnIskEY0EsKtxwm9wnq27GBF3d02vQNa6HpL1wbvyJOYyt9ho
	 YJkN95McMgQtPBs1+M5qUXxKitxLXHTtQ72b3LaNkYsE/k2D+DjqvMxtmI4DovAmUt
	 hU5vyYvKqDoNkCdwzA1gU88jk950A5cER++yK28TcRIsoA7mCT6fbLdmO9EyS5xnK+
	 aanewocyJ2dxA==
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
Subject: [PATCH 17/20] tools/testing/vma: update VMA tests to test vma_clear_flags[_mask]()
Date: Thu, 12 Mar 2026 19:16:15 +0000
Message-ID: <c391ce76c41eef0941d3e6c2e51fec73994a8316.1773342102.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773342102.git.ljs@kernel.org>
References: <cover.1773342102.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test have existing flag clearing logic, so simply expand this to use
the new VMA-specific flag clearing helpers.

Also correctly some trivial formatting issue in a macro define.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 tools/testing/vma/tests/vma.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index 1395d55a1e02..340eb3119730 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -330,19 +330,21 @@ static bool test_vma_flags_clear(void)
 					, 64
 #endif
 		);
-	struct vm_area_struct vma;
-	struct vm_area_desc desc;
-
-	vma.flags = flags;
-	desc.vma_flags = flags;
+	struct vm_area_struct vma = {
+		.flags = flags,
+	};
+	struct vm_area_desc desc = {
+		.vma_flags = flags,
+	};
 
 	/* Cursory check of _mask() variant, as the helper macros imply. */
 	vma_flags_clear_mask(&flags, mask);
 	vma_flags_clear_mask(&vma.flags, mask);
 	vma_desc_clear_flags_mask(&desc, mask);
 #if NUM_VMA_FLAG_BITS > 64
+	vma_clear_flags_mask(&vma, mask);
 	ASSERT_FALSE(vma_flags_test_any(&flags, VMA_EXEC_BIT, 64));
-	ASSERT_FALSE(vma_flags_test_any(&vma.flags, VMA_EXEC_BIT, 64));
+	ASSERT_FALSE(vma_test_any(&vma, VMA_EXEC_BIT, 64));
 	ASSERT_FALSE(vma_desc_test_any(&desc, VMA_EXEC_BIT, 64));
 	/* Reset. */
 	vma_flags_set(&flags, VMA_EXEC_BIT, 64);
@@ -354,15 +356,15 @@ static bool test_vma_flags_clear(void)
 	 * Clear the flags and assert clear worked, then reset flags back to
 	 * include specified flags.
 	 */
-#define do_test_and_reset(...)					\
-	vma_flags_clear(&flags, __VA_ARGS__);			\
-	vma_flags_clear(&vma.flags, __VA_ARGS__);		\
-	vma_desc_clear_flags(&desc, __VA_ARGS__);		\
-	ASSERT_FALSE(vma_flags_test_any(&flags, __VA_ARGS__));	\
-	ASSERT_FALSE(vma_flags_test_any(&vma.flags, __VA_ARGS__));	\
-	ASSERT_FALSE(vma_desc_test_any(&desc, __VA_ARGS__));	\
-	vma_flags_set(&flags, __VA_ARGS__);			\
-	vma_set_flags(&vma, __VA_ARGS__);			\
+#define do_test_and_reset(...)						\
+	vma_flags_clear(&flags, __VA_ARGS__);				\
+	vma_clear_flags(&vma, __VA_ARGS__);				\
+	vma_desc_clear_flags(&desc, __VA_ARGS__);			\
+	ASSERT_FALSE(vma_flags_test_any(&flags, __VA_ARGS__));		\
+	ASSERT_FALSE(vma_test_any(&vma, __VA_ARGS__));			\
+	ASSERT_FALSE(vma_desc_test_any(&desc, __VA_ARGS__));		\
+	vma_flags_set(&flags, __VA_ARGS__);				\
+	vma_set_flags(&vma, __VA_ARGS__);				\
 	vma_desc_set_flags(&desc, __VA_ARGS__)
 
 	/* Single flags. */
-- 
2.53.0

