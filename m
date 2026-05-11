Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560FD3F54AB;
	Mon, 11 May 2026 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508349; cv=none; b=jsK5pHfdMT1WwsnSvXlwJJKvjJLOmhstrLdRqlJhDcNgUCcWk0iTP2CPQfsPl1EWobh6b7WeBoGr6VBdhhQWDIhnUNG5Gm5o0+Cp+K7ImBmARc+7eiQyaGakxVtsEmvCjPVoDmA/7s/6lFCub9UYI/GM/RzekN4QOIi7lRTIKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508349; c=relaxed/simple;
	bh=VMme4hNP/eM+ancPCzgwcEMKJqVdjI2yHAw5rPRUmE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E69U764BhU6Cgs5V7KGiTUxjKqQZhonUZXTm2H4GNlKTJo/xwsshxQZNMF3mkYcHiR8/YEwIPYI9KMhmg6fJZl8ssZugUUBzbDFHmEeqGEXyEwlK7k4ufTQZLIp1PQ03Dbtr5LlJ4MGkYiWyiOsj9GgUMUCmVMnF7ljaniYeHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOgjHA25; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOgjHA25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3921EC2BCF7;
	Mon, 11 May 2026 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508348;
	bh=VMme4hNP/eM+ancPCzgwcEMKJqVdjI2yHAw5rPRUmE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hOgjHA251N+AuGQAcHY49+GihQZEWt/kPQGVzFkJ1DoPGaWOYf2DJxFRf0DdPUImS
	 7AIus401fPM2QGs3iwxv6jpqlJe4Ake+N9+d++Dh5t+N4IfV/drPMm1XsSzGr6sec7
	 kSweIR6wwM/Gp0bdaj9g9Trvk2DFZELNPRVBiNsZDa4Tw5gNDgJzIg2l7Jq735fDrr
	 voxt/4ejanfokwg4xolHAwo6eqyi5y95IaMOZ2YO15ilj5nVYqFpZJdXg+FKQzzJv8
	 tCFCjZjobllgHLhyqv2zRnfJ30612QxGV6mbMINrfWztiOi5qzTmqUoCZbQO7mC6Ih
	 oNuEdbrf0mpjg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 11 May 2026 16:05:30 +0200
Subject: [PATCH 2/8] mm/bootmem_info: drop initialization of page->lru
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-bootmem_info_prep-v1-2-3fb0be6fc688@kernel.org>
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

In the past, we used to store the type in page->lru.next, introduced by
commit 5f24ce5fd34c ("thp: remove PG_buddy"). The location changed over
the years; ever since commit 0386aaa6e9c8 ("bootmem: stop using
page->index"), we store it alongside the info in page->private.

Consequently, there is no need to reset page->lru anymore.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/bootmem_info.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index 3d7675a3ae04..a0a1ecdec8d0 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -34,7 +34,6 @@ void put_page_bootmem(struct page *page)
 	if (page_ref_dec_return(page) == 1) {
 		ClearPagePrivate(page);
 		set_page_private(page, 0);
-		INIT_LIST_HEAD(&page->lru);
 		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
 		free_reserved_page(page);
 	}

-- 
2.43.0

