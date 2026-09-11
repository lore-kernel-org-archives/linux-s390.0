Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C771E36B91A;
	Fri, 11 Sep 2026 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155511; cv=none; b=HnhuclHHnFRnYPest9MqVeKWZJL7Vk6R2QxN2GS5DaYHeN7Zi/UdxGGxAShW2pIvaiNA9QI7p6nmqjL9JWVAtz+34L23o3y5+edYYH/803p14FIlLZ6kKT9ykmNzdbB2+ZTNV2zX4XMKOzAF2wL6k9fyoHiPZDmXMmZj0lC6Vjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155511; c=relaxed/simple;
	bh=/oVUJMuXZzN2Mln0svsuYp5CjufCOLvsQN8v4EfUuTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hknufuv+1Cc6wJwbLfShC4/SOnoY8sHRDQTqjgyidpZ4ulw5WmsOge3oK7+Mu9k3hskhX7Q1Wdvc6TZIvgtJaWM6yl6XwMsjcPZfBO8oHs5yF2CTnU1KYBcW5ERsFu4xRah5u9LzRkDrPv75ZNvHhr+l1gtZvx2OR2MjMtOak6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqjfjDf1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqjfjDf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B821F00898;
	Fri, 11 Sep 2026 19:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789155499;
	bh=tvUeWOslwBY4cQSIpSeXPe//if7BG6WqShXhm+v9yeA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EqjfjDf1gmgeoQ6KFnLRIpL/FQ72wHxtrGuPwY8ocWmgpqtGL3bkjU+CQiX6YkBL3
	 aThe6AJsNuEVpKJsvHtwNULbix3u8B/oOusAIOZ2wn2kZ8F3dAssn62nNJbH5CGn2C
	 HbKbJV75ZEbwAgEz8e+Mf5BYAolRYHp5dkMQP1rVjUWBnkJ7uDPrMoE+qheb3IN5ki
	 QOohWbeDcHeGAUqMnPcyj6aFaWp8wbWdCY0XfhMH1pn4ZN4mR5K4b6PzP8FH5Ni/6R
	 ZSNeUBXiUEXA6tntnPtTYT5jD1ZQ/C6YPpFC2ij6F+lOvQHUkLN76ownVowHon7qYQ
	 mje1nqvk4V7iA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 11 Sep 2026 20:36:48 +0100
Subject: [PATCH v3 01/12] mm/huge_memory: zap deposited page tables after
 an RCU grace period
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-rcu-pagetable-freeing-v3-1-7b8c86103821@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1958; i=ljs@kernel.org;
 h=from:subject:message-id; bh=/oVUJMuXZzN2Mln0svsuYp5CjufCOLvsQN8v4EfUuTg=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKWRDRyXmYNtf+xLTR+69JnAr2pjX8d7SR//Kp5I9WVs
 /j5l0PTOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRtK2MDL++T5Wwlbo4X2av
 hTuf1IKihjWPrLU6DldXzWh1ez2Tv4vhf4TPjX83ejMZY/9xnNtW1bNuPVvaooT6yUys4tWzV17
 PYQQA
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

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
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

