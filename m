Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47633BBFBF;
	Sun, 26 Jul 2026 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785086524; cv=none; b=C8w8emIbKbCk8FVT+fSjqFpzghPwxsvXxvPRunwpONTzE7U8L3mb15LKk9NQLXXY6HoNqaBpXKO1oG+63r2IkqbpP8Fv5w6KfAfBdh0zmQEnKc24Grc9mGlh4RzvRHi4pCpyPbZD8WtqitoMyvqFB5CHrMOJgk+8lsGWtNZSphY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785086524; c=relaxed/simple;
	bh=u9Np9/+2jibUoEpD1NftwLedNbvDcu4XHGhAO6qNjHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/J96YbpZ+t5VryuP0BFd1Ac/FBAV47xyXl7fS7xUlgnt8pCkPCw4IQGsLxcLYq8FWd8EBhH1AsDLsJpN6EfHxOKvz/RSYMQkmLDc4GHVd+pgmJM8d/7YRGDwtqxBhSyMBxH62l8T9gf3t532XwE/VS0LDRTg/a07iG7xTza3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lT8WZ3Uz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lT8WZ3Uz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QHIhKh3967058;
	Sun, 26 Jul 2026 17:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=r6zp6kzgdyp/oP5NT
	5pWJIK12PWcKCrUpYGWin7WeY4=; b=lT8WZ3Uz1LgmCfJde2T1sga01L+Mweqme
	F+AzrwlL8qOun+0xqgiH5zg5xAtVYmSxPMfnButH50Wp7Np9nC/F0ojT0qX48Sj+
	ZL3ixzbGEPDb6pSIdesYVp7t3g848E6XYGeA3T2FvKN3dL2p0LbNTwbg4FOtCxm5
	MiHGWFf5j1651QO+XoC5hL6G0bCxvG4Hm6WDirAdrD2wdNo4dvai1qZAhBU0gZzE
	R4hutqhTS7LACy0fHQvNrIWqakOVurnpqF8XOssVWHP8bjRd/2zvrDZLqQN6+j0M
	7VhpP7tR+vN4Cb70QFkPGgj8CmnEF1c1FaGka4pZzAnHtwagcqz9w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhv3u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66QHBdRM014361;
	Sun, 26 Jul 2026 17:22:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq2cuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66QHLvDp43319568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 17:21:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F19122006B;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB0F22006A;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 92C081612A3; Sun, 26 Jul 2026 19:21:56 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Farhan Ali <alifm@linux.ibm.com>
Subject: [PATCH v6 10/10] s390/vfio_ccw: implement a crw lock
Date: Sun, 26 Jul 2026 19:21:53 +0200
Message-ID: <20260726172153.1818056-11-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726172153.1818056-1-farman@linux.ibm.com>
References: <20260726172153.1818056-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfXwi+Mll8gbseR
 S4LNOl4aCSoXLjTgJvsmjfCc1tXl8lJ3Mvy0chUIYfhG3QXapzQDOCniXP2oA4xFNcVRd6QjPrs
 2k8CdIrhBtsKy+dsczhsJwPgAYZcnjs=
X-Proofpoint-GUID: esA2I2yhvpkcc4YGFJGF6szGWX3qbMHy
X-Proofpoint-ORIG-GUID: esA2I2yhvpkcc4YGFJGF6szGWX3qbMHy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfX7BdvDGTDkle/
 gLQ3J0/3K0J+VGIPmSCwmf333hHT1HY8Y4Rr5kDZ/MDgN6S5iFQsCBRQTVcaOV1lIB4Ncy/ooOW
 rBd2IUxyE+cNSJmZIZfKZGUPrD3xdioXFw+CNBKdcjTK38GU8SP/uZDPL4545dD9jcmkzdpysKs
 fLqKyuvWVpJ9Eh0l3pL5dlo49+QNUpxViFFG9kSJ7na5HbxCgrmQhONFi02kqKUbjZ5eBsJ2bB6
 Wq94WsFuoj+zoxN5EYOl5nlQUNwTNX+yik6ne70gH/9BRNXOk3bUyvCBmx+3sDAJ0rYFjodllAy
 /ZvbgDiAVr5qS4WrY9h4EEIr2SWDLU8Si/rrGhk3HYE+4+xd1yu/bTq+jKrPvbJiJkyEXIGYGYC
 gmSuARD6H70cVXYpV3oyEa3vAO85H5VXFKz33qZlTMf0p2jw/2ovbiO90kUImKIW7yDCt9YmDdB
 0t7AGAFEoTs8d24UrmA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a664239 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=huIa1HNm52ewcn7HQvQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607260175

Unlike the channel_program struct, which covers synchronous I/O
submissions and asynchronous interrupts, the CRW region relies
exclusively on asynchronous events coming from hardware.

Implement a lock to manage the list of those payloads, to ensure
they are read cohesively.

Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
Cc: stable@vger.kernel.org
Cc: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_chp.c     | 26 ++++++++++++++++----------
 drivers/s390/cio/vfio_ccw_drv.c     |  6 ++++++
 drivers/s390/cio/vfio_ccw_ops.c     |  4 ++++
 drivers/s390/cio/vfio_ccw_private.h |  4 ++++
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
index f3015132d4b5..7708eb4d6de0 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -93,17 +93,12 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
 	loff_t pos =3D *ppos & VFIO_CCW_OFFSET_MASK;
 	struct ccw_crw_region *region;
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
 	int ret;
=20
 	if (pos + count > sizeof(*region))
 		return -EINVAL;
=20
-	crw =3D list_first_entry_or_null(&private->crw,
-				       struct vfio_ccw_crw, next);
-
-	if (crw)
-		list_del(&crw->next);
-
 	mutex_lock(&private->io_mutex);
 	if (i >=3D private->num_regions) {
 		ret =3D -EINVAL;
@@ -113,6 +108,16 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_=
ccw_private *private,
 	i =3D array_index_nospec(i, private->num_regions);
 	region =3D private->region[i].data;
=20
+	spin_lock_irqsave(&private->crw_lock, flags);
+	crw =3D list_first_entry_or_null(&private->crw,
+				       struct vfio_ccw_crw, next);
+
+	if (crw)
+		list_del(&crw->next);
+
+	/* Drop CRW lock while copying to userspace */
+	spin_unlock_irqrestore(&private->crw_lock, flags);
+
 	if (crw)
 		memcpy(&region->crw, &crw->crw, sizeof(region->crw));
=20
@@ -122,15 +127,16 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio=
_ccw_private *private,
 		ret =3D count;
=20
 	region->crw =3D 0;
-
-out:
-	mutex_unlock(&private->io_mutex);
-
 	kfree(crw);
=20
 	/* Notify the guest if more CRWs are on our queue */
+	spin_lock_irqsave(&private->crw_lock, flags);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
+
+out:
+	mutex_unlock(&private->io_mutex);
=20
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
index faf2de074a10..d7e93b9d491c 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -122,11 +122,14 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 void vfio_ccw_crw_todo(struct work_struct *work)
 {
 	struct vfio_ccw_private *private;
+	unsigned long flags;
=20
 	private =3D container_of(work, struct vfio_ccw_private, crw_work);
=20
+	spin_lock_irqsave(&private->crw_lock, flags);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 }
=20
 /*
@@ -279,6 +282,7 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
e *private,
 			       unsigned int rsid)
 {
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
=20
 	/*
 	 * If unable to allocate a CRW, just drop the event and
@@ -296,7 +300,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
e *private,
 	crw->crw.erc =3D erc;
 	crw->crw.rsid =3D rsid;
=20
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_add_tail(&crw->next, &private->crw);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 	queue_work(vfio_ccw_work_q, &private->crw_work);
 }
=20
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index ddfcd2b4296f..2f28846fdf72 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -60,6 +60,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *v=
dev)
 	INIT_LIST_HEAD(&private->crw);
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
+	spin_lock_init(&private->crw_lock);
=20
 	private->cp.guest_cp =3D kzalloc_objs(struct ccw1, CCWCHAIN_LEN_MAX);
 	if (!private->cp.guest_cp)
@@ -137,11 +138,14 @@ static void vfio_ccw_mdev_release_dev(struct vfio_d=
evice *vdev)
 	struct vfio_ccw_private *private =3D
 		container_of(vdev, struct vfio_ccw_private, vdev);
 	struct vfio_ccw_crw *crw, *temp;
+	unsigned long flags;
=20
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_for_each_entry_safe(crw, temp, &private->crw, next) {
 		list_del(&crw->next);
 		kfree(crw);
 	}
+	spin_unlock_irqrestore(&private->crw_lock, flags);
=20
 	/* Should be empty, but just in case */
 	cancel_work_sync(&private->io_work);
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_=
ccw_private.h
index ac5aaa78a74b..c23430e1a78e 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -98,6 +98,8 @@ struct vfio_ccw_parent {
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
  * @scsw: scsw info
+ * @crw_lock: serialization of CRW list information
+ * @crw: list of Channel Report Word elements
  * @io_trigger: eventfd ctx for signaling userspace I/O results
  * @crw_trigger: eventfd ctx for signaling userspace CRW information
  * @req_trigger: eventfd ctx for signaling userspace to return device
@@ -121,6 +123,8 @@ struct vfio_ccw_private {
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

