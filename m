Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3BC47126A;
	Thu, 10 Sep 2026 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038031; cv=none; b=bu3SOjwZh/MkvKt9vqikbASKDGa6A1SfDv9jujAzYiuEmsokzahPmXg+s9G9ZmSyv2558K02eu2T4k3LKQ7nJhcp7J5oUcCDpVmSzxGwzchBLB/flsZ0fkRPlCj0V58db75DAoyomTAY0m/DnnsV+bY93luyOFGP01lFhTZu/ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038031; c=relaxed/simple;
	bh=/Q+UndceaLElGRuOMnjLND2Cqzr3OFYfCjs9ZisM8t4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9L2JyNVdaSDgKAxbd6rI3DAR995JL/ug0icHsHuS5P0XGNCHV3Y0djGor09O6iExrAI9PWuT/k3olsRdpmtSpRY3yJvne3FqZj1gkcK31FpZgERlC40jZE6LNh0zIAEZ4YlWeLRmGvXCuyjyCKGyVU+0D2+XAJ8IE9zHJ8bicc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUSLtGkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUSLtGkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02D71F000FF;
	Thu, 10 Sep 2026 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038029;
	bh=kEZ6nz/JFEHq+6k02cM7QTBhs2+peJoyslzMnyOEfRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PUSLtGkWdQoW+cSKLEstDTvjtTeqxWgpfsBiiGWDFJ6/TgdE8RnkfKbvYkWH/mxQq
	 iUD1GMaIaoNEzflLY2zAsXaOXhLynyxr7XCAvjSidp0vG+Vlvpv1umfrZBFuiD+q4J
	 vMN83RdUZQ/KPVcNidMa0lqABo/fOw/x4yahPoo8IiglMd0D2/43P5RRDSNf/AiNOZ
	 B0CVFCFz5ZgnHe0oSLZFnDjvOO/B2T/TzHSRHyKLeRjC+cwqEULVvkA8uN5R4I9TJ9
	 E5bjtHmqPaP86CNViLqsXoTbKl8X34Gxt08GmhG4jkmeu3a60XAy8Au3/CHJ58ob3a
	 a0Hvww47S/I/w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 10 Sep 2026 14:00:08 +0300
Subject: [PATCH v2 06/13] s390/cmf: Use kmalloc() for the CMB area
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-s390-cio-ready-v2-6-e931086fdde1@kernel.org>
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

alloc_cmb() allocates the channel measurement block area shared by
devices using the basic channel measurement format.

This memory can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

The measurement block origin must be 32-byte aligned. Each CMB is
32 bytes, so kmalloc() provides the required alignment without rounding
the allocation to a power-of-two number of pages. Reject an empty area
before allocating it.

Replace use of __get_free_pages() with kmalloc() and free_pages() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/cmf.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index 92ab3d546fe47..8fd41a7dfc20b 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -482,6 +482,9 @@ static int alloc_cmb(struct ccw_device *cdev)
 	ssize_t size;
 	struct cmb_data *cmb_data;
 
+	if (cmb_area.num_channels <= 0)
+		return -ENOMEM;
+
 	/* Allocate private cmb_data. */
 	cmb_data = kzalloc_obj(struct cmb_data);
 	if (!cmb_data)
@@ -501,12 +504,12 @@ static int alloc_cmb(struct ccw_device *cdev)
 		WARN_ON(!list_empty(&cmb_area.list));
 
 		spin_unlock(&cmb_area.lock);
-		mem = (void *)__get_free_pages(GFP_KERNEL, get_order(size));
+		mem = kmalloc(size, GFP_KERNEL);
 		spin_lock(&cmb_area.lock);
 
 		if (cmb_area.mem) {
 			/* ok, another thread was faster */
-			free_pages((unsigned long)mem, get_order(size));
+			kfree(mem);
 		} else if (!mem) {
 			/* no luck */
 			ret = -ENOMEM;
@@ -547,10 +550,8 @@ static void free_cmb(struct ccw_device *cdev)
 	list_del_init(&priv->cmb_list);
 
 	if (list_empty(&cmb_area.list)) {
-		ssize_t size;
-		size = sizeof(struct cmb) * cmb_area.num_channels;
 		cmf_activate(NULL, CMF_OFF);
-		free_pages((unsigned long)cmb_area.mem, get_order(size));
+		kfree(cmb_area.mem);
 		cmb_area.mem = NULL;
 	}
 	spin_unlock_irq(cdev->ccwlock);

-- 
2.53.0

