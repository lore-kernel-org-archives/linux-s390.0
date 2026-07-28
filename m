Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634C283142;
	Tue, 28 Jul 2026 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202517; cv=none; b=QAXIV6TLgoI7JlRlwFs1saWPpJqdzydmxT/pElWw/vGZZUKf+uI8Dz9i44L5CQLui/wpZIRa29EDITZA5lSGcMMVdT6lj+ZKcsjQePlOF9BHDV4lfWC3RxUGHCIff/mZrUAW1EovgbWydmKFxoCU6uYcozUjqQ0uAkNTDxNHxLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202517; c=relaxed/simple;
	bh=QA8k+912oLy2bRgrjzpjTgwEHh5bCKclyHOJUmA1VfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qkh9kbVHWOKntFClo5R3VizqAjlmZC7lZeR1HDcnK6RS0gxj+FwWzup9kF0MXQRnmRHtRdoY+JE7+93dGTmPljqbSCKM9lcSW20pnk6iYiskMcwcJZMcjr7WVpXiu5p8wA99peYrNiiIShWgD+LjH1u8lLI5KKEyNPvNJ0ub5oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MM3wUOpf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MM3wUOpf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0nM1d1891521;
	Tue, 28 Jul 2026 01:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LwjzebzNIDbqokilb
	C3B4NHYm88HcXLfoqbWR1NdgDs=; b=MM3wUOpfgvps+XSzbjazUGY7jAUfae9nV
	McadOlUc65ZQ5GGWP1RlN4BC7MTIY0Nd2ypWULC/1aHRWpd6oFx8FgxTgqODfJmq
	hygh8NUbacDlgGxvln+WDhHnhJocY4P48Yi75VGVBd3+zy5eE4ziEOyZEmb08+iw
	npm/2aWN+sehzY6V2blWlEtQSM7BLsFzFXN6IC3W7JNMxZVcegwbCFLBve23qXXj
	Xges0bp2RcGFMzFYQj4GqSXJj95BUSos20mgM09SHhXyywS5G1RoRJ7yYs0lRD9Q
	Nfua86S9AwpEEh+3sEy+iZURHxE0pQt5QYLA/BLB4NfIOqKeU6xvQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycaw8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 01:35:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S1QXZd029363;
	Tue, 28 Jul 2026 01:35:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq7x1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 01:35:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S1ZB9751118358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 01:35:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E86CE2009B;
	Tue, 28 Jul 2026 01:35:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4A292009F;
	Tue, 28 Jul 2026 01:35:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 01:35:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 84F1716282C; Tue, 28 Jul 2026 03:35:10 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v8 08/10] s390/vfio_ccw: move cp cleanup out of not operational
Date: Tue, 28 Jul 2026 03:35:07 +0200
Message-ID: <20260728013509.1551753-9-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728013509.1551753-1-farman@linux.ibm.com>
References: <20260728013509.1551753-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lQwu1sWusG8NA-a99v43Y2e58jGtcbii
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAwOSBTYWx0ZWRfX98Ub/Cbzrmp3
 CyQaR4xk5ubbFlI4bJwFbwVjJftoNaGC1yip8QRj7mejpNSF02vt96hN8ysuGwFbmu70yqZhO6A
 8uKGqUDorda18KsewGZJd6soJm+NQaS+Fsb09Pl4YMSAmyuQC6OTOtckfHmbOP1G9r9mA8CSFqs
 1YO0T13nXWCsFLvD5Aqd8b76Nt9xSftUI6tznimZ+L+uJn5gmw3ba11A2RF9V2xBPl6hDjuzuc3
 oi5ippydO5j+buJFm+qwIdfL/E65E6pxGct1AEBKkLJpoHgwDG7Oa0IPS2OWx0G211m5nr306fz
 6pJD2F3lbCbJFZgGWH6H0EmCsSoalyZUvi8U4jVXEisBKf8mdj6NmYAlbuHngLjV+anys9Z8wqH
 KVgMkfrAU5mk/jpFkGTzR4CjsTGhATW7kmAKh7LaOszjW8kYLlyOW4KiaECPt5aGOCXCzifANC2
 Cw0uvuVG9L6ODF+00iw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAwOSBTYWx0ZWRfX643PmhMO1tUH
 +nA+mKzXvTfvEE5fF2LuHv60xMcDxYLrnyVQk+XMt3xBh4e3F7HXiUXXwdpFJeWUBgMQ9Y8Vq+p
 2w0gYHdDgLYTH23hhto88EMKks/mja0=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a680753 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=PHhSqfijsb0kgUKkh4oA:9
X-Proofpoint-GUID: lQwu1sWusG8NA-a99v43Y2e58jGtcbii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280009

The fsm_notoper() routine is called when the device has been
lost, and is (by definition) no longer operational. Since this
can happen asynchronously from the normal behavior of the
driver, the cleanup may happen when holding other locks
in the calling sequence (notably, the cio subchannel lock).

Push the cleanup of the private->cp resources to a workqueue,
where it can be done out from under that lock sequence and
safely under a common locking mechanism.

Fixes: 204b394a23ad ("vfio/ccw: Move FSM open/close to MDEV open/close")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 9 +++++++++
 drivers/s390/cio/vfio_ccw_fsm.c     | 3 +--
 drivers/s390/cio/vfio_ccw_ops.c     | 6 +++++-
 drivers/s390/cio/vfio_ccw_private.h | 3 +++
 4 files changed, 18 insertions(+), 3 deletions(-)

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
index bc8eb485d03f..1cca3ecdae45 100644
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
@@ -133,7 +134,9 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
ice *vdev)
=20
 	/*
 	 * Ensure these work items are fully drained, so none can
-	 * fire after being released.
+	 * fire after being released. The notoper_work struct is
+	 * only meaningful if the device had been opened, which
+	 * means it would have been cleaned in an earlier close.
 	 */
 	cancel_work_sync(&private->io_work);
 	cancel_work_sync(&private->crw_work);
@@ -216,6 +219,7 @@ static void vfio_ccw_mdev_close_device(struct vfio_de=
vice *vdev)
 	 */
 	cancel_work_sync(&private->io_work);
 	cancel_work_sync(&private->crw_work);
+	flush_work(&private->notoper_work);
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

