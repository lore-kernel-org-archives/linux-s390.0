Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E02B3EDAB5;
	Wed, 18 Mar 2026 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849075; cv=none; b=e8btSergDQlkewA4U8Ygl3UC7JFVrQYlqK4bOTgWTurNKqA3Ko55y5yFoeSe7SHS+C+FiL+AKrO7PEASBXdexz0s2UIKkkxsZ3HRYve8szKixwHETlm5smIG0cjrjKADwL5dqJMC9SDSnKneTNYAdKE6FEt88GztiRTKTmXlgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849075; c=relaxed/simple;
	bh=LrLBS64c+lmBUJM2XbvLHLJnGjK9/zMfbb5TL2UTCws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBf5fZgparHHMOZE1zlXSweeYjy7E8UZMU5JBOPHFJfFT358l9hMjKwmGj3yBOq/2lPs/hBNTs/d4C6nWnBHYwS8imcUIPeNXlm+UO9bqsunbk+gFebZR6RDWXQDnXMr2j6c9DodmirtBMowgXY/cjoZnsjbqd3+7i8igTD2wRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAMV/FRG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAMV/FRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F1CC2BCB3;
	Wed, 18 Mar 2026 15:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773849074;
	bh=LrLBS64c+lmBUJM2XbvLHLJnGjK9/zMfbb5TL2UTCws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PAMV/FRG9PjgQCw7QyBV6vAY5/1tkgmucdPKe6bNfQcaayUFlcPcWUrRM5+pumUew
	 8tkdQO0XR039wEdB/Z+kBm+nVhTMS+y+FEWY9areaHD6j2ywMX1H//6cVHsmdp6ujF
	 M8CROXi20fKoT1AdSl0ZdsL1KeupVrZxCUxOLYtB6/K8aGzLF9/ZuGPeCnm1biPoS7
	 zf9JSM2o7s+qHRM/dDXx7XJX5zWvE/ctttO/iWCDZFKpArYUsCJ2Cods/BYOCBUPcY
	 ldo+q78sUAKXxMqnxurIx0JfoKd2+Sc8PBn+lOt6KAxcWcmrMIXNNY1urbuV+cISbL
	 5HToCgJWlqsdQ==
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
Subject: [PATCH v3 12/23] tools/testing/vma: test that legacy flag helpers work correctly
Date: Wed, 18 Mar 2026 15:50:23 +0000
Message-ID: <4bbead202fcd419239913a61de769b209aa298fd.1773846935.git.ljs@kernel.org>
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

Update the existing compare_legacy_flags() predicate function to assert
that legacy_to_vma_flags() and vma_flags_to_legacy() behave as expected.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 tools/testing/vma/tests/vma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index 98e465fb1bf2..1fae25170ff7 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -5,6 +5,7 @@ static bool compare_legacy_flags(vm_flags_t legacy_flags, vma_flags_t flags)
 	const unsigned long legacy_val = legacy_flags;
 	/* The lower word should contain the precise same value. */
 	const unsigned long flags_lower = flags.__vma_flags[0];
+	vma_flags_t converted_flags;
 #if NUM_VMA_FLAG_BITS > BITS_PER_LONG
 	int i;
 
@@ -17,6 +18,11 @@ static bool compare_legacy_flags(vm_flags_t legacy_flags, vma_flags_t flags)
 
 	static_assert(sizeof(legacy_flags) == sizeof(unsigned long));
 
+	/* Assert that legacy flag helpers work correctly. */
+	converted_flags = legacy_to_vma_flags(legacy_flags);
+	ASSERT_FLAGS_SAME_MASK(&converted_flags, flags);
+	ASSERT_EQ(vma_flags_to_legacy(flags), legacy_flags);
+
 	return legacy_val == flags_lower;
 }
 
-- 
2.53.0

