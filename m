Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920823;
	b=vjKnO7Db821sPZ5BIRkzl9L5PfmXfzwgfZOHtDrkEP0fCAFbS3/2/Y7xj28mRDL/OSsG
	 eLvXNoLVHL0Cd3E26D/80zh+K13f3WI43jPw7bCEznSeTsDBi6QLJ1WTMX8brmyFyiTfp
	 zarWyXHSJ0Hub95eDT8BGPJyQxBbDI+TUfVORh5Q6Ttfwf90tHig+CL3cI32kLv+k2uUZ
	 5YyHfgAWUmQOb8O1BO5YMS9D/I2OVWRcoaSZOdonbI92BMZsR3bMA0O0wUSBWJhvAYDPK
	 DsW2WyBxUBnYsTnLAuEGrz992j6v/Mt50LWpDCU8xXbtRrUBPyGtTCemufN9n2cjrWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920823;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=T0wDH7EIIn793eoNPou6qrdwgP73podZGEO7sZLmZIE=;
	b=RP7G1cSc8+EPI4+J4vWCsD4srr/jyP+KVA3MM8mL/0iDT91y0h61iBsIlXfkoBYUh/Wo
	 S1vejV8GnWBYHoRxrzwrPEHu+VjxRIn7JB8W/5ajkues86B4ouaKUQeegmttGLlgZTKHm
	 FsA9pvFM4WvrSWTRBv0P6spHpGRSU+4SX/YpOQMultF8VhjdShbjsE8xCldWuV4D3KLVF
	 yzlJp+rg+epPRSDtoFz74Ym5qp6whqvN+NTFnZhlY9paszTVZfzZrz/Uv/ZlIDrPqW18o
	 fMTxF1icQvmDGc3lsMuYhCSCqyo32FDFA+mMov4naYYt4wqWVYH4HarYWLIpM8gbRuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqhj+g+2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6791606A88B;
	Tue, 17 Nov 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqhj+g+2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255FB1F00926;
	Tue, 17 Nov 2026 13:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920823;
	bh=T0wDH7EIIn793eoNPou6qrdwgP73podZGEO7sZLmZIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kqhj+g+2uD3rzmQIjibcu68U3XmSPowcT99xB2eE0pAmKLpy6Hqaz6H1BM7hGlpsY
	 I/5uPm2CFtIM/sN71IkcuL22UNym7Hu8VNCKG9LWaALv3mWih/rdkz+AYzbwGzXUyX
	 48ixhblGVMtZl4L715qXVevqkLPQzlyaOi/QeAI5TtjPb++iV28bWABPb2wY4PCERw
	 Xp8vIFRP+tiVBHCxqazazL4Kvg1XDNlGVBA4KDKxIz6QwvfQaOSki6ddUMTd7yzxJq
	 gpvvaA8hlpaHQgopcr0cl+eMfikiCjF1oo+bAjd2aACEDRh8HdBntqun9QGv/wxtMo
	 WYJGAKMQo6ktQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 17 Nov 2026 15:06:53 +0200
Subject: [PATCH v2 01/14] s390/sclp_vt220: Replace get_zeroed_page() with
 kzalloc()
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-s390-sclp-ready-v2-1-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
In-Reply-To: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Sven Schnelle <svens@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org
X-Mailer: b4 0.16.1-dev

__sclp_vt220_init() allocates the SCCBs that are used as the output
buffers of the VT220 console driver.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/char/sclp_vt220.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index b95af0974624..e79467c07d24 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -715,7 +715,7 @@ static void __init __sclp_vt220_free_pages(void)
 
 	list_for_each_safe(page, p, &sclp_vt220_empty) {
 		list_del(page);
-		free_page((unsigned long) page);
+		kfree(page);
 	}
 }
 
@@ -750,7 +750,7 @@ static int __init __sclp_vt220_init(int num_pages)
 	/* Allocate pages for output buffering */
 	rc = -ENOMEM;
 	for (i = 0; i < num_pages; i++) {
-		page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		page = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 		if (!page)
 			goto out;
 		list_add_tail(page, &sclp_vt220_empty);

-- 
2.53.0

