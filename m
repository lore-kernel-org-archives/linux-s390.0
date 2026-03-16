Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1900283C9D;
	Mon, 16 Mar 2026 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773666588; cv=none; b=MXhH506hzJo1sZWWQ1Q39dmzp8t/JVzirbauZHvzXUMMjUscbWHwvPPmAuejkd4SOAknu125zsOg8SlwThaXJCLzFiSVOtgYJ4or2sRsn68gQbusGgpgIe9FcYVDOzXqDlNWP9BVrB8YgH9TXgxuWdm830499Upvsg/Gno0sErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773666588; c=relaxed/simple;
	bh=VYCGf0WaVtwDjxvr9LYOu82c/eRoRD87luS4chwjGHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlXKaQQe5E9w5DryAED8MJssA9fZaUoTB1uXyqpwPQOP26kaACi6PwLuAbeucKK4/Tzr7yAVstNvDom4NyTtsavFXkn1oZOMcxzzAZraswcOn2nFwJlzo1xI0DCp9DxMk+4t1vwS+L4jS2YyGzPNzXz6G1enxLXVcfFtW8ANnHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9ClPzfO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9ClPzfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC0CC2BC87;
	Mon, 16 Mar 2026 13:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773666588;
	bh=VYCGf0WaVtwDjxvr9LYOu82c/eRoRD87luS4chwjGHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9ClPzfObkNEhL332KF/QsJjLdy0Fa0xLfyvSh61rjRN/BLUc3TuvXAWwaGBQ8G7c
	 GrPR02Wp03hFy51gh/NzNNgJQh3ikS6t8NdZQoyd7tiagwoHharLCpKdXjRdVDcjDd
	 Z93+eqGfFfbfHQCfyc0492bN6xXyWKxnPUAXhPgpMO7c5TlVo1FnE8xQNocNbL/d+A
	 Vme4UVDf6vAPXLLNngj55BlkvIg+fLN/ZvoPcQ4G6TnTdpJKa3DPU1F2eNnJ463akL
	 grY0yOUO5yzdAHsdG1vqOwD71rrNYWbV3r3uqj+7loTkJo7ibd1m7/M9Tsf4bH34Pe
	 sZZ9+w/i+EySw==
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
Subject: [PATCH v2 19/23] mm/vma: introduce vma_clear_flags[_mask]()
Date: Mon, 16 Mar 2026 13:08:08 +0000
Message-ID: <397c67b154a4868e19db9be1012e976148901de2.1773665966.git.ljs@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773665966.git.ljs@kernel.org>
References: <cover.1773665966.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a helper function and helper macro to easily clear a VMA's flags
using the new vma_flags_t vma->flags field:

* vma_clear_flags_mask() - Clears all of the flags in a specified mask in
			   the VMA's flags field.
* vma_clear_flags() - Clears all of the specified individual VMA flag bits
		      in a VMA's flags field.

Also update the VMA tests to reflect the change.

Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
---
 include/linux/mm.h              | 16 ++++++++++++++++
 tools/testing/vma/include/dup.h |  9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index eb1cbb60e63b..4ba1229676ad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1368,6 +1368,22 @@ static __always_inline void vma_set_flags_mask(struct vm_area_struct *vma,
 #define vma_set_flags(vma, ...) \
 	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
 
+/* Helper to clear all VMA flags in a VMA. */
+static __always_inline void vma_clear_flags_mask(struct vm_area_struct *vma,
+		vma_flags_t flags)
+{
+	vma_flags_clear_mask(&vma->flags, flags);
+}
+
+/*
+ * Helper macro for clearing VMA flags, e.g.:
+ *
+ * vma_clear_flags(vma, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
+ * 		VMA_DONTDUMP_BIT);
+ */
+#define vma_clear_flags(vma, ...) \
+	vma_clear_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
 /*
  * Test whether a specific VMA flag is set in a VMA descriptor, e.g.:
  *
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index e68d3eb78178..1c4a58f11852 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1063,6 +1063,15 @@ static __always_inline void vma_set_flags_mask(struct vm_area_struct *vma,
 #define vma_set_flags(vma, ...) \
 	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
 
+static __always_inline void vma_clear_flags_mask(struct vm_area_struct *vma,
+		vma_flags_t flags)
+{
+	vma_flags_clear_mask(&vma->flags, flags);
+}
+
+#define vma_clear_flags(vmag, ...) \
+	vma_clear_flags_mask(vmag, mk_vma_flags(__VA_ARGS__))
+
 static __always_inline bool vma_desc_test(const struct vm_area_desc *desc,
 		vma_flag_t bit)
 {
-- 
2.53.0

