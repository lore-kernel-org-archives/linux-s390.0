Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D346984A;
	Mon,  7 Sep 2026 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776657; cv=none; b=If4NwJiqyKmUflvdJomJRN1ZYvDdiCgd3+KixLwbqiSTL+owgF6IsI0M3CsOcIMW4c24Cy5wu1o7dUHXetgKr+H7IJjT4P94kCPVfWeMYmNRhOpYloo13WL/6oISLY5xFIKKyAEJHwuuyR90YQY9CAaX0xE+oSKYwwWHZRV5gxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776657; c=relaxed/simple;
	bh=YFe5aklWntOgT5nQimw/7kgNgaa9z7nEQspTYutJFVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcuZfmkujUn7N9o/nWWeORmdJA79Q/eo8VTbzf9BUYoH0WenV3MsP+GW6PxgC43Fu1/LZL5Q3sWLccGHfbV+Psh/aQArpJGK7ZEgYujeF2CsWo/OGxShX7L5WY/DUlIcv7bNtLHm+YP6WnkhSCrOxPludopy1G4OwzSk5pbFNOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQD1u0iZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQD1u0iZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90AD1F00A3D;
	Mon,  7 Sep 2026 10:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776655;
	bh=3tq+MmVWpxNrmq2a43GAPaqrd07nxrFSLnxvA2070ww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iQD1u0iZXJqJOENikM9GGerBxb8HEccexTEau4VGA63cDIw4BSsatuxl3gWwXTGHD
	 SYXN6vXKEMpzfU0RJMP6W4FH2rhsJoTPQeTj7QHO8C0BWaxsMML3kCjlpb7QCoZKfQ
	 HpVTv++GYxSCjuiwXe/BBHNmUp4QPXsHrsthDtPMM1Rxb0Y4cwd1aw2Kui8gZBVUYT
	 Noc0z5jJcIPQCzNMgltOivv+y3/paJNswKpY+/UTwGIRQfEGN+JynsFmHrZUc0T5Qq
	 XuRfX9zWEKCRG0RM6+4yvfkw1+XYcI3d+exQortSfRKNF49MWRXYLDSJQx9XLHPb1g
	 +9syUsDnG4AWw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 07 Sep 2026 13:23:48 +0300
Subject: [PATCH 07/13] s390/idals: Use kmalloc() for IDAL data buffers
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-s390-cio-ready-v1-7-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
In-Reply-To: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Mike Rapoport <rppt@kernel.org>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.17-dev

idal_buffer_alloc() allocates the data chunks of an IDAL buffer that is
used for channel I/O.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_pages() with kmalloc() and free_pages() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/include/asm/idals.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/idals.h b/arch/s390/include/asm/idals.h
index 06e1ec2afd5af..248829d461bce 100644
--- a/arch/s390/include/asm/idals.h
+++ b/arch/s390/include/asm/idals.h
@@ -147,7 +147,7 @@ static inline struct idal_buffer *idal_buffer_alloc(size_t size, int page_order)
 			ib->data[i] = dma64_add(ib->data[i - 1], IDA_BLOCK_SIZE);
 			continue;
 		}
-		vaddr = (void *)__get_free_pages(GFP_KERNEL, page_order);
+		vaddr = kmalloc(PAGE_SIZE << page_order, GFP_KERNEL);
 		if (!vaddr)
 			goto error;
 		ib->data[i] = virt_to_dma64(vaddr);
@@ -157,7 +157,7 @@ static inline struct idal_buffer *idal_buffer_alloc(size_t size, int page_order)
 	while (i >= nr_chunks) {
 		i -= nr_chunks;
 		vaddr = dma64_to_virt(ib->data[i]);
-		free_pages((unsigned long)vaddr, ib->page_order);
+		kfree(vaddr);
 	}
 	kfree(ib);
 	return ERR_PTR(-ENOMEM);
@@ -175,7 +175,7 @@ static inline void idal_buffer_free(struct idal_buffer *ib)
 	nr_chunks = (PAGE_SIZE << ib->page_order) >> IDA_SIZE_SHIFT;
 	for (i = 0; i < nr_ptrs; i += nr_chunks) {
 		vaddr = dma64_to_virt(ib->data[i]);
-		free_pages((unsigned long)vaddr, ib->page_order);
+		kfree(vaddr);
 	}
 	kfree(ib);
 }

-- 
2.53.0

