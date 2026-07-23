Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474C479895
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814479; cv=none; b=WQCys0skI+zFlZG41Q3y/FbkMPWuvXnh1/vkWX4PRnwGdwnpJtbYgFfq+96HW06AXjJGDFESJwvRUscui8KX73LC6aJwHRgfLrlru2N9bY+CQEZV9yAhxVvZ5pM09I0se2jaCjIGD9tOowC7CgmyyxT/mTNo8PbDcn+ehYIFlpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814479; c=relaxed/simple;
	bh=Q5RneZgr0r8PaHqowbi9qGcGK85DuOZb+eNuurDrPbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ritpzqIRwP3CQu0VojmjeD/4NIToXzMVnTVU2ZJgtoTrFQcpCqz6lhPcv5Yn9mVm3ZTiOpJpN6afqp5xVy9X6nmwQnrGgPdS9tfJkJFE24UTM2WH41IuegfrEOPXW2nadl41srku/vNBsf0m9JJaNdPz+dqXwtgJFZwBqzI3ZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lj1ayJoh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lj1ayJoh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDC2Ru3015625
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/13hsgbUSbGk+Zkzu
	jFj9jh0fOetYmqnEijactw2zH8=; b=lj1ayJoh8iC/MzI1CWwa+ec8aBFC4X027
	Lmt13ipAUvmmRRPafdUecyyX/MWG+jpYycWCaEIC/CF6o8uBprChzvyRKlxT37XG
	2q04UZc0nBFOJCqUg9l6DtIAh/cHZUCMnS32cRBnv2vU1gxbB1GO8bqEXIDL71aF
	VOk/A6Tc/83yR9uBLdYiHi3eCQ0OahTwJtIKiQ9nZykQvLwhUWgERD9NPzlOJu30
	uVQAumJN9NTY1pACiVUTeIOnlkU+EqDz5Cf+cVg//5sQbuapqklP+7LVJiVAz/8O
	bIIkhYdYKRk31c/ddeVLO62Tp6xwBe+guGmmRlhg95YhGVT+Vd1Zw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kf8rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NDYZDP025842
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk4dun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NDlnka59179420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 13:47:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B4672004B;
	Thu, 23 Jul 2026 13:47:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1417920043;
	Thu, 23 Jul 2026 13:47:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 13:47:49 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v3 11/13] s390/dasd: Report ESE capability and format mode at device online
Date: Thu, 23 Jul 2026 15:47:41 +0200
Message-ID: <20260723134743.672413-12-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723134743.672413-1-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a621b89 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=_yd_xlNYP7hmE0PasyQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfXzeLI6AuQIHdr
 ECQxMD11hrw9hXapM+vx02cXq+wrVHrvi4/5VZ1vHhHSOsYm9+uMmeh4XG8ivaxH9/jte+u7R+g
 x2zcZccMORyOVKhMcrJgxNFsdL+pUTs/DfaIyFCr8mhhexUqpbmX984E3RyMTVvrRODzi2zvaLi
 ODdCHSy4CgakUXZ/XfRy2R/ZPjGDUnz9K1qPEHjXzkwbXYT7y7nOkr9BdVfKEkO60nkKhb0k9Hw
 IxZUalmX4CRwx2Kyvyf+5vGQYtw+vjrT38RwoEWTyIrjmHNtrKa7CcBGHbfSvJ311YXcZ/b8oVm
 5HbrLnq3VIzx+TlXau6f4WK9wEHPkOFYvD8HgTeU4PIA8EE+AkYz7u1+Ab02ZNZcuGWRiT6gHif
 8sfOIjD3GwlMgcWKxdHyi/xo43mT3JF0Yu87s2EqnXFIJuRLgAYqagWNw7lveZuzxlhx4ZaHti7
 nCNqrdvL5tMt/ypCfaw==
X-Proofpoint-ORIG-GUID: A4vdRyyds1umLor033DijV9ON7IDErqi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX7XQUcD612yFc
 YQhsWkRoqcD38X2p1UM/p9HgU1d31O4hW/c0olE1kh/naP9ladn2R0bBJMGl3l8ncMf/bmSenD2
 E0BPMXkdO0AKB87HkUjcrcZ6at34Fa8=
X-Proofpoint-GUID: A4vdRyyds1umLor033DijV9ON7IDErqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230135

Extend the device information line logged when a volume comes online with
the ESE hardware capability and the on-disk format mode. The format mode
(full or on demand) is derived from the on-disk format label alone, so a
volume that is not backed by ESE hardware but was still formatted on
demand is reported correctly.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 7ed12d5f6582..40d76532345c 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2483,6 +2483,7 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
 	struct dasd_device *device = block->base;
 	struct dasd_eckd_private *private = device->private;
 	struct eckd_count *count_area;
+	const char *ese_str, *fmt_str;
 	unsigned int sb, blk_per_trk;
 	int status, i;
 	struct dasd_ccw_req *init_cqr;
@@ -2569,15 +2570,29 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
 			  private->rdc_data.trk_per_cyl *
 			  blk_per_trk);
 
+	/*
+	 * Report the ESE hardware capability and the format mode. The mode
+	 * comes from dasd_eckd_on_demand_format() (the on-disk label, or the
+	 * ESE state when no label is present), matching the on_demand_formatting
+	 * sysfs attribute.
+	 */
+	ese_str = dasd_eckd_ese_capable(device) ? ", ESE" : "";
+	fmt_str = "";
+	if (dasd_eckd_on_demand_format(device))
+		fmt_str = ", on-demand format";
+	else if (dasd_eckd_ese_capable(device))
+		fmt_str = ", full format";
+
 	dev_info(&device->cdev->dev,
-		 "DASD with %u KB/block, %lu KB total size, %u KB/track, "
-		 "%s\n", (block->bp_block >> 10),
+		 "DASD with %u KB/block, %lu KB total size, %u KB/track, %s%s%s\n",
+		 (block->bp_block >> 10),
 		 (((unsigned long) private->real_cyl *
 		   private->rdc_data.trk_per_cyl *
 		   blk_per_trk * (block->bp_block >> 9)) >> 1),
 		 ((blk_per_trk * block->bp_block) >> 10),
 		 private->uses_cdl ?
-		 "compatible disk layout" : "linux disk layout");
+		 "compatible disk layout" : "linux disk layout",
+		 ese_str, fmt_str);
 
 	return 0;
 }
-- 
2.53.0

