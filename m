Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB833BED44;
	Mon, 20 Jul 2026 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578780; cv=none; b=VUMhbkrJy8wCA6nhiA85Vmy/mJRTuaWrbZRRuqYAwe6jaK6ptNy79K2P6y4aYMHuOwW8qilnA4BIq9egVxLleZiC0OhnLgPfcTj65d7TyH5uhEOLB32RsJcEtdvWLz6S71xiEHFS1CTA0FRP9UgeG1kM3RQbrazGe4kL36JmcVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578780; c=relaxed/simple;
	bh=8VSyzjuUzleU0iRGjJve6wH14nf3NIylq6KFDRi7Pts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsgLYwPGfNNWVcOQh1wpyHvXzjtF1jMk+CjyNP3eAilWX86nI6rz+/NFfrQqfaijT3CKQpfAuyY5bTiccxtXo8+fBfoHULidXkHF9RmTi2iwB5+LntbBvLBeUZVIxdn0m2OXKG6bhvNrx1A2hqbTlDtHUre7TeFP55p2tmwdHKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WgXRw2yU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WgXRw2yU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJfpBS3048287;
	Mon, 20 Jul 2026 20:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v2JqUU5j29LMneLiB
	CEz5Bg4k1E+Q/v1XQ6xgPRubTM=; b=WgXRw2yUKH+f++NDvWWjRxnFYrf989QsS
	Zn5HeHsScfs5wBfK7coAJn2ElJFppH6BrdmyA0JJE6K/vnTOz30UR3ZF5rF/Ugkx
	YqFE7jzABGSHINjc/xQ1cHiWBT0DUecgVjt8eVl2yWophAETLhdaMnV9lvWb0c8h
	d2kaQxWPCOwGRlyXJYqJrLcrUNHa8IPeeHEmdqD+sGcRhwAvoYM6IIRoQR63yN57
	iTXKURAMOPSjpaHHUkqRkaI2P5whh3jKgrMy1OwYRpOLJRIxlzc87RY0fuYhvGe7
	52IJbbxb4md9pQWNWc/0DBnbNUyN1WaBTY8zZPdprvcec88Gicpfw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k12b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KKJafR015412;
	Mon, 20 Jul 2026 20:19:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g7175-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KKJXPL24248604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 20:19:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DF362004B;
	Mon, 20 Jul 2026 20:19:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09BCC20040;
	Mon, 20 Jul 2026 20:19:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id C474B1627A8; Mon, 20 Jul 2026 22:19:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 7/7] s390/vfio_ccw: implement a crw lock
Date: Mon, 20 Jul 2026 22:19:31 +0200
Message-ID: <20260720201931.976660-8-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720201931.976660-1-farman@linux.ibm.com>
References: <20260720201931.976660-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5e82d9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=nxvipetsQlNpnt3QvtcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX+bRrksT/Gcla
 UBqEFuEr/t6W2Y9778rbwLVIUUbEWryxZnzv1XBHaFgihFBLLIknAuv2JkjvhhYdZAopswL99S9
 E09toGvc50GFASqXu8LcnYXCau5ZKVmoYHghzmror3241pPExkQw44Kd/8rjZR3IVCEhpVhiVrM
 Zu5sp0OtYuSGmi9524P8zTraDFI8UCItKCyz8g/uXwWEtTcwnk4ULWjEsWYns7HLtLtVX3xq5cQ
 ZT9HimG6GBngM7Pq7PU5lGmUAHUX8OZfBLC/cv1/YE7BT6nzhsReE+bs2h7AGCPgAvPgox6KPyB
 75Bn13Sg//+g00jZaEQAsqUtx7EjcNP+S+ADSSMctaHwVSyGqaKWWiOQbEOvoxYVeaDlQ8pGotm
 NRWsjLgdvJR4MNuoNU+OHER6QCb9J8R7W70/r4gvBkaWzjgQUPs3FVPKPDvFiGha5gvknPZuhil
 mH7WhclihoOyO3oD0Rg==
X-Proofpoint-ORIG-GUID: 8yBwNuoYJE_re-G1nK3Pd-cXXWI5w_Xr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfXxD5UKkBFkWWR
 MSR4Oiy8h3PVJkKWvvod5E02kLAr7aFBmxBLNywRb/BOOh/tB5pT8cVzil2YBjiB/3zUhWlNV1P
 r9jzryqccKeYUBeQa0vNJBe1mFWRuHc=
X-Proofpoint-GUID: 8yBwNuoYJE_re-G1nK3Pd-cXXWI5w_Xr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200220

Unlike the channel_program struct, which covers synchronous I/O
submissions and asynchronous interrupts, the CRW region relies
exclusively on asynchronous events coming from hardware.

Implement a lock to manage the list of those payloads, to ensure
they are read cohesively.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_chp.c     | 15 ++++++++++-----
 drivers/s390/cio/vfio_ccw_drv.c     |  4 ++++
 drivers/s390/cio/vfio_ccw_ops.c     |  3 +++
 drivers/s390/cio/vfio_ccw_private.h |  2 ++
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
index 38c176cf6295..bbc445efd67f 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -90,14 +90,18 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
 	if (pos + count > sizeof(*region))
 		return -EINVAL;
=20
+	mutex_lock(&private->io_mutex);
+	region =3D private->region[i].data;
+
+	spin_lock(&private->crw_lock);
 	crw =3D list_first_entry_or_null(&private->crw,
 				       struct vfio_ccw_crw, next);
=20
 	if (crw)
 		list_del(&crw->next);
=20
-	mutex_lock(&private->io_mutex);
-	region =3D private->region[i].data;
+	/* Drop CRW lock while copying to userspace */
+	spin_unlock(&private->crw_lock);
=20
 	if (crw)
 		memcpy(&region->crw, &crw->crw, sizeof(region->crw));
@@ -108,14 +112,15 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio=
_ccw_private *private,
 		ret =3D count;
=20
 	region->crw =3D 0;
-
-	mutex_unlock(&private->io_mutex);
-
 	kfree(crw);
=20
 	/* Notify the guest if more CRWs are on our queue */
+	spin_lock(&private->crw_lock);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger);
+	spin_unlock(&private->crw_lock);
+
+	mutex_unlock(&private->io_mutex);
=20
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
index bfb68de6e52c..12edccb62cbf 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -125,8 +125,10 @@ void vfio_ccw_crw_todo(struct work_struct *work)
=20
 	private =3D container_of(work, struct vfio_ccw_private, crw_work);
=20
+	spin_lock(&private->crw_lock);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger);
+	spin_unlock(&private->crw_lock);
 }
=20
 /*
@@ -296,7 +298,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
e *private,
 	crw->crw.erc =3D erc;
 	crw->crw.rsid =3D rsid;
=20
+	spin_lock(&private->crw_lock);
 	list_add_tail(&crw->next, &private->crw);
+	spin_unlock(&private->crw_lock);
 	queue_work(vfio_ccw_work_q, &private->crw_work);
 }
=20
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index d2475b3158cf..b3699ffd2f1d 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -60,6 +60,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *v=
dev)
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
 	spin_lock_init(&private->cp_lock);
+	spin_lock_init(&private->crw_lock);
=20
 	private->cp.guest_cp =3D kzalloc_objs(struct ccw1, CCWCHAIN_LEN_MAX);
 	if (!private->cp.guest_cp)
@@ -137,10 +138,12 @@ static void vfio_ccw_mdev_release_dev(struct vfio_d=
evice *vdev)
 		container_of(vdev, struct vfio_ccw_private, vdev);
 	struct vfio_ccw_crw *crw, *temp;
=20
+	spin_lock(&private->crw_lock);
 	list_for_each_entry_safe(crw, temp, &private->crw, next) {
 		list_del(&crw->next);
 		kfree(crw);
 	}
+	spin_unlock(&private->crw_lock);
=20
 	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
 	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_=
ccw_private.h
index 061b594fde36..4a43609d6422 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -120,6 +120,8 @@ struct vfio_ccw_private {
=20
 	struct irb		irb;
 	union scsw		scsw;
+
+	spinlock_t		crw_lock;
 	struct list_head	crw;
=20
 	struct eventfd_ctx	*io_trigger;
--=20
2.53.0

