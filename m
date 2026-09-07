Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6B45A2A8;
	Mon,  7 Sep 2026 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776643; cv=none; b=tQx24F5pSrsedBQKLczWUUhIBal3WW9RloIVPCLzVVhLTZMtegMvf2tBlUyiHpnBICLF9453B08piAjVoqyGO63EJFKRmzt1y3nUdIR0ZxBS/yBvFvtrdkeXELxW3n8h/J+/jJ7W2Cqcbx6MDrhYQw+2uKJIMh9dH2OJO73nARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776643; c=relaxed/simple;
	bh=27W7XaDI53ge61OsV1O82PMbVANHyRB3FsKg1gBZ+r0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uqNSp8zbUIKo+at0ZzUSM/pKt5SQOwfEm8j2tZGa+431yQaGhlwLPexN1DR54dKFeF42y8HWk/zoi0qyFALdmL5J4ZC0rj0I2l7I0x21UnNnXYvM8Ip0W7DvCeSdDskTE+lzWUA39LMkzWf6cYXr7NkEQsJ1uiwdC51SRY/MDZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHGV8ioI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHGV8ioI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1811F00A3F;
	Mon,  7 Sep 2026 10:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776642;
	bh=/CjaWpeoftE+Wn2hDoCKbw50T/OskJjYcBztwhRMRzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aHGV8ioIOvddcAtewqb4hGh5f7g1CTeL0/3RgSjclKplWSCHhJxvVr+7LA9tUkY3W
	 CyYjk3PnBbDhEzexWTulCBZ2q0p9mgr1MtrYcRHzay7W9H51gBEzLv/PGQ0wp10tgk
	 yd5iIEEm9NaBTYzucXFmllfgzNo5pcFOMphosVdep+mfDYls9Z5PjAqYXZqIcSrxh8
	 5q1ML6kcDiyxJYE9RWXX16FRKv5nrnqR6/9u2iRLtey2zCJKbM2FanQpKrNvR+UAaZ
	 xeJ6g/0xf7wKPRr2NNHdgMmEO6o9GgfW8JztKEKdT6sEmrto2y2YI7GGOgv8LwPo4u
	 1A9zeVlDpoGgw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 07 Sep 2026 13:23:44 +0300
Subject: [PATCH 03/13] s390/chsc_sch: Use kzalloc() for CHSC requests
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-s390-cio-ready-v1-3-ca7f39806234@kernel.org>
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

The CHSC ioctl handlers allocate request and response areas for
CHSC commands issued on behalf of userspace.

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
 drivers/s390/cio/chsc_sch.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index b6cb8bb8bcc4b..c8d6871d1841e 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -292,7 +292,7 @@ static int chsc_ioctl_start(void __user *user_area)
 	if (!css_general_characteristics.dynio)
 		/* It makes no sense to try. */
 		return -EOPNOTSUPP;
-	chsc_area = (void *)get_zeroed_page(GFP_DMA | GFP_KERNEL);
+	chsc_area = kzalloc(PAGE_SIZE, GFP_DMA | GFP_KERNEL);
 	if (!chsc_area)
 		return -ENOMEM;
 	request = kzalloc_obj(*request);
@@ -321,7 +321,7 @@ static int chsc_ioctl_start(void __user *user_area)
 	snprintf(dbf, sizeof(dbf), "ret:%d", ret);
 	CHSC_LOG(0, dbf);
 	kfree(request);
-	free_page((unsigned long)chsc_area);
+	kfree(chsc_area);
 	return ret;
 }
 
@@ -340,7 +340,7 @@ static int chsc_ioctl_on_close_set(void __user *user_area)
 		ret = -ENOMEM;
 		goto out_unlock;
 	}
-	on_close_chsc_area = (void *)get_zeroed_page(GFP_DMA | GFP_KERNEL);
+	on_close_chsc_area = kzalloc(PAGE_SIZE, GFP_DMA | GFP_KERNEL);
 	if (!on_close_chsc_area) {
 		ret = -ENOMEM;
 		goto out_free_request;
@@ -353,7 +353,7 @@ static int chsc_ioctl_on_close_set(void __user *user_area)
 	goto out_unlock;
 
 out_free_chsc:
-	free_page((unsigned long)on_close_chsc_area);
+	kfree(on_close_chsc_area);
 	on_close_chsc_area = NULL;
 out_free_request:
 	kfree(on_close_request);
@@ -375,7 +375,7 @@ static int chsc_ioctl_on_close_remove(void)
 		ret = -ENOENT;
 		goto out_unlock;
 	}
-	free_page((unsigned long)on_close_chsc_area);
+	kfree(on_close_chsc_area);
 	on_close_chsc_area = NULL;
 	kfree(on_close_request);
 	on_close_request = NULL;
@@ -392,7 +392,7 @@ static int chsc_ioctl_start_sync(void __user *user_area)
 	struct chsc_sync_area *chsc_area;
 	int ret, ccode;
 
-	chsc_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	chsc_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!chsc_area)
 		return -ENOMEM;
 	if (copy_from_user(chsc_area, user_area, PAGE_SIZE)) {
@@ -414,7 +414,7 @@ static int chsc_ioctl_start_sync(void __user *user_area)
 	else
 		ret = 0;
 out_free:
-	free_page((unsigned long)chsc_area);
+	kfree(chsc_area);
 	return ret;
 }
 
@@ -438,7 +438,7 @@ static int chsc_ioctl_info_channel_path(void __user *user_cd)
 		u8 data[PAGE_SIZE - 20];
 	} __attribute__ ((packed)) *scpcd_area;
 
-	scpcd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	scpcd_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!scpcd_area)
 		return -ENOMEM;
 	cd = kzalloc_obj(*cd);
@@ -476,7 +476,7 @@ static int chsc_ioctl_info_channel_path(void __user *user_cd)
 		ret = 0;
 out_free:
 	kfree(cd);
-	free_page((unsigned long)scpcd_area);
+	kfree(scpcd_area);
 	return ret;
 }
 
@@ -500,7 +500,7 @@ static int chsc_ioctl_info_cu(void __user *user_cd)
 		u8 data[PAGE_SIZE - 20];
 	} __attribute__ ((packed)) *scucd_area;
 
-	scucd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	scucd_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!scucd_area)
 		return -ENOMEM;
 	cd = kzalloc_obj(*cd);
@@ -538,7 +538,7 @@ static int chsc_ioctl_info_cu(void __user *user_cd)
 		ret = 0;
 out_free:
 	kfree(cd);
-	free_page((unsigned long)scucd_area);
+	kfree(scucd_area);
 	return ret;
 }
 
@@ -563,7 +563,7 @@ static int chsc_ioctl_info_sch_cu(void __user *user_cud)
 		u8 data[PAGE_SIZE - 20];
 	} __attribute__ ((packed)) *sscud_area;
 
-	sscud_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sscud_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sscud_area)
 		return -ENOMEM;
 	cud = kzalloc_obj(*cud);
@@ -602,7 +602,7 @@ static int chsc_ioctl_info_sch_cu(void __user *user_cud)
 		ret = 0;
 out_free:
 	kfree(cud);
-	free_page((unsigned long)sscud_area);
+	kfree(sscud_area);
 	return ret;
 }
 
@@ -625,7 +625,7 @@ static int chsc_ioctl_conf_info(void __user *user_ci)
 		u8 data[PAGE_SIZE - 20];
 	} __attribute__ ((packed)) *sci_area;
 
-	sci_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sci_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sci_area)
 		return -ENOMEM;
 	ci = kzalloc_obj(*ci);
@@ -662,7 +662,7 @@ static int chsc_ioctl_conf_info(void __user *user_ci)
 		ret = 0;
 out_free:
 	kfree(ci);
-	free_page((unsigned long)sci_area);
+	kfree(sci_area);
 	return ret;
 }
 
@@ -696,7 +696,7 @@ static int chsc_ioctl_conf_comp_list(void __user *user_ccl)
 		u32 res;
 	} __attribute__ ((packed)) *cssids_parm;
 
-	sccl_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sccl_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sccl_area)
 		return -ENOMEM;
 	ccl = kzalloc_obj(*ccl);
@@ -745,7 +745,7 @@ static int chsc_ioctl_conf_comp_list(void __user *user_ccl)
 		ret = 0;
 out_free:
 	kfree(ccl);
-	free_page((unsigned long)sccl_area);
+	kfree(sccl_area);
 	return ret;
 }
 
@@ -756,7 +756,7 @@ static int chsc_ioctl_chpd(void __user *user_chpd)
 	int ret;
 
 	chpd = kzalloc_obj(*chpd);
-	scpd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	scpd_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!scpd_area || !chpd) {
 		ret = -ENOMEM;
 		goto out_free;
@@ -775,7 +775,7 @@ static int chsc_ioctl_chpd(void __user *user_chpd)
 		ret = -EFAULT;
 out_free:
 	kfree(chpd);
-	free_page((unsigned long)scpd_area);
+	kfree(scpd_area);
 	return ret;
 }
 
@@ -796,7 +796,7 @@ static int chsc_ioctl_dcal(void __user *user_dcal)
 		u8 data[PAGE_SIZE - 36];
 	} __attribute__ ((packed)) *sdcal_area;
 
-	sdcal_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	sdcal_area = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!sdcal_area)
 		return -ENOMEM;
 	dcal = kzalloc_obj(*dcal);
@@ -834,7 +834,7 @@ static int chsc_ioctl_dcal(void __user *user_dcal)
 		ret = 0;
 out_free:
 	kfree(dcal);
-	free_page((unsigned long)sdcal_area);
+	kfree(sdcal_area);
 	return ret;
 }
 
@@ -904,7 +904,7 @@ static int chsc_release(struct inode *inode, struct file *filp)
 	}
 	snprintf(dbf, sizeof(dbf), "relret:%d", ret);
 	CHSC_LOG(0, dbf);
-	free_page((unsigned long)on_close_chsc_area);
+	kfree(on_close_chsc_area);
 	on_close_chsc_area = NULL;
 	kfree(on_close_request);
 	on_close_request = NULL;

-- 
2.53.0

