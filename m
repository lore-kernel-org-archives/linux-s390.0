Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FAE3C13E3;
	Sun, 26 Jul 2026 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785086526; cv=none; b=kE22n+Bn+iyMN+XI4Bhp0T7xYKi/iR2/wdXZAD0ccybdQh4V5A265j50o1ZnV1UvWZUTmjblGMgjAD24S98rhdySP1FMCp/iztwlcmbASQ679hMu2OXoSRvyldD9LNQO48lyl5bQ+VoIWiuVgpxBe53aVq8OU8p0IM7R6AD6wmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785086526; c=relaxed/simple;
	bh=//IyFxIrsGrpvLppMEA2ljRi3HVTs7tD/3c20Xyid+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJk4BuZdh4kuzQKzwKhaAzbj5XlNMKdDzwbPmUTaQAPMixur0kWPu6zIo6ZCWrKXI3xkIH93Yb3rQ6xz82J4FhETMtK6sZqDFo2n3wuPCU2A8/7dRDE0N1dX02W+1rbQxQQvTpxYq2ns8fPRLDSr5n93i/oKzq8WsbWJvMgwGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UxUFsBHj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UxUFsBHj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QHINYS3966741;
	Sun, 26 Jul 2026 17:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B8TIpsC6SmDC3fV6+
	VJsOF3pNjZ/mVk32hcGbzJrDMo=; b=UxUFsBHjLdwsQBrlRr1NO7Vy4HSz+65+6
	4y8hdzAM6/DnE89FRdpkWuE3d0aE24pbR/i8yPe5MYOqCPUscocaXjgvdtnIcx41
	9ElwW2TQ/2P/Z76xnNm+YhwRtSNm5G/47/VxDpuwdycHlWzFwyPayd7O9yCtA5Tx
	xAi1wtnm7Tr9qFude/42LS0QztFlbv1WUpuHJNUQn3DvMgmidb8maAHaIB5Cr/Om
	662lFbz72BrvwMv018ZCeTrV+M/jm4pWHdFptKsJZmzFSsQ8tqSbF2vrdPftS8zc
	4aTN64GEj8a28Mo+kAKG0RG0/3hrss9eFFkcpRo6zI16U9L+mUPuA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhv3u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66QHBaVV030517;
	Sun, 26 Jul 2026 17:22:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjt7vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 17:22:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66QHLvHt50856304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 17:21:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED7532004F;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8F9320067;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 17:21:56 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 8E6F9161295; Sun, 26 Jul 2026 19:21:56 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v6 08/10] s390/vfio_ccw: move cp cleanup out of not operational
Date: Sun, 26 Jul 2026 19:21:51 +0200
Message-ID: <20260726172153.1818056-9-farman@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfX4MKYySrVWrsu
 foONolSLG7C7Rz/US1XA2xBfcs19lnRqZOjJIzAWS3yeu/9zpW/PHWJjL9X1yb/aTDnMVsaJXoz
 v2P0hqSktQxb/Hfy4YJAjlY17lZ+DTk=
X-Proofpoint-GUID: H0Xl8Qsaocme0mkpvWq7Dae_i16el8bz
X-Proofpoint-ORIG-GUID: H0Xl8Qsaocme0mkpvWq7Dae_i16el8bz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDE3NSBTYWx0ZWRfX2aCRoIkpCGnd
 s5+4phQoIDCJVWgUvceNu35sDK6Ll7QxJkdrjLK5oJobTwx/aHkZ9HwDkq0r6jAq9ImeJX0nYeo
 E7ROM9mKa2Z1VhUIsftPPPmD1I28Q+4WO7Aab0E8/QlhL2n7VdLPw3iCfqz8a8WZHj1orXNBNFv
 ucPDADFeMx1cOEL+LZum8W984RUstqQn+FY2h255Fr1G/BmN5gP8nnGNg9FusJmgEkWck44OjCO
 ZWFtcJc+qswLcjAaTmZY27IbTB5QDJiccfNRwgdfRCte3Yf+i20Pwlmgs/QllAjYOt63ocAn0Hl
 Bznzg40OM/uIiIFOfzR+0vNXY621SwFpvZZIjg5PpdOR/jtpX4qmL2MhsVwMD9aUA9cKrRTjW7o
 UsTj3zQG3+/CK4avT8XcfvqoRfukEkrFop8nsafwIkmakVk+SziNsl79lE2GB2aacUVuB5M7ba6
 NkSGCL6Oaap1LCdNwLg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a664239 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=bJCXobfW90SFHFxB7XEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607260175

The fsm_notoper() routine is called when the device has been
lost, and is (by definition) no longer operational. Since this
can happen asynchronously from the normal behavior of the
driver, the cleanup may happen when holding other locks
in the calling sequence (notably, the cio subchannel lock).

Push the cleanup of the private->cp resources for this
scenario out to the closure of the entire MDEV, where it
be done out from under that lock sequence and (soon) under
its own serialization mechanism.

Fixes: 204b394a23ad ("vfio/ccw: Move FSM open/close to MDEV open/close")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c | 3 ---
 drivers/s390/cio/vfio_ccw_ops.c | 9 +++++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_=
fsm.c
index 4d7988ea47ef..248adf1e7707 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -169,9 +169,6 @@ static void fsm_notoper(struct vfio_ccw_private *priv=
ate,
 	 */
 	css_sched_sch_todo(sch, SCH_TODO_UNREG);
 	private->state =3D VFIO_CCW_STATE_NOT_OPER;
-
-	/* This is usually handled during CLOSE event */
-	cp_free(&private->cp);
 }
=20
 /*
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index bd488e40e153..a717174675bd 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -210,6 +210,15 @@ static void vfio_ccw_mdev_close_device(struct vfio_d=
evice *vdev)
 	cancel_work_sync(&private->io_work);
 	cancel_work_sync(&private->crw_work);
=20
+	/*
+	 * Ensure that a not-operational device has indeed
+	 * freed any resources. Normally the interrupt handler
+	 * or FSM close should do this, but there exists the
+	 * possibility that a device removed from the config
+	 * would have left some of this about.
+	 */
+	cp_free(&private->cp);
+
 	vfio_ccw_unregister_dev_regions(private);
 }
=20
--=20
2.53.0

