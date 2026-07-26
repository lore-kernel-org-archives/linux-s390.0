Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB1A2931F1;
	Sun, 26 Jul 2026 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785038499; cv=none; b=n7NpH3/C0hQVjI4P0Xl1Wpo9oJEDQ9xECh2WwC7ueNTZz0upHewigLwyF3I8o/C69Iy73MtQbJ1+Ldygb4907zPhQ1IOY5S944XbBpqDMxR/ok9eAfeLxBWxT+Urpm9+2zyl2D2E3yHwWGCHhfOOMEMIiqSBBVDVEIOd4zhgyO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785038499; c=relaxed/simple;
	bh=vhUFaFsKCgasR5z/REaz2Oum9NFrNaPL9E8IEuAOJ3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7aZnPgItJtgX3+5jyMSTlpS9Ltoo6AEBuKNrrmeGMh3Esji+AVAIYP4M3L/oCFijVFMRckwTJs4mIiH/f7hwtT+SvLKM7xvoZmdIBDgB4x+o7/x1qnGLmuUAE/6ffzBd80jVm6TTx5poU1PPHTGo2SQQqnXOoke+dk9GA/Qiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tmlgJlJX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tmlgJlJX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PNI0I31945665;
	Sun, 26 Jul 2026 04:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jtyxW3b7YUceff/eM
	F8LXHcihh+o/wU1vxkpKmB5Kk8=; b=tmlgJlJXEFleaI8T7bhkv+V+uMVr+w3mM
	PtchEeTJ3RUFhjnCjRH6YBJQzymEKiP98d5uF/uqhRmHLeBm9q4eIgDxwFrO2Mnp
	A4BoumMS0zAwm7qlPaGOLCDW2fcr/x3ciKg0rGFDmkosjQGzHlLyg+cZnSZgqaXi
	Lwyz44k3mV2oo/rUXibp2fOq2ryQvdkl45x2Rv/ocn2RkvZZWhTXQWwa+aIGCBv7
	Hx6Ik5iRj3IBwoulmETitNpHPmy9+gKliuTFArF9NbHMMfefO0xrwPmUJnHosogp
	kD2QxPXY1h52xJPGegyMB6sSTK4euG6oGeuaXpNSI+mu8rNbiiqQA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcj87j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66Q3uuKK010080;
	Sun, 26 Jul 2026 04:01:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvrepj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q41Wld27460016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 04:01:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F2D0200C7;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C208200CC;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 2BDC8162820; Sun, 26 Jul 2026 06:01:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v5 08/10] s390/vfio_ccw: move cp cleanup out of not operational
Date: Sun, 26 Jul 2026 06:01:27 +0200
Message-ID: <20260726040129.2946151-9-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726040129.2946151-1-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G-o6U3NzBRiYTmZMeRfn8_ZYHFpF_HTf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfX2/5bSqvhAsUj
 3yemBNT/hqW0jZsW/w/QpSJDGxycf3FeSXkW1nc1/7q3vM5WjfAah2vFje8w/SQiGJSJS+JKtgY
 oG09xzDAUAaBRJHB/CUFVB39RRIABqE=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6586a1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=eUPndkpJGv8SUAYCnnQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfXzlTXigCDE5/s
 X7SOBSYg4v5pRhHo4uj0oeEvdOh1eqSPclq6Vpf1GYkx4DgYuvCUobFDuqim5hppCGOFAVoVoRM
 lAmX+V8RHbYMZH6zVvHzM/tXrFDFM/ubGwBwjsXhmfa8gfmYlAYDgmn5Shgno7exppcCxrPsHJY
 w5ERC+Rw+fSOlGLFJVgTSR0E0ezTP2FxhOW6IqqMORQKys5nLauXmnN7cGUGtDAwDaAAMTJ7nYH
 r6GCj0oqJATpajEIwswzhFTMXnDVzYERJqNYG6g4mN0iQgPs5lPQ9+aGMsHBoc//ElTHKanNatE
 ln7Soc+bETweDmeZoM+IngjIrO0SW97cFPk1BxUXjn6aUTXLA7OA3lJ/DlaZFB108PMX2CblbgX
 /nW3TvAYcUechu7YeO2jqAAH3JxZzjRmJSG7YmDga76o1EalKE2wr0JqwQerJcPy/jWtMhCKtra
 qm+91B8X7OQhPaQIkfg==
X-Proofpoint-GUID: G-o6U3NzBRiYTmZMeRfn8_ZYHFpF_HTf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_07,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260033

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
 drivers/s390/cio/vfio_ccw_ops.c     | 2 ++
 drivers/s390/cio/vfio_ccw_private.h | 3 +++
 4 files changed, 15 insertions(+), 2 deletions(-)

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
index 9048c1e6e7f0..26c19f0e5e47 100644
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
@@ -138,6 +139,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
ice *vdev)
=20
 	cancel_work_sync(&private->io_work);
 	cancel_work_sync(&private->crw_work);
+	cancel_work_sync(&private->notoper_work);
=20
 	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
 	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
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

