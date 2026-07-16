Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F0D42D75D;
	Thu, 16 Jul 2026 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213495; cv=none; b=NyvNu/4LbXYJg78ExvzSbfOnZJuvE599xPTtw7VwIH6rTss6fHIBPdhkCN8zJbdTDZL+nX0ujrzrDTd5XBfu1lexHilf/u9gAfMDM1vm3z4OxcMRvhZ1fUmLnVLP/4RhRCtUV3k1OFWX3lqNW0UWnAChNrAEzdeYfXGM8IeeJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213495; c=relaxed/simple;
	bh=X7TicotKgFD4yfSuVdOOYPx1BkmdDhSZMb1+52Ak080=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RrG4tDQ6qMIb/8CdBgtyUmaBM0YSdfjnBRJBFt1sMIQgeo1qR//1UCwjI98Y4bBp5ZtU3RlUU1GiMrRSZ19n4Ulmdb7c9kNEaXe0QADhvDZAPv/Xqif09K9tmMW4ZI4VnaBF+w5CYwmRHobTJHHZlK45nOP/nahv+UrUTTQ61eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpNW5sTJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpNW5sTJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755701F00A3D;
	Thu, 16 Jul 2026 14:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213493;
	bh=8LTuIGe8Io4Hp0JGGsyty7Bh+5p268Vyx6JhVPmlFxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kpNW5sTJx/u9c2MEqIOUVccXD5xnbPluojNAHtABf3edyEU1lpAsaRfDV7oPtunry
	 XOyIS0lbUr0g5QE2bRkA/ONFQcJITWJ8R1NpULOTqPYuVcVKR+hWcXVwz9tlUkdVtB
	 LB+FwbK8KGdBd589G5b4s53GA7AZksZD6HeBVpLa/MqktsDfcpKkFEoMKdcFX4jGAS
	 Z7UEdNdsnbqrnmLGsutF+/yLwgo+ig80d/tvurqSewRUJ8SE8eidxQdkpo3qjkm/9A
	 ud/FON5uINp7cQhCKVnw40CozW7MXoPCMlm1YRjEbpCqspTV/3aHYvDX6mdvuYu3LY
	 XroHJr6x/P9Vg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 16 Jul 2026 16:51:02 +0200
Subject: [PATCH v2 03/10] s390/mm: use free_reserved_pages() in
 vmem_free_pages()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-bootmem_info_part2-v2-3-4afc76c73d61@kernel.org>
References: <20260716-bootmem_info_part2-v2-0-4afc76c73d61@kernel.org>
In-Reply-To: <20260716-bootmem_info_part2-v2-0-4afc76c73d61@kernel.org>
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

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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

