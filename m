Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6687139B48F
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582624; cv=none; b=niPMn9NIOuh+ynM8z2or72ZW4dP5ilFp5iCuN3LoVk8mpPShw/XKSuwtqEigCtpY8XULGr3rLviArcCwcQD6LfE6sT8ay0O3hhQfO/DsTUmRExGdXrzBqTA5Ds74CEQvRk+/e7I2v40p3spoF0BJUtBV39swrOXJdhnho3NyWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582624; c=relaxed/simple;
	bh=O1Ox91lHJPM4TZtSoIdhUo9Wrxyvc4LJlO3zOIc0TIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIC2SyHoDxzs26/B3InMUYPUHmhM/693cxCdzOVPeKIyAlhU4bYDZK+ATcHqSbJ2V6TjVmPxifdyWhSseCOSHf9gArd2nAv+DYMVMK9rVZT4w7GrCvkP9QZ+N54lkHhe28Hj+y11iZaBWb1gfVHuFcJiCgP6SSS5P7ziuUuCFLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eo67fkBa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eo67fkBa"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6712w6hC1784781
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oxFIiU
	lwR07Gpg508fbNApDlMTtcpBHIUFa31SnJtvQ=; b=eo67fkBa2Q+qAhEfKBI3ck
	b7w17Lfa2FluET5ftnC/+NdUR2B5VcRjsCY7BfSw4Czo6vgnQXW+bp2PZIRyRt7g
	SO8iseL/W5PLt8m5Rln6Jdq+4freBZRitlpaq/l0qqJQkucYNhSTLg2uAgJIVH3d
	3JhPs2C79A+bqTsbtghixpOGojcZtHoLGk1iKjPKWyyBYjiYRtnG59EwLX6PMMKU
	Iez4A1PMdkszFjyOR0mw2/MTJkusAtubzH9CEo/wHrYmlRqqpZG2Y05OJ/rtVr7B
	9dAd/gjnuRfeCODDgN5F3o7byjHO1OqAAZCie/hHekygxjr7sqiTf4lTJ5zhgRYQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fq9393-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671AuH1V013954
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwkuqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671BAHQY48103860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 11:10:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6902E2004B;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F77820043;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v6 06/18] s390/dasd: Add defines for the Extended Address Volume track address
Date: Sat,  1 Aug 2026 13:09:56 +0200
Message-ID: <20260801111008.3391031-7-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801111008.3391031-1-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h2BoPzMMl6jY0hDDBKYUa6wMYYtTi4v-
X-Proofpoint-ORIG-GUID: h2BoPzMMl6jY0hDDBKYUa6wMYYtTi4v-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfXzxL28CFLbZAy
 KUaTZ421TYwBe4a2PLotoEZOyHyRyHoZsDvduxOR4gyXVuEDniiGtQomOsDfPnFjr/knjicaGqe
 kAw+oIxk6GPAuQ5l4URkrbB3ZHIBI50=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a6dd41e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=TMLJGLmHJrsBqeDK7DYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX3g9EfdWIzrJQ
 Ipn9A3ZW4id5q2Y7oitr2OAPgETOqr2ZvoAQ90uUZz1ehO9uMBV0S8coBzObP8tbxVZQ51Tm0dX
 YgvwyzDesgeYDhWQI87qDLoVGtoC+dy8A7iPatrPIRS0R+Y6iigCMsSk/vyJhEZOi6X0yKtUvh3
 tDMeUHLaRQEFqRfeUaMIj+7MOCNXkJme0nl9q+DxPseTTumRSYDdBM3iDsGFWO97IDojVlh+k6r
 sRnRZwlxjh5zMvPeb+X8Efzf17GUeAnYeu4II2JUvYvoZPoaX+HFnNavQ67I8zYHg2oexTfJOuf
 KuFBKy5xoXFiN7XqOhmiQ05h2tIsrDa/rZPa9T45FgHVme3wYItvRWvwHfqxbPiOTbl+XMGTk6L
 v5f/xwj9a05fbdEOrGNUIpFi+mGA/D9E4nGbff+iwCOldGjSzVMfnC0cfIZAWBF9zt7yySCFd4B
 vffBZoDPNBEvzbJTrKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010083

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
index 7ce8a82d951d..8192f939aa43 100644
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

