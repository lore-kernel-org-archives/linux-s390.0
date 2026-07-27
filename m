Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692C3D1AA2;
	Mon, 27 Jul 2026 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181431; cv=none; b=aiE0E1+oz6H0hGJ8x8PA1xlmCQvvAUkC3b+0rRlifO7Xhbx+0SZ77wg645FQMbYLcsKAlHRR2skKuUUWqb0/Thay6bPCN4ZlwCvFpPaSAL2Uljvs4eOSnyQIyeB+OHMnm8kBmCrsCEWB/x0rIxyuWyzirGJSErUxRxD44hnAlN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181431; c=relaxed/simple;
	bh=ffnFhA3AiJ7Sh3cLiZNAA/z2Kg29Ywleux3RohIl54s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utyPJwaV4WWnLQ1NHErhmg2RJkH0zUn2ULmT+VvmOmF3CdpF/TJiBG32aL+Sw+AWZ0RY08nsHJKe3SWRnXkTIlOT75bCitHwpU0STk+06MkmdcwNz0Z4ohb72qn5h+p7yubPMBTd6ZKKZeV+l/QSPIqpdHs8aCpqhmj42NEqgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EGgmH9FT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EGgmH9FT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RIHagI2956896;
	Mon, 27 Jul 2026 19:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I0KD+AE540ojdAz1S
	+BJRaOgj90Bwnu0DWJgE6VcGm0=; b=EGgmH9FTDbE/7AqD7SbW3+MM88ZcpCVEW
	XXOe/QHukjyxmQHbF7m+DjIdyk8WD4an+apL1RuzRUf4eFAcjPfIFtVrsUVaLUsv
	IcHBWHO8Kjh+IX8LaUhD8Tw1lGJRNTWHBMBpUX0+9nihTGBiHr+HviHTomm/tXjO
	wH5NRoZ0Q5Kca4qKBsvVH70onMIQeK2zkJAAxzCFCrnKv63EGlqV2e+j+kf6Lr21
	TkH9kai5gElYnrR95LnNqaC47c/3D1IGOURQ+MSn+/korBwIBxCTJiPsiiZy2UXL
	YmdDpUFhf/S/VQalNlsIZSOEQs7VOwtj4ZBhgdKeEQPFJbkmrsFNw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw79sx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 19:43:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RJfJuj020964;
	Mon, 27 Jul 2026 19:43:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xxghe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 19:43:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RJhiA442205456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 19:43:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39606200F4;
	Mon, 27 Jul 2026 19:22:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12780200F1;
	Mon, 27 Jul 2026 19:22:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 27 Jul 2026 19:22:37 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id C9BAE162834; Mon, 27 Jul 2026 21:22:36 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Farhan Ali <alifm@linux.ibm.com>
Subject: [PATCH v7 10/10] s390/vfio_ccw: implement a crw lock
Date: Mon, 27 Jul 2026 21:22:30 +0200
Message-ID: <20260727192230.2715207-11-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727192230.2715207-1-farman@linux.ibm.com>
References: <20260727192230.2715207-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Me3m5IgpeDRkBqpSIpqrArg6zZtvwYFF
X-Proofpoint-ORIG-GUID: Me3m5IgpeDRkBqpSIpqrArg6zZtvwYFF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE3NyBTYWx0ZWRfX3khiTVrn8WbQ
 qqmf7np4iRAo9Tdrn/2azTtvy3a1V/2rlxmWZ0SVpjxe9li6Aaf8o8F7vEhwR9bp8Oy/lJ4N1mn
 TEBxmm3CZysZMKhyQqK9mDF1/YWux1uHLpgpqqb3ePBMWshn87FWDoi3F4tXRmu+wRKGreC+diP
 Q+LDGejpc5k8zD11VrrYWALZJCQn8ss9T92OWmj5kYNOa7cLqmlYpr33MCUJQ3HbC/ETNswVNrM
 ZE6yR+mTBw/xTrzjIfT0GaXASI+EzCIkgmykL52jKmN3Le8sg/ay5QZ/BkucZXwiUgkWFCh0WX7
 Cm5OE9ALUTro6hJjHs16DktI3pNx1YNrttmNU0qlWyqaMX5jf6OwBa6wluc+Pg5fk0JK728vpln
 xi6A++VtMb+Lzer8C7pHHy1YJUGZPLM1eF3EfTpRzgdOcXNaD282lRqrX9jG4CYdj3iemHxnHva
 Uh8NhHwsAt50Zc6ikLg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a67b4f5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=huIa1HNm52ewcn7HQvQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE3NyBTYWx0ZWRfX1jUtvKhDerMa
 San0TC3Fwl1n1zbPtVdhlraByaU0p+Cbs2yLRQvJjoiLTbe+pCs9lSawbfQoSG+tKHjwTzDQhv1
 xwpVb2ex6Cyk8yC0okuJYk5y+HsUz7k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270177

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
index 9269b54f5cfd..7708eb4d6de0 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -93,18 +93,13 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
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
 	mutex_lock(&private->io_mutex);
-	crw =3D list_first_entry_or_null(&private->crw,
-				       struct vfio_ccw_crw, next);
-
-	if (crw)
-		list_del(&crw->next);
-
 	if (i >=3D private->num_regions) {
 		ret =3D -EINVAL;
 		goto out;
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
index 757ff5b2556e..ab6b518cc353 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -118,11 +118,14 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
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
 void vfio_ccw_notoper_todo(struct work_struct *work)
@@ -286,6 +289,7 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
e *private,
 			       unsigned int rsid)
 {
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
=20
 	/*
 	 * If unable to allocate a CRW, just drop the event and
@@ -303,7 +307,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
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
index 8ec6b175d991..9cbb277b83fb 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -55,6 +55,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *v=
dev)
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
 	INIT_WORK(&private->notoper_work, vfio_ccw_notoper_todo);
+	spin_lock_init(&private->crw_lock);
=20
 	private->cp.guest_cp =3D kzalloc_objs(struct ccw1, CCWCHAIN_LEN_MAX);
 	if (!private->cp.guest_cp)
@@ -131,11 +132,14 @@ static void vfio_ccw_mdev_release_dev(struct vfio_d=
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
index 739121116ab6..3bd0171d38d0 100644
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
@@ -120,6 +122,8 @@ struct vfio_ccw_private {
 	struct channel_program	cp;
 	struct irb		irb;
 	union scsw		scsw;
+
+	spinlock_t		crw_lock;
 	struct list_head	crw;
=20
 	struct eventfd_ctx	*io_trigger;
--=20
2.53.0

