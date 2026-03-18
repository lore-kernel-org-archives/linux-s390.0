Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3023F2107;
	Wed, 18 Mar 2026 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849098; cv=none; b=CKSsnBvy1d4C7DbG/S8tc2aI7CX07hMfm2qel8wNJ/9rjQxuDRYIKBGSveD4UOKyXn0Bs3Hi9HYu25NgyPYaNw7+aZWBspBxe3nCWaWCnonp2xERQTYIe2pBFEUccoFaykLUk++ybLCLMk5uKA5XJBf/r2/dQ0TMgEF5bmCLNhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849098; c=relaxed/simple;
	bh=iW8PyaQGY3GlJfRuD9IYEogcwxKab0EzWBI+zvgE1Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ho3HC4Y0503lShBJG9Yyu+K2CrqrfcHezDleyHQPz9T9PhV3epkQljviB9div/faGnr/yu50FvxPLZts0dQX7y+zTMpEL9XgqISWvw+1BSB7nDSTVD7ddcCfO8LfTcVw/s3QNGG+UnKaq2Mk6+Qeubrfb5lpEIzuvihMvZJSO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1Z2PjBq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1Z2PjBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CDDC4AF10;
	Wed, 18 Mar 2026 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773849097;
	bh=iW8PyaQGY3GlJfRuD9IYEogcwxKab0EzWBI+zvgE1Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1Z2PjBqKzp0GfmuAIanbg5AtkQ2vJbq21vcreUid4pRft2yNMcWAMsHaeeMh8tJ8
	 RqyDrk+CO8eOTX1oBQSybsCDlMcOiFZe65B36NUvKKODmwNdhTZoL0+IG/GlzflXP6
	 GvnZ4ucdm0cDUeV3jtLJwciaZlgds1F3YHk5k4QrGze63EGkMzVXl5y64C1lwXZNs4
	 IxDOb6PcqmkxO7mFmLydMSZXJNLcm22sZbGC679SpdSAyrF+x1dUXwztCfrbuyQZ3F
	 ANRAFE3eujHK5OqsObkJCD5pJRyytH8M4WeiAHZplrwztTkK/SBHYOZ6Bu7LaFbjE4
	 hcVN9j6N4c/9A==
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
Subject: [PATCH v3 20/23] tools/testing/vma: update VMA tests to test vma_clear_flags[_mask]()
Date: Wed, 18 Mar 2026 15:50:31 +0000
Message-ID: <c2f83d5711753f5b0a6d9a69819f9207a997d728.1773846935.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773846935.git.ljs@kernel.org>
References: <cover.1773846935.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tests have existing flag clearing logic, so simply expand this to use
the new VMA-specific flag clearing helpers.

Also correct some trivial formatting issue in a macro define.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 tools/testing/vma/tests/vma.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index c73c3a565f1d..754a2da06321 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -347,19 +347,20 @@ static bool test_vma_flags_clear(void)
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
-	vma_flags_clear_mask(&vma.flags, mask);
+	vma_clear_flags_mask(&vma, mask);
 	vma_desc_clear_flags_mask(&desc, mask);
 #if NUM_VMA_FLAG_BITS > 64
 	ASSERT_FALSE(vma_flags_test_any(&flags, VMA_EXEC_BIT, 64));
-	ASSERT_FALSE(vma_flags_test_any(&vma.flags, VMA_EXEC_BIT, 64));
+	ASSERT_FALSE(vma_test_any(&vma, VMA_EXEC_BIT, 64));
 	ASSERT_FALSE(vma_desc_test_any(&desc, VMA_EXEC_BIT, 64));
 	/* Reset. */
 	vma_flags_set(&flags, VMA_EXEC_BIT, 64);
@@ -371,15 +372,15 @@ static bool test_vma_flags_clear(void)
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

