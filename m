Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54243B6E1;
	Tue, 14 Jul 2026 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071342; cv=none; b=oaV15Q5kzD8PPBBvV14lKRMz36eiC21HArr1m9wFwY/+tQloxue12tgC6j2ofRFtDRLbh+dc27LexwcN22bFP7xbHaGXs9UKh3KS8PXrDaOkwXcH9BL98VGUCU0n4K9+YPq8olk4cJQxBMS9HyuTbAYiWZ7QAKO+jEcJ5mlKPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071342; c=relaxed/simple;
	bh=P3XWV1htfv/+pnaxzwiBMyLNA7sp2LcefcxT5gFJCTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqXGivDOtTw0jgPBZDrgR8DTNaLc3+Uc7luogpKkuVn/YGTQvmCz2780yF1cNQrUnRFRAi5cL8HCw7QQOs+29PkCfeTFXFgeXutx88bzjJ5rDAz819gVFWs42sShZc5QKgdoWs7QWtGpLezS21eXZ/x+VYdqvR2FRX/VuINYH1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L0h9C13O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L0h9C13O"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EJBmie2116414;
	Tue, 14 Jul 2026 23:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jdj62yyVkb6OFhQmM
	MbgfgBqscDlThLxK9g+9kNIuAk=; b=L0h9C13O1f7T2SYHkmbBwujc0Nyzckw1T
	QOlRIXE04zlEH9LnyErWAPQxyRnzbOySndlwJ/q8RVhhAhpjckGhaftRbewHRaBO
	iTn25MJAnPcmkDRNEZtfP0gU6uXvPtxaxf4n+BF0hyBhG/JTxhUfXm1CYWfGnYRW
	zpr0l9lWUM9rexegNJ6rss7Uo64YUYY5KCNtlW33y3MxOdRS/5NRdmU8NAxhb/Vx
	NN0jETUUlfxrC032d5Gu8NHVBCPpWQdg75lr3GoiS75KNzSZLbJ6n+4vE/ldYW2g
	dhObNG2ck/kmVhY+QiV0xR2xBf5q6k0hx2+0DEFXef19l7RKzQ6qw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a86e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 23:22:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ENJf3g011560;
	Tue, 14 Jul 2026 23:22:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jw6g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 23:22:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ENMC7P48562512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 23:22:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98D0620040;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 745DA2004B;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jul 2026 23:22:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 437E11626C4; Wed, 15 Jul 2026 01:22:12 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v1 6/6] s390/vfio_ccw: lock I/O resources alongside I/O regions
Date: Wed, 15 Jul 2026 01:22:08 +0200
Message-ID: <20260714232208.1683788-7-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714232208.1683788-1-farman@linux.ibm.com>
References: <20260714232208.1683788-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDI0MCBTYWx0ZWRfX3T2hzZ5ZuHRS
 fa5ul8XyJISItb3qHjmBrVku8xkxX3rJi+131B/udsYUaF7bctX0ISVIf/VP822rEG8mYmoOfR3
 WkJV2nNdmAg9/PXlZ+ptB3mCF5L6HoE=
X-Proofpoint-GUID: -aIfqjlLJgtxEpBs-PbIy1JAf2pymKLe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDI0MCBTYWx0ZWRfX60mjDU47PK4V
 LkiD/F+kGtgOGQV5gzz3h4vmLNx3akyzbw09KYXTv4PdzddEbUa2WA8ztBk4mPv7vtrzQIG0Pkw
 XLrzVk23N30CXFZ6lWeREBW0twhrce/AQBMh3EllrCIJrYpERfDKAEH6JNvRJkBc7PQhswxR3uj
 BMeEnjcnrIvDFSg/iO0VIwKIvLVJnGe/9vkeFUmQYQEp54E82oIOmHs6OsZUuDAO5i/3D3ladCL
 TW1be0qwdiOeHjk1cn5gKcU/1LXClNKk8W6knV/rRQhnzB+RCWuwhaDGJbryi70DgwjU8o0tZDg
 Z8TFzIgJ5mRypA9Tzs03fFvLGOwGX7YnW88etc9jDLIVSeoi/gOdPy6dkgcxIObezm3pRXY9dL5
 XBnH3buWwNrBj7AXitKJpg5TKv/cDobr12w8ShLbB0g+qTrQ0j0/CsTumiNDopzxHORQ+oOacH7
 M6m6vW/EUacX9QyP1Lg==
X-Proofpoint-ORIG-GUID: -aIfqjlLJgtxEpBs-PbIy1JAf2pymKLe
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a56c4ab cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=KyaCFF8TlgOd3ial2BYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140240

The memory regions shared with userspace for vfio-ccw operations
are correctly accessed under a lock, but there are a handful of
related structures that are associated with the same lifespan of
a given SSCH (and thus the written-to memory region).

Some of these cases are done asynchronously from the guest
(e.g., hot-unplug of a device or channel path event), and so
should be protected in some similar way. Since a subchannel can
only have one I/O active at a time, redefine the I/O mutex from
protecting the region, to all the resources associated with the I/O.

Fixes: 4f76617378ee ("vfio-ccw: protect the I/O region")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_chp.c     | 2 +-
 drivers/s390/cio/vfio_ccw_drv.c     | 2 ++
 drivers/s390/cio/vfio_ccw_fsm.c     | 5 +++++
 drivers/s390/cio/vfio_ccw_private.h | 2 +-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
index 38c176cf6295..872620a9488d 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -90,13 +90,13 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
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
 	region =3D private->region[i].data;
=20
 	if (crw)
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
index 1a095085bc72..385af7daca3b 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -292,7 +292,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_privat=
e *private,
 	crw->crw.erc =3D erc;
 	crw->crw.rsid =3D rsid;
=20
+	mutex_lock(&private->io_mutex);
 	list_add_tail(&crw->next, &private->crw);
+	mutex_unlock(&private->io_mutex);
 	queue_work(vfio_ccw_work_q, &private->crw_work);
 }
=20
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_=
fsm.c
index 4d7988ea47ef..96f23da88a39 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -171,7 +171,9 @@ static void fsm_notoper(struct vfio_ccw_private *priv=
ate,
 	private->state =3D VFIO_CCW_STATE_NOT_OPER;
=20
 	/* This is usually handled during CLOSE event */
+	mutex_lock(&private->io_mutex);
 	cp_free(&private->cp);
+	mutex_unlock(&private->io_mutex);
 }
=20
 /*
@@ -410,7 +412,10 @@ static void fsm_close(struct vfio_ccw_private *priva=
te,
=20
 	private->state =3D VFIO_CCW_STATE_STANDBY;
 	spin_unlock_irq(&sch->lock);
+
+	mutex_lock(&private->io_mutex);
 	cp_free(&private->cp);
+	mutex_unlock(&private->io_mutex);
 	return;
=20
 err_unlock:
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_=
ccw_private.h
index 0501d4bbcdbd..8f3792fdd31b 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -88,7 +88,7 @@ struct vfio_ccw_parent {
  * @state: internal state of the device
  * @completion: synchronization helper of the I/O completion
  * @io_region: MMIO region to input/output I/O arguments/results
- * @io_mutex: protect against concurrent update of I/O regions
+ * @io_mutex: protect against concurrent update of I/O resources
  * @region: additional regions for other subchannel operations
  * @cmd_region: MMIO region for asynchronous I/O commands other than STA=
RT
  * @schib_region: MMIO region for SCHIB information
--=20
2.53.0

