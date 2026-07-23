Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC13909AB;
	Thu, 23 Jul 2026 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828884; cv=none; b=TEPnoy3OdUw+C0fSr8oadiTRZZwxo76d/v1KGdpVytQZ5v2L5b32DtrrzmNfDkpoEM8Q+qz4u9/hGbfs0sSfs13D/pv79ug4kW1LGInCMFwqKmnX/uWczHuVHtDAUkgNqUPdHfA1EHVbZa3BTRdkcIRdRqczBeZ1ekcgI3SmlB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828884; c=relaxed/simple;
	bh=g+KDBnTPFlTv2aIMsJAmJAaZVOfMwE8EFTe20OL6DM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKv+zgvBFYgunVjZ+0bZA/PWRxDh6xClmqfeTZOF8gmX0odLcZABUKIPw3chaaHcpKOdmk/4RzidtTgIFlPsi4Q4GTe3sQjUlJG1D2GtJkPi35TmapIXOtUvdRd1ILNSy7iHxb7B39A3+kPM6vlak0yf/INLKyCPWEhRUZYB318=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q9b6bFmV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q9b6bFmV"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHgKuY1805437;
	Thu, 23 Jul 2026 17:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jmi2Xqml8iJ+sFhyD
	wakqzIGwE442sctsbJrKFG1D0M=; b=q9b6bFmVU0QeXaYBN583H8OtIGqIfFyXI
	lyXa37A+7/LEM0cC96hVoLhfqNnVngjzfUo8rJGKuY6Na8SRvPWXoqin91sZcLdF
	Sk0tb57JYL0NcoQY8qNJ+qjLby8AcPAcl5UeKnEzVpnlwszXu4Xl9vLObYVmdltS
	DrCcc97luKqW0avO5OUQ4Zgv54AeYpyIWfU5ZwGjiCNwL0rzbqNnWlQ50CPya1Nx
	QAFfQJLoVN3x+nW7tF/dk24vqLeMb/b2usqvD90PjTMgNiXbGlF3r65q4RzeGwlA
	5pXAMR6I90xcmEI3nuqF82ggkS0KHRPQ6MSeqxcyhBZlqqzYE5QmA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77arw4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:48:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NHZD5A027793;
	Thu, 23 Jul 2026 17:47:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk5bpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 17:47:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NHltqY60359034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 17:47:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BCFA20043;
	Thu, 23 Jul 2026 17:47:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDEBD20040;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 23 Jul 2026 17:47:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id AE4F7162803; Thu, 23 Jul 2026 19:47:54 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org,
        Farhan Ali <alifm@linux.ibm.com>
Subject: [PATCH v3 8/8] s390/vfio_ccw: implement a crw lock
Date: Thu, 23 Jul 2026 19:47:51 +0200
Message-ID: <20260723174751.1180334-9-farman@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: bgtAFuClzCIx4xB1kz-Rtd-FR0vDqFZD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfX1jYqx8JkMBk2
 mnUYKqO0HRDT+e1h+vGX+aKzTY3Oke3Rhv/pSeUdCyVKVBXdl2bcrSKLNuhMFAiFoTMsxC+E6Sl
 l7Zi4y/AZYglMFHdjPRM5kMgjlN8fUk=
X-Proofpoint-GUID: bgtAFuClzCIx4xB1kz-Rtd-FR0vDqFZD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3MyBTYWx0ZWRfX2QGs2z+kanpQ
 nku7+8W0kgkwzBSXOehsAnNsQDvfvb1+LzFt/0a0iogap2y4hqmrllO3jY8AVOSh1sbia2Cd+XO
 uzH1ti2JsnXDfZP6fyz4e5TzqoqFTZM1eLeX/Ns8XPxJWFh8Bvu9PeILH3awOZAEwGzqG/Ee4oT
 YEkDTOGyxS3G0xchZBmscd8AfDKeBsaHDMGlyPGjb/5OSlB7Z31Bjqf216YKskt0PhmLFV1NZdS
 6n8ihQ80yBuOEwzEy3Fz2WZ29sq7NrocB6/iNgjsejKxd0Cx/PpoRRfxX8wPel4AixV2agNeHe1
 d6E6x+h1l6WAVVuhCUOkt046Ox5G9Bw/MQitBsiXiQaXbCUGjIdxuTmiyC/gU8KDsilXXQlBSLy
 N81WeB/A6mUoAv6vOO2qoewI+kBf8hIyBnOp3mrKi8IchJk3NlD3aiTHZ9zQX7ZeYSZI3tub2jO
 qw290ZkvcJOpMuMjGqw==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a6253d0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0_ASXfQLkdswD2wDWUsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230173

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
 drivers/s390/cio/vfio_ccw_chp.c     | 17 +++++++++++------
 drivers/s390/cio/vfio_ccw_drv.c     |  4 ++++
 drivers/s390/cio/vfio_ccw_ops.c     |  3 +++
 drivers/s390/cio/vfio_ccw_private.h |  2 ++
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
index bf678270c457..3d05aaf790fa 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -93,15 +93,19 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
 	if (pos + count > sizeof(*region))
 		return -EINVAL;
=20
+	mutex_lock(&private->io_mutex);
+	i =3D array_index_nospec(i, private->num_regions);
+	region =3D private->region[i].data;
+
+	spin_lock(&private->crw_lock);
 	crw =3D list_first_entry_or_null(&private->crw,
 				       struct vfio_ccw_crw, next);
=20
 	if (crw)
 		list_del(&crw->next);
=20
-	mutex_lock(&private->io_mutex);
-	i =3D array_index_nospec(i, private->num_regions);
-	region =3D private->region[i].data;
+	/* Drop CRW lock while copying to userspace */
+	spin_unlock(&private->crw_lock);
=20
 	if (crw)
 		memcpy(&region->crw, &crw->crw, sizeof(region->crw));
@@ -112,14 +116,15 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio=
_ccw_private *private,
 		ret =3D count;
=20
 	region->crw =3D 0;
-
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
+	mutex_unlock(&private->io_mutex);
=20
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
index 1d8c2ed9da50..2c0a27851342 100644
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
 /*
@@ -300,7 +302,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
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
index 04800cfa779b..277138f14b25 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -60,6 +60,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *v=
dev)
 	INIT_LIST_HEAD(&private->crw);
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
+	spin_lock_init(&private->crw_lock);
=20
 	private->cp.guest_cp =3D kzalloc_objs(struct ccw1, CCWCHAIN_LEN_MAX);
 	if (!private->cp.guest_cp)
@@ -138,10 +139,12 @@ static void vfio_ccw_mdev_release_dev(struct vfio_d=
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
index ac5aaa78a74b..2562679b5ef5 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -121,6 +121,8 @@ struct vfio_ccw_private {
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

