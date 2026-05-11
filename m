Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1993A1D05;
	Mon, 11 May 2026 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508358; cv=none; b=g9mrHXa0Id8o92NuFTqG03S6N+6wOlZMjes1S83tHvNf24Ku1x68U3ojFXFeD2kMMLNOcoFyhIjVLKfzKRlEcta+xnfw8kCvqGjsUBXIX2TB8T3HEdgTNdJ5pnR3aM+BN/f/lXsjWTiEKRpeRMNYTtrwBfKqo01xnXLojlNC/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508358; c=relaxed/simple;
	bh=0Ocue3eCm7kftjDOEvgMIfcEU6dPF7QGnIf4HYzbk1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GCeVyepad+jHFzhtZigZsQpPmFRsZ11T702KLBVr3V8nOJQPcOzSfwXdFIJc61ogEAJj6DUoh8sWvLhh9zH1XGRqm9oLTgcvR+qvOgr9Tx17bz4lCpE03w90HAHeoJX3LMtFZKcziJ/xf728ZGHFMIlyacnE7Kjie+PnvHO+/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kohAm45R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kohAm45R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A68AC2BCB0;
	Mon, 11 May 2026 14:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508358;
	bh=0Ocue3eCm7kftjDOEvgMIfcEU6dPF7QGnIf4HYzbk1E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kohAm45Rpj0GtsJc339+4HuV+qMJDQGo+OaGrUlsvRENMLfGC7yd+8Am9w+nMsbot
	 lj6c+L4Z1u6qvm6mkjovGEmaHCIyIMXnG7LyJQpkgojs5UXrNFgpWefy6AwbnY5C1z
	 ty2kfu8/5ma/3T+/lZKlKFaDOGpcpGI/QWxfqZjZNw2uJlzHEDnZjf6L6VSMEqPIiI
	 AW+6ECoossl3ODeBCgdyyUGa1ibx5REXX3G95YbmSUcDkQIkm4h6rzaV3iCdE20VEm
	 omnCjbI3KzvVWJnQ8H1EH6BJI5eh2E/YkK6veo2XPHKLx0TNxDaFyDiqrm2Xf0StNx
	 ljcaeng7fr+ig==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:32 +0200
Subject: [PATCH 4/8] mm/bootmem_info: remove call to
 kmemleak_free_part_phys()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-bootmem_info_prep-v1-4-3fb0be6fc688@kernel.org>
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

The call to kmemleak_free_part_phys() was added in 2022 in
commit dd0ff4d12dd2 ("bootmem: remove the vmemmap pages from kmemleak in
put_page_bootmem").

In 2025, commit b2aad24b5333 ("mm/memmap: prevent double scanning of memmap
by kmemleak") started to use MEMBLOCK_ALLOC_NOLEAKTRACE when allocating
the memmap to skip the kmemleak_alloc_phys() in the buddy.

So remove the call to kmemleak_free_part_phys(). If this would still
be required for other purposes, either free_reserved_page() should take
care of it, or selected users.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/bootmem_info.h | 1 -
 mm/bootmem_info.c            | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index 492ceeb1cdf8..f724340755e5 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -82,7 +82,6 @@ static inline void get_page_bootmem(unsigned long info, struct page *page,
 
 static inline void free_bootmem_page(struct page *page)
 {
-	kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
 	free_reserved_page(page);
 }
 #endif
diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index 6e2aaab3dca9..74c1116626c8 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -32,7 +32,6 @@ void put_page_bootmem(struct page *page)
 
 	if (page_ref_dec_return(page) == 1) {
 		set_page_private(page, 0);
-		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
 		free_reserved_page(page);
 	}
 }

-- 
2.43.0

