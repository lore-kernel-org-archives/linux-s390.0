Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F835BDB2
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733421; cv=none; b=RUdBY6scOpmWq6llJYAipTjylBzNp7/ztJ3NLRLQazjnNZND8qq0xocpGI1VKbFpUOCSkyWJ1SKtzcC2j634xasJaCJFaeqc56OWEGV0eXR71XYzllaH7B9C1GzvvuMfNLl06J+kWBXA2+IP9T0hfGMOaIgZ8HzCNWvc3qVngSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733421; c=relaxed/simple;
	bh=QD42W6fF1cjbXmDqNz2eUbiRCIrlJmpNv9qD8pyNamo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9aOfpCF3hNiWnznmBut7USIu5wQiB0YNDTbRHZsTK/iMP28LtkaWEz54LLatVx+diOolmFEvNlA5sF4KE/cXLrbtNuGyOVsvWdQJDg6RJrRrKohQbt/ZSen0cBgxLpS4165ebjHIKkSlJPfclbjv3jGtIoKkgIaBgaKtjHvIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dcc3st4d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dcc3st4d"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDg2mX095757
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B/sedW
	fQnLzR7w4vyJ7f4c7vCY27Zr2rfld8T3/WLf0=; b=Dcc3st4dDcjLV5S38q2KrA
	PHmsGTK5wJqMh5w8qKpwBVBu2L6BeGRJ1OxceW3NKugTzvtoRFBeHsDduXnBV/+d
	DAUnqTFB9dZ2EdvFLT7qB6Dkuwyzf0ekjRIkdKwoaxpqe62wrR/Yrz6MvBvyiUVk
	xz4SV+dthsugy+KFAoo5WObKMZjBzQIHHVMnYDAfqeoCUUiWja0P1RSzywX6RwDz
	HgbEeMF6exBQlIBKg+vVbwlUz7AqGOXjnUR6gbSdEgSmN6a5v2sb0Z6xOILEIt9K
	G7NvUPtQcOcdw3t44MciBRb7YLpUcJpOfBpoFHMdq22EVNLiQ3fUDFGJFD9/r52g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahadbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:16:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MF4tqv013237
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:16:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq82d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:16:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MFGrZ561211110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 15:16:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B84EA200FA;
	Wed, 22 Jul 2026 15:16:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 743AB200FB;
	Wed, 22 Jul 2026 15:16:53 +0000 (GMT)
Received: from li-c11aa8cc-2ecc-11b2-a85c-95df2f347b4c.ibm.com (unknown [9.111.60.227])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 15:16:53 +0000 (GMT)
From: Volkan Unal <vunal@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: oberpar@linux.ibm.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
        meted@linux.ibm.com
Subject: [PATCH 1/3] s390/dasd: Add device type defines for FBA devices
Date: Wed, 22 Jul 2026 16:16:49 +0100
Message-ID: <20260722151651.292621-2-vunal@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722151651.292621-1-vunal@linux.ibm.com>
References: <20260722151651.292621-1-vunal@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sAZbrC0-v9B2YacPErHgJMM90yL97TIh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX27dr1K9oSEta
 +KlDECJUGUXyCeG9Qvg4NVLup4wD+xZDtwLXfU6nt/mIZjF4YTdbr9uixHJyhwhlglKlSSg672n
 upbfZRmxXqJ5k5tYvXxl6lpJYNdUUf9NcIp+bCzEMIb3qrh3vKn0zk/I1OsxlDYrPCFRWLdWBfT
 yFVPY2g/dd+cnv8K5wm9tXT7+pfmLAlb4nqyUHxgD+SAn6lJWSTcyUGU0XiExYLMrKdBFiPts+P
 ds13Y5FJlyACfemfZc3+dcNLLCdwWyMS4lADEyC20tkQcgJAafFfjMHJGZnDBGDbIDtN2BxIg8j
 xoLphpd4uzCUjCEujId+dTKSIjUZv7oMjevc2xmY+AF1BqWasYbgMazhbBoi3ULqFmDB1vTczqh
 4g+nZGdfdiLzyUHekSiogu9N+Xtta912H7Xnak1cbaA/SKfc9QR5pZpVu9LjxpDoD5/LJePQI4R
 qGHLLeZ+ae88MB15Ztg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX+1TYzoLkPbKs
 nHDlG5hgcCrIGnAAI6s2bk43TdWXnqAByGfV38H13orynKjrYq89oRi0IsDQ3wJUQ0yCyYPB58j
 3RuHAL1K0HZzv/lkMOifQrKTQhOaYVw=
X-Proofpoint-GUID: sAZbrC0-v9B2YacPErHgJMM90yL97TIh
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a60deea cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=oPwCWnqw_SgioW4XjacA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220149

Replace magic numbers in dasd_fba_ids[] with descriptive macros
to improve code readability.

The defines distinguish between:
 - Virtual FBA devices (0x6310/0x9336): Memory backed virtual
   devices.
 - Physical FBA devices (0x3880/0x3370): Physical 3370 disk with
   3880 controller.

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Volkan Unal <vunal@linux.ibm.com>
---
 drivers/s390/block/dasd_fba.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 029acb83ecab..45a488db897f 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -31,6 +31,11 @@
 #define DASD_FBA_CCW_LOCATE 0x43
 #define DASD_FBA_CCW_DEFINE_EXTENT 0x63
 
+#define DASD_FBA_CU_TYPE_VIRTUAL	0x6310
+#define DASD_FBA_DEV_TYPE_VIRTUAL	0x9336
+#define DASD_FBA_CU_TYPE_PHYSICAL	0x3880
+#define DASD_FBA_DEV_TYPE_PHYSICAL	0x3370
+
 MODULE_DESCRIPTION("S/390 DASD FBA Disks device driver");
 MODULE_LICENSE("GPL");
 
@@ -42,8 +47,8 @@ struct dasd_fba_private {
 };
 
 static struct ccw_device_id dasd_fba_ids[] = {
-	{ CCW_DEVICE_DEVTYPE (0x6310, 0, 0x9336, 0), .driver_info = 0x1},
-	{ CCW_DEVICE_DEVTYPE (0x3880, 0, 0x3370, 0), .driver_info = 0x2},
+	{ CCW_DEVICE_DEVTYPE (DASD_FBA_CU_TYPE_VIRTUAL, 0, DASD_FBA_DEV_TYPE_VIRTUAL, 0), .driver_info = 0x1},
+	{ CCW_DEVICE_DEVTYPE (DASD_FBA_CU_TYPE_PHYSICAL, 0, DASD_FBA_DEV_TYPE_PHYSICAL, 0), .driver_info = 0x2},
 	{ /* end of list */ },
 };
 
-- 
2.55.0

