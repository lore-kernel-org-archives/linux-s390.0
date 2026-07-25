Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2B2571D7;
	Sat, 25 Jul 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993238; cv=none; b=oOaaKWLUG6ML+cuoB/gAvZ//HkbO6oH9nEf97TsetvrsJYfgHHgsrBHOu4gH/6nRSDzX3WSx2JZRYXbkaCxg1cjAT/g2P13mmR5ccjqevs4mZE4C/0VromnrEAcBSuawluzwDMsmYwKSnBbU7jYctEpmZvrr+9kDEsCO4EYI5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993238; c=relaxed/simple;
	bh=u2zK9k06k93JGJNTuH+Q/kzwYFhYrf3rw7o9mmFoSpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ytn9uCqTFhou60zsdZ+6eKSIvIfBcALGVfM2droCOo8hbUrq7RB4FIFxBoCpSLnY5s/Ci67OqXo0nPIs46TTNyLqwp0wVuX+IvcoUf9lhim6nuqKRaP4+S3qMl31OTwZ2yshjUj6L77z6MuT1rrLeeRoVdSgqleNpXIVRAitVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mqWDozXI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mqWDozXI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PDlhsk3116604;
	Sat, 25 Jul 2026 15:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=txHDBvFl0LIvtwYcB
	VhwqLsTswKD8vihnAy33QHGsas=; b=mqWDozXIzYp6wjAMCsHucWG0EcT0v1A99
	4+gfa+sVJUTRGKfVpot4Uexyh3A3MBWMK5EbRZebTd5QD4GNE0l6HZFygBVEsQFa
	riXZ+niuSwY/aYVOGw2USI5LaK50MTd9jH/MGf8H8ZzKr74C6t5GHuMbMYMQBQyT
	Dkr5ZNMsr/Nye/o1vwngg2wYgi2su3Ox8CjCAzFWjkPgsYqx+MOesIi0OMBEKcBa
	ZqowsUFpgRdLoPMUpXpCiuKZLUKzllcI0fWFagkAEJGcfC0KolClTSZyeqnyVl5k
	bO1AmaWAj6q/ldArm+T0Vrq84p9vQLfXB3xufQv17PQYAtmQJYOVw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc0jyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PFQIVa013958;
	Sat, 25 Jul 2026 15:27:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn5h9n25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PFR9nj51577168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 15:27:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3D31200FB;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA873200F9;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 74DCE16281B; Sat, 25 Jul 2026 17:27:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v4 8/9] s390/vfio_ccw: implement a channel program mutex
Date: Sat, 25 Jul 2026 17:27:04 +0200
Message-ID: <20260725152705.3958100-9-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260725152705.3958100-1-farman@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T2DI0WI3ZorvZ4GbRKleK21wHTtn6kqZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfX8FvAxongQ+JW
 t+7yb+amSAMI+MeubhpFyPJaaPQuWTDlpL5vugMHg16NXvk2+gRavF2V/O+7NQyZtoOO/1rfcX9
 S0t+lrnasQlmrJxuZ4I8Uh0rs85Koq9256jWs7Bto0/8KcOa7GEOT7fkRK4l/LD2qcHNRyiWBpE
 I0bJCcOWssPMUhML7cq9E7SZ5wL8SMX9e2PI2NrNQBkUzMIX613I9qehixS2YrXFf4rxP0Ji64u
 OqjvlcPt+RO2OwZJoXutzrUeGHoqwnXD63VeJmfqxMsT5gunTprr4VVe/qb9tDQ0Le9vBaEC3fX
 fkWOaMXcU5amT/FNAuABiWJ4JNdp0hHo9iL4hsbiMTD2fRPrRUgphnQLoTAw3r6J78kthDrI2W3
 SqLHiGVwXUF8wJVnXFneXA7tS58i6KKEyKH9yLM5FBfxlkTHAsDzm5FvKO9Y1+s6ek8Apa6mFTf
 3Ol7f+/1xQLfbESq+nQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfX4c3gIWbDcseu
 3z18oo15wla4O82chnkrAqMSxQ/bB7XtLjCXS6U3ZZP8l56isfhWbpfTQRNAmHbUNu74qZYnhHi
 lma8bNjlSKTbF1kHvxAJAi6ANgfVjAo=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a64d5d2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ivfjLWcg7tKDF-lgONIA:9
X-Proofpoint-GUID: T2DI0WI3ZorvZ4GbRKleK21wHTtn6kqZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250144

The channel_program struct is manipulated without a serialization
mechanism to ensure consistent behavior. Take a broad stroke of
putting the entire structure behind a mutex, and ensure everything
that needs private->cp holds this mutex.

There are a couple where the cio layer's subchannel->lock performs
this role in this code, which isn't correct (it should only be used
when touching the actual subchannel, like cio_enable_subchannel()),
so adjust the locations where that spinlock is acquired/released
to correctly coexist with this new mutex.

Fixes: 0a19e61e6d4c ("vfio: ccw: introduce channel program interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c      | 30 +++++++++++++++++++++++++----
 drivers/s390/cio/vfio_ccw_drv.c     |  6 ++++++
 drivers/s390/cio/vfio_ccw_fsm.c     | 20 ++++++++++++-------
 drivers/s390/cio/vfio_ccw_ops.c     | 10 +++++++++-
 drivers/s390/cio/vfio_ccw_private.h |  3 +++
 5 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index 5ef082b8289a..ab66caff9894 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -738,12 +738,15 @@ static int ccwchain_fetch_one(struct ccw1 *ccw,
  */
 int cp_init(struct channel_program *cp, union orb *orb)
 {
-	struct vfio_device *vdev =3D
-		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
+	struct vfio_ccw_private *private =3D
+		container_of(cp, struct vfio_ccw_private, cp);
+	struct vfio_device *vdev =3D &private->vdev;
 	/* custom ratelimit used to avoid flood during guest IPL */
 	static DEFINE_RATELIMIT_STATE(ratelimit_state, 5 * HZ, 1);
 	int ret;
=20
+	lockdep_assert_held(&private->cp_mutex);
+
 	/* this is an error in the caller */
 	if (cp->initialized)
 		return -EBUSY;
@@ -784,11 +787,14 @@ int cp_init(struct channel_program *cp, union orb *=
orb)
  */
 void cp_free(struct channel_program *cp)
 {
-	struct vfio_device *vdev =3D
-		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
+	struct vfio_ccw_private *private =3D
+		container_of(cp, struct vfio_ccw_private, cp);
+	struct vfio_device *vdev =3D &private->vdev;
 	struct ccwchain *chain, *temp;
 	int i;
=20
+	lockdep_assert_held(&private->cp_mutex);
+
 	if (!cp->initialized)
 		return;
=20
@@ -841,11 +847,15 @@ void cp_free(struct channel_program *cp)
  */
 int cp_prefetch(struct channel_program *cp)
 {
+	struct vfio_ccw_private *private =3D
+		container_of(cp, struct vfio_ccw_private, cp);
 	struct ccwchain *chain;
 	struct ccw1 *ccw;
 	struct page_array *pa;
 	int len, idx, ret;
=20
+	lockdep_assert_held(&private->cp_mutex);
+
 	/* this is an error in the caller */
 	if (!cp->initialized)
 		return -EINVAL;
@@ -883,10 +893,14 @@ int cp_prefetch(struct channel_program *cp)
  */
 union orb *cp_get_orb(struct channel_program *cp, struct subchannel *sch=
)
 {
+	struct vfio_ccw_private *private =3D
+		container_of(cp, struct vfio_ccw_private, cp);
 	union orb *orb;
 	struct ccwchain *chain;
 	struct ccw1 *cpa;
=20
+	lockdep_assert_held(&private->cp_mutex);
+
 	/* this is an error in the caller */
 	if (!cp->initialized)
 		return NULL;
@@ -931,10 +945,14 @@ union orb *cp_get_orb(struct channel_program *cp, s=
truct subchannel *sch)
  */
 void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
 {
+	struct vfio_ccw_private *private =3D
+		container_of(cp, struct vfio_ccw_private, cp);
 	struct ccwchain *chain;
 	dma32_t cpa =3D scsw->cmd.cpa;
 	u32 ccw_head;
=20
+	lockdep_assert_held(&private->cp_mutex);
+
 	if (!cp->initialized)
 		return;
=20
@@ -977,9 +995,13 @@ void cp_update_scsw(struct channel_program *cp, unio=
n scsw *scsw)
  */
 bool cp_iova_pinned(struct channel_program *cp, u64 iova, u64 length)
 {
+	struct vfio_ccw_private *private =3D
+		container_of(cp, struct vfio_ccw_private, cp);
 	struct ccwchain *chain;
 	int i;
=20
+	lockdep_assert_held(&private->cp_mutex);
+
 	if (!cp->initialized)
 		return false;
=20
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
index c197ad5ab580..4830f0dd9c3a 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -91,6 +91,8 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
=20
 	is_final =3D !(scsw_actl(&irb->scsw) &
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
+
+	mutex_lock(&private->cp_mutex);
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
 		if (is_final && private->state =3D=3D VFIO_CCW_STATE_CP_PENDING) {
@@ -98,6 +100,8 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 			cp_is_finished =3D true;
 		}
 	}
+	mutex_unlock(&private->cp_mutex);
+
 	mutex_lock(&private->io_mutex);
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
 	mutex_unlock(&private->io_mutex);
@@ -131,7 +135,9 @@ void vfio_ccw_notoper_todo(struct work_struct *work)
=20
 	private =3D container_of(work, struct vfio_ccw_private, notoper_work);
=20
+	mutex_lock(&private->cp_mutex);
 	cp_free(&private->cp);
+	mutex_unlock(&private->cp_mutex);
 }
=20
 /*
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_=
fsm.c
index 4d47a3c7b9a0..cefdfcb0cad7 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -25,17 +25,15 @@ static int fsm_io_helper(struct vfio_ccw_private *pri=
vate)
 	unsigned long flags;
 	int ret;
=20
-	spin_lock_irqsave(&sch->lock, flags);
-
 	orb =3D cp_get_orb(&private->cp, sch);
-	if (!orb) {
-		ret =3D -EIO;
-		goto out;
-	}
+	if (!orb)
+		return -EIO;
=20
 	VFIO_CCW_TRACE_EVENT(5, "stIO");
 	VFIO_CCW_TRACE_EVENT(5, dev_name(&sch->dev));
=20
+	spin_lock_irqsave(&sch->lock, flags);
+
 	/* Issue "Start Subchannel" */
 	ccode =3D ssch(sch->schid, orb);
=20
@@ -71,7 +69,6 @@ static int fsm_io_helper(struct vfio_ccw_private *priva=
te)
 	default:
 		ret =3D ccode;
 	}
-out:
 	spin_unlock_irqrestore(&sch->lock, flags);
 	return ret;
 }
@@ -251,6 +248,8 @@ static void fsm_io_request(struct vfio_ccw_private *p=
rivate,
 	private->state =3D VFIO_CCW_STATE_CP_PROCESSING;
 	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
=20
+	mutex_lock(&private->cp_mutex);
+
 	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
 		orb =3D (union orb *)io_region->orb_area;
=20
@@ -299,6 +298,8 @@ static void fsm_io_request(struct vfio_ccw_private *p=
rivate,
 			cp_free(&private->cp);
 			goto err_out;
 		}
+
+		mutex_unlock(&private->cp_mutex);
 		return;
 	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
 		VFIO_CCW_MSG_EVENT(2,
@@ -319,6 +320,7 @@ static void fsm_io_request(struct vfio_ccw_private *p=
rivate,
 	}
=20
 err_out:
+	mutex_unlock(&private->cp_mutex);
 	private->state =3D VFIO_CCW_STATE_IDLE;
 	trace_vfio_ccw_fsm_io_request(scsw->cmd.fctl, schid,
 				      io_region->ret_code, errstr);
@@ -409,7 +411,11 @@ static void fsm_close(struct vfio_ccw_private *priva=
te,
=20
 	private->state =3D VFIO_CCW_STATE_STANDBY;
 	spin_unlock_irq(&sch->lock);
+
+	mutex_lock(&private->cp_mutex);
 	cp_free(&private->cp);
+	mutex_unlock(&private->cp_mutex);
+
 	return;
=20
 err_unlock:
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index 6c74d596be9d..9242a37677a0 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -38,8 +38,13 @@ static void vfio_ccw_dma_unmap(struct vfio_device *vde=
v, u64 iova, u64 length)
 		container_of(vdev, struct vfio_ccw_private, vdev);
=20
 	/* Drivers MUST unpin pages in response to an invalidation. */
-	if (!cp_iova_pinned(&private->cp, iova, length))
+	mutex_lock(&private->cp_mutex);
+	if (!cp_iova_pinned(&private->cp, iova, length)) {
+		mutex_unlock(&private->cp_mutex);
 		return;
+	}
+
+	mutex_unlock(&private->cp_mutex);
=20
 	vfio_ccw_mdev_reset(private);
 }
@@ -50,6 +55,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *v=
dev)
 		container_of(vdev, struct vfio_ccw_private, vdev);
=20
 	mutex_init(&private->io_mutex);
+	mutex_init(&private->cp_mutex);
 	private->state =3D VFIO_CCW_STATE_STANDBY;
 	INIT_LIST_HEAD(&private->crw);
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
@@ -91,6 +97,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *v=
dev)
 out_free_cp:
 	kfree(private->cp.guest_cp);
 out_free_private:
+	mutex_destroy(&private->cp_mutex);
 	mutex_destroy(&private->io_mutex);
 	return -ENOMEM;
 }
@@ -142,6 +149,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
ice *vdev)
 	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
 	kmem_cache_free(vfio_ccw_io_region, private->io_region);
 	kfree(private->cp.guest_cp);
+	mutex_destroy(&private->cp_mutex);
 	mutex_destroy(&private->io_mutex);
 }
=20
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_=
ccw_private.h
index e2256402b089..b595fd81f370 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -94,6 +94,7 @@ struct vfio_ccw_parent {
  * @schib_region: MMIO region for SCHIB information
  * @crw_region: MMIO region for getting channel report words
  * @num_regions: number of additional regions
+ * @cp_mutex: protect against concurrent update of CP resources
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
  * @scsw: scsw info
@@ -116,7 +117,9 @@ struct vfio_ccw_private {
 	struct ccw_crw_region	*crw_region;
 	int num_regions;
=20
+	struct mutex		cp_mutex;
 	struct channel_program	cp;
+
 	struct irb		irb;
 	union scsw		scsw;
 	struct list_head	crw;
--=20
2.53.0

