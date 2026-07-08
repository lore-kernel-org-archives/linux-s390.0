Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A182F49FD;
	Wed,  8 Jul 2026 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519891; cv=none; b=B1o9q5DxK8lYEnXFTzXAR1FQuNMdcu4s0pApO+YHMeEEHadJQKMbMA7pH1facJtz5YN87LlkmI2Up/FqvPrBcIgXUbg7ZLg0F4WSqiyCHqFjxLkZDQ4WwJJws6DduT8II7wa+zyvBk5Pwb2s634Zy014fMRA1GZkv5bULPzjn/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519891; c=relaxed/simple;
	bh=11Mi0L5RkzYgGjVLx5O8tyj4dpNHryjn99L/VBIPlmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1V9fcADObZOn94iZdKbZW9AYe7yCmwaCn2z3aCxVtfvH6VJBjVzYcZp7xZklYc2u2eU68Xo6E5ij4+eF7uBlfqcuAynzNmQ0x1M0j44+iGXR6Ufa+IJFY6eSj67JLIbCwhckWo8/lvVoOYQtAUegzShBj+B934ABM18tMkr2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8L481O8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8L481O8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AC01F000E9;
	Wed,  8 Jul 2026 14:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783519890;
	bh=O5aEZlWJMk1RITDuZR/wsK7LI5ceGlZUSm3ZY2ggjRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q8L481O8cXlYqYV856wc5MZ0cmUzvzCU62QcD+EXEiG6tvRKWeyXBkZyUlxRZyYvW
	 Q0aLFDuk9B2+VSLd9IuiOUW3VSlwPQ8rYpn2I1PaQNsR9AEFZ4RAH2FpqvZ1PFuCZD
	 Cn+2Yfr2JsonOLpyX1laA8yFfFm4c3IWrzmit1ThomLc+oIA6dGzwVAEjnxFld5GSc
	 BmaKvwB8NrlJeVhCGZVv7AY2Y7zTx1TTKvB+uHazm8LFhd+J5XWy6LBrvgts2Ne+Zl
	 AaT3280R7y+kfYQKoe9TQXC4F8i8jbteoI/4Rm5oc6P3Rd+picOdZ/VAYBjvOHFslD
	 rFfL8hAn4MsBA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 08 Jul 2026 16:10:58 +0200
Subject: [PATCH 03/10] s390/mm: use free_reserved_pages() in
 vmem_free_pages()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-bootmem_info_part2-v1-3-156ce4986598@kernel.org>
References: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
In-Reply-To: <20260708-bootmem_info_part2-v1-0-156ce4986598@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-s390@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.15.2

Let's use our new generic helper.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/s390/mm/vmem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 94ee06ae89134..d2879ce860a13 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -39,7 +39,6 @@ static void __ref *vmem_alloc_pages(unsigned int order)
 
 static void vmem_free_pages(unsigned long addr, int order, struct vmem_altmap *altmap)
 {
-	unsigned int nr_pages = 1 << order;
 	struct page *page;
 
 	if (altmap) {
@@ -49,8 +48,7 @@ static void vmem_free_pages(unsigned long addr, int order, struct vmem_altmap *a
 	page = virt_to_page((void *)addr);
 	if (PageReserved(page)) {
 		/* allocated from memblock */
-		while (nr_pages--)
-			free_reserved_page(page++);
+		free_reserved_pages(page, order);
 	} else {
 		free_pages(addr, order);
 	}

-- 
2.43.0

