Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB53BED69;
	Mon, 20 Jul 2026 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578781; cv=none; b=SkL6czdpxlvnARa0ptO81yiroghs4N+aMI/cRVoOA9gc26gcGckbjP0F9xhg3fqWd5+tCVivQEkScatoAQzbyt0wxeYS0/ZeU+cj+Vgnl/CGCSa58gQc0B7H/BN15h5/fTSxTJHiCBgwr6gbkk7vC89YW289o8CunHDQ9wDoPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578781; c=relaxed/simple;
	bh=lpJrG6iT9scBVYyD864SCam0wBve1Emeth0KEeF2PiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUfQN04qxp+skmlcTPDxMESYdRD04d4lAsnDEAkyGhAIvumnTyLx6SnEl/btn6KJLZLEqEHG6KdVP2y/Fa9jux+Xn+Wj/h5qsCE2hgXxThSojk6YwoUtqZiVaeauyRLmaUNm7dMlaih9umFwmpNteOgWBC0tOSMhgCdFtINIFMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MwEJs7GK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MwEJs7GK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJfsXt1246280;
	Mon, 20 Jul 2026 20:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WPUskg3wADi66krTy
	G85jNapQrPVJvQLs8/ASWZo1tI=; b=MwEJs7GK5xU5a1X46wrjm3XpmNL9aP50l
	HScsSAVatSyGyCnpoh+rzfmWg5AaWDJ9opqPzt71QdJXT4lI7IM/IeEeW9c5lR9M
	XfOLeZ78cy46stwAvzYG6c5wY6Rc0CbDW5/FcnucivFNS1J4gewOCnOYLJgHud/d
	aGrxom8n81PsyMdAe/88hc2AOa/OFi0qkbdCwu8UaZVokzlsCfJAiL8uQItiyDxZ
	swDaiOr9CuCQBPWTLwt1MNSvHYLdn9lfrRoDVyoYKQ6qiGfcoFPmUH9ONQ930T5x
	NjOrdi8fozlYME/2AJFFMy4ju+Z4bY6VihEOHEjBJjxlqKsbGF7nw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77a9bth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KKJb9p029514;
	Mon, 20 Jul 2026 20:19:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjq734-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:19:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KKJX4Z40435976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 20:19:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F57F2004D;
	Mon, 20 Jul 2026 20:19:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0125D2004B;
	Mon, 20 Jul 2026 20:19:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 20 Jul 2026 20:19:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id C25821627A5; Mon, 20 Jul 2026 22:19:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 6/7] s390/vfio_ccw: implement a channel program lock
Date: Mon, 20 Jul 2026 22:19:30 +0200
Message-ID: <20260720201931.976660-7-farman@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: oKQiAWJkwtVUlFu2iQc-eTnxDsTyKDWl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfXzaT7+s4YclG8
 dXz4QwxNZSgvpNqnpV4h2VKPBVO4gP3KzEkqPrq5KQNtb22p1AK8oyqoP1hwswxLPD6KqgsHR9O
 7os0M5wGoLwEOEwjJsOGX93PGAdKJdo=
X-Proofpoint-GUID: oKQiAWJkwtVUlFu2iQc-eTnxDsTyKDWl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX+uIRxKZVqbZA
 L9QKJT6GXck2cVKRccWFUAbQmEZw2QduUpSwEEPneqTq819Gf7RKQoqNOBBxhZI5MLiltdag+hL
 +ejmTOWUs2G6lkF4i6TWZYNtFcevfJMTUjh46425hdRB6vw0E4Fg7IZi/YnwrSMkJqoRzbvgjfc
 UIV05K7AJ4a8s+jjj2/5PoJQ7G0eT/Ro2pd1K/qU/l3hL3VRMJAFwKTw5b21+feBafQmT5odrwz
 VFWstPa6SCweXHckRkJGZ97ZrFaM9bdfZuOlrMW8PMycYPIzwH5l1rBWyssu+6WvG2fYuPCx0yC
 X2XiIIMgL0Aq9bgFXuNNqsNbA8ATPXv+IAvBFkTQkwRrZw5JIO8FVUhJuoGGDpAiY9hGAuh23RY
 wraFepmM9DWZTp3jP3Y7CxLpHj7YhFB7cv1DlTTwW8ZdhfhIm4YZvOeZhGnPp9oWM71V4BosFEk
 S/7POXKnz5r/6afVJYQ==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5e82da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=nvEYHYHUJT7TizB4bHYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200220

The channel_program struct is manipulated without a serialization
mechanism to ensure consistent behavior. Take a broad stroke of
putting the entire structure behind a spin lock, which can be
acquired with or without the mutex guarding the I/O regions that
feed into the population of the channel program.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c      | 13 ++++++++++++-
 drivers/s390/cio/vfio_ccw_cp.h      |  1 +
 drivers/s390/cio/vfio_ccw_drv.c     |  6 +++++-
 drivers/s390/cio/vfio_ccw_ops.c     |  8 +++++++-
 drivers/s390/cio/vfio_ccw_private.h |  2 ++
 5 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index c6f0264fb5d3..7bfb3a952817 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -790,7 +790,7 @@ int cp_init(struct channel_program *cp, union orb *or=
b)
  * @cp, which must have been returned by a previous call to cp_init().
  * Otherwise, undefined behavior occurs.
  */
-void cp_free(struct channel_program *cp)
+void cp_free_locked(struct channel_program *cp)
 {
 	struct vfio_device *vdev =3D
 		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
@@ -810,6 +810,17 @@ void cp_free(struct channel_program *cp)
 	}
 }
=20
+void cp_free(struct channel_program *cp)
+{
+	struct vfio_ccw_private *private =3D
+		container_of(cp, struct vfio_ccw_private, cp);
+	unsigned long flags;
+
+	spin_lock_irqsave(&private->cp_lock, flags);
+	cp_free_locked(cp);
+	spin_unlock_irqrestore(&private->cp_lock, flags);
+}
+
 /**
  * cp_prefetch() - translate a guest physical address channel program to
  *                 a real-device runnable channel program.
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_c=
p.h
index d547dbc969cc..edfb47a292ca 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -48,6 +48,7 @@ struct channel_program {
 };
=20
 int cp_init(struct channel_program *cp, union orb *orb);
+void cp_free_locked(struct channel_program *cp);
 void cp_free(struct channel_program *cp);
 int cp_prefetch(struct channel_program *cp);
 union orb *cp_get_orb(struct channel_program *cp, struct subchannel *sch=
);
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
index 1a095085bc72..bfb68de6e52c 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -83,6 +83,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 {
 	struct vfio_ccw_private *private;
 	struct irb *irb;
+	unsigned long flags;
 	bool is_final;
 	bool cp_is_finished =3D false;
=20
@@ -91,13 +92,16 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
=20
 	is_final =3D !(scsw_actl(&irb->scsw) &
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
+	spin_lock_irqsave(&private->cp_lock, flags);
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
 		if (is_final && private->state =3D=3D VFIO_CCW_STATE_CP_PENDING) {
-			cp_free(&private->cp);
+			cp_free_locked(&private->cp);
 			cp_is_finished =3D true;
 		}
 	}
+	spin_unlock_irqrestore(&private->cp_lock, flags);
+
 	mutex_lock(&private->io_mutex);
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
 	mutex_unlock(&private->io_mutex);
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index e695cd985369..d2475b3158cf 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -36,10 +36,15 @@ static void vfio_ccw_dma_unmap(struct vfio_device *vd=
ev, u64 iova, u64 length)
 {
 	struct vfio_ccw_private *private =3D
 		container_of(vdev, struct vfio_ccw_private, vdev);
+	unsigned long flags;
=20
 	/* Drivers MUST unpin pages in response to an invalidation. */
-	if (!cp_iova_pinned(&private->cp, iova, length))
+	spin_lock_irqsave(&private->cp_lock, flags);
+	if (!cp_iova_pinned(&private->cp, iova, length)) {
+		spin_unlock_irqrestore(&private->cp_lock, flags);
 		return;
+	}
+	spin_unlock_irqrestore(&private->cp_lock, flags);
=20
 	vfio_ccw_mdev_reset(private);
 }
@@ -54,6 +59,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *v=
dev)
 	INIT_LIST_HEAD(&private->crw);
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
+	spin_lock_init(&private->cp_lock);
=20
 	private->cp.guest_cp =3D kzalloc_objs(struct ccw1, CCWCHAIN_LEN_MAX);
 	if (!private->cp.guest_cp)
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_=
ccw_private.h
index 0501d4bbcdbd..061b594fde36 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -115,7 +115,9 @@ struct vfio_ccw_private {
 	struct ccw_crw_region	*crw_region;
 	int num_regions;
=20
+	spinlock_t		cp_lock;
 	struct channel_program	cp;
+
 	struct irb		irb;
 	union scsw		scsw;
 	struct list_head	crw;
--=20
2.53.0

