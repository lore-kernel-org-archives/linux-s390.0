Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F36472072;
	Thu, 10 Sep 2026 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038034; cv=none; b=uZR+bbfdw3K4r5Tk/O4SKXBzw8Vi84yoMVOtwpGq0L2D/3vr934FM0MmvugJTvfWYCZTP9CE0HLGgpI13GPxktemr0m+v+xqxBnDCVTaeV9RvgLq4mGwxJARO2Xeom6IYduaVSPH0YlLRQZuXP2WtmCHjJsThz8/jbqH2lzJKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038034; c=relaxed/simple;
	bh=rdcrVC0BA24TZWlwPcwV+Z6oi8PioFMGwbQn+fYuYnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=srxZ3a8KuprRh37IioPhW3xmHubgzGLOMaCxagwVhsdZzGXSvSfwPubg4o6KJ/9Xb3dC9r6iHzga+68pOlOD5/oGPVoY+uMSS3VFJVZTO7kIItXGtpbe0qAjShj7OkLaXx/qXqjnzS3Vd3r6tCxCnMg9K8V0kBPQqtKQO8iQlSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwJMnW0u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwJMnW0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369BA1F00893;
	Thu, 10 Sep 2026 11:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038033;
	bh=bAVP4y79lmB0kd35IBqs2N16e6jwAfNVV+NWInsx3B8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QwJMnW0uXEnOlhVjMZA3ChXQrzqwPzdD00tByvpMjpZhbWPYw2EJdfVvtch3h/gZS
	 G8mh1fgKfpv7AA3MQn35gggwdWJqOOt2ofz18QG2rJT8R953CBCiPLjyEKF49uqLnV
	 q+EQ8WmHBUuk8iQhRrfrGrGExi9FTJn+tmDTlhkm57GGQd9AruTdroDxlPuerbDl3C
	 zdEQE9V5Q5uiApj3qDzkEd2l9IzAmVxfy8hwd1UtOad7tfAX7gF4+7ggrj70cCZZqF
	 8aGTdeEAocc03X2vN+/KbDM2SEyEEyymgz2CH1VaZpf7oHPgD6/ZQxzdUlPElKMchr
	 VjgvEuvNpQnLg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 10 Sep 2026 14:00:09 +0300
Subject: [PATCH v2 07/13] s390/idals: Use kmalloc() for IDAL data buffers
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-s390-cio-ready-v2-7-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
In-Reply-To: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
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

