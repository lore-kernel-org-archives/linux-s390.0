Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007312B143;
	Tue, 28 Jul 2026 03:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785210399; cv=none; b=DGG1W9wm6cHSafXEv8nUES6xa6OUmJAc5eoKqlXNn/Ro3X8t0VE3KgAUjFP/YSMn2rIdDYfycOHfmMxJo/t8wKc5TnNbSfXZRMfCzM9ouEVVXUzXhUF+OIzQ/Y+2e3Kcz8cQs+/EtZziLsqp3VCr+BoW5lcLrthD1eFYoOk0438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785210399; c=relaxed/simple;
	bh=io6x3nA72pTA1hFUFfnE6wexECiMroBJvUj3ONzkADc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PieOFJN2b/09uoRJDoVozkUg9n3cT29V6NiRd89PeUOSQ+Z6fQjAkSz8tWuNgF+tAvNCw1mAiEmxQXQnJiin0Ay3fiA5hVLUkONc7/xLLXL425zVXGpd4YfAZRLu8uSBU9FcGE8KRXdofD+dQ4m7MVpfLR+bHvtJXChWYwpcid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lFW3s0fD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lFW3s0fD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0lYBH3751590;
	Tue, 28 Jul 2026 03:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GP+SiwQBTq9QAtKkg
	oBZfMm0nxpLWAtcULDly9mVJkE=; b=lFW3s0fDiHkFwEDB9B580pNlZCiRt8UfD
	tezZ3H/N0olGuKyvBO/UDbGsAMTddkiJNRf+3Ez4C9lvAl4e282T+4HGlL4uNa+m
	Rv5gDUMNq1Lf/tNdp8pw+4ubstlzETfebZfhdYupu3g9dpZV1cC85HD5qymOKMph
	EQpI14OCyiz5Y6QHxcI/xyH7k/evwpBYL/hiZKZFoCM9kinpYcBA1/IaVuZhEC4s
	ZniMAFyGsOi3im0Ih3Wphx9M0Z+9Oe/DMUqbyufBt+xIbtULOU7TZ9TtjEsaOuiP
	s78gE7cWoHNpPMDTo9bDOKXqz/yYluF2A3qUU5bTSslXyyyrGtkLg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7ba14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 03:46:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S3fUSl019492;
	Tue, 28 Jul 2026 03:46:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw08fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 03:46:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S3kUpN37683462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 03:46:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86AE920242;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D83620240;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 28 Jul 2026 03:30:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 23D9C16282C; Tue, 28 Jul 2026 05:30:24 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v9 09/10] s390/vfio_ccw: selectively expand io_mutex
Date: Tue, 28 Jul 2026 05:30:21 +0200
Message-ID: <20260728033022.2658232-10-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728033022.2658232-1-farman@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: beihfFYhiFDQspeT1PjPTwmiwo7bYaR9
X-Proofpoint-ORIG-GUID: beihfFYhiFDQspeT1PjPTwmiwo7bYaR9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAyOCBTYWx0ZWRfX638Dtk6gQvaf
 iFaB4N/a0uvgqdNVfY3vAQaQ1Fki/UDa2nKL0xvmXIXzFtfLVggW6V63Fu9mU5Vx3D8vnFtbN24
 aifVpvWeNFIuqhtPH5841CSRq5iDSTZyLlvYzjQAqVfH6zKBaql5UbY/uYjNu44YueXK8QAjXmO
 TICReWea0t6OsorFmdGMMSEUcFr33LKiAl57BD/aJ5XGAayg6scKX2To86hg0DYMwVrNYMfwFDT
 NYCTyVkNrO8URnxx5T2ZgM9EJiJ0hfu712vnbXhjNeq2Mj1B/+ZVeYrYg+lgUaCJqYHnxunjrg2
 bTyF1NSGzOLyBYUmj7+RIAEy+Al62vJZfZ9YCpg9/QXMN0N2kUZ+239PBfBMnk7puY2qsnkW/Vg
 YtFclzmxJboGexHd2Sh9D06/cSmXxr/e+e572FFNCuwctVhwcC1+KTZW8380V5HOekmLevcRf7I
 NOCb3shF1goRisK0XEA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a68261d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EkIAoCbfkmX2K6UF1qUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAyOCBTYWx0ZWRfXxcNF0XZbmGud
 4BlmCqQw45fQi4cRM0DMxIidQvCJvHIrf0N0pZ+AoTjrtvrai4deavYbmh1m21B+c3i9eSkx0oK
 hD/xIaXp5VLupLDMrc8ZqqhFMwiSOoc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280028

The io_mutex was defined to serialize the io_regions, but then has
also sort of been associated with the I/O themselves because of
the close relationship they share.

With the handful of races that are possible, the choices are either to:
 A) expand the scope of io_mutex to close these remaining windows, or
 B) reduce the scope of io_mutex to just io_region, and introduce a new
    lock mechanism for the remaining I/O resources

This patch implements A, since B brings with it a lot more interactions
that would need to be tracked and kept in a correct hierarchy. It also
takes advantage of the workqueue element for cp_free() that now gets
called out of fsm_notoper(), which could be invoked out of an interrupt
context and thus cannot acquire a mutex itself.

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

