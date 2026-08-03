Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4593655D6;
	Mon,  3 Aug 2026 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773377; cv=none; b=RD/Y3XHZo0p4KgoqQR5VeVtnP5YL40bGg/eMZghVAod4sV5NGOsGsXVCuZrRMqJ+r1nQaN0kmPgptiAV5LjDpFGgwMDdxpH60e9cw7DaxW+wDPWueKWipYAUC8Oj6TG3cp2FmRAka4TSvCCp88NMJUAPr7kGucC5TBGmz3ogJqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773377; c=relaxed/simple;
	bh=VHHUzty73ezjp/qU8clH5A8n/XfF1Tp6AY6wx/J/coY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGIRnsMZy+hgs/B2Ez3S1gmeBbd9SN7QemQ8a2Yv1XRxsTi451dvcVXsBvsvIxNreuP89rX3JdVxWoRMWZA/J+w9kB1+HSgY5ohjqExM9f1p7fpAEFZJoFOFOhVvWZeFe4wsa8k85FZeQPGnenJq7Ga8OivvpYAhuFxnoUlmmzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dBCM7rZr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dBCM7rZr"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHnTe2262163;
	Mon, 3 Aug 2026 16:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Qt0U07Rzf29OFxR07
	WOvz1poLCpC66XhXn7f2l+CWy8=; b=dBCM7rZrgR2zV0wKONTtmESTsnejTDB7a
	8GX7jZS9I3LYJJGs92+TP+Ae1gsb4NfD3T9wQaX+Bb+Hfu+tZEK1MrZQM6n09+dT
	qBaYZ3qxWg2Gd1TOThPpXu/zeNsj+aFuGY433tFDMQ0LK+sFFAKSIU22/NDvjkd7
	SW4qQa9KaO0WlH8HfEgGZgA20u+JFKG7jXFJF9CZaHxT1a0Z1FQhr1Q/Xb4Q7Cxq
	5rZUuZJMm0OVFBkD3Bh+kl1DjBVakrjW1836diPjAqU8h6uHy0jPdMDTAvt/7POH
	cAf9UKghWxicgEKd6a/jWEW2BAuovjLYSBfvIP5/VYJyuKjt+J3QQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3sqtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuJfB025659;
	Mon, 3 Aug 2026 16:09:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtydwwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9Qb649414590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7D5620043;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEB912004D;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:25 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 08/23] s390/vfio_ccw: Move cp cleanup out of not operational
Date: Mon,  3 Aug 2026 18:09:09 +0200
Message-ID: <20260803160924.236807-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803160924.236807-1-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a70bd3c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=PHhSqfijsb0kgUKkh4oA:9
X-Proofpoint-ORIG-GUID: qjoo_4vt4nBgXlfXow6Hw3lKhlveQvpK
X-Proofpoint-GUID: qjoo_4vt4nBgXlfXow6Hw3lKhlveQvpK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX80PTa9RT3TST
 YrvsnI2NB/plmsHK9Ak9uNu0jz4yiQuMSGVsrTKxiqhkWNz5MOLhZjjZfahH+7hxBOXJ7XFH0+S
 t1mtBrbwAGYjEvORIw1zOcUOqcNK3zU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX+SOFnHeGRSOk
 aBW4nmVfFhcYrLFzjVy1FCpn9G9oAUhZJXXh2C4S7T7C0hKkAqqYWRdN5GMB+TGCsO3fuzZdD/n
 ll4KmchJ5zaykHZ2z7BJOXA+PFrIo/LYMap0dZHm5HipXt+cDn43nP8WL9RfYU7/pMUrT7fcGML
 Wy9HDZwxtUTgSjDugGjkEn7OH0tefY0R9veiT5I7Km1CX0JvYUbZF3XJuA7TLnB0VZidhyi6Sry
 zQaqvV1xpfFrPGhEqPJNfa6ucRmZWOJWZFLoIf/JJ3V+GiUh139PN1E7DfmKo0E9wIXdTik3sHr
 k1kIfEVTEu0UEN1f3LXrqZFwJUjlNH4YwnEVQFEXyk5uma+Bws+dkDa0H3oHZa3yooGmC5WhMtk
 Zv+TCnEjGjL/DeO2Bw3yFchTWfFIZ9jMEaCRXh9zAcY18GajCFJyvvAOZGtDzzBYb0KgqIckH7t
 i34kJ9MsuccKOO/J7xA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030141

From: Eric Farman <farman@linux.ibm.com>

The fsm_notoper() routine is called when the device has been
lost, and is (by definition) no longer operational. Since this
can happen asynchronously from the normal behavior of the
driver, the cleanup may happen when holding other locks
in the calling sequence (notably, the cio subchannel lock).

Push the cleanup of the private->cp resources to a workqueue,
where it can be done out from under that lock sequence and
a future patch can safely manage the locking requirements.

Fixes: 204b394a23ad ("vfio/ccw: Move FSM open/close to MDEV open/close")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     |  9 +++++++++
 drivers/s390/cio/vfio_ccw_fsm.c     |  3 +--
 drivers/s390/cio/vfio_ccw_ops.c     | 13 +++++++++++++
 drivers/s390/cio/vfio_ccw_private.h |  3 +++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 1a095085bc72..c197ad5ab580 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -125,6 +125,15 @@ void vfio_ccw_crw_todo(struct work_struct *work)
 		eventfd_signal(private->crw_trigger);
 }
 
+void vfio_ccw_notoper_todo(struct work_struct *work)
+{
+	struct vfio_ccw_private *private;
+
+	private = container_of(work, struct vfio_ccw_private, notoper_work);
+
+	cp_free(&private->cp);
+}
+
 /*
  * Css driver callbacks
  */
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 4d7988ea47ef..4d47a3c7b9a0 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -170,8 +170,7 @@ static void fsm_notoper(struct vfio_ccw_private *private,
 	css_sched_sch_todo(sch, SCH_TODO_UNREG);
 	private->state = VFIO_CCW_STATE_NOT_OPER;
 
-	/* This is usually handled during CLOSE event */
-	cp_free(&private->cp);
+	queue_work(vfio_ccw_work_q, &private->notoper_work);
 }
 
 /*
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index d361d1fde3a0..1df6d649565b 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -54,6 +54,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *vdev)
 	INIT_LIST_HEAD(&private->crw);
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
+	INIT_WORK(&private->notoper_work, vfio_ccw_notoper_todo);
 
 	private->cp.guest_cp = kzalloc_objs(struct ccw1, CCWCHAIN_LEN_MAX);
 	if (!private->cp.guest_cp)
@@ -134,9 +135,16 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
 	/*
 	 * Ensure these work items are fully drained, so none can
 	 * fire after being released.
+	 *
+	 * notoper_work should have nothing to do here, because only
+	 * open devices could have channel_program resources in use
+	 * and those would be released during close. Nevertheless,
+	 * call flush here as well to be certain anything that was
+	 * allocated is freed.
 	 */
 	cancel_work_sync(&private->io_work);
 	cancel_work_sync(&private->crw_work);
+	flush_work(&private->notoper_work);
 
 	list_for_each_entry_safe(crw, temp, &private->crw, next) {
 		list_del(&crw->next);
@@ -213,9 +221,14 @@ static void vfio_ccw_mdev_close_device(struct vfio_device *vdev)
 	/*
 	 * Ensure these work items are drained, in the event the
 	 * device is re-opened instead of released.
+	 *
+	 * notoper_work needs to be given a chance to run if it
+	 * is queued, so any memory associated with the channel
+	 * program can be returned.
 	 */
 	cancel_work_sync(&private->io_work);
 	cancel_work_sync(&private->crw_work);
+	flush_work(&private->notoper_work);
 
 	vfio_ccw_unregister_dev_regions(private);
 }
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
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
 
 int vfio_ccw_sch_quiesce(struct subchannel *sch);
 void vfio_ccw_sch_io_todo(struct work_struct *work);
 void vfio_ccw_crw_todo(struct work_struct *work);
+void vfio_ccw_notoper_todo(struct work_struct *work);
 
 extern struct mdev_driver vfio_ccw_mdev_driver;
 
-- 
2.55.0

