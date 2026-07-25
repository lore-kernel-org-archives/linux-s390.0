Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12A2EA47C;
	Sat, 25 Jul 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784993237; cv=none; b=co5mqYvLJbL3OFXrQNOSvEeX8j+ws10x7ZgLK2i5l9u+5iuCeYLpUSH/HaPm6hZyAScR9ZnDIs8xfXxV7uJP7dzNSA1QrBsqMXULz1naOlJPAhJB2xrV33N0NxG8UNBV16P1cIY2MyXI751lZOMxlO2H9D+GQmQFT65vjgC/rkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784993237; c=relaxed/simple;
	bh=wpi4P8y9K1SLjsP3VAuJ4TUlSO/AB6pEtdSw/WzBHDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Van50oOrlYFTuWx8aTMzxqGVwgt6OTxOPSDTZLCqW71cFvfcNex6qUYqL2SYh3QyDKuubuV8lN7gk7HN3To5fGgoYRg8XLpHU3nrjYpd2Pi2LIn9P+MbVJnwQNkoLWgsX04DBnwFOS+ucfWg1pXetGpAXR4T3vwNA4C2bUV+sRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ONy/kQFL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ONy/kQFL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PDlrQp793599;
	Sat, 25 Jul 2026 15:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=inIgiBbYnhUHnNmwl
	Uxkix66hPWZWzn8hk1Xj47z1yw=; b=ONy/kQFLRW1HV9MqQqd6C3NMOow/vnwS9
	y1CsyNfF/LwH02S4LsrsCdPzfoRdiUTRMQGv0jviMTyIVNb8GRelwkDQpjXX7c4U
	l9uH8qEluaoBS2bsgBq43AsOEXS6v0zeiQ+A+rLd7NrEHOMxDjna8ccGlv0QDKXu
	84uHuAWOszA+KoYNQ8ujyigldxoqiVs0e8SxrABCCs6xFOv9ZmsdPukfHia55gRH
	2mul2WFuLM+MuQfXGfc106OYgbUJDgIy/DidT+wAHOkYvstDGF1ipOXaosvMirIk
	PAnv19g7uAFBCfC6sluCz7yuhxYYukWMbMb2Xqlj2WJPR1Uq3lygA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw70kbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PFQKAu016934;
	Sat, 25 Jul 2026 15:27:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn331ntu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 15:27:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PFR9wV53477638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 15:27:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C274F200E1;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAFB4200E3;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sat, 25 Jul 2026 15:27:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 7707E162820; Sat, 25 Jul 2026 17:27:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Farhan Ali <alifm@linux.ibm.com>
Subject: [PATCH v4 9/9] s390/vfio_ccw: implement a crw lock
Date: Sat, 25 Jul 2026 17:27:05 +0200
Message-ID: <20260725152705.3958100-10-farman@linux.ibm.com>
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
X-Proofpoint-GUID: qBxJgc0yDB9mkazSg4M-51C7bCaushUb
X-Proofpoint-ORIG-GUID: qBxJgc0yDB9mkazSg4M-51C7bCaushUb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfXyxVPmzlmgZM+
 b3U4Gp/1TkyE2Kq70L4i9rj0wrTdkC5KvFr6x2y4TIrGwxPL1aR69fJsYtO4DK7ck/K/kMNdT7+
 75gWap1FVZIXb4Y/d//bBn3lE6I7Gwg+cO+8qHHcKvPvHpc1LdwWEdYYd1n2qfT9d/uKfxqPGOt
 3gLGJ36223jR4nR4twHC7yQfWYL2CIuBGPqs521YB44wjnvMEzfmJ2i16xsZfRbK0N7oqyAmPmf
 KZYO6FVPA9U2wQqWyYEGBe2MnCAGsZuaMqfX+1sVs+lKu3uNiKiSv8u1+bh6KTF4nKoO61i5HOh
 WnbGZezmcFyKYEEY1qWDUhbja5N0xjLkUAsyQWj2XDqTGuvxTkodT5FNTolrIfIXdZcIM5RtdGA
 TYpuV/4mN+Qg3FrGvOv8ZXa4ncfBG0vfX9G7v2PWrdtXcGtrjkuxDMZty+FrUJ6vJ6uUA6kXX19
 RSDaCFA5P7G4ghmRLGg==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a64d5d2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=huIa1HNm52ewcn7HQvQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE0NCBTYWx0ZWRfXxYDFKcPEOT8M
 fLKS28JktrMSuwVrK390OFylKud1NSsYl9PHoJdEOgqZ/jw/dDxMJjc5LBttz/pJ4som5Zj4nh6
 P4IOJrHpibNlA+4Vq7xcAjaBZwg6vnI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607250144

Unlike the channel_program struct, which covers synchronous I/O
submissions and asynchronous interrupts, the CRW region relies
exclusively on asynchronous events coming from hardware.

Implement a lock to manage the list of those payloads, to ensure
they are read cohesively.

Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
Cc: stable@vger.kernel.org
Cc: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_chp.c     | 25 +++++++++++++++----------
 drivers/s390/cio/vfio_ccw_drv.c     |  4 ++++
 drivers/s390/cio/vfio_ccw_ops.c     |  3 +++
 drivers/s390/cio/vfio_ccw_private.h |  4 ++++
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
index f3015132d4b5..313c541e83eb 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -98,12 +98,6 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_cc=
w_private *private,
 	if (pos + count > sizeof(*region))
 		return -EINVAL;
=20
-	crw =3D list_first_entry_or_null(&private->crw,
-				       struct vfio_ccw_crw, next);
-
-	if (crw)
-		list_del(&crw->next);
-
 	mutex_lock(&private->io_mutex);
 	if (i >=3D private->num_regions) {
 		ret =3D -EINVAL;
@@ -113,6 +107,16 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_=
ccw_private *private,
 	i =3D array_index_nospec(i, private->num_regions);
 	region =3D private->region[i].data;
=20
+	spin_lock(&private->crw_lock);
+	crw =3D list_first_entry_or_null(&private->crw,
+				       struct vfio_ccw_crw, next);
+
+	if (crw)
+		list_del(&crw->next);
+
+	/* Drop CRW lock while copying to userspace */
+	spin_unlock(&private->crw_lock);
+
 	if (crw)
 		memcpy(&region->crw, &crw->crw, sizeof(region->crw));
=20
@@ -122,15 +126,16 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio=
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
+	spin_lock(&private->crw_lock);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger);
+	spin_unlock(&private->crw_lock);
+
+out:
+	mutex_unlock(&private->io_mutex);
=20
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
index 4830f0dd9c3a..32f631d08620 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -125,8 +125,10 @@ void vfio_ccw_crw_todo(struct work_struct *work)
=20
 	private =3D container_of(work, struct vfio_ccw_private, crw_work);
=20
+	spin_lock(&private->crw_lock);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger);
+	spin_unlock(&private->crw_lock);
 }
=20
 void vfio_ccw_notoper_todo(struct work_struct *work)
@@ -307,7 +309,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
e *private,
 	crw->crw.erc =3D erc;
 	crw->crw.rsid =3D rsid;
=20
+	spin_lock(&private->crw_lock);
 	list_add_tail(&crw->next, &private->crw);
+	spin_unlock(&private->crw_lock);
 	queue_work(vfio_ccw_work_q, &private->crw_work);
 }
=20
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index 9242a37677a0..6735b5f4c07a 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -61,6 +61,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *v=
dev)
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
 	INIT_WORK(&private->notoper_work, vfio_ccw_notoper_todo);
+	spin_lock_init(&private->crw_lock);
=20
 	private->cp.guest_cp =3D kzalloc_objs(struct ccw1, CCWCHAIN_LEN_MAX);
 	if (!private->cp.guest_cp)
@@ -139,10 +140,12 @@ static void vfio_ccw_mdev_release_dev(struct vfio_d=
evice *vdev)
 		container_of(vdev, struct vfio_ccw_private, vdev);
 	struct vfio_ccw_crw *crw, *temp;
=20
+	spin_lock(&private->crw_lock);
 	list_for_each_entry_safe(crw, temp, &private->crw, next) {
 		list_del(&crw->next);
 		kfree(crw);
 	}
+	spin_unlock(&private->crw_lock);
=20
 	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
 	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_=
ccw_private.h
index b595fd81f370..ffa8be7547fe 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -98,6 +98,8 @@ struct vfio_ccw_parent {
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
  * @scsw: scsw info
+ * @crw_lock: serialization of CRW information
+ * @crw: list of Channel Report Word elements
  * @io_trigger: eventfd ctx for signaling userspace I/O results
  * @crw_trigger: eventfd ctx for signaling userspace CRW information
  * @req_trigger: eventfd ctx for signaling userspace to return device
@@ -122,6 +124,8 @@ struct vfio_ccw_private {
=20
 	struct irb		irb;
 	union scsw		scsw;
+
+	spinlock_t		crw_lock;
 	struct list_head	crw;
=20
 	struct eventfd_ctx	*io_trigger;
--=20
2.53.0

