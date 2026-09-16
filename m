Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955935AC1C;
	Wed, 16 Sep 2026 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560246; cv=none; b=UcF3q8XzmDdr72GBPjvFs4MyeTKfoqvZ7oIV+Mq5JRYDc8FL7/2L4vHQDvQ+wMVklG0bdtiBmVHPXgp+hK1+PpvML38kRppaWMOUiU30iO/JcufrxQ0fmNJZ2PpRl0VmcNCKV0yIFlrHOLaDleJdeKBYWt5XLH36xlbbpQBCCvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560246; c=relaxed/simple;
	bh=ILeEvtymUiyFn6FXjfwWf9BUERRvcE4G786kxLGajS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTqzOzStnIWVgrECadeESV2sZgLOmFtmQoSORRG+Ji7EwT7CgLi0ILXe+CfsNyGLreNii61fJApWbSkWR8k26Cuzb9jR5nl8qoAtDMpCpkR2rPP7XDG4Gx6PW59iabWzBnHohbxh5Li6sZhjP2qI4V3mEQwPzMYK8phy3aKfTQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml42hJBd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml42hJBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1C71F00899;
	Wed, 16 Sep 2026 12:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560232;
	bh=JO8zvszsozs4GkpHmyopZ7vErLCjHtSqmQPyVsRODfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ml42hJBdAQr2V10Uh2pmfR0pjHqFBHJj6PovDXwc8vewjqQGxlDhnIsDti0bpmfWy
	 qbcEynQD9O5UPH8qDpVSiyp7gR8W5fD10rfET67Dt1I/887weT9JoDXcW6ztZHOMEA
	 ZnS1R2vaQy2Z28heQ7hU6pB0wdeEqqPFKA+36oh8IGv5aULa5t9GvmzW0BcXls50mf
	 gHCOUdOBZkRK7++WyPFy2Gu0KrWQE2KlgRTn/hLip7vZ0s8+rwdaIHZa1np+GSIGud
	 xPUIUvIaOq7dEUBXw/UbQtzvvTCmX64FMucBy98Id0Aj2ELEnBk1BjrIOtK/qJjvgq
	 32Fq2RNvXUMIg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 16 Sep 2026 15:03:18 +0300
Subject: [PATCH v3 11/13] s390/qdio_setup: Use kmalloc() for the storage
 list
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-s390-cio-ready-v3-11-39e4894637d6@kernel.org>
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

__qdio_allocate_qs() allocates the storage list information block of a
queue.

This memory can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/qdio_setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index b6f2ff202fe64..d8e9c0872d15d 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -83,7 +83,7 @@ static void __qdio_free_queues(struct qdio_q **queues, unsigned int count)
 
 	for (i = 0; i < count; i++) {
 		q = queues[i];
-		free_page((unsigned long)q->sl_page);
+		kfree(q->sl_page);
 		kmem_cache_free(qdio_q_cache, q);
 	}
 }
@@ -109,7 +109,7 @@ static int __qdio_allocate_qs(struct qdio_q **irq_ptr_qs, int nr_queues)
 			return -ENOMEM;
 		}
 
-		q->sl_page = (void *)__get_free_page(GFP_KERNEL);
+		q->sl_page = kmalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!q->sl_page) {
 			kmem_cache_free(qdio_q_cache, q);
 			__qdio_free_queues(irq_ptr_qs, i);

-- 
2.53.0

