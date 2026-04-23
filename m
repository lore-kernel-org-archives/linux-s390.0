Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79D32BF52;
	Thu, 23 Apr 2026 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954443; cv=none; b=ov9Sy31DEZJi5PEJgcSL/sW4oIoTpmqQngvGR9kleFxTNPI3bAZFnxncv7+mEQmZyQPdhcW4yk4QjqKnod64HST++NbuquEIgTlBI2TppgsY7fjKJ216aH4/e1eMp54MtizsP48YAe13KQUFZbcbk2LI4/Zhsz1C25bm0u9vKAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954443; c=relaxed/simple;
	bh=sg88L7aSRr/yIkrbDVNul3tKP5dLzPLjUmMSnMTEC5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8EYI2KzIepnpLP0P4XtOBmdOSAtIt0txXpU3+0c5h4971sg4luLZiC8tL56D16KVy/FMTVBOAbZAUaImtdA47boHZNOzDYEHcu18zRgcvoiKfPczm5HOtd4TkftfVq1s6vc8Zd5bU15eojQcDNzKV2iiU5/ucjFbWCt2bmtOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HwA1u0ya; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HwA1u0ya"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N4rxLe982124;
	Thu, 23 Apr 2026 14:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZF0moZ
	6J8WpKGfEmwTQGpnw/Wi2dLOG4CXH+5vN7AYc=; b=HwA1u0ya1xBOom036/0o/c
	8cr5lLHJUqT+3gtV9849+C/51GXNTndGTx8b7Aqu0N9VNhcTW6dfbaFtsnwyf2lf
	Wf0I7jtWtFHpygZ7WKKV2gTouGy5YFHJszYTkH4Efw4AcwFhqJAVFmP8dKwoheGn
	wNMvBnA7lV4CW/M8ThCsOZGHM29w4GeyMCfhEq+qMzRitBtDcW0x7ngocMBNvDXN
	rKHamv3Gxpkvw+Vaba/9FDxMsGGbR5COTj3Q6//j+LoCidDlL2ZEdpRAVAMCVIvw
	BPbvuMIvYailvVEWwhpj+VbX6gcdnHJj0CnbpK3VU9c0HkctZsWBL1hfVHmpp2xA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7rhfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:27:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NEKH2t018186;
	Thu, 23 Apr 2026 14:27:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxxy1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:27:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NER2ej29229390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 14:27:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2562B2004B;
	Thu, 23 Apr 2026 14:27:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00A262004F;
	Thu, 23 Apr 2026 14:27:02 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 23 Apr 2026 16:26:49 +0200
Subject: [kvm-unit-tests PATCH v4 5/6] s390x: sclp: Add detection of
 alternate STFLE facilities
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-vsie-stfle-fac-v4-5-32943fe43394@linux.ibm.com>
References: <20260423-vsie-stfle-fac-v4-0-32943fe43394@linux.ibm.com>
In-Reply-To: <20260423-vsie-stfle-fac-v4-0-32943fe43394@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=2kgA2E0NfDiDj1gYMtBPUgOLEBXVTgxK+WzzargyPKs=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmvdExi30+5+Kw2bN2uxyK6zsc3cVrWzXlq9vKRQ0XnW
 kWjw1rHOkpZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZiIyW5GhqbQTdlPhKcvza5R
 TXljLrUrMuF97/ZQ8VTbP4mr5d6X2zIy/NAxeHFU2nxKmOYf5+27bnJUmv04tirwqnH8a8Xddhk
 TOAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S0B9fxQKYEwkp0avLbHvKtgN3kwH5CTN
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69ea2c3a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=QWCs0eiKgbEvguDEGgoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: S0B9fxQKYEwkp0avLbHvKtgN3kwH5CTN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0MiBTYWx0ZWRfXxabRvkuig6p1
 egkjcvhCMZsdKOsb8AeQrYXmH6XbP5Dv/cR46vKV/7Q3XIvnU4gx5DY9Tf23HELIUL4Kr9ryPgz
 vjYGBmUZlZ3E8zwVibrmPqVc65z1yrUYMvepBJ14DagZ6Lj6bkdFP6fpzZi21ovv/cxTMXCdatQ
 Ld8unDGBE3HzX99xBcY1A91r/Gxglv8xMbAKfHu9fr2SGF7yQMgAr36LvZwrB3xfT3DZd+NF0oi
 udLQu+kNmkn5etph/CuQ74KJM28uCwKsxb3A7j3mAjCKZPsBU1Db4vXlcX6Ciq3tKT3bidTgNLq
 H04AtsAzLgJepwa2lHvjL5l4Bbcc8trvrmtocRaZNN9aoKtSE/vGt/Mw3eRjbj6rsh1YtUQF+5f
 ygvol8J4W5945Zy372UUJ7qx9H0T0g5qc9VsBvtXuDz0Wj/cwSXYEK0T4SxmwrcJu7sVIas17Ff
 sH9NFWNH4g64CYsOZ5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230142

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Detect availability of alternate STFLE interpretive execution facilities
1 and 2.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 lib/s390x/sclp.c | 1 +
 lib/s390x/sclp.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 9d9fd3cbcb8c..c9d32ee48217 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -167,6 +167,7 @@ void sclp_facilities_setup(void)
 	sclp_facilities.has_ibs = sclp_feat_check(117, SCLP_FEAT_117_BIT_IBS);
 	sclp_facilities.has_pfmfi = sclp_feat_check(117, SCLP_FEAT_117_BIT_PFMFI);
 	sclp_facilities.has_diag318 = sclp_feat_check(134, SCLP_FEAT_134_BIT_DIAG318);
+	sclp_facilities.has_astfleie2 = sclp_feat_check(139, SCLP_FEAT_139_BIT_ASTFLEIE2);
 
 	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
 		/*
diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 87af429b5798..eb574350d678 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -129,9 +129,11 @@ struct sclp_facilities {
 	uint64_t has_cmma : 1;
 	uint64_t has_64bscao : 1;
 	uint64_t has_esca : 1;
+	uint64_t has_astfleie1 : 1;
 	uint64_t has_kss : 1;
 	uint64_t has_pfmfi : 1;
 	uint64_t has_ibs : 1;
+	uint64_t has_astfleie2 : 1;
 };
 
 /* bit number within a certain byte */
@@ -142,9 +144,11 @@ struct sclp_facilities {
 #define SCLP_FEAT_116_BIT_64BSCAO	0
 #define SCLP_FEAT_116_BIT_CMMA		1
 #define SCLP_FEAT_116_BIT_ESCA		4
+#define SCLP_FEAT_116_BIT_ASTFLEIE1	7
 #define SCLP_FEAT_117_BIT_PFMFI		1
 #define SCLP_FEAT_117_BIT_IBS		2
 #define SCLP_FEAT_134_BIT_DIAG318	0
+#define SCLP_FEAT_139_BIT_ASTFLEIE2	1
 
 typedef struct ReadInfo {
 	SCCBHeader h;

-- 
2.53.0

