Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1742A144;
	Wed, 16 Sep 2026 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560232; cv=none; b=t4c2kXYXKJ5MIQJ5XyqA4A/vCMNlPcZvEViLxdYQ/L/+ZWSKRBiHSb7rgOARBTF80Lal0VvtIDn/wrRIWiOeQDdCxVmacUzRv32RK6UpzMbd8QUMv/skWs8VAlhpQAuIgE0iITlwK6qv6ddq00fZ3UgwmtK5frXqZzNEDc8+rxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560232; c=relaxed/simple;
	bh=rdcrVC0BA24TZWlwPcwV+Z6oi8PioFMGwbQn+fYuYnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RbkQViBCL649eSdN813UNonss77vHON1d2MKkxwpeZCeqZc6PQJ3FDXG67cAieF7MlMS2pmAZWhtW1LpqkrCKQ7g4SeBYKUAGrIBydqgWZCSttEelZQ1u8gTS3aACyVOQk0kLdiwfPZKaLt45lH7ZZIXE0K/HTQzk+i9ljPHX90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTt/GeWX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTt/GeWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E9A1F00898;
	Wed, 16 Sep 2026 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560219;
	bh=bAVP4y79lmB0kd35IBqs2N16e6jwAfNVV+NWInsx3B8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VTt/GeWXn4wGm+DCH9mXXJSp7QVqNTomDqScLoOI0DSnG/syZbREC6+JqLFScDMts
	 w0tqRt3zKmQUkvgAzmklD+LuFal6jyosmohlkHuCLIIwGPHMto+6yiGEiM+wZ0d5Bs
	 kS78RGjv9qNlb9LPWA9+YwO+sr76FakD9GmyE/nwWwMjbQYgWFCiZBIvKfdu31jWE0
	 cXw3euA/GWEZYYbqPM+T9khBqET69p5CTMzKFY+CaA77mzvqGH5CeAxAIP3CoeB6pi
	 vgxPCE3YyPBxo0pZG+eg3tv8wr9u6wFz1JPGrlXWOEeWA5+Onijl07DWaSQwiWHwpE
	 bpX9bmZ/1YlHA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 16 Sep 2026 15:03:14 +0300
Subject: [PATCH v3 07/13] s390/idals: Use kmalloc() for IDAL data buffers
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-s390-cio-ready-v3-7-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
In-Reply-To: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
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

While on it, tell kmemleak to ignore the data chunks as only their DMA
addresses are retained in the IDAL buffer.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/include/asm/idals.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/idals.h b/arch/s390/include/asm/idals.h
index 06e1ec2afd5af..213f430a8d33a 100644
--- a/arch/s390/include/asm/idals.h
+++ b/arch/s390/include/asm/idals.h
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/kmemleak.h>
 #include <asm/dma-types.h>
 #include <asm/cio.h>
 
@@ -147,9 +148,11 @@ static inline struct idal_buffer *idal_buffer_alloc(size_t size, int page_order)
 			ib->data[i] = dma64_add(ib->data[i - 1], IDA_BLOCK_SIZE);
 			continue;
 		}
-		vaddr = (void *)__get_free_pages(GFP_KERNEL, page_order);
+		vaddr = kmalloc(PAGE_SIZE << page_order, GFP_KERNEL);
 		if (!vaddr)
 			goto error;
+		/* Only DMA addresses are retained in ib->data. */
+		kmemleak_ignore(vaddr);
 		ib->data[i] = virt_to_dma64(vaddr);
 	}
 	return ib;
@@ -157,7 +160,7 @@ static inline struct idal_buffer *idal_buffer_alloc(size_t size, int page_order)
 	while (i >= nr_chunks) {
 		i -= nr_chunks;
 		vaddr = dma64_to_virt(ib->data[i]);
-		free_pages((unsigned long)vaddr, ib->page_order);
+		kfree(vaddr);
 	}
 	kfree(ib);
 	return ERR_PTR(-ENOMEM);
@@ -175,7 +178,7 @@ static inline void idal_buffer_free(struct idal_buffer *ib)
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

