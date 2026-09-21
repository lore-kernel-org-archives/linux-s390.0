Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21CD497381
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996631; cv=none; b=noXfUKwo8g0E/m9NNgthBlMMnj8FznwBAFOxFD4h71bDRiQjYW02xtDk1C4y70PJy9Rwf2nLTTwhrsI2JC1OWYXQ/xhG3x9eDR78q/2zjuQLDcofC2iMFQ84RMLm9IKF9+a09ppKJQWZUaok+39ji5TG8Lkt6cZmvhLsZrcuDtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996631; c=relaxed/simple;
	bh=pqYZU5qqJQNP85QWxQiJEsY7MUkzAEPRg7o58pSEv5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ru1zk3fqr9oooO7cwmRgCjtiQip8Q4ZtFYEAtN8LIR1A3RiL4tN0i7wYzScOq7INyQo5QyJk3B/ri+/A6h1gt7zZ8L5mJM1VI+HVCDjgWo8DTrddQiaUeu+wUI5VHHanfcgVHq73p63oTCh/bQCj/38fnWyZjCjudu3e5DXqx3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZEVFvnj+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZEVFvnj+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB5VL11316710
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 13:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ht6XFaV+J2TgKl3dTan8JPsZ4/++wEPsdmswiZHjp
	lc=; b=ZEVFvnj+B2z9UYWV9FAhAbIZtSqsCGxgxyRYQUb62gC2NJhofKwn2Y2Wv
	HGDxZwE5oWzJUYgfsormMXXFeFmI5K7Mj4VaMYniV6QLGr1DWnQJX0PQ8G9OMeuN
	xoP6Z+CM+42J1DVBaQVaecg4FuM9zpjvj15Kqw2KAaSEMxtgTWvPrZSDaIzBNuPS
	mOoNsyjWocC4287I4Qr5LMnYX6hyeaXQJ/pkkIap4off/hkKlR9xAyYR5dbtnF1g
	81mYPu/M4zyOF5M7KSfivdKKb3pIFODf0LSIX4qW012Y9waA9QGD09YPnziNe4Ob
	fxEfz+40diLMAbrZ0+egpAfuqiQug==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg28q7s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 13:17:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAlTM12063264
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 13:17:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy55nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 13:17:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LDH4mD49873220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 13:17:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70F692004B;
	Mon, 21 Sep 2026 13:17:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 509A220043;
	Mon, 21 Sep 2026 13:17:04 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 13:17:04 +0000 (GMT)
From: Peter Oberparleiter <oberpar@linux.ibm.com>
To: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH v2] s390/cmf: Fix virtual vs physical address confusion
Date: Mon, 21 Sep 2026 15:16:48 +0200
Message-ID: <20260921131648.3636771-1-oberpar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PWzzekvnBLf-Al3cOjg86SP-8SawCGPr
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab12e55 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=GGS46Ek4GWEU-WjQI6EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE5MCBTYWx0ZWRfX/SGWJ6+jC63/
 JjXf9Y5Qoaz4jUpn6gWwsFfKVVvbx1Xgpo1YNuxcuz8tdnv8fy4yrtw8iNuYaW27WoLPYJOmvPk
 OVKJfWR6DjCSA1n9T3r32UJdHpip5qRdJFd7ihBt5Yr2J0pq3XdDIUMC4muAnzVYpKFW+DB/IOy
 Miu5y3u7C5FPabSG8msAnctzejALxXcubh3ODLthdlag2CzgTJSH3mToDTTIA40xDr5QXW2BYNr
 eX2dwsRAnfbdr5ZP+Ax5/nHI0UlaPF45i90h+dR77eSA79xiYeem9B8Z8kWu72FEPLbTbKUzSNm
 d46fJxylZswIfDJ3HSYfVUYHusWDL7vCEbfoIztkZqau3MmTEe87L0/r8lfIn6qOGuKrN202/ix
 HpIpHf3ppzkWa3YKHz1PQXryHoOWt++lOlyBRaf/nbGZrFU0PcPj0ZnB3/JnOypYZA+axZs6HAJ
 7rvUCjIxhMZui3ASIsw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE5MCBTYWx0ZWRfX91VbYbPvTK1H
 IthbmE3hvCDu8z0L8WXrhh1a+qfY1FBKFYTCiQJCl1mJMcjUbziGVyW4KXWbKsKpVEn+oR2OdMN
 9uJtXIs8MjbhNku03eWGxbMvgrHodXU=
X-Proofpoint-GUID: PWzzekvnBLf-Al3cOjg86SP-8SawCGPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210190

The measurement block address is an absolute address. Define the
associated schib_config and schib fields as dma64_t to enable automatic
detection of incorrect assignments. Also add the missing virt_to_dma64()
translation.

Without this fix, a wrong address will be used by firmware when storing
extended format channel measurement data on kernels built with
CONFIG_RANDOMIZE_IDENTITY_BASE=y.

Fixes: 14edd0d73bfe ("s390/cmf: fix virtual vs physical address confusion")
Cc: <stable@vger.kernel.org>
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
v2:
  - Change type of mba field from u64 to dma64_t
  - Add fixes and cc-stable tags

 drivers/s390/cio/cio.h | 5 +++--
 drivers/s390/cio/cmf.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index bad142c536e1..e0a6b4663ff1 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -7,6 +7,7 @@
 #include <linux/mod_devicetable.h>
 #include <asm/chpid.h>
 #include <asm/cio.h>
+#include <asm/dma-types.h>
 #include <asm/fcx.h>
 #include <asm/schid.h>
 #include <asm/tpi.h>
@@ -49,7 +50,7 @@ struct pmcw {
 
 /* Target SCHIB configuration. */
 struct schib_config {
-	u64 mba;
+	dma64_t mba;
 	u32 intparm;
 	u16 mbi;
 	u32 isc:3;
@@ -66,7 +67,7 @@ struct schib_config {
 struct schib {
 	struct pmcw pmcw;	 /* path management control word */
 	union scsw scsw;	 /* subchannel status word */
-	__u64 mba;               /* measurement block address */
+	dma64_t mba;             /* measurement block address */
 	__u8 mda[4];		 /* model dependent area */
 } __attribute__ ((packed,aligned(4)));
 
diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index 8fd41a7dfc20..02b0feb9d1fd 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -183,7 +183,7 @@ static int set_schib(struct ccw_device *cdev, u32 mme, int mbfc,
 	sch->config.mbfc = mbfc;
 	/* address can be either a block address or a block index */
 	if (mbfc)
-		sch->config.mba = address;
+		sch->config.mba = address ? virt_to_dma64((void *)address) : 0;
 	else
 		sch->config.mbi = address;
 
-- 
2.53.0

