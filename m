Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9FC3BCD00
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607244; cv=none; b=JKqkcGibOHEAMAKPjN5ymHiut7bwWUvcB7N2uGx7JFqDw4in3T9EG0fmv5qMw1ZSRDsXb3x41NcenSDbfLrkt/DQEbuN6Xi1XWgIPplLdqPHmg3J/HuDyGj3JJZnRnxzpKqY7dNtyrT0tcW9qa5KRKqSmnUwmnw+FpzAj4Hgu50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607244; c=relaxed/simple;
	bh=O1Ox91lHJPM4TZtSoIdhUo9Wrxyvc4LJlO3zOIc0TIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFs0d705uat2pzpBiSqEAqniqjOLCWvy6GiAxrbjVu3GDU5+dcXGR1l2HydHAKAoaApyUiCk9gudOD9AaWbUWmCD66QsrfVnceaTrxPrHih46pejKpwXVNPxFFenLGV8LkFbYAwQfX8zQROHg1gEM7shw+kkWsJRYJLmHP6YWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I3KY/eOm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I3KY/eOm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671FmIdP876519
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oxFIiU
	lwR07Gpg508fbNApDlMTtcpBHIUFa31SnJtvQ=; b=I3KY/eOmu3QpRCRRrBJNBm
	r9yFeVa+rrHZQ2t3jsblgUaLwrOIXZ9wosEdnstglVDtrLCMto/dTpAT+R4CWB4e
	idCFp2BD47P8U4iYpxerCETnBGr2xE3hgxMX+eSnMBTku5CxWLmyZNl7Vy4kGqt+
	fXwoe4XnB71IBVgC8HDUQy80PyPs3rPKaLCUgK/K6kcmqCCac8eD3rg/XkdJgnqm
	Qu8lZbheF72KfRyVAzdph+cnyQJSuTMt1R750oxBOpE4UIvQNAke3b/w1KcYwClb
	BRFp36gFqgZMGDzgl61RUuHi+dFMFTWE55U/aQWT3S0BPH/gesiHLXjHclWuWvFg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67ha9sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671HuJLk014480
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkmr9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671I0b9J35127776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 18:00:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AE4920043;
	Sat,  1 Aug 2026 18:00:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E76EF2004D;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 18:00:36 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v7 07/19] s390/dasd: Add defines for the Extended Address Volume track address
Date: Sat,  1 Aug 2026 20:00:21 +0200
Message-ID: <20260801180033.3679412-8-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801180033.3679412-1-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfXyTuAnLSf7X8c
 DQObUE6dXuF1n7gZIV/F53Tgd0AZqAfsRJPeCUFyyLQbitkPj0DWmNRGGW54hr43Qfy1DE1ZEl5
 qAu6JoXMOSh2D5WOCu+SXvpj5NnFHq8=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a6e3449 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=TMLJGLmHJrsBqeDK7DYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX9nfFPEBGJfKW
 XpuuaVXXNkCOLwdxdAUG6/AVmD7oT3jVJcBFauvjnUvN8+Ga/QY20p3lBpFW2kbj+EQijMcl8u2
 wYkNOAQgoXr+CbN67uyC0APQtmspNSRFS1vzik71+tLNfmp36CapYWRLGoOIGqTn0ukvXgncThV
 ftpckhhOAI4R+Dz1d7CePyiQA5ayBb1htgK3BvchEXrsvDIRqAUssTFit7rdBVOJAKp3JnkYjHA
 ZQP4eDNHMYECR+5uR0nSiuVBpyZchjWAWdUfkKQG5xupt658Rmz2kwVXNRHwNLliDkZlzozJLlq
 M5NnCk0R8a6pPBt2KVbkt9OQos23D4EQY0y03uun0BlpyRHSZ3aXmwD50TADmGOMIexSI3EJqPb
 Yaocve94C5lnM4q+m9/0iungiWVPVQHdvS81JpHE/cIi0MIdP2iILrob+iG1okHc5+iupp1aiG9
 7a5beHJQq4nhaCHnwjg==
X-Proofpoint-ORIG-GUID: NbctqzBkuJd71HfrzCPxxItqD6_i8rge
X-Proofpoint-GUID: NbctqzBkuJd71HfrzCPxxItqD6_i8rge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010143

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

