Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326A3CAE8F;
	Tue, 28 Apr 2026 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364144; cv=none; b=CPv7/Krs7AZtc/ei4g7VrJKAxRr/AE7A+aKfc6Xopkh4xf3DB5fBHxzww7TjIAsnD0c3vXBTBlnHTDN0hX4GILT4aRxhfhu5B91xgMKtY4RDFZEW+dIP0/nzHpaYE/erA3Q+nR9M9iDalhZKCPnsO7P9L/lCMQGeVhbbUjFdtYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364144; c=relaxed/simple;
	bh=bf0l+qnY5Z4nXTL6SarVdLg3czWRX2ly2rs/LxCaUq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LunF4JMCRMiIyW0Fmj/LZ4HQFf2R1+KJaSb15QR5dMlcj2xAR5MlKF5r/EwSSxjoqrjnhOIcF+l3aLevyNHSibhRJs3TKrhSHIzY2xjyXZzWlLYFpJqn8XO+4KCwQnEM/NW2DubwWjYCmofUuuUNhvpJkL2N3w8jMqE3wG1J+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XFmI5N7w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XFmI5N7w"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S4iRow2652173;
	Tue, 28 Apr 2026 08:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kpNmdQ
	FLv7DSnpbN0s0soSDlc2OGTcpPz0FwN7cCdF4=; b=XFmI5N7wTpvDHNKAqWM3qP
	IqsrlEf4wIR1/sWjRUHTvPnTdmQAWUNkWTnnEprrEpofM5C6fDi+bnZIiKzXUxyf
	gyLoJqlXtyeSEgG/eL2Sif2DYZQCINf2jdE6vQNTv4u7crbqvcLhoPmu6KLkzhgS
	hyIY71ajKsMI5O4cr6MmEM2RFfS22WBuAG3im1LOjhTm+5cD9LJYi9TKW9GhT+Jc
	hx7zkevLXV7w+R/tOKcRgcQ0itWsDpNLbC+kX9a/p4kDOK82e9ZJRpOaM8q6u6s5
	v6VT38B6B3+PYrC8iL/BxumjAKCBhIrbRtYSZ3nxtHCAMoTQE13pZhDAPKOJVvoA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vba5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:15:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63S88wZo029960;
	Tue, 28 Apr 2026 08:15:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk0t65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:15:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63S8FYmI49414592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 08:15:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92EE220040;
	Tue, 28 Apr 2026 08:15:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68F0320043;
	Tue, 28 Apr 2026 08:15:34 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 08:15:34 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 28 Apr 2026 10:15:26 +0200
Subject: [kvm-unit-tests PATCH v5 5/6] s390x: sclp: Add detection of
 alternate STFLE facilities
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-vsie-stfle-fac-v5-5-34c5933a218c@linux.ibm.com>
References: <20260428-vsie-stfle-fac-v5-0-34c5933a218c@linux.ibm.com>
In-Reply-To: <20260428-vsie-stfle-fac-v5-0-34c5933a218c@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=7EC9rvaW7G5GBY47rpXFojzlbtl2vpcSYdgjniiWOw8=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJkfcpaK955RUWzxfC3+veDZsdTKIxvP1U7u901l+nOrw
 Xxt6CnZjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACbC0sjIcN6O+btv3fdd7cGH
 pd+VpLI889mmHnEgY029rhvH2+XvVzL89zN+N/936FMD7osfimamrGY59tsnag/Pgh7BNs1lwel
 LGAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f06cab cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=jhiYOCp1ZGrQtAn_9xAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LejFzHz9UeCcqkLfyCq7QMcPID5CsBL3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3MSBTYWx0ZWRfX0kcoe/Gtgtm4
 Qfg0IDrfDpCr2vT+/31BV5XBNwX+RIrhGKwzh20OoLpmj/7CbokvqCd5z3bRposSz6kztCWNXAG
 JmW7tCFBEM0zAojgmtVQ5GwLy+qLa55jzjMyrwkIWKkKJmQHvYLWDJm1SgYXVimCCEXTwPABeys
 i3nEofdOgFg80tFK6FMzWRo+ZYdv1GYTFHY3asx1wfz0dGVJe8xsv6Z0BPe5GtDVayfdh9dmpeh
 /cbzL9GX+E0G1q/Kivx9FANjJa6CUrazjmUg+58RRMDSfsImGnnu/LWYf1XjxZMX3DZWTdF9heH
 H65LqUeNkd+bDtHM9zydi5L1U/zBGeapwZ+l57lIB+Yv5gqQDUq39fr9us/2dU4aYNPVSbsVGMA
 o0XMMtT++XKFoZJEqpBea5CKMUZL8MMCaa1bOfaWU41YBKaIxOl9zBxE18QUe6SaUWSCYUcJASo
 77WXK/sfeWosFID4SXg==
X-Proofpoint-GUID: LejFzHz9UeCcqkLfyCq7QMcPID5CsBL3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280071

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Detect availability of alternate STFLE interpretive execution facilities
1 and 2.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 lib/s390x/sclp.c | 2 ++
 lib/s390x/sclp.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 9d9fd3cbcb8c..850cf432dc90 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -162,11 +162,13 @@ void sclp_facilities_setup(void)
 	sclp_facilities.has_esop = sclp_feat_check(85, SCLP_FEAT_85_BIT_ESOP);
 	sclp_facilities.has_kss = sclp_feat_check(98, SCLP_FEAT_98_BIT_KSS);
 	sclp_facilities.has_cmma = sclp_feat_check(116, SCLP_FEAT_116_BIT_CMMA);
+	sclp_facilities.has_astfleie1 = sclp_feat_check(116, SCLP_FEAT_116_BIT_ASTFLEIE1);
 	sclp_facilities.has_64bscao = sclp_feat_check(116, SCLP_FEAT_116_BIT_64BSCAO);
 	sclp_facilities.has_esca = sclp_feat_check(116, SCLP_FEAT_116_BIT_ESCA);
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

