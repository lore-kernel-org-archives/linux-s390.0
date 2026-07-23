Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35A38E8D8;
	Thu, 23 Jul 2026 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828884; cv=none; b=b0KWRYF4lBDubhkHx952YWfvYdrqdHyjtBCwKp0IcpRmjeWqebpRNlmT+l5Tq3k9L4qcoEsYooRR+QklzZLThvfqbX9SgE8eJQeiMVycNAF42yHycCugyeTEjVsPtagUmWwmQNsqJSEi+wHzeeN30iRnERBI1qFbGuwWDiaDJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828884; c=relaxed/simple;
	bh=CGHOSA4YvKqaToYBuBTQmTKjYIPCjI8nZiGJ0sYR1UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSR6KADdvNF+Nx6cpx0oHyK1+wVnPfubgYMkiWM5tDBmM4jE9iUBSe+tW3CATtIE749CvpsqpKjfNcCKTnLNxoc2hJyITGjGeTFjIys6hw8mXmlMBsf1xixdOOQvwm77F5C+rv6jTk2RqDIgzzEV82Ynx3viheqRR0zxhDoflHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GbBpq2J3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GbBpq2J3"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHg44r3688684;
	Thu, 23 Jul 2026 17:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dIjI9qQbTOc0RPofm
	UxkbZs77CEJzKdRYNgemPgjOAs=; b=GbBpq2J33kJ2br+OEttD8ZgQX+Y++6oKu
	fyaTgp3KcIjX2eLGn6jzcDskgmmq3EWDEBEL0fDYz3Y462NRh7z4N3Z7kDWuJ4+n
	cd5PuFc93QJ8SFy2k1jgCxnecs4idG2Z0jC2eL8/pjOwNfaW4PAk7BmgVTNRZo7z
	d2bmfS2AOFMMZkZxs0feSKqhBnF4si/Iq9YZM5UlADz0XKoBSGGfUFShaAcrHU09
	EUKa2wg/hKC5DScdnqbhCK2L8g4ING9/dKYTGdzfXVQw5UgoLcG25uA5D+SLypMQ
	Nbaa1SHSBq18ibylxOmc02Z/5ZMxho8+lzPxFmqLhTLIuZpWwEivA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahg96t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:47:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NHZ22k009756;
	Thu, 23 Jul 2026 17:47:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gn59s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:47:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NHltoD54657476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 17:47:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F1192004F;
	Thu, 23 Jul 2026 17:47:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE6872004D;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id AC26C162801; Thu, 23 Jul 2026 19:47:54 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v3 7/8] s390/vfio_ccw: implement a channel program mutex
Date: Thu, 23 Jul 2026 19:47:50 +0200
Message-ID: <20260723174751.1180334-8-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723174751.1180334-1-farman@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ofEI0HrvVNBBT2juYtml7t_DL8n6143N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfX4UTYf8C+g5Rw
 zvkwcJMTDOzIZOAIUgS1z2cRdC5KKjFGnDt+7UM2U23671cEmnMPPWGWKhG7ZqEY7x2n9vnY1XD
 ZdF/1rGa+Ktm54V6R3g09C9iaiWsvlLW7zTDl7G2rK2ZgW6uRYF7OnDNyXeQEjtZrehP1PbRvzZ
 +0gNN6SnpVS9w+VakCa0FPGKnLyNCfAWjMffiX4mx64isEfoi8zwMChvnLvlZV8E4sCTnROsKzD
 pQgWRBiD4AxkGYCeL2C4oCGgoqMP7on/QIkRL+1Md82hrywG1aA60lxESan17lKaa5WTgZtNb/b
 o0Thgg4heKwY9ZfCeDOr5HBpFaK6TJP6Er3H80kX89a+iOr0Yrr/8GD9RIJg3FRvCItIILE1r7O
 rEtkHjkzui48Ksqh5mY6etZ/cTe3ZfpGS+cIWwKCiJq/P2MPu5IrMFKu+biQfEcIpZBu67sl141
 qYM/WbwJWnwnDTkCf2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfX//eGdmm8e6IX
 MlZjXx+jiveLKhl80JNcf6ZygyKBmbw2sX7s8ktdms5QogebNhCYiict/9GqCcW6rCOTI82iD2Q
 Ca3PaEjjlcJVooMNovcrdE7yRkThY1E=
X-Proofpoint-GUID: ofEI0HrvVNBBT2juYtml7t_DL8n6143N
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a6253cf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=DdavvDh8zCgnNAJguYcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230173

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
 drivers/s390/cio/vfio_ccw_drv.c     | 10 +++++++++-
 drivers/s390/cio/vfio_ccw_fsm.c     | 22 +++++++++++++++-------
 drivers/s390/cio/vfio_ccw_ops.c     | 10 +++++++++-
 drivers/s390/cio/vfio_ccw_private.h |  3 +++
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
index 1a095085bc72..1d8c2ed9da50 100644
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
@@ -259,12 +263,16 @@ static int vfio_ccw_sch_event(struct subchannel *sc=
h, int process)
 	rc =3D 0;
=20
 	if (cio_update_schib(sch)) {
-		if (private)
+		if (private) {
+			spin_unlock_irqrestore(&sch->lock, flags);
 			vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
+			goto out;
+		}
 	}
=20
 out_unlock:
 	spin_unlock_irqrestore(&sch->lock, flags);
+out:
=20
 	return rc;
 }
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_=
fsm.c
index 4d7988ea47ef..9fbe97bd23f9 100644
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
@@ -171,7 +168,9 @@ static void fsm_notoper(struct vfio_ccw_private *priv=
ate,
 	private->state =3D VFIO_CCW_STATE_NOT_OPER;
=20
 	/* This is usually handled during CLOSE event */
+	mutex_lock(&private->cp_mutex);
 	cp_free(&private->cp);
+	mutex_unlock(&private->cp_mutex);
 }
=20
 /*
@@ -252,6 +251,8 @@ static void fsm_io_request(struct vfio_ccw_private *p=
rivate,
 	private->state =3D VFIO_CCW_STATE_CP_PROCESSING;
 	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
=20
+	mutex_lock(&private->cp_mutex);
+
 	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
 		orb =3D (union orb *)io_region->orb_area;
=20
@@ -300,6 +301,8 @@ static void fsm_io_request(struct vfio_ccw_private *p=
rivate,
 			cp_free(&private->cp);
 			goto err_out;
 		}
+
+		mutex_unlock(&private->cp_mutex);
 		return;
 	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
 		VFIO_CCW_MSG_EVENT(2,
@@ -320,6 +323,7 @@ static void fsm_io_request(struct vfio_ccw_private *p=
rivate,
 	}
=20
 err_out:
+	mutex_unlock(&private->cp_mutex);
 	private->state =3D VFIO_CCW_STATE_IDLE;
 	trace_vfio_ccw_fsm_io_request(scsw->cmd.fctl, schid,
 				      io_region->ret_code, errstr);
@@ -410,7 +414,11 @@ static void fsm_close(struct vfio_ccw_private *priva=
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
index 032a1cdf4df7..04800cfa779b 100644
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
@@ -90,6 +96,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *v=
dev)
 out_free_cp:
 	kfree(private->cp.guest_cp);
 out_free_private:
+	mutex_destroy(&private->cp_mutex);
 	mutex_destroy(&private->io_mutex);
 	return -ENOMEM;
 }
@@ -141,6 +148,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
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
index 0501d4bbcdbd..ac5aaa78a74b 100644
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
@@ -115,7 +116,9 @@ struct vfio_ccw_private {
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

