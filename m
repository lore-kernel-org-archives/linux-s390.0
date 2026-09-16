Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A11A4A92C7;
	Wed, 16 Sep 2026 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560238; cv=none; b=W4R6j6EmLfD8lC6T3luT24fH5rscDetlag6rXDFTLb8GHnrmk2ABRGWl0JNF1iJklyrSfN5Fi1MlBu+I6jiigvEoUfqVTa4rh5XAoWmPSJ+jpmfIki3ioCps9ks+3qyyiI9nPjag5EARWynbja7DLp2OhpMrFHeYvJArMMbMwbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560238; c=relaxed/simple;
	bh=py2j1Mb0iGfPkNln0c3I0yAAV0xNwtsE2Kq4knjbP0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gdl380SE/idp/Tq5hxDi3Gv7mIK2k96R1sftQG+DNWyCwbo5S0Knyyb112Q6AptmUtcLdeorWEANyfC1CIhuGd2KnFWL6uNaIP+/qOGdIPPQt8MfmQAIYEU/OYgxQuRIcqi847q2zrEnL+ifx1u0dhCxp/L8H04/zxqj29bP1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItwhD1Mq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItwhD1Mq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB7D1F00893;
	Wed, 16 Sep 2026 12:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560229;
	bh=LB6kX+FFwnDBpk8VzIo69FZJtwl3A5eOSrIP15c/e4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ItwhD1Mqn6yU8lPHx1IoQyozxF/eTvq0Qux1vlAAkedoiDk4wmAeOmF1QR5HiK+Bq
	 2XWTqo6e94n9BakGBma98xSY2SNzwlOrhv5TwZtacuWlT+dPmd1yZyaXyLtVCFlXP+
	 Ry9lHc31HrH4jv3M55dxPsnFIL48fv07CeiPA9MNMfM6cbZt7elvXntpbCuj06Eh68
	 Ih9s1GKDAJtsDZKWSroBoWB2CA7sVvwddJ+FaFZv/boIGtS1tlFGzjFgNhnSAb6rs1
	 WqtZOQaAkSIGKeHoUwv6I+mdIwJYkLwt2HCbzRTbwpugh3zYKQ0EicYcg4QzmZ6u46
	 9l912jw4GB6ig==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 16 Sep 2026 15:03:17 +0300
Subject: [PATCH v3 10/13] s390/qdio_setup: Use kzalloc() for QDIO buffers
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-s390-cio-ready-v3-10-39e4894637d6@kernel.org>
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

qdio_alloc_buffers() allocates the QDIO buffers.

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
 drivers/s390/cio/qdio_setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index bd80703c174c7..b6f2ff202fe64 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -35,7 +35,7 @@ void qdio_free_buffers(struct qdio_buffer **buf, unsigned int count)
 	int pos;
 
 	for (pos = 0; pos < count; pos += QBUFF_PER_PAGE)
-		free_page((unsigned long) buf[pos]);
+		kfree(buf[pos]);
 }
 EXPORT_SYMBOL_GPL(qdio_free_buffers);
 
@@ -49,7 +49,7 @@ int qdio_alloc_buffers(struct qdio_buffer **buf, unsigned int count)
 	int pos;
 
 	for (pos = 0; pos < count; pos += QBUFF_PER_PAGE) {
-		buf[pos] = (void *) get_zeroed_page(GFP_KERNEL);
+		buf[pos] = kzalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!buf[pos]) {
 			qdio_free_buffers(buf, count);
 			return -ENOMEM;

-- 
2.53.0

