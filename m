Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693F11D5CFE;
	Tue, 28 Jul 2026 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202524; cv=none; b=aCOEUqSRhpf5hN6y46LCOAP4dNb0wKe6oN3zApU+GQUoEaJ1u4jA0tYd9x31Q0P3VXMmisA9PoGCQjLE4DDn4nXRhVCPkkod98H0iuNFNJyWh1zvEoki3XwMZw84MZh7bcxfi37WvlTTFzG4HFkgu6feFVy7+cHG3GXvP4uKkY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202524; c=relaxed/simple;
	bh=ZfINm5lv3/VxfojJpedQ3k/YlspBA/HzFRNU+194y8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwjaZ4ytPBZFeW9T3apVWylLMurQpsTgfd8O5kMrcvorKqG3rsoBR0BJRDFsNUYICT9ichw7GGLJMb5jcXaWMfeUbnLqlcs/L+MgZjsECTkvZmW0nFWr9veXNqTB1wFvuUwmk9sBjWgTS0cxC2Jr7wrxeH3CgFZpQo6afSsFlIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ecm5/se0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ecm5/se0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0ls4P3783785;
	Tue, 28 Jul 2026 01:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qbafwO2Oo2Rg+mKp8
	rLtE/7Y6jUati6OVhvGs4o+Jk4=; b=Ecm5/se0ilO9tzugtMSUX9kT5jnuHo+hY
	179l2U4EBYDZS3no0b+4F3MvyQn2K/occGaGJC56cJu8D0rs4iqXzRtbbmKzffkf
	dTHNfHS2hZGWUD5WIpPB3yEV4puWaRoi9n6wIMwH0nqM743Tp3MSYZdPivkqEcrg
	zocT7VoGMnFM+jjGtFCm31whFHC20Bvww2jh00onTJP/7APv0s8JLUudmRUM/JuR
	yl5OnpBEsKzkMMyyO4o9Cf+pURqlVI/SdJ1GP5MOnDKQ+dMQoTAE6/VPYyLJvvDY
	35MLo+OBqPpZo0xKGcOMahTEZmqp0cUDf3QSMSqZafoBx8JrJPPEw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xjxg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 01:35:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S1QGbX004597;
	Tue, 28 Jul 2026 01:35:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg7j9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 01:35:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S1ZGA944761544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 01:35:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4E7A200CE;
	Tue, 28 Jul 2026 01:35:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2FBB200D1;
	Tue, 28 Jul 2026 01:35:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 01:35:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 8739D162831; Tue, 28 Jul 2026 03:35:10 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v8 09/10] s390/vfio_ccw: selectively expand io_mutex
Date: Tue, 28 Jul 2026 03:35:08 +0200
Message-ID: <20260728013509.1551753-10-farman@linux.ibm.com>
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
X-Proofpoint-GUID: OrrEO0r3rMlyE6jBR96xf5UqXeodcH9s
X-Proofpoint-ORIG-GUID: OrrEO0r3rMlyE6jBR96xf5UqXeodcH9s
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAwOSBTYWx0ZWRfXzCM16mty9Pe3
 q4vMY0kHSobE8c3M4FqdWBMNZapH9a+hJw9rKdwhhyfXaKG0ksXpgAnISL9+a6a4CQeEsGO9Vx/
 E9RlHycHAv5w4LLzIYmZiG4PgeY8Tlw=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a680759 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=rvqAJIi9A1FxVMVShTgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAwOSBTYWx0ZWRfX3MAXTmH54XlS
 A1As90DRfqjtj58VYNPtyv9J1oQAZ7ZGSEbAXSKakiM1IIXAPrbgztZpx7fbKDQWZseB7W7ByUS
 r39KBqozs3ptlJbLz1g8OQELYKumJaFzda/LAGHCm3kjZMjYNzs5j3yYys+y3I0SjJQaaOJX2V9
 rTdqIW7S2qqFPvO6xRnFTvOp2FYtCJSa1pa4Bh98Ep1Miqn6jlm41Vbg7RG4rOnoLRYWzU+yVCM
 R92uzc25OHfBAomPAA5GDmBXi2Of0Sw1+ziWo73h7VvM0IR3fWHGNUY2JXthpUUhX1IZSJSseDG
 PDgZABSnbD/0OzqBJtcfiE60rVyPJEmvUELGXtLOZI7QrOySWb7g3qBLqiczOZlqrbfiWfcORqc
 XTuuwQtwf6rN3PeIYTxlKzkf+l26hQfsfoLg/xpcpKuiAGSx1emccon7SdzWTFu+Vr6q+AVenzi
 NjSVR3jXQdwAh5h06OA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280009

The io_mutex was defined to serialize the io_regions, but then has
also sort of been associated with the I/O themselves because of
the close relationship they share.

With the handful of races that are possible, the choices are either to:
 A) expand the scope of io_mutex to close these remaining windows, or
 B) reduce the scope of io_mutex to just io_region, and introduce a new
    lock mechanism for the remaining I/O resources

This patch implements A, since B brings with it a lot more interactions
that would need to be tracked and kept in a correct hierarchy.

The biggest functional change is the introduction of a workqueue
element for the cp_free() called out of fsm_notoper(), which is could
be run in an interrupt context and thus cannot be acquiring mutexes.

Fixes: 4f76617378ee ("vfio-ccw: protect the I/O region")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_chp.c     | 2 +-
 drivers/s390/cio/vfio_ccw_cp.c      | 8 +++++++-
 drivers/s390/cio/vfio_ccw_drv.c     | 6 ++++--
 drivers/s390/cio/vfio_ccw_fsm.c     | 5 +++++
 drivers/s390/cio/vfio_ccw_private.h | 3 ++-
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
index f3015132d4b5..9269b54f5cfd 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -98,13 +98,13 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
 	if (pos + count > sizeof(*region))
 		return -EINVAL;
=20
+	mutex_lock(&private->io_mutex);
 	crw =3D list_first_entry_or_null(&private->crw,
 				       struct vfio_ccw_crw, next);
=20
 	if (crw)
 		list_del(&crw->next);
=20
-	mutex_lock(&private->io_mutex);
 	if (i >=3D private->num_regions) {
 		ret =3D -EINVAL;
 		goto out;
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
index 5ef082b8289a..58722c4baa25 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -977,17 +977,23 @@ void cp_update_scsw(struct channel_program *cp, uni=
on scsw *scsw)
  */
 bool cp_iova_pinned(struct channel_program *cp, u64 iova, u64 length)
 {
+	struct vfio_ccw_private *private =3D
+		container_of(cp, struct vfio_ccw_private, cp);
 	struct ccwchain *chain;
 	int i;
=20
 	if (!cp->initialized)
 		return false;
=20
+	mutex_lock(&private->io_mutex);
 	list_for_each_entry(chain, &cp->ccwchain_list, next) {
 		for (i =3D 0; i < chain->ch_len; i++)
-			if (page_array_iova_pinned(&chain->ch_pa[i], iova, length))
+			if (page_array_iova_pinned(&chain->ch_pa[i], iova, length)) {
+				mutex_unlock(&private->io_mutex);
 				return true;
+			}
 	}
+	mutex_unlock(&private->io_mutex);
=20
 	return false;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
index c197ad5ab580..757ff5b2556e 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -91,6 +91,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
=20
 	is_final =3D !(scsw_actl(&irb->scsw) &
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
+	mutex_lock(&private->io_mutex);
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
 		if (is_final && private->state =3D=3D VFIO_CCW_STATE_CP_PENDING) {
@@ -98,9 +99,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 			cp_is_finished =3D true;
 		}
 	}
-	mutex_lock(&private->io_mutex);
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
-	mutex_unlock(&private->io_mutex);
=20
 	/*
 	 * Reset to IDLE only if processing of a channel program
@@ -110,6 +109,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 	 */
 	if (cp_is_finished)
 		private->state =3D VFIO_CCW_STATE_IDLE;
+	mutex_unlock(&private->io_mutex);
=20
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger);
@@ -131,7 +131,9 @@ void vfio_ccw_notoper_todo(struct work_struct *work)
=20
 	private =3D container_of(work, struct vfio_ccw_private, notoper_work);
=20
+	mutex_lock(&private->io_mutex);
 	cp_free(&private->cp);
+	mutex_unlock(&private->io_mutex);
 }
=20
 /*
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_=
fsm.c
index 4d47a3c7b9a0..5fd94e9d5c61 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -170,6 +170,7 @@ static void fsm_notoper(struct vfio_ccw_private *priv=
ate,
 	css_sched_sch_todo(sch, SCH_TODO_UNREG);
 	private->state =3D VFIO_CCW_STATE_NOT_OPER;
=20
+	/* This routine could be called from IRQ context, so defer */
 	queue_work(vfio_ccw_work_q, &private->notoper_work);
 }
=20
@@ -409,7 +410,11 @@ static void fsm_close(struct vfio_ccw_private *priva=
te,
=20
 	private->state =3D VFIO_CCW_STATE_STANDBY;
 	spin_unlock_irq(&sch->lock);
+
+	mutex_lock(&private->io_mutex);
 	cp_free(&private->cp);
+	mutex_unlock(&private->io_mutex);
+
 	return;
=20
 err_unlock:
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_=
ccw_private.h
index e2256402b089..739121116ab6 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -88,7 +88,8 @@ struct vfio_ccw_parent {
  * @state: internal state of the device
  * @completion: synchronization helper of the I/O completion
  * @io_region: MMIO region to input/output I/O arguments/results
- * @io_mutex: protect against concurrent update of I/O regions
+ * @io_mutex: protect against concurrent update of I/O resources
+ *            and @cp lifecycle
  * @region: additional regions for other subchannel operations
  * @cmd_region: MMIO region for asynchronous I/O commands other than STA=
RT
  * @schib_region: MMIO region for SCHIB information
--=20
2.53.0

