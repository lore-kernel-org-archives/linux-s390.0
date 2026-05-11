Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64FC3A1D05;
	Mon, 11 May 2026 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508353; cv=none; b=jWDH2dyiBiOhZ0yYx2U3facnVBPGGjzDnnXUa8pz8KbCM9IcJaPeEMmlmBKu72h0JbyMw/o1EepTVyJ/yvC61VpVGCj4yybHWAjyyAIxoWjIkw/gGLLYLSXCfgzpavL61GrnwYgXqLR19OUnwGBL2uguAq/JNwAgVC/aHCpIFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508353; c=relaxed/simple;
	bh=/pOfZWbC9cprP4CiwJVpUWxqpXHz/aiDjfQglaSBebg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4SpvQQCFZ3xQNolTmyORCGxo0lvvgKFc90QV1ZejlZRkRkpjVbLKcOIjB2NgoczOm6IhmJgTxlyRD7vUpjWeCxYvUhyhF/X4/Yg6UJeaU7ASymhELwHEvx/ABaJvOAr5Xwmnjg7ZyEVnEaTrB8Xqy/x9av+Wn5UiaNSiQrPIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFn6rc26; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFn6rc26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2174AC2BCB0;
	Mon, 11 May 2026 14:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508353;
	bh=/pOfZWbC9cprP4CiwJVpUWxqpXHz/aiDjfQglaSBebg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jFn6rc26M9OimLWckkvKk1AgDXLVRQ8KuE9cyARG9LjU74GLBScBL5ialIQnbM93F
	 woMLS+u4RhxAlTgupssA1sorXxYcum1WHRotK0UyqZjoAHHLvfS5PwOCqEMfqH2g8r
	 Cq6VkdIkThwjJBi6COurSnGP5bgL8ouiUkmuGTHsbRH4o4xgsR3kjwiycdRBvsBiO2
	 EqB5/uXejMTMhTCiE4a8cj5wkeQVQTyhoqboCovHIJmID6kpbkjYI8zq+oCBt75XsQ
	 4FAMUU+RPV64+1jg9eyDe2vR8+R3iYSWTAGj2PrJYzw8WeYR7XTO71JWBIFUgLxaAI
	 9DNXm86BpBjXA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:31 +0200
Subject: [PATCH 3/8] mm/bootmem_info: stop using PG_private
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-bootmem_info_prep-v1-3-3fb0be6fc688@kernel.org>
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

Nobody checks PG_private for these pages, and we can happily use
set_page_private() without setting PG_private. So let's just stop
setting/clearing PG_private.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/bootmem_info.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index a0a1ecdec8d0..6e2aaab3dca9 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -19,7 +19,6 @@ void get_page_bootmem(unsigned long info, struct page *page,
 {
 	BUG_ON(type > 0xf);
 	BUG_ON(info > (ULONG_MAX >> 4));
-	SetPagePrivate(page);
 	set_page_private(page, info << 4 | type);
 	page_ref_inc(page);
 }
@@ -32,7 +31,6 @@ void put_page_bootmem(struct page *page)
 	       type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE);
 
 	if (page_ref_dec_return(page) == 1) {
-		ClearPagePrivate(page);
 		set_page_private(page, 0);
 		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
 		free_reserved_page(page);

-- 
2.43.0

