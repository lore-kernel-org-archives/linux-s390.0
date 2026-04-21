Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC7737F8DC;
	Tue, 21 Apr 2026 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771948; cv=none; b=R6CM6mrdX9epdjmFpPvxmuztiJQHOFviUiKoO8Jz3ccu1BO+22FQv8nHv2eepDbsJMNo22AdC6pdXfCRITR84DGLpxLcLCqP57X9Sugs+9nuZBRetXMOSyOAIJaC1YPLn/+ce3n9wjsgT9Bn60sGBeG4T2+MRanV7HiEtTlsTSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771948; c=relaxed/simple;
	bh=MnAfmg4Uv+r8fi+oV24MGMp3vklvfWDzBJdqjgF0Ack=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kqY8Y1YgvyVqmwz1GFV/J1Eb9lJqu/MnSPX3eryqkARlC1EBlaGpo1BKX1s2uSDSfYrUvkbhUwZap5KXShR7O/H9/nR1RbpMf1Nme2bh0R1rFGMLjAacCWyl6UceLevnlFd4sPGmwWvcfqvDhBP7AL34M1ZbzNA/Inwjm8b7Q84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R6kYkSWu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R6kYkSWu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJgmYx2328470;
	Tue, 21 Apr 2026 11:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Eticee
	OfyX2O1vOte6Ye/VLqWKG/x9sGCT5h2mIyOMY=; b=R6kYkSWuHGc1w80l/p8wYR
	b4Ag0yMF4OqJQX8u5GR7hC9hcJ9LrZRzXGaIuHPCUGmyZWuXIjj22hVWqCw++TaV
	4leuRrAFBiSht03FSowoNFOJRlPa1wEz8d/asQo2nEZnR1DlH2h1xgPHfwWuPiYh
	9dFfrQWkBVgn0CRIjlI7WSuejHoeaftOG4pdb6zfSFGE6MVdsscFnutDby6LKcQZ
	2NuDGuv2YU58C/fj+7hOMyQuyqTA8W+FO9acaPY/s22oOElBzRmmCtbbxKQmGEPt
	/nUGK11yncGqYl0rP2bK27/OU6aqoI2nyKY96mQiX/JjA43mrLxp/YOb9awmlUYg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k0uadf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LBZQ4Q021621;
	Tue, 21 Apr 2026 11:45:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvrmqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LBjbMW51249636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 11:45:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 519DA20040;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 333442004E;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 21 Apr 2026 13:31:09 +0200
Subject: [kvm-unit-tests PATCH v3 3/6] s390x: sclp: Rework
 sclp_facilities_setup() for simpler control flow
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-vsie-stfle-fac-v3-3-3cee84efefa3@linux.ibm.com>
References: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
In-Reply-To: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org, Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2508;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=MnAfmg4Uv+r8fi+oV24MGMp3vklvfWDzBJdqjgF0Ack=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJnPkxOmrs7I69G1M1277obB3rTI4Nmmh+/uC9j2QPrIp
 aMzG47zdZSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjAR44WMDEeLtRzlRC6a/Tjr
 oB6/o/yM+8243DLV/EeXu1g0lO7v7mZkOJFe/O4ne/PZS9YdmxnUvx7ZV1peK9/6n0vEVmXb1nO
 neQA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mzQ7ZjPzwbBUvK7nV5LCmzeCXt_wUAF7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMiBTYWx0ZWRfXzXzYvxYxhVmN
 BnOHqkiGL4ijAAb3dL6svxWoYIEt9KCPLMohI2qr2gmDyUs3RpaKV99pwjLGSdOFckQhzSz4zjX
 de/K7GdjibCi9Z6T8Nqsek8JeT+QuS/dvkq/rj7EjVu6RiMQzt6iVIO5652H7RdZ9GD3xU7pBIJ
 gin3lhqpTFRK4ijk65s3p2l6IySGyhIk8ORsb9nQe2+N1UjxpgGLz4sFri7hAN/2OulKcZdY+gY
 Qlh/CfD4SXpULHmfQ9PsIfpKDZDsQ4XEwkSFg2bod40uLgB1kYUblud1+hCigiOhuARMJR+h4vG
 +25ps2EtvcXwIF2A6Xi+HNg6naGbKclR/m4rqUFgqDN8Ab+8IhHypIdea4OUCB5fRADjIXS0XmH
 4ih5+MlxuKhuovH+KSh3ah8UPvIxnQH60nlJdgieeEXifqDD9WB815GCAyLPafv5SS/RY67iqYD
 srYzcLSNQuker3rjEZw==
X-Authority-Analysis: v=2.4 cv=PtujqQM3 c=1 sm=1 tr=0 ts=69e76365 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=M4Ik7g3vCtbGSaaBp14A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mzQ7ZjPzwbBUvK7nV5LCmzeCXt_wUAF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210112

Reverse the order of operations to allow for early exits with increasing
cpu offsets when reading facility bits in the extended range.

This is done to ease future additions like the one in the next patch in
this series.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
---
 lib/s390x/sclp.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 2f902e39e785..d624872cba60 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -154,17 +154,6 @@ void sclp_facilities_setup(void)
 	assert(read_info);
 
 	cpu = sclp_get_cpu_entries();
-	if (read_info->offset_cpu > 134)
-		sclp_facilities.has_diag318 = read_info->byte_134_diag318;
-	sclp_facilities.has_sop = sclp_feat_check(80, SCLP_FEAT_80_BIT_SOP);
-	sclp_facilities.has_gsls = sclp_feat_check(85, SCLP_FEAT_85_BIT_GSLS);
-	sclp_facilities.has_esop = sclp_feat_check(85, SCLP_FEAT_85_BIT_ESOP);
-	sclp_facilities.has_kss = sclp_feat_check(98, SCLP_FEAT_98_BIT_KSS);
-	sclp_facilities.has_cmma = sclp_feat_check(116, SCLP_FEAT_116_BIT_CMMA);
-	sclp_facilities.has_64bscao = sclp_feat_check(116, SCLP_FEAT_116_BIT_64BSCAO);
-	sclp_facilities.has_esca = sclp_feat_check(116, SCLP_FEAT_116_BIT_ESCA);
-	sclp_facilities.has_ibs = sclp_feat_check(117, SCLP_FEAT_117_BIT_IBS);
-	sclp_facilities.has_pfmfi = sclp_feat_check(117, SCLP_FEAT_117_BIT_PFMFI);
 
 	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
 		/*
@@ -184,6 +173,20 @@ void sclp_facilities_setup(void)
 			break;
 		}
 	}
+
+	sclp_facilities.has_sop = sclp_feat_check(80, SCLP_FEAT_80_BIT_SOP);
+	sclp_facilities.has_gsls = sclp_feat_check(85, SCLP_FEAT_85_BIT_GSLS);
+	sclp_facilities.has_esop = sclp_feat_check(85, SCLP_FEAT_85_BIT_ESOP);
+	sclp_facilities.has_kss = sclp_feat_check(98, SCLP_FEAT_98_BIT_KSS);
+	sclp_facilities.has_cmma = sclp_feat_check(116, SCLP_FEAT_116_BIT_CMMA);
+	sclp_facilities.has_64bscao = sclp_feat_check(116, SCLP_FEAT_116_BIT_64BSCAO);
+	sclp_facilities.has_esca = sclp_feat_check(116, SCLP_FEAT_116_BIT_ESCA);
+	sclp_facilities.has_ibs = sclp_feat_check(117, SCLP_FEAT_117_BIT_IBS);
+	sclp_facilities.has_pfmfi = sclp_feat_check(117, SCLP_FEAT_117_BIT_PFMFI);
+
+	if (read_info->offset_cpu <= 134)
+		return;
+	sclp_facilities.has_diag318 = read_info->byte_134_diag318;
 }
 
 /* Perform service call. Return 0 on success, non-zero otherwise. */

-- 
2.53.0

