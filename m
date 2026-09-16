Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875BC42668B;
	Wed, 16 Sep 2026 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560232; cv=none; b=i9PEY8t2ByxBhOZRP/nPMcy3Ng9uy4f7oULciogNW+VuFMgfzW/727QW1i/PGoyFZG+UYEvQabb64u29JjjF/XJywSYzFdxxoWbaHVfiRehpF7m/FelLYipYvLTbHQp3RACbIO1EkvzeKB+GWwc7XrFc9tSx5pTv4NWFYGEjzug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560232; c=relaxed/simple;
	bh=/Q+UndceaLElGRuOMnjLND2Cqzr3OFYfCjs9ZisM8t4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BZRMhYX9VV5hkFOO5lqeFCsA+Yv4gFYMV41Sq1X/3/Fb+bY9SKhjB5wd4exa+Fohb5mXfpCpIywRVaNZZFTMa7WKWrt+XQdTW4DkMai+NiBIkvHgatMCIpHc6ZTPIs1EimNwhb5gUyDEYv7ujdK2rRhctcI09juN7PhA7QWXPsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loxsFHy/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loxsFHy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ECF1F0089A;
	Wed, 16 Sep 2026 12:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560216;
	bh=kEZ6nz/JFEHq+6k02cM7QTBhs2+peJoyslzMnyOEfRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=loxsFHy/1eGz0qgPCeXN17uzD1ptVS/Qxc+rDq4qznAMqIVmpl8x1bPXVz5v78gGp
	 E+G037KiAiF17UQYrBj1C+2W71dMxMfTyy3ALvNjsrgjwwAZVOz/P4Ro0Y+qG95ij7
	 itVTEszggQCYKVFrYbDdNc+Fn2YpsR2xhwG7rOxTFF5BJr6p8N/b6YBsqzobih9x4o
	 ie1WGvsiiiF/P+/HmzjazSjiCv/4ZTAmi83l0qCDxHJTCh/15Ar6X704M3PAE8D6E6
	 0MEg+Pw6SzS2yKFpJWlhEqeuu1UG8qyjCVIquA4Dv3BgNvN5XgcddFG5N7Y2muRF7P
	 iu+6kR7AqO/lw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 16 Sep 2026 15:03:13 +0300
Subject: [PATCH v3 06/13] s390/cmf: Use kmalloc() for the CMB area
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-s390-cio-ready-v3-6-39e4894637d6@kernel.org>
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

