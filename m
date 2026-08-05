Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B29F435527;
	Wed,  5 Aug 2026 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928592; cv=none; b=Irzkfjipx9FdWOAl/pPygukNAcrAQJz0ad5F9cndKtaV+lS4dWrmEvYZXCDw4OwATbvvZQvCS92QL2NhccIAR46jrjfwMV52Wp55nUdthLBVwOwoWqhobK/yUwKdsvafQfPV1prZQI0lUVCHrHBVkjvEX7ItPOQnN2HL41lNpLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928592; c=relaxed/simple;
	bh=HUsuztf/B1ZdD9fQdlw5BkChnFgqrVU+uY6KK5PtDAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uudxxjcuQjQtfaeKhNNs7OObBHPC85lLJlRkNIb52ae7wjaVjWeA4ov5uTP7ujdku3Gnc5JOlDj2p4Kb52BYofgNDjn1kQH8J0fUOG3YfcB+oujoHWKD/SsI+cx57Rk0HYl0y5KBZSVPWBZ+8RLPMsW5vFwDOiH4h7d7CfPGV9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MV9fBSCo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MV9fBSCo"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758m0hi3355049;
	Wed, 5 Aug 2026 11:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iCZ6fm
	cpPJFAxV2lqO6vk5zkYlX8mcWD7/HApQlMfOM=; b=MV9fBSCommkKvLYRUkU7YR
	Kc62rc2Qgi9QzD5zHzvv1MDCK0FlUNBcb6V5J8zDnU+HCEINYOSOB2nSvUvoTljk
	bC5ncttsu5tHybnwby4RAQH0u1B4tSEF0007SzaPOH2R2OSa2XfSm/p20DQySkqS
	qg2GbqUa90RILf4V+S8ti48QPxFWoLhEDTGnJAR7KpLKXbMuWaX6d5MgqDlD9814
	S3etT8/Cu9C+WN+2ExpdJ1m59hEEC2nWhL1qTTK8+KLAf486A2At1ZtqP9jJX5uz
	rPuPyTpcXn+hFVjBfMLn5/6Pe3K17sFsXf9uTm8Ex9GIWUFA6t/giy+Wd7S0qr6w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42prm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AfYxk006295;
	Wed, 5 Aug 2026 11:16:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k685h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGHN949676732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A248B20043;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F8652004E;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:17 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 07/19] s390/dasd: Add defines for the Extended Address Volume track address
Date: Wed,  5 Aug 2026 13:16:00 +0200
Message-ID: <20260805111612.1285190-8-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805111612.1285190-1-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a731b89 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=TMLJGLmHJrsBqeDK7DYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zTnKWgfZdKFJ7DQqCjU-8_W0-Y0X1C3Y
X-Proofpoint-GUID: zTnKWgfZdKFJ7DQqCjU-8_W0-Y0X1C3Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX7QsXsRIuUVik
 5wScCUxqWiXWnhWy6g55LdVtc7rUEpDM21r94qoSYOKApQpoMggicCS4lvgcNKDINUXJ/a4zvQx
 +g5bk01T+mrdFJM4AN2qOigNiKqVOEk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfXwWiqK8MNx1TF
 wtugAlXXetHyzDBRslfpgtBDNVMM8A4Qad9FzmBqS21nsEMT0XSDo92xRj7WbNuortnL3GDuoSD
 o0rI/JTjbV55UWCPw+JPwWRYZakYzsZjH43z5nJZjgBhXHapIBqHfeIKuyMPOL2QAK0tLzycMUO
 FIAxMJ9zKasrZXtmBXptbU5gm2eA35Z6qE7JddRea38ZQgSrrw7JWwAkW+3aFN+sKZz0eyjnKiH
 zDfLmVwxkXdEvdthO/xa1wgontye0efP1EMQAOYvnDhOOGEH72xulJsEX2PeH9t5HnU6r9LsolK
 6E4YIpIy5X9/zhgefRaEBFDQ6xbLNUxkRg4bakwivEMB/0GmeSDKyigZZ+kSLYP18SQm7p9+YbV
 gA69jqKseTXna0f60LyqyKisQm79n0UUpq7ijE7WsZkXJ4H92hreaq3zgJ0RNE86KLqO2TOmquu
 C5vgHMusIAOSkoAmk6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086

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
index b64ca714b53e..52d008b59561 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -200,8 +200,8 @@ recs_per_track(struct dasd_eckd_characteristics * rdc,
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

