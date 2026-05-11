Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04DA25333F;
	Mon, 11 May 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508369; cv=none; b=GvhFjPc218fgJeQ/Tx+pVkY3GF6DGVtGz5fBnvgZlS8J2BeOoE2/CvN4GrPLsv0mwsPyMn/IIpDj3lajBr+5NDsptOWDTEy1n7szFx00cyCMfSLOGEt3pUO6TQzexgWsTFbPkgWXZdyBUGM3A2f2DjeDXl0Pybyl7thYAXVdqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508369; c=relaxed/simple;
	bh=Df7YQtlt1u58ew8l6Y3LcE6eBp8Ob9c95zjKPT1feMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ToiU9+j0IAFjyXqnmEIHvH6+Pi2cJ3SYzl8FP93nbWGl80ZuEKPO+4upe6CciMeMBl0Ywqc9DOw4Z7EY1Ib9e1hdFNITSh9DSYY3v3BT0YPoUbMJ6Mk1qwgRGTriN5XOD4D94x9WBUzPjnci3rY/GvoKyAxkxb4hcMpMzSl6eW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkHD5Qko; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkHD5Qko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3134C2BCB0;
	Mon, 11 May 2026 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508368;
	bh=Df7YQtlt1u58ew8l6Y3LcE6eBp8Ob9c95zjKPT1feMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FkHD5QkoYoiTQo6rsfptPtJyyjVmT203uCGrdm3RY3TRoKsGoRzuEBRzTLOM/MoDg
	 MayWcxnF91mKM6xXDqXD9sGLU9DDrFF/Wd0FcMZBhsbYliBwps+T+lJ6mRl4OaaReO
	 AlharA0hbNn+y6DBkFP+QQAyvIrUPUFzFmpPv9Aeut02HsJDMZ8DCG5+AYe4QiH1Jo
	 8RHEPoYqRTLWsqkE6/OR/o79ST9ZtLIw1kKnllAjVgvLKKr3BbYRA+dtRv8sj5b0ws
	 pNwKalE2Qqrlt/eCvy2KefMfl81e24Y17AgpykKyxL2jc/Kn4MflcxXJ6feg6RoApD
	 oitkf0c1mdkoQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:34 +0200
Subject: [PATCH 6/8] mm/bootmem_info: stop marking mem_section_usage as
 MIX_SECTION_INFO
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-bootmem_info_prep-v1-6-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
In-Reply-To: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

We never free the ms->usage data for boot memory sections (see
section_deactivate()). And to identify whether ms->usage was allocated
from memblock, we simply identify it by looking at PG_reserved.

Consequently, there is no need to mark ms->usage as MIX_SECTION_INFO.
Let's just stop doing that.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/bootmem_info.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index cce1d560f094..0fa78db7fbc0 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -38,10 +38,8 @@ void put_page_bootmem(struct page *page)
 
 static void __init register_page_bootmem_info_section(unsigned long start_pfn)
 {
-	unsigned long mapsize, section_nr, i;
+	unsigned long section_nr;
 	struct mem_section *ms;
-	struct mem_section_usage *usage;
-	struct page *page;
 
 	start_pfn = SECTION_ALIGN_DOWN(start_pfn);
 	section_nr = pfn_to_section_nr(start_pfn);
@@ -50,14 +48,6 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
 	if (!preinited_vmemmap_section(ms))
 		register_page_bootmem_memmap(section_nr, pfn_to_page(start_pfn),
 					     PAGES_PER_SECTION);
-
-	usage = ms->usage;
-	page = virt_to_page(usage);
-
-	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
-
-	for (i = 0; i < mapsize; i++, page++)
-		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
 }
 
 void __init register_page_bootmem_info_node(struct pglist_data *pgdat)

-- 
2.43.0

