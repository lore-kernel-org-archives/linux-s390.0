Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8C43B3EF
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512349; cv=none; b=nwj+MoN7LqbzflXakcmNQ2ngjRYtmSimOFwEGR+OOtTTwzS9M2gMjFyMnbK9utQWnW8ZFFfoBfCo12PSOCkzVPYR4dGrxPwUvA5bRJfBdCY++gcv+pnfhXKGXMIEsbsSJg2KliPZSPjihXMaBXjEFN/D2+7MPgV10BGuAYTmNcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512349; c=relaxed/simple;
	bh=Tzvb/ymADbVwDnH0ocbjUbBp0rDr39X/huTacHzRL5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EW5ZMAwDU/li+ndyeL0/eKul2Az0Qh/55znqxbHHOqTYlglOkY8awQF2kouRutMiO1NlxEOgbxWIiIELxue28Frsiz4M2LJHNWm3P2D+jJ2cFsf35ZgoqmuaTGFZMQqPtDmMrRY6NCS7Tu+MzbDS5ITzjVPBwweMRuXuPJjR9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oAWubTjb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oAWubTjb"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBm3nl4073671
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wgsFAF
	Dzs7zlByHqLYgpI0hbj0t7zqz7Sb+uN72m/v8=; b=oAWubTjbt5ApU0LvxPP7wU
	j3zDVawXuqVq63fm3hdhY0qfqrrVg0o2jdXeIp1QUpH02kdpEb+8KpgMEHozNxgP
	RUD8ChHEY71oyQxB7D3zkOZxy7B5b/FOSXjVLir44BZX4xWJfQspKwacVvXlj6be
	YZFsfJk/uFXDMLTlXD8g0SYVxDQyrhyVgxwW0NuuRZgMUyc0nUEDsiK9tXQHBhK9
	J1Ijs3hTreTEh4CSBvozwJ2cJmZwJFI7kWIKoonHLN7utsZRPgXuEka8VjtfSX6l
	RPbPacjzt/zv5QCPUlbv5FfGOsH9jHH/lpTcHBVoQZYJlfrGRJTi25jmWgHVjQFg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycwqd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VFBSp2027942
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgra25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VFd07l48955896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 15:39:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DA4B2004D;
	Fri, 31 Jul 2026 15:39:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21B692004B;
	Fri, 31 Jul 2026 15:39:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 15:39:00 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v5 05/17] s390/dasd: Add defines for the Extended Address Volume track address
Date: Fri, 31 Jul 2026 17:38:30 +0200
Message-ID: <20260731153842.1729627-6-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731153842.1729627-1-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C4Nbf7ZqOhBb_xSk8sEw92stXYpVjWMD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfXwhL+gZRNvnPB
 qvClkqqtfAm41P/V1Y7yYeGynhK1WL0cI86Yjzi2lngJIpf60nbZXB5NpAwfsQImi82LhgMVU8v
 JhRmIpxwa0OZwv2iwdAswEC7xZpCjVBP5VcWqFgbPWKZVq2qsEaOJJBhgnGIcsm5bo5HaDTmNtx
 umHCwXdLA0sC73J5qPQ4AW7V5GiLcT5AZ1JPZ2oO4MBvPqg4dG/SuVN2oDWuuIwZlcLQRlbY8C6
 CURTqfpKjc47Il35HdBCLgSIKa4CVnxqH0sA4By8TKZ7m1PKmqN79NBSlUyAeQIA1rS9VaBaGQ+
 iLdaHW0mKfjzQle30b6wIuRBUO285Z2parEdP6X6mASIqgrgcNURVahRSKm28Vdet8GDSevV4Z+
 bvrk2MhVIcxji42y0lQDrWoRlVTKn9E4A4pW15naJrK8G+ZI+Xk8W6RMtPTUFKMESoUesAz6kWF
 8r/9w8YfN+J9j36IObA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfXzF278mC6DR6p
 RfueyBI3WR3NrSUMEgw98Hfr11BMRpLXs6KrdV4ZF2yRzb0h6Wy3CAtL8j8FY6ya4VFoeHOAOmz
 7AYDr1Xba/92g9ocq4xC/8ewETDJRSw=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6cc198 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=TMLJGLmHJrsBqeDK7DYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: C4Nbf7ZqOhBb_xSk8sEw92stXYpVjWMD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310116

The track address of an Extended Address Volume (more than 65520
cylinders) carries the high cylinder bits that do not fit the 16-bit cyl
field in the upper part of the head field. set_ch_t() open-codes the
corresponding shifts; name them so the encoding is explicit and can be
reused.

No functional change.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 4 ++--
 drivers/s390/block/dasd_eckd.h | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 5593013c9db2..0734a82a7ba1 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -199,8 +199,8 @@ recs_per_track(struct dasd_eckd_characteristics * rdc,
 static void set_ch_t(struct ch_t *geo, __u32 cyl, __u8 head)
 {
 	geo->cyl = (__u16) cyl;
-	geo->head = cyl >> 16;
-	geo->head <<= 4;
+	geo->head = cyl >> DASD_EAV_CYL_HI_SHIFT;
+	geo->head <<= DASD_EAV_HEAD_HI_SHIFT;
 	geo->head |= head;
 }
 
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 763733bcc4d2..bad7ba666370 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -146,6 +146,14 @@ struct eckd_count {
 	__u16 dl;
 } __attribute__ ((packed));
 
+/*
+ * Extended Address Volume track address: the head field carries the actual
+ * head in its low-order 4 bits; the cylinder bits that do not fit the 16-bit
+ * cyl field are shifted in just above them.
+ */
+#define DASD_EAV_CYL_HI_SHIFT	16	/* cylinder bits beyond the 16-bit cyl field */
+#define DASD_EAV_HEAD_HI_SHIFT	4	/* head occupies the low-order 4 bits of head */
+
 struct ch_t {
 	__u16 cyl;
 	__u16 head;
-- 
2.53.0

