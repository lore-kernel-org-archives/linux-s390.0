Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC3C4070FF;
	Tue, 24 Mar 2026 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366140; cv=none; b=UR3hubZwe60njd7uI9Oc6nP0XKk+4NVbzaL3ZuqaY6pqnpPc06k+0Vax0Y6Ga7u1f9RBI/kLno5LTdTBzPVoJmtZJ92GHP+9zEo7h2VuTyrKdcnOzFbPrUhGzVe5EdGAHNghKTdVi+V9FyeKof8dD7u15GwWrk7Te9HZKT1G5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366140; c=relaxed/simple;
	bh=MGTHSBdgGLPPyrKx77p9K6cLI+6mIRdR4pHYNG10GnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QuRlX5DxPe9lIr2awIzjb0sAhyQzxytvDLUmQmpXWO4bjXOQxWYu9bHyrPytcvpQIHVkaypximsuKJqPVoPlA1DpIjbJqX2XJUK6c8V7DPE+YGm1lZqsGe97uS8fFzBQCXFo6CGPN8sDnqodFR9RMDwNB8DAkX10RdS+xNYXmLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aIg099+K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aIg099+K"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O1nXLO3317009;
	Tue, 24 Mar 2026 15:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3TQJ74
	V2bKPRtOKk1qvr12/7WXQflNKljAAl5q510dI=; b=aIg099+KMpbhd+CncGX1uA
	TGZZgzRyhEEpI5rarvREstenzUMtxzoFz0GFvwk2vsBEF0nTxX0BV685rhUB71XU
	BwTtKmNeHQjgPvgDIhBrDJKLjPbWsmAGzQwea+y7/h6rcBeZp904/qf+o0ky+kKD
	OqGrv2E2z1Jjm1HHjp4Won+pPRIO19L+V7fXVRtgQ8nVaq/bE3iRBb2q6TmFfdmx
	U2ehJ3XRsCIvRD3dGhwJiDZailWXub71i4CQDbkOLyk7ePT2Hi5Obt6cEOmds9a2
	eDfXQacw+4ulvteiFNY2/XKgt+RVv+zRZQ99lc2T4DIjZ8lCXjnkQFtqI2pirSpg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky03kd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:28:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OFM6tC006009;
	Tue, 24 Mar 2026 15:28:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yjm43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:28:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OFSmpO45285672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 15:28:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF45220043;
	Tue, 24 Mar 2026 15:28:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29CAC20040;
	Tue, 24 Mar 2026 15:28:48 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.21.79])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 15:28:48 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 24 Mar 2026 16:28:08 +0100
Subject: [kvm-unit-tests PATCH v2 4/5] s390x: sclp: Add detection of
 alternate STFLE facilities
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-vsie-stfle-fac-v2-4-5e52be2e4081@linux.ibm.com>
References: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
In-Reply-To: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org, Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2311;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=9JPsmGUo/ZBjR7og+3Y56vJkPaQVhvCX5Vh/U9fAp1o=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmH1q7Jk+21t7x7JeOBYVFfj8M0i+zr79b9/XrTzEROm
 nf59SqJjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACayV5yRoS1KQc91UUv5YVfB
 PK8VvJari2Q+ZB32MLUMY91jol7AyfC/eJ2z1ISFzkKPAytXTtivod1iJCPr0PdT26Sy8RCn6GY
 2AA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX2nymx817dBAm
 qP0gF3oasjY5dqgSl8KyPPwxniJAXVOKYF79D/ysfBuFpQ+41Up4g4oT3j0AF+YOQeea6P5+mGj
 Xw2viVeV0LBHYXXQJra2xhrD4Ei3Mr5GRfz7A1lejKJ3zAIjQAq8DFVmsh8KA9E8gYIw3p0mrHS
 EhX6WKiqIuWQ/UtCKU9/8Uo5toNqItiCWA0huV/vPr6i+CvjUF0Cprekuw+HorUMgUis6Vqt0xj
 ezrc7HD6cao7lGmqrIVAs6aaA5LUpgR8Dy0kkjMcqKYja6FnpziHLKyFSnoSs1Fm/MmJoLV05FQ
 SipDPpX69x3MHvU01kLVRAjAfDg9djzIxAw7GhEHfrAVSvmFlyBitAmWY9+AjFShQhHKpDLujPl
 nwXok0tUn/PXKF/jsxpGmNZwJMQPBrSwtgwK4T0sJyvNIwghcbCkG1sV9782iaQ2RGOS4ZZZyVq
 Vl0dLJj/JiaKavIxCnw==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c2adb5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Dxa6YZADxO0mQfdHC30A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VoJ-ZtvIud85Hs3sVukj4IV1aDghhW4L
X-Proofpoint-GUID: VoJ-ZtvIud85Hs3sVukj4IV1aDghhW4L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240119

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Detect availability of alternate STFLE interpretive execution facilities
1 and 2.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 lib/s390x/sclp.c | 5 +++++
 lib/s390x/sclp.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index d624872cba608fcbbd0c482a25f091fe19475a43..77b2a5ec00d68ec7ee82da295f2f31c539b5c00c 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -181,12 +181,17 @@ void sclp_facilities_setup(void)
 	sclp_facilities.has_cmma = sclp_feat_check(116, SCLP_FEAT_116_BIT_CMMA);
 	sclp_facilities.has_64bscao = sclp_feat_check(116, SCLP_FEAT_116_BIT_64BSCAO);
 	sclp_facilities.has_esca = sclp_feat_check(116, SCLP_FEAT_116_BIT_ESCA);
+	sclp_facilities.has_astfleie1 = sclp_feat_check(116, SCLP_FEAT_116_BIT_ASTFLEIE1);
 	sclp_facilities.has_ibs = sclp_feat_check(117, SCLP_FEAT_117_BIT_IBS);
 	sclp_facilities.has_pfmfi = sclp_feat_check(117, SCLP_FEAT_117_BIT_PFMFI);
 
 	if (read_info->offset_cpu <= 134)
 		return;
 	sclp_facilities.has_diag318 = read_info->byte_134_diag318;
+
+	if (read_info->offset_cpu <= 139)
+		return;
+	sclp_facilities.has_astfleie2 = sclp_feat_check(139, SCLP_FEAT_139_BIT_ASTFLEIE2);
 }
 
 /* Perform service call. Return 0 on success, non-zero otherwise. */
diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 42a2f2e9f25a45d3ebd71729df0d9d6d93a4fb50..5345e1ff8057c787f3aaea0245fc1e19096c75e9 100644
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
@@ -142,8 +144,10 @@ struct sclp_facilities {
 #define SCLP_FEAT_116_BIT_64BSCAO	0
 #define SCLP_FEAT_116_BIT_CMMA		1
 #define SCLP_FEAT_116_BIT_ESCA		4
+#define SCLP_FEAT_116_BIT_ASTFLEIE1	7
 #define SCLP_FEAT_117_BIT_PFMFI		1
 #define SCLP_FEAT_117_BIT_IBS		2
+#define SCLP_FEAT_139_BIT_ASTFLEIE2	1
 
 typedef struct ReadInfo {
 	SCCBHeader h;

-- 
2.53.0

