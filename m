Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2293E0083
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032736; cv=none; b=a0Zh4L+VMxc+trU7bHwvwCvC185rjshen7l4uyjoXnVZAJy22NVKfjNRSIY0RUDJEpDL2dkVMiuO8xqhHeh1t2Juj/vyD1EpvSunxm33fgyM929GudU0CCOP5gq037MHuphdIrDAdzITTGkwgdvkAtNRSjKqDFEiqjLrdwHNUNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032736; c=relaxed/simple;
	bh=8Dgxac3PRlsZPU2bzzj9DO7DcYAouFpeA14r3uOYqLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZtkk1I//iiOWEEEICyzuA6Bn+9TRMnOYBBW9KcRxD4ZduTCSNbyzasqHCk6LSXzD+r9lBWnrvXRjK/4edUcS1RdTrizm8s+WHnY3kVm6+JJ3dZuHtVg5InPlPZRiJvC+8SkSpNC1442Ra1CF/yXtQ2ffMiGsiTDWfx5tRH8NTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C1BYFi9O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C1BYFi9O"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A91QsU576541;
	Thu, 10 Sep 2026 09:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=csnybtMjC16AbU3s4
	NMlsNIsAL6tYPBz96d/EcULE1w=; b=C1BYFi9OYREN6EAbFB7MEuQBKxPIR5nIb
	BJhFmbDOpKKBgY2ScqwEGGZzzYkasxih2lROkHM81uLqXmU3xdw9j5nV8xr25g0P
	9hYqzEXVQ7hedFu/ddLlfzYK/MZqnfHOFL6TM7/DWngavAckxJTHeHXxvVUBtoss
	T4mX0lhTfD90UJb5bZkq46GREQhcm9yE7uISMjrIftVQLO8s02wDxXbahwkEVjWp
	jiX//RbyFI7gO7NVj1Dv+2iAedMrRZjPIWVcvhdNLbyB2EK6DJZ3GqPNsVLrFwek
	AipQl1KSM00VJ3rohawe9a2Cn6q+/fMyyZJef7rUTYuoYrlxUejSQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8n3mwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 09:32:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68A9QERO004657;
	Thu, 10 Sep 2026 09:32:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkcr3bmpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 09:32:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68A9W6qR46924156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 09:32:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D48F20043;
	Thu, 10 Sep 2026 09:32:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3732E2004B;
	Thu, 10 Sep 2026 09:32:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 09:32:06 +0000 (GMT)
From: Vineeth Vijayan <vneethv@linux.ibm.com>
To: wbezenah@linux.ibm.com, cohuck@redhat.com, pasic@linux.ibm.com,
        farman@linux.ibm.com, mjrosato@linux.ibm.com, oberpar@linux.ibm.com
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 2/3] s390/cio: Check pmcw.dnv before pmcw.ena in I/O entry points
Date: Thu, 10 Sep 2026 11:32:02 +0200
Message-ID: <20260910093205.3357827-3-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910093205.3357827-1-vneethv@linux.ibm.com>
References: <20260910093205.3357827-1-vneethv@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NMVAaE6g c=1 sm=1 tr=0 ts=6aa2791b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=gWGMffZzqr4IqpLisxkA:9
X-Proofpoint-GUID: lmrDHIdEl_2qtr32Esv4k9nbH1Io70op
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDEwOCBTYWx0ZWRfX6kIofPrHMt4z
 nEWKrUjOyEOpUIvBkfZplajmQ1w4GwDYwXiqiMZ4iUwolHhuueaShis7QfXHNaZ5i7rOMp6W/NK
 JFCbdWlhVUSNyaw9WzRK2VGYpN3kIH4rK0Nn0fXLadURHE04iMcPrUsqPiqXuY/lCKJMYQgFSgs
 6Q3B6i5dpi/qxMgkgUp+uvUbZN76WEiCWNxZqSJbWdLzZK1UcfiZ24FJGObcPWf6x+T3fQuj9Qb
 rdPJmfZ5vtXWEPgiy5Nbo1ez20V4okl5P8lycgGXs+0Be0vyPPhMu8MblMqztdfuAaZyKWQviYP
 UjoMEyGv+678A1JavsUYk+ZQBhzrV1i+f3aoVIXebbDZ3w59Rae6v1rAY38Q6Yh2V9oQoABeLMa
 qF7wAvCPMbBlabxfv9lAqkqxvbS6WS8iCEuuZf2aXmVwBFLjwUdujnocjIXC4o4GR84kteXS+PP
 uDliVELSmalIks/JUZg==
X-Proofpoint-ORIG-GUID: lmrDHIdEl_2qtr32Esv4k9nbH1Io70op
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDEwOCBTYWx0ZWRfX2/R1Gxim1fxu
 Qiofeqe+UcZlXJu78LSxr5cLxg8ZnoFCh9dOBjFhVjvw3gGNZw1sXGHXkIUgMoXJYNT8KtoKmiq
 FYtZZxk0imLb7qMrTJoocDAzYniau+o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100108

The device number valid (dnv) bit in the PMCW must be checked before
acting on any other PMCW fields for IO-type subchannels. A subchannel
with dnv=0 has no valid device number associated, making it meaningless
to evaluate the enabled (ena) state or issue any I/O instruction against
it.

Reported-by: William Bezenah <wbezenah@linux.ibm.com>
Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Fixes: 8c58a229688c ("s390/cio: Do not unregister the subchannel based on DNV")
---
 drivers/s390/cio/device_ops.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index 61c07b4a0fe8..c1ba4a19368f 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -142,6 +142,8 @@ int ccw_device_clear(struct ccw_device *cdev, unsigned long intparm)
 	if (!cdev || !cdev->dev.parent)
 		return -ENODEV;
 	sch = to_subchannel(cdev->dev.parent);
+	if (!sch->schib.pmcw.dnv)
+		return -ENODEV;
 	if (!sch->schib.pmcw.ena)
 		return -EINVAL;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
@@ -198,6 +200,8 @@ int ccw_device_start_timeout_key(struct ccw_device *cdev, struct ccw1 *cpa,
 	if (!cdev || !cdev->dev.parent)
 		return -ENODEV;
 	sch = to_subchannel(cdev->dev.parent);
+	if (!sch->schib.pmcw.dnv)
+		return -ENODEV;
 	if (!sch->schib.pmcw.ena)
 		return -EINVAL;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
@@ -379,6 +383,8 @@ int ccw_device_halt(struct ccw_device *cdev, unsigned long intparm)
 	if (!cdev || !cdev->dev.parent)
 		return -ENODEV;
 	sch = to_subchannel(cdev->dev.parent);
+	if (!sch->schib.pmcw.dnv)
+		return -ENODEV;
 	if (!sch->schib.pmcw.ena)
 		return -EINVAL;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
@@ -413,6 +419,8 @@ int ccw_device_resume(struct ccw_device *cdev)
 	if (!cdev || !cdev->dev.parent)
 		return -ENODEV;
 	sch = to_subchannel(cdev->dev.parent);
+	if (!sch->schib.pmcw.dnv)
+		return -ENODEV;
 	if (!sch->schib.pmcw.ena)
 		return -EINVAL;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
@@ -548,6 +556,8 @@ int ccw_device_tm_start_timeout_key(struct ccw_device *cdev, struct tcw *tcw,
 	int rc;
 
 	sch = to_subchannel(cdev->dev.parent);
+	if (!sch->schib.pmcw.dnv)
+		return -ENODEV;
 	if (!sch->schib.pmcw.ena)
 		return -EINVAL;
 	if (cdev->private->state == DEV_STATE_VERIFY) {
@@ -694,6 +704,8 @@ int ccw_device_tm_intrg(struct ccw_device *cdev)
 {
 	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 
+	if (!sch->schib.pmcw.dnv)
+		return -ENODEV;
 	if (!sch->schib.pmcw.ena)
 		return -EINVAL;
 	if (cdev->private->state != DEV_STATE_ONLINE)
-- 
2.53.0

