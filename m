Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563853CA6A;
	Tue,  8 Sep 2026 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870791; cv=none; b=KcSY66a4ynOcTeaKUDNZAhxLfcpW2z0i0OZJ1FDoCPXoen5su5bKrAawE/PWF7lIK8dAO2kaJv8E02OMRFkYD7+XN77R3O9eobMQDlL0uLZSTynL+YyWKJ6eHEhhT5BfW1kcTiEPPcOf6Z/ytmTZ1krSxYPlwmBbG9amT5bSUsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870791; c=relaxed/simple;
	bh=QsmXD4bhTqKAKkUCvIrmgq1QZ07I5df5Am7bAMtZYGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rz/YyTL9NWLCN1Kl/p2Dd3wc+BlAaicBfcSLjCgTOSIhaDEtVVIbYi7Qj2WNlE7QJuoZ2jC6BUzZLb6ySV38/PpyshKYeSUEqq2i5uEZ2rg0GftsWqAUZu8w7JTE/tt0ZRJ1XVuL3tbKvfqsMxC+GFoEYEKB/R45EKN5XGZiCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLtpz7A5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLtpz7A5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC691F00A3A;
	Tue,  8 Sep 2026 12:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870790;
	bh=qrlRHDKkKksSse2z7V875Db2PCZ3B/h/JK+Hse17ruk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aLtpz7A5VymVqyE5xIUldqu4FEfYkW3C/kRkUKk7eS5Fd938lNBcUqjWIc4HUU61D
	 DVipoD/pdYsc76ZExc8Qvd07r0+EVBvsmN0INrIpBqY43rMzTPkA1y8XItRLueMgmx
	 3YOfOCnlih3OLyVjTsPc67cCII18Lx0cRR9hCnypeOHaV41VQzUaFqL6rwG0rnaocV
	 dq/wVeanPRwRB8LUnw28+2OE1zJ6OXYKiYMDTUC/ChepsXs8Tbov72fkpOZpN5UuX4
	 BnK+GneNUBzkfBv1WkAj2ZiQktcmuToqdhISbN/sVHSCyc1BsNQXmhbGQ6rk9lwLrr
	 h4poq5HhB3GXw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 08 Sep 2026 13:32:10 +0100
Subject: [PATCH v2 01/12] mm/huge_memory: zap deposited page tables after
 an RCU grace period
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-rcu-pagetable-freeing-v2-1-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907; i=ljs@kernel.org;
 h=from:subject:message-id; bh=QsmXD4bhTqKAKkUCvIrmgq1QZ07I5df5Am7bAMtZYGk=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIWMEQz2MotteNZL1imp//16Cr13zP57DKuWi88+/7V3
 rv7jPrnd5SyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTGBDuDgFYCIdVYwMTyUVDice2bv+1N8t
 ptvOq5Z+sY5uu1n26MCPewUH//vl7WD4n9LEE+pReenVX+nclMY/0peKpct75+X5nPI4xSKj2PW
 GFQA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

When an anonymous mapping is collapsed for THP, a PTE page table is
'deposited' with the installed PMD entry.

This is done in order that a split can be performed without needing to
allocate additional memory.

The freeing occurs in zap_deposited_table() and is done directly without
any delay via pte_free().

This is currently not a problem as existing page table walks are protected
by the mmap or anon rmap lock.

However this becomes problematic in a future where RCU-only page table
walkers exist, as there is nothing to prevent a page table walker that
started the walk prior to collapse having its PTE table freed underneath
it.

Commit 13cf577e6b66 ("mm/pgtable: add pte_free_defer() for pgtable as
page") already provides us the mechanism by which to solve this -
pte_free_defer().

Therefore, as a prerequisite to a future commit which will permit fully RCU
page table walks, update zap_deposited_table() to use pte_free_defer()
rather than pte_free().

Note that the IPI sync in collapse_huge_page() is still required to ensure
refcount correctness against a GUP-fast operation.

This is because GUP-fast might increment refcount, but
__collapse_huge_page_isolate() determines whether it is safe to proceed by
checking folio_ref_count() against folio_expected_ref_count(), so the two
must be mutually excluded.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 54494c3fa983..505f7b62ff28 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2476,7 +2476,7 @@ static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
 	pgtable_t pgtable;
 
 	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
-	pte_free(mm, pgtable);
+	pte_free_defer(mm, pgtable);
 	mm_dec_nr_ptes(mm);
 }
 

-- 
2.55.0

