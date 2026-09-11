Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6A04AB1A0;
	Fri, 11 Sep 2026 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155733; cv=none; b=jctm52LycoyxZb6YT8Zx7C2SRrpe01fYdK74puzPu387aR4KnGCeJbFQY4UzggyHTwHIg2XNaaBEHTI1bUHccIwXR8lqUVQLAW1bG7sIBTnFD6ud5aI0dGayVFXD2VGEGH+yHr6DYg0kV5Thsj1/B6bOinR7JROAVOm9clPsSbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155733; c=relaxed/simple;
	bh=d4o8BvEhvbpmkAFDsmC7e/OS16AthPkW67coZubsUt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jKYBsWIkMs8vqLDfR0l0/ZQwRW+iQw0lhgA5FXBkk2pJia49SAdio/51gWF3WXfV8ogbFhd/wQUN12iGHwiw2epf8AXqA60YhgdnC8UYriXueO6YuXoA8yzpqE4nhEw+0pJ80B1v84h96Yk/6ma8ULrjGTX+T5MZnKt75uFKrOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5hZkxPe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5hZkxPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6EE1F00893;
	Fri, 11 Sep 2026 19:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789155714;
	bh=M7feebBV+4w0SqCnHHPUA0WnsaaqlXi4RbYO862HspA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b5hZkxPeby4ytfMTJauKfEirdwvu+obLbvn3xWPzZcr0wBfX3w+c2kujWFIcDpY9n
	 25FLBvyf42J+UZUzQbo4EoU7R+DQKAdV1weZ0+5Qm1djVUXn5MsNCrmeyoRpAkTbTJ
	 siMNDnCxo7ntKpAO1aUHoIFfJkSGnCkmDedyGaQ3sl0jd3SZvqvmObc3YM/xNBonZf
	 k+LnB3mpReS5jSnuryAr5mgkoBDh+B/eY8XbcD0SZAWiMwiGHobrF0ybz9sq0aO3oR
	 P9ZtVpQUF5BFr3CO4oSylZnpjSWQo66V0pbELQZm+VUzxOw02NQkviAWzBGK9gChxZ
	 3WaZrJuQhS4QQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 11 Sep 2026 20:36:59 +0100
Subject: [PATCH v3 12/12] mm: change the contract for free_pgtables(),
 update docs
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-rcu-pagetable-freeing-v3-12-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dinh Nguyen <dinguyen@kernel.org>, 
 Simon Schuster <schuster.simon@siemens-energy.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
 linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, 
 Qi Zheng <qi.zheng@linux.dev>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3290; i=ljs@kernel.org;
 h=from:subject:message-id; bh=d4o8BvEhvbpmkAFDsmC7e/OS16AthPkW67coZubsUt0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKWRDRfPca+K1Qt69Vu3RSVu8e9Ur+x7Hbg6r6kKjhjQ
 tW2Xw17OkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRtYKMDKtcrE7Oe/bdKdOw
 QVRKubxP/maw6+Z2i5NRMyQLnn/8n8DIcLLhht/b1oOGNt4zuvVbs+/8t5WS4NfTdnZawiPYtGc
 JEwA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Now that page tables are freed after an RCU grace period, it is safe for
read-only page table walkers to walk page table ranges that are being
concurrently torn down, provided the mm is kept alive via mmgrab().

It is however unsafe for writers to do so, as they must obtain an
appropriate lock to do so safely.

Update the pte_offset_map_lock()'s comment block to reflect this.

Similarly update the process addresses documentation.

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 Documentation/mm/process_addrs.rst |  6 ++++++
 mm/pgtable-generic.c               | 15 +++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
index a7296f251799..b1f4f44d75eb 100644
--- a/Documentation/mm/process_addrs.rst
+++ b/Documentation/mm/process_addrs.rst
@@ -537,6 +537,12 @@ We establish basic locking rules when interacting with page tables:
 * When changing a page table entry the page table lock for that page table
   **must** be held, except if you can safely assume nobody can access the page
   tables concurrently (such as on invocation of :c:func:`!free_pgtables`).
+* Page tables may be *walked* under RCU alone, as page tables are freed only
+  after an RCU grace period has elapsed. However, any entry found must be
+  revalidated after the page table lock is taken (such as the
+  :c:func:`!pmd_same` recheck performed by :c:func:`!pte_offset_map_lock`)
+  before it is acted upon. Changing an entry requires the page table
+  lock and one of the locks that excludes teardown (mmap or VMA lock).
 * Reads from and writes to page table entries must be *appropriately*
   atomic. See the section on atomicity below for details.
 * Populating previously empty entries requires that the mmap or VMA locks are
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index b91b1a98029c..a127e3e8f9b9 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -385,10 +385,17 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
  * Note: "RO" / "RW" expresses the intended semantics, not that the *kmap* will
  * be read-only/read-write protected.
  *
- * Note that free_pgtables(), used after unmapping detached vmas, or when
- * exiting the whole mm, does not take page table lock before freeing a page
- * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
- * pte_offset_map() and co once the vma is detached from mm or mm_users is zero.
+ * Note that free_pgtables(), used after unmapping detached vmas or when exiting
+ * the whole mm, does not take a page table lock before freeing a page table.
+ *
+ * As page table freeing itself is RCU-safe, page table readers can safely run
+ * concurrently with page table teardown.
+ *
+ * However, writers CANNOT as, without a lock being held, nothing prevents
+ * concurrent teardown.
+ *
+ * Also note that the PGD itself is freed at mmdrop() time, not under RCU - so
+ * the walker must keep the mm alive either by pinning the mm or the VMA.
  */
 pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 			   unsigned long addr, spinlock_t **ptlp)

-- 
2.55.0

