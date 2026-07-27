Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905E937A847;
	Mon, 27 Jul 2026 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180166; cv=none; b=i3YeDP5XboS+cSZDZr8ptjBsek4qQ1qAJCH2ocfwLWrn+59wQYLvAvmJqCVcnhPCaMxXhmoNN0oEVtMhWJo/8NWN1Z21GcukgKIVnTKjePQRU21QtXI6PNpjplgtSGbQ7om4d4uGP/XfPVtzhHWlvIQckEES1Hct2Azf/V3nw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180166; c=relaxed/simple;
	bh=5BgEV2qQhY1Tu/xv7o6QtMTPTWdgdV6sx3leudGuLe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ln4Zy/TTghHJmA9xjQDyiKvVcIvimmR0TSFx8sW0TA/IAf3DD9ifrWmbJOv3UwOZ521y6Qifw4H5iQspq7T3RAwlHUECwtVuNl1oxujIUeW+hCc/BXT9WHlNaQouhgJGOOApn5sTnOhfHL6SX/3CTurInoYKJst45AueNG0FQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dQ9chI0M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dQ9chI0M"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RIHsqC2881520;
	Mon, 27 Jul 2026 19:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QWcI0t30MXB/IPHD9
	Jsx/M9qb7aezOHi4p3RDEZgVng=; b=dQ9chI0MLBynlH4m3qZDXEFJCRshCvpl+
	Kdbf74gfN53Ueb/8d7kTejA1ssITxkM5y1Dsx2DOl+aUpNZShmnUGD5TZjNLzjvW
	WmjrNt+b/mG9jL1Mu6IUck89+w5kCV6q23+rnk/8yTPvhnjFbAM2NVcwNSQsVuVK
	xUcuzNuU/Ua4gHJPw7qu165D4W1WylaqLOLx0x8tp/nNGxT1RgjfU3mGqKJIBW38
	rzV/n/MPmxGxRogCWjdprOPdqhbxWohKUKQcYx1FTKO2gdrlq1AG6zpNsNq8+Q/W
	e8UtlAmXXCa3fWARQ3bV2jJJJ4zu5DGHY3FzTvNcNjyrH6aGi5xPw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj18pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 19:22:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RJBRiT018656;
	Mon, 27 Jul 2026 19:22:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvxu9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 19:22:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RJMbJO48169292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 19:22:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B2FC2023E;
	Mon, 27 Jul 2026 19:22:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CFE92023B;
	Mon, 27 Jul 2026 19:22:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 27 Jul 2026 19:22:37 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id C575416282C; Mon, 27 Jul 2026 21:22:36 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v7 08/10] s390/vfio_ccw: move cp cleanup out of not operational
Date: Mon, 27 Jul 2026 21:22:28 +0200
Message-ID: <20260727192230.2715207-9-farman@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE3NyBTYWx0ZWRfXzdgPPTjowHfu
 h624qZMlWaVM/+H4wYi8QVSQrEPsx9ZCaRO17wszMpkqG2RHoD1wl74Iv1GTavxynd1hmsGR7KI
 VHG9UGaTXZKBYWUq/v8PCOIux1uDJmg=
X-Proofpoint-GUID: N85H8Kj2q5IMEfUJdGscTfMycidwacoN
X-Proofpoint-ORIG-GUID: N85H8Kj2q5IMEfUJdGscTfMycidwacoN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE3NyBTYWx0ZWRfXzgTW/rf2nQ4u
 Aw6K+c02ZSvOZm1+l+wYzn7vOgPjf2BacM6zCSAJh64TeKdJXFjbK4NvadiWGvfcHhovwwsIBHJ
 Vg1x6QJAjr6eVBbv6Cplc7UazJzfl9i7EKjiIR4yQNTJKdIAq8TDNoMRssWNB4aDqogFIJUiuNX
 0uEw9Hf+18a7i0ofnCQHgKIfbJxHFlOaa9arc9Jqqm9tpe3N1qm6KIt61k05LSp7xndvGaOyR4z
 bUkir67BvTaAoxOU9pCGTivuiOcCczAssyULw2YIBdv8QVEr3n360EKmI3HnykaVA7Yh1gXL36H
 ZO/5t59eyxpZwGhzqNKVqCWc3QxfUF0DPTnDdosUot+4KdaZPu7clO+EgLgKK1JGkauFAyxZiD+
 Y+odOspHWTtklo63e1ZCww0mPv9l99k8bwI+uMEDfZHsUQ1owm3S1rzXBeL7U7w+pyVQvFb5jTs
 SodeoCGj7GI0Ic0F9FQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a67b002 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=PHhSqfijsb0kgUKkh4oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270177

The fsm_notoper() routine is called when the device has been
lost, and is (by definition) no longer operational. Since this
can happen asynchronously from the normal behavior of the
driver, the cleanup may happen when holding other locks
in the calling sequence (notably, the cio subchannel lock).

Push the cleanup of the private->cp resources to a workqueue,
where it can be done out from under that lock sequence and
(soon) under its own serialization mechanism.

Fixes: 204b394a23ad ("vfio/ccw: Move FSM open/close to MDEV open/close")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 9 +++++++++
 drivers/s390/cio/vfio_ccw_fsm.c     | 3 +--
 drivers/s390/cio/vfio_ccw_ops.c     | 3 +++
 drivers/s390/cio/vfio_ccw_private.h | 3 +++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
index 1a095085bc72..c197ad5ab580 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -125,6 +125,15 @@ void vfio_ccw_crw_todo(struct work_struct *work)
 		eventfd_signal(private->crw_trigger);
 }
=20
+void vfio_ccw_notoper_todo(struct work_struct *work)
+{
+	struct vfio_ccw_private *private;
+
+	private =3D container_of(work, struct vfio_ccw_private, notoper_work);
+
+	cp_free(&private->cp);
+}
+
 /*
  * Css driver callbacks
  */
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_=
fsm.c
index 4d7988ea47ef..4d47a3c7b9a0 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -170,8 +170,7 @@ static void fsm_notoper(struct vfio_ccw_private *priv=
ate,
 	css_sched_sch_todo(sch, SCH_TODO_UNREG);
 	private->state =3D VFIO_CCW_STATE_NOT_OPER;
=20
-	/* This is usually handled during CLOSE event */
-	cp_free(&private->cp);
+	queue_work(vfio_ccw_work_q, &private->notoper_work);
 }
=20
 /*
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index bd488e40e153..8ec6b175d991 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -54,6 +54,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *v=
dev)
 	INIT_LIST_HEAD(&private->crw);
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
+	INIT_WORK(&private->notoper_work, vfio_ccw_notoper_todo);
=20
 	private->cp.guest_cp =3D kzalloc_objs(struct ccw1, CCWCHAIN_LEN_MAX);
 	if (!private->cp.guest_cp)
@@ -139,6 +140,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
ice *vdev)
 	/* Should be empty, but just in case */
 	cancel_work_sync(&private->io_work);
 	cancel_work_sync(&private->crw_work);
+	cancel_work_sync(&private->notoper_work);
=20
 	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
 	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
@@ -209,6 +211,7 @@ static void vfio_ccw_mdev_close_device(struct vfio_de=
vice *vdev)
=20
 	cancel_work_sync(&private->io_work);
 	cancel_work_sync(&private->crw_work);
+	cancel_work_sync(&private->notoper_work);
=20
 	vfio_ccw_unregister_dev_regions(private);
 }
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_=
ccw_private.h
index 0501d4bbcdbd..e2256402b089 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -102,6 +102,7 @@ struct vfio_ccw_parent {
  * @req_trigger: eventfd ctx for signaling userspace to return device
  * @io_work: work for deferral process of I/O handling
  * @crw_work: work for deferral process of CRW handling
+ * @notoper_work: work for deferred processing in not-operational state
  */
 struct vfio_ccw_private {
 	struct vfio_device vdev;
@@ -125,11 +126,13 @@ struct vfio_ccw_private {
 	struct eventfd_ctx	*req_trigger;
 	struct work_struct	io_work;
 	struct work_struct	crw_work;
+	struct work_struct	notoper_work;
 } __aligned(8);
=20
 int vfio_ccw_sch_quiesce(struct subchannel *sch);
 void vfio_ccw_sch_io_todo(struct work_struct *work);
 void vfio_ccw_crw_todo(struct work_struct *work);
+void vfio_ccw_notoper_todo(struct work_struct *work);
=20
 extern struct mdev_driver vfio_ccw_mdev_driver;
=20
--=20
2.53.0

