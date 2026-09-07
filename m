Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C9A466B0B;
	Mon,  7 Sep 2026 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776654; cv=none; b=CgTfCII0Ei4/oQu7ZbpOH4hL5DKyLwPJ7+JAu58m/xB+MmcWQrbQSuIXPHthE3ZHFGmPIi1VCpv/KJT+WOqhI52AhSmUyYZDpGjR6WFIyleN/R+iNVtRmPe34cAKUDTgoJNj0Bk7V9wLmPlAu3Bf9D8o0bCu6uc+AhHHQB10yPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776654; c=relaxed/simple;
	bh=Wz9lw37vgc/zsfAcUFmqMX4aeUHgIcVMtzl7BxRqOx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NQSWEH5+wi0s9kW3DYSI7dBpydxL/wBuO/yOITCr0EsTRxeOXt+CO1NGK0TXYBTU5epOXdMx2h6W63tBB1QqipICZsuCjyXshSqiiKXlDy54xdXaM+d63EiQQlHSQnzksFVTKSHYn1wZ0RatloA9rTEomax3+sXkl9c8FO6kvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEYhKzO9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEYhKzO9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D74F1F00A3A;
	Mon,  7 Sep 2026 10:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776652;
	bh=y/TW8KJTz/sa6Ud6LR0Wgj8IHB3N+btY5TCgJ/dBLmI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OEYhKzO9+sk1gMdKkphyEDFcX2mlBenng2D7KchSJuCA/ESqNbfTZvZN/KL3GBeZx
	 c0XGEyzO8EI49L6GSX1No0XvyFgmdikTGEXiSn+GhrNNQRaZ4J9EU7WMFNovP09hDT
	 zv/Lwe6IXGB1oaPx1EpALYwBuHk/Mt6HAKlxKPTGbHOPdu/PYqD8CWAx9O1vGQv38T
	 9g1T2RSM8Ani2MntBskgISidwlgl+vQkmFRCDMIfcJTxL0g1pnkZnY+1srZbM8W27Y
	 Vt4G3iFCBa8mSAkFtiEkAxWB4dqHFuvCUmaQUzdXWb6y8TL2vAYlo03wj7UkvUmNCL
	 ngXncbEY02Sww==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 07 Sep 2026 13:23:47 +0300
Subject: [PATCH 06/13] s390/cmf: Use kmalloc() for the CMB area
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-s390-cio-ready-v1-6-ca7f39806234@kernel.org>
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

The measurement block origin must be page aligned and kmalloc()
guarantees that a power of two sized allocation is aligned to its size.

Replace use of __get_free_pages() with kmalloc() and free_pages() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/cio/cmf.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index 92ab3d546fe47..6c46b0d0b3da4 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -501,12 +501,12 @@ static int alloc_cmb(struct ccw_device *cdev)
 		WARN_ON(!list_empty(&cmb_area.list));
 
 		spin_unlock(&cmb_area.lock);
-		mem = (void *)__get_free_pages(GFP_KERNEL, get_order(size));
+		mem = kmalloc(PAGE_SIZE << get_order(size), GFP_KERNEL);
 		spin_lock(&cmb_area.lock);
 
 		if (cmb_area.mem) {
 			/* ok, another thread was faster */
-			free_pages((unsigned long)mem, get_order(size));
+			kfree(mem);
 		} else if (!mem) {
 			/* no luck */
 			ret = -ENOMEM;
@@ -547,10 +547,8 @@ static void free_cmb(struct ccw_device *cdev)
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

