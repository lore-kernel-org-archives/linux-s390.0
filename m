Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E93ED113;
	Mon, 11 May 2026 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508363; cv=none; b=KGOMfeWn6Fb3AN0MF6+GSXFNPQZR6fLEnYv25WvUGK3GJLhzTBKPqb0R10XnS8le9GUuzih2Hps49UqQSzHoKC8seulWTZQLd1aZISjGKEvl/afSvlkJqHzDR+gF1ZCZrH4yYnb/nR0RLihF+QzNDweShBJ05f6U8BIU8+zxC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508363; c=relaxed/simple;
	bh=MFrlSNsTp04kT+A7ReVQ6q1RUJiMOyuWN+whgS79KCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HadTFk+p5GhqFno/qEY3BhYMYFTydQ/DJjaHRy8eQrYYN2H1NdNGLSj0wWuFkkeMBsHQMI3JeXSiSSetjjzyBtdTmg1SPa9TrpKoKVS12im9LRz3EC/1XSShgdT3EJIgL870Ini3gwNW7bb+yFIP7aQ+hObmbTrWQL1CmDKegBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzzaUGht; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzzaUGht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A89C2BCC9;
	Mon, 11 May 2026 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508363;
	bh=MFrlSNsTp04kT+A7ReVQ6q1RUJiMOyuWN+whgS79KCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VzzaUGhtjmv+hgICpWb9Ds9RkOduoJ8mQ0Y/DcgBVY2dFaaRVfcVxiN2SbUKQuwiL
	 o7eRr+5Toxr4lABnCNoOTIMMN4aJ7fOgqOVvyGtkdg6QrUqs7rUeaGOqi3u1nVPDkg
	 Ksz0MxzCsMSNEnnyFYKhliTDT4hT3Njg5ZT2r8cMD3/8wzL/mBhdvfWXpE7D+1LW98
	 rN7lvX13lEtdJbla8okiBqaGSKrxpTp5HtBwVqWJp27YyraoMyd04koJ5hVKbMZSfn
	 dFRNDUbp6ZtPNR/BNeg+D8gkJkfsmTb8oqE4KzJl4JXpHPBQHLEyE3u3AiI6BbVR9e
	 ixKjUMbFwUVSQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:33 +0200
Subject: [PATCH 5/8] mm/bootmem_info: stop marking the pgdat as NODE_INFO
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-bootmem_info_prep-v1-5-3fb0be6fc688@kernel.org>
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

We removed the last user of NODE_INFO in commit 119c31caa59e ("mm/sparse:
remove !CONFIG_SPARSEMEM_VMEMMAP leftovers for CONFIG_MEMORY_HOTPLUG").

But it really was never used it besides for safety-checks ever since it was
introduced in commit 04753278769f ("memory hotplug: register section/node
id to free"), where we had the comment:

	5) The node information like pgdat has similar issues. But, this
	   will be able to be solved too by this.
	   (Not implemented yet, but, remembering node id in the pages.)

Of course, that never happened, and we are not planning on freeing the
node data (pgdat/pglist_data), during memory hotunplug.

So let's just stop marking the pgdat as NODE_INFO.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/bootmem_info.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index 74c1116626c8..cce1d560f094 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -62,15 +62,8 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
 
 void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
 {
-	unsigned long i, pfn, end_pfn, nr_pages;
+	unsigned long pfn, end_pfn;
 	int node = pgdat->node_id;
-	struct page *page;
-
-	nr_pages = PAGE_ALIGN(sizeof(struct pglist_data)) >> PAGE_SHIFT;
-	page = virt_to_page(pgdat);
-
-	for (i = 0; i < nr_pages; i++, page++)
-		get_page_bootmem(node, page, NODE_INFO);
 
 	pfn = pgdat->node_start_pfn;
 	end_pfn = pgdat_end_pfn(pgdat);

-- 
2.43.0

