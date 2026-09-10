Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD3472543;
	Thu, 10 Sep 2026 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038044; cv=none; b=prFPbDATX1W4ITSwK2DFlKAmiPGgugO0/j/68aKwAQJGfdYIlfmgrJYQ2ChqhhrX6121QNlUyPqzZ6vYBvlg0JKQJBwBdhUhv7Hbgo0CT9lfFqkEXPobiRCgzMmmTkZFOY60NrWtPrHrbbvrX2R46pQFp7WnNuX3FIjU1+AnFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038044; c=relaxed/simple;
	bh=py2j1Mb0iGfPkNln0c3I0yAAV0xNwtsE2Kq4knjbP0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hddUnUHu5vkK7OewiNRJRI/bH4tTvwa9PMfp7jPSoHMRyt5jU8ad7V/ZXUc57ZRBNFy9xwSI5fgWJnqRydEEomk1f1nWrI6963i379oMu0UVxEC9uDQewCJNxfuhCH/w6xiZg+wpkfLNcRxQ+pxHq94gICtNvW4eWqSa4z9eVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpmwVDWP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpmwVDWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129041F000FF;
	Thu, 10 Sep 2026 11:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038042;
	bh=LB6kX+FFwnDBpk8VzIo69FZJtwl3A5eOSrIP15c/e4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jpmwVDWPGtwMq+bse73BBAXPLxdFo/PuhmwQ6g+42F7+Bm8HB6e3qf2i8rqPqHj7k
	 6Ep5rX6QaLg0XF02kXeSk92E9O+44smp4nzr77/ZGQKwHfX2qnDxpIh7qrxeTOwfkZ
	 6/btxiSo1yTZB5uGpw/MYUOltmW/1ch4vD7hKw1yvcy1Es88vnM6GuOBXsSixwcaFl
	 QIW305pHBgAFWWa9cyp9WU2W+NpBS9c+fJbuHv6Cah/a8GV9z3Xj/EefE5h1B3GpGo
	 Culqtq2TZbNWfSEc2uRF65xhFaNffRmjcFTRuXDmuO2CB6pW6F7ZZuVAf6g9lJsNSA
	 XvCZ1citPFn/A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 10 Sep 2026 14:00:12 +0300
Subject: [PATCH v2 10/13] s390/qdio_setup: Use kzalloc() for QDIO buffers
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-s390-cio-ready-v2-10-e931086fdde1@kernel.org>
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

