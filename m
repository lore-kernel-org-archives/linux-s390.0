Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBEB373BE7;
	Wed, 16 Sep 2026 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560237; cv=none; b=YHDLk5l5H0cop+5AkD0ONPBXMkmdkgJyPlJocBA0ASmVPEZDboqgd0foNEs0Tf9iXCXIM3eNBojQdTll0wWuTyLR8Gtt6Ir/7UnFedCuV/AN/mC1eF5ZKL/YH5aSSjUaAWGyBFqAt9dWjoQVio3Su8hOSmiIYUC9ei63cNmKXsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560237; c=relaxed/simple;
	bh=4alY3z2W927Ms15LZYZMvwkRWVZRcuBdqTKjuIfVo1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fFTTQ52jBmR1YZqU86xJFzT9N6KLb3lKK+kvPwZS9U7StS3W6hZCkV61xKwKkClSTQPH8/Xd84/tGyaueHdC0RdEa2+s1KtYgdA+Admnb4Kv/LqpsBzNmH86qpAwLqj+EWzpC70F1UzxinzjWVCoaO6gXp3nmUajX1q5qQHZiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6fFas1B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6fFas1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5276F1F0089C;
	Wed, 16 Sep 2026 12:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560226;
	bh=GAESRwUS4AoT8Fe9vxXzcjqr/ANwAvgo8C6M4V7pHvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a6fFas1Bc27pKC1jQ/NkBXM0GYbCXSa82qImbsgbod4ilaTgi9SjJGRCtvOVYxpW/
	 qVcv9GI3uHMODJ7+tRRVAeuCE17oUOTATFrKBEAW3WmjjhF4G1pcXjCztOycunN0oM
	 279Eud8rdiIi3IZFrvyawyqJ8tqiGhG44Sr0xYOz7bG/lmqK2EPx2nXeYWxIG4W/b+
	 XV8Hi5hZn1Y2UrEMatxNrVPWUOflcK4YcrrjYkoEvVH2U6SXDf/HfhTMTifY5eP+AO
	 MCIZKAvRNX1dRS3VCu8JVKs92sxX8UQPmFBoq/R8ZgI3uO+brqUJQ/25Dg7W6liu+B
	 uwGV8ibY/dDLw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 16 Sep 2026 15:03:16 +0300
Subject: [PATCH v3 09/13] s390/qdio_main: Use kzalloc() for the QDR
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-s390-cio-ready-v3-9-39e4894637d6@kernel.org>
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

qdio_allocate() allocates the queue description record (QDR).

This memory can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

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
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/qdio_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 28eb8602ca97e..889f63f94a4a7 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -933,7 +933,7 @@ int qdio_free(struct ccw_device *cdev)
 	mutex_unlock(&irq_ptr->setup_mutex);
 
 	qdio_free_queues(irq_ptr);
-	free_page((unsigned long) irq_ptr->qdr);
+	kfree(irq_ptr->qdr);
 	kfree(irq_ptr->chsc_page);
 	kfree(irq_ptr->ccw);
 	kfree(irq_ptr);
@@ -988,7 +988,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned int no_input_qs,
 		goto err_chsc;
 
 	/* qdr is used in ccw1.cda which is u32 */
-	irq_ptr->qdr = (struct qdr *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	irq_ptr->qdr = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!irq_ptr->qdr)
 		goto err_qdr;
 
@@ -1001,7 +1001,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned int no_input_qs,
 	return 0;
 
 err_queues:
-	free_page((unsigned long) irq_ptr->qdr);
+	kfree(irq_ptr->qdr);
 err_qdr:
 	kfree(irq_ptr->chsc_page);
 err_chsc:

-- 
2.53.0

