Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F563D4114;
	Sun, 26 Jul 2026 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785086527; cv=none; b=p14bn1bbtIQiUo4Wrb+chx+g3L2/ylxa8BU4Gr/06lLp4UfCr7P4AlwVB1wZQJvTU2JZLIVETvRn+uNSXevr2cspNfiUvMvWN03FnvsTgBAxIwpPpbtcPeTuBrWSsq4x0aYYLJFDNebLFEpzWC6HiZ2+dYBFBf9Whz3nI6d1gic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785086527; c=relaxed/simple;
	bh=csPcymv3RQutvqc3hYuZQkNZzDhCFNSY1SioHmWBZU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5/YxDjvdnf/yCjY0jJQ+gRqMHC5P5u9daRB0ErsTYFPzdUp2UeBIUQinMChejV3Cmzykh3dPOKgqTkIHLwbW6aVANif79R8ThFxGh8qX13TDs7Ai1VjvPfPNMTOhjNKkhqVpgwtg/Kki/YroRBcz1xDpRz93cx93TIKPKwMpcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eJ0eCknl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eJ0eCknl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QHIYR12179218;
	Sun, 26 Jul 2026 17:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eqVREhQAy2CTW0JzT
	cStvuJIC5XyM96pZA9xPqTh8ZQ=; b=eJ0eCknlveLtBvsV+nyoSdOJke02lNlK4
	JR/2ETnx/a4RUwUWYC7JenH1+T3lK47E3spr2KnVAUayziBs6Gg1nVSoHl6cUGUJ
	Y71BXmeIwVTTBHjWkGBcaXXtoXXRpBTyR4KNt4GWyZ/fBPddNHOWPkcWM7Pi4Tye
	+gbkU1v7SgA6h8QiqUHTDgJNW1gL4YTGL9L/dxFnyFMK3+zylQZJJBI/S5q2UhVy
	UEib/p7fckCGrgSOjv97ISuc1c67mO3FPCpHS5xZIciMJd9ltEXWzm1jzrjiRMQK
	NdtQwnanNtz4QRkhHZY5//Dg49A53cICdPqCiNBILnSj3u2dln6dg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc4bak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66QHBZpj030510;
	Sun, 26 Jul 2026 17:22:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjt7vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66QHLv0541025848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 17:21:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC79B2006E;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7F9A20099;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 8C647161288; Sun, 26 Jul 2026 19:21:56 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v6 07/10] s390/vfio_ccw: cancel existing workqueues
Date: Sun, 26 Jul 2026 19:21:50 +0200
Message-ID: <20260726172153.1818056-8-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726172153.1818056-1-farman@linux.ibm.com>
References: <20260726172153.1818056-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yjRPYtudctFt9X7VkCukZYubp5KEck7o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfX6t7oaHgi7NMc
 6TNWfS2VVeqgvTZIWU24BTDsDbG3WrS+m7izY5eH6fT4tphFUTqwxnm5IqXqL8yI3HBRse/i4EO
 Apk2pA0vtsWOyo01PMZ4o/RdIi2WnBUenMgAPlPKMs1R1qEL1fuJxFRt8fMFNSR4T27oEjDUp13
 Q/CzAP3yr3fCgWFs7OQXgfMTZ2fP2+AXsHfXa6zknUS/VKzGzTP0camTfnPzM6IEdkDDZUywcIW
 m4Gw5FeZ/DV9IpUsFy+XmtAkIDCjHIrAtjxsjvCVHfdlofeLymX0ye+pn5G70Z7L0WFYGgAOIpf
 BuRORFJFSXqgmjSp7ofDzv5286JMqYNrB5BOZVJC86insP7OLe27DRDNQ+TAUgN+eJ4apm0X0v4
 nxDsVtE8qSPrQ9514P3yBUExn5K6aDjE6BZ1By1OhU/d4h+KQHuJzic4YOI2db5ctPC22r2+rj6
 v7e/963j1CO74pqQZVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfX1suA7OYK0PRn
 1Vg5eMiPQ+JXkQy67eLM8p47o/k/04AEQbkDKzwqa55PEStSpxetgDw7r//H83IH2ZYMlvNeZMW
 D+KmxeXBFiHD1BBJGpyWEjOtunIXbuw=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a66423a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=xt5PtEg-49noLGkpZzoA:9
X-Proofpoint-GUID: yjRPYtudctFt9X7VkCukZYubp5KEck7o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260175

The initialization of the io_work and crw_work workqueues begs the
question of whether they should be un-initialized. Add the corresponding
cleanup tags in _release_dev to ensure work isn't dispatched after
the private struct is free'd.

Suggested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Fixes: e5f84dbaea59 ("vfio: ccw: return I/O results asynchronously")
Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index 032a1cdf4df7..bd488e40e153 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -136,6 +136,10 @@ static void vfio_ccw_mdev_release_dev(struct vfio_de=
vice *vdev)
 		kfree(crw);
 	}
=20
+	/* Should be empty, but just in case */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
 	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
 	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
@@ -202,6 +206,10 @@ static void vfio_ccw_mdev_close_device(struct vfio_d=
evice *vdev)
 		container_of(vdev, struct vfio_ccw_private, vdev);
=20
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
+
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	vfio_ccw_unregister_dev_regions(private);
 }
=20
--=20
2.53.0

