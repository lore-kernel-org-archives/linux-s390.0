Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF9938F248
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582624; cv=none; b=kAVDraI3SIj8sCP69QePWwyBCcjb8tZgOwzUUyGK+bhn9+wDlhEJaXNhJwhKXsn6YjrUi5FUH9yMS6KuBIPqtdX9ydg7lbax2yNtoHyTMX9g88pGCQuCAAiJ6srvwNTqO3QIb0cixMRgx9UYlVPBiMAPKdYCgzaCv68T4kgql/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582624; c=relaxed/simple;
	bh=1nkbS4t0z/jNRIPvt15xVo/n2dUlxGg0BuXBYg2XhL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tcs3lS4pjmHxDIN6F5w67GYZmstthrL3qKa/WnWQuFlmugoZTfkVG6LWeFcDTi0KrC1dSQvEcn6wve0gg48mmcOlbM9ynegQwIlFin2flMxLaJP0wg4+BUy++0UdWO6mJpIIKhKNb3Jowvwg9AM6hGjcVZY4tGQ2V7axrW9H2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kAN3MbuU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kAN3MbuU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6712trfo3692192
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qPeZ8L
	meuKfX5O8qbmPQCZbpm6RTF4pXptsGoiEH3rs=; b=kAN3MbuUZNhQBExzOREZaD
	HCFN/AXTDV56sj+8CyXB6vBKIhUnm9qbnChtEVKmRNleq6R8QzJlKk+picU5+YTm
	BtTVAtHx+FVzPFaWHB8aCortg8FYZwguc+c7YpImNVnmqORtZSac6QyFg6cYeeTu
	2uWA8Z4cgTYwtfSkdWn/HWYELt9FN0TPaIn0qMrewshIGUsOq3COd5UQ5Kktcd/5
	u+R5NsTFtwqnWnwj85hnWME9BzYLPrRWPeVBWIgICvQfGBPj572H/lL+2AFM7VnE
	IdSLhs1HoDiVPwimmqihguQnsNn2EBp70k7l+bGOxzfW9Td7bEKOyI6NrvjU7ZFA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eu9211-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671AuOSl014184
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwkuqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671BAHNU32375064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 11:10:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A05C20043;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 072D520040;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 11:10:16 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v6 04/18] s390/dasd: Optimize max blocks per request for track alignment
Date: Sat,  1 Aug 2026 13:09:54 +0200
Message-ID: <20260801111008.3391031-5-sth@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: LM1__FSaYmkHc-XI95IGV8ExgeWGGEzv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX8/ADJh5vYQhP
 IsUz5/tbodoT23UHc4KqIg0ffZp55j+Chb8cmuzKso/gcIwvB+q2ANhCmfJWGMmET0tYMxvIRmn
 ptpNYu47hZNbKuiTxHpqePRriaW3WCA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX1S5nzztZvJeu
 lpSNGCLiHahRWRJmJww3Zo5lfKbvJmG9/RjyPXOVmgOU8krp8f2+txdlrqmzXj5/Mo7isXbTB2t
 DleJYrDbhgJONBJ57KZMYeku3/v9TXEIK5r5fcX3UMcZwWouI1lTF+mj1FmI+PYzdTrQCoadFeI
 GTbKrY2JFM8WVq8INOn99CuCVQSFLW7JneNx3G2M2FG0lcFxOZDGxfWj3KLlYeaTmjICLSLVwAu
 33Ysv04D68p5s15yetBPf64c5h52yJh6v6l6O03hmpBaRLUECJ5dOn1aMe+Sx9B3bcRa3uYW0Ev
 Hkr7QrAseZ3JTXHRbEWNYk2aoL3W5YAnj0moXWMARB42tj1GUjZ/mz7P1fpP3VFYnYfFhZ1/eYW
 7Ns+aoecj4UIjQcR+5/reke3WNUU5LtLUWm+q6D2ice6NWnWVg9X8Sh/DQB0RGp1W3gjLUJ+pBu
 //6XHNl/uq1+WgW4Rxg==
X-Proofpoint-GUID: LM1__FSaYmkHc-XI95IGV8ExgeWGGEzv
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a6dd41d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=8f17mpASHZ0i51vZi0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010083

With 4096-byte blocks a full ECKD track holds exactly 12 records. Lower
DASD_ECKD_MAX_BLOCKS from 190 to 180 so requests align to track
boundaries (15 full tracks); full-track I/O is more efficient than
partial-track writes, and 190 had no alignment significance and could
let a request cross a track boundary.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index f9299bd184ba..763733bcc4d2 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -131,7 +131,7 @@
 /*
  * Maximum number of blocks to be chained
  */
-#define DASD_ECKD_MAX_BLOCKS		 190
+#define DASD_ECKD_MAX_BLOCKS		 180
 #define DASD_ECKD_MAX_BLOCKS_RAW	 256
 
 /*****************************************************************************
-- 
2.53.0

