Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1D42DFE1;
	Thu, 16 Jul 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213499; cv=none; b=kzPAyM243WzWzMnvWP2uNjkcYHysw6Jh+Ogpoi+/zRYHvLqnPQhZu8FmrtI+cMceeWuJ9amiG5jXg5TEWuh0ljbU1j9tVhLpJsZl+x7O2gF2GVbBwUderExBB/4BjOcemGOdyjfNagro+OtMrVQZBcTfJsw99W/WYc4cO7akSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213499; c=relaxed/simple;
	bh=l9Eon2DAllHdR7TpivU/G/WNzIVckSN8NOjnlhaieQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVOQ5Usq846Ddrg+h8PAdpm4ySLi7N+UhrFNhYJOcDlE9Q19RNCMxHaqsHwKVOkFlA+GbjJPeMGPCqTxhdQfovldZRT7bH1WlV7/e44gJu//3IA9UgMNk2TwYET1EIBMxgZQ6M3NBAbU1Qs1ybuVaipCuvbXWUTRxz5BDCQd8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhJ8k2KZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhJ8k2KZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB391F000E9;
	Thu, 16 Jul 2026 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213498;
	bh=4s9VNibOd89d9UPHIC3VdfqdIw6cc3uF1PGgnXgGtOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AhJ8k2KZFqliaAqjQf9LzR9AdE9YgK5D5ArxxTLTQgmgSXOf8jfqUAzF8TLTczJRU
	 MJap6wY76tZCjiDj7rclJjZoZ284wlfh4a9aa2DxDdwThMR4DbhDdjbXyWf51LSe+0
	 za+FEvWACbp/mW8KFJcza2s5c8KihKE/0YKLssYt9G1TkWjLEL4V/yPv7M5HlZ09Lw
	 hHenPzKWM1S1Xu683kFXEKUQvU3c9argQzI61tdzPrvTF5xh2nKGMbD+rGIFR019BD
	 G9q005m9cfgBSSWmtpJJbb3wiBvD6eywjwd55FLpuHDU4kufXrC2uDd/KpjQCKcl7h
	 bt4l/fV1Ec2yA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 16 Jul 2026 16:51:03 +0200
Subject: [PATCH v2 04/10] mm/bootmem_info: allow calling
 free_bootmem_page() on pages without a bootmem_type
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-bootmem_info_part2-v2-4-4afc76c73d61@kernel.org>
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

As preparation for further changes, let's temporarily allow freeing
pages that were not previously registered.

This will allow freeing unregistered vmemmap pages allocated during boot
through free_bootmem_page() from hugetlb code, until we fully rip all
of that out.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/bootmem_info.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index f724340755e55..486acc6127039 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -44,12 +44,12 @@ static inline void free_bootmem_page(struct page *page)
 {
 	enum bootmem_type type = bootmem_type(page);
 
-	VM_BUG_ON_PAGE(page_ref_count(page) != 2, page);
-
-	if (type == SECTION_INFO || type == MIX_SECTION_INFO)
+	if (type == SECTION_INFO || type == MIX_SECTION_INFO) {
+		VM_WARN_ON_PAGE(page_ref_count(page) != 2, page);
 		put_page_bootmem(page);
-	else
-		VM_BUG_ON_PAGE(1, page);
+	} else {
+		free_reserved_page(page);
+	}
 }
 #else
 static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)

-- 
2.43.0

