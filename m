Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0630D419;
	Tue,  1 Sep 2026 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260897; cv=none; b=PqN7+g/3ui+naQFrKIEA/RJNicpB0WjigLSUZ0iQAEfzX0q8WSXN1SJ7VGZ3XYncH6hdBizwdh2cbAfnoeR3PvxtnOFoVmZSSQIH9KWDHn015bKLPxDoJ1urtINJKiv6N8EexcwOZFc1KiaSeqWGa6wiWp4lZM8wdXN3kYUQA14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260897; c=relaxed/simple;
	bh=uhyIEUfivUfYjY2KJIFLWdl2/R/JGZ4vd0KXQY3X22M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQI8TVla+usqxNnAq0tHtQO9fAUWiJTTEf6cE+H9Q/G6usRV983Lz1kC2yMWfY9jlJWSu9RBZYQWMEmw5cbvCaoGqpqiPPAZp/q40vS58GyconLCcz2d7GfjZNcUaYiQqdTJGegRUmMKBi/hKQIvBd0wBTzQ+YLnjM/loS3ySS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaXuseNN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaXuseNN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B951F01560;
	Tue,  1 Sep 2026 11:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788260896;
	bh=IYLKfJh2aq/+D/f0z0lQwToXfU+mbL6v7Z2WXfVA1J8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PaXuseNNd5OHIcETkIN99VBVpzIEgqH1cFw48vxykM+4JiQdBrwoGrZqn31H9tCrQ
	 +nMJDRRimnHfkJ2P9tABG1G1oNyVlh0yqdetdxb7iObdNy6ZrB5/4Mx4L5cYSm53a8
	 y3hIIhtQV/E19hIKPtHb6XlOxhi18TzVFZVVG9Q7YGx0UoiWFAwmN0QdkEXNz28CPn
	 /ZQxjuKaJwIMV8afJ8mHYXvZXkuP+nj2iKEeB3qvUqVOSWAgGky8z0ZIqw2++twf+o
	 Wo7KSZR9k7YwawPyIjG6hJpogtaSBDNjiCnKJAuOaC6/0F7wqmkJMr38aIk5TyiURR
	 c5W+esEaI4kqg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 01 Sep 2026 12:01:32 +0100
Subject: [PATCH 12/12] mm: change the contract for free_pgtables(), update
 docs
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-rcu-pagetable-freeing-v1-12-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3252; i=ljs@kernel.org;
 h=from:subject:message-id; bh=uhyIEUfivUfYjY2KJIFLWdl2/R/JGZ4vd0KXQY3X22M=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKmbfS4vTOF89p5geaChpS/bxx23t75UvjFyz8iuyZs/
 uisO22CYUcpC4MYF4OsmCLL8y/i+4NEwuZ1XvB3g5nDygQyhIGLUwAmIprHyLA3KJPz/s/VSlsZ
 Xsuvm5y/NLHq1MPlNccP9Nh7b2dbtU+E4X/qmuM6jqz/bpwpnn85YKn4D/eX3nxJjxc2e6kWb39
 a/oELAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Now that page tables are freed after an RCU grace period, it is safe for
page table walkers to walk page table ranges that are being concurrently
torn down, provided the mm is kept alive via mmgrab().

The comment block before pte_offset_map_lock() established a contract that
this was unsafe, which was correct prior to these changes. Update it to
reflect the change.

Similarly update the process addresses documentation.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 Documentation/mm/process_addrs.rst |  6 ++++++
 mm/pgtable-generic.c               | 18 +++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
index a7296f251799..1e65b139f355 100644
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
+  before it is acted upon. Changing an entry always requires the page table
+  lock.
 * Reads from and writes to page table entries must be *appropriately*
   atomic. See the section on atomicity below for details.
 * Populating previously empty entries requires that the mmap or VMA locks are
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index b91b1a98029c..ff8ff3706485 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -386,9 +386,21 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
  * be read-only/read-write protected.
  *
  * Note that free_pgtables(), used after unmapping detached vmas, or when
- * exiting the whole mm, does not take page table lock before freeing a page
- * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
- * pte_offset_map() and co once the vma is detached from mm or mm_users is zero.
+ * exiting the whole mm, does not take the page table lock before freeing a
+ * table.
+ *
+ * However, the PMD entry is cleared first, and the table freed only after
+ * an RCU grace period, so a walker that mapped the table under
+ * rcu_read_lock() stays safe, and the pmd_same() recheck in
+ * pte_offset_map_lock() detects the teardown.
+ *
+ * Therefore it is safe for "outsiders" like khugepaged to use
+ * pte_offset_map() and co. for VMAs that might be undergoing page table
+ * teardown.
+ *
+ * Note that the PGD itself is freed at mmdrop() time, not under RCU - so the
+ * walker must keep the mm alive via mmgrab(). With that held, walking remains
+ * safe even once mm_users has reached zero.
  */
 pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 			   unsigned long addr, spinlock_t **ptlp)

-- 
2.55.0

