Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCE1331A4B;
	Thu, 23 Apr 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954440; cv=none; b=BGSlcLwWOH5lZMaeLFiZuclLCs9pePFjsD/f0jeIflEQmiqPXEnk1C2KWajRO56nvYEBy+kdpyhX4g/Vc5oJi7BROQHUP6Yta5r7pTSpb+y0Fi1IobAy+TWuF/BteFWcAhtoHioIdSDcCziM3psjf1CxNmFBrdcOfVqp8OiQd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954440; c=relaxed/simple;
	bh=RnfBNI6cv45mK1tS9BK4jQlAxD6oLJJKVPFWoOi45J0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cb0gZgkO36Wvqh72SUl03Eiy42X8k4cQh8kTP8SAhBycxvEnmJXdukUxUeFLDbA9taaP4cUmmg03IrIktY3OJ2VzFGdoG7M26yZ6ptquBIcd11v6P0oiIga+X+T0RATk3KNec6fzLfuX3O9xGnrUoFHgHYh0/jNv+t/t3AOtFm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pBSuPK1u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pBSuPK1u"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N7jY0K3944124;
	Thu, 23 Apr 2026 14:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v4+IeF
	5Y1Jk4DmciV2RRKtCEd0sn+Z5h7kyMLvwuXRI=; b=pBSuPK1uWKFYSXS+bYVYbW
	1QyqEmqdybMyVGWhAp8idJHQINeO7DKBtgSnjfeAJw2nXtEjnjL7E7tQy4jEPErX
	UoT5ALlnfkAmzwYtL6UKPwfgrMZbQI4f3kmK63gQM5XeR517gPdG99R9QfmOwLSD
	hcbBh6m36hymziWzL56Aw9bvTZr06S+t74efgb6bLkthqLUD7j4CNrpvm+m5lcOe
	raBUgWQ0PlgBYArAHILt6Swvzpp3JCXeHR7dqFEkxQgPQy/x4sXF7H0kzl85XaF4
	YPlZyJqU8ZQV80S60eycRXyrWjw4p0rK/yIVJvw6czG6AsSCfh0Ovhzt/GYOGYig
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3rgc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:27:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NE5Vj9001251;
	Thu, 23 Apr 2026 14:27:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyext3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:27:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NER2aQ29229388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 14:27:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF4DC20043;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB0382004B;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 14:27:01 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 23 Apr 2026 16:26:48 +0200
Subject: [kvm-unit-tests PATCH v4 4/6] s390x: sclp: Use sclp_feat_check
 directly to read DIAG318 feature bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-vsie-stfle-fac-v4-4-32943fe43394@linux.ibm.com>
References: <20260423-vsie-stfle-fac-v4-0-32943fe43394@linux.ibm.com>
In-Reply-To: <20260423-vsie-stfle-fac-v4-0-32943fe43394@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2189;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=RnfBNI6cv45mK1tS9BK4jQlAxD6oLJJKVPFWoOi45J0=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmvdEyS0vmWlthN/aYuoxEkWzevYvXfAONda7i3vHHg+
 XpXJP1aRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABOpimX4n9qxV+vjpJ33fuvZ
 rmYR9zjfUfW87fjndX+qDFTuXHV4vIWR4UVpms3l2WtuPGXape2gelVBqPnN5bTg7pOZM5eu1Fa
 4wAIA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YPfLB2BnocGiQ4AXv4PFJmheq9qIxTxJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0MiBTYWx0ZWRfX+VZzFpywAcd4
 W7aD/ohbTNndJIM7pXZe8zLX4fQy2jwbn+qcC4LZAR+WBK+QSB74dthYXpkBHR3S5pJGEn+qdLi
 WMtb+oxqsq3tno84hAK9y/icOzeHUlg+NxFgMN88WgNAxKDO/0OHYqJeFDK+OpMVLvouhrJWtGl
 GxQh7WSQ8U1jTWeI08NC+nlYkFrUcl7y/VA3miNlttJua/Hjt6fnEDin2lPeRnZ0CkMsNpi8Z3g
 JOTqz942JLIr1lwZZjRM4SsXp2wDpJftShQ36q5mzWFHhXQwyX8XSuHtXasXCDoB5ToQ8ZuI3zN
 DP1XiByzryWeJGRlCZbVDy4iVL+swGd6cVN1Dc4s0pKrNF8Mr10uZTPl0nyk7eVzs6RVQ+P6666
 2urzXtEWnJ2miZv+ohYnkYKs1sfml/ohR7mLHGwPXvz5RcNXYqhyXKsns7pOSZwPLRNLpOJs9bY
 Ic4MyOB9yhpi+8s+HXA==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69ea2c3a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=9Xh-GkoT5eCmbU3qKcIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YPfLB2BnocGiQ4AXv4PFJmheq9qIxTxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230142

The additional entry in struct ReadInfo is only used to set sclp_facilities
where we are aware where these bits actually are in _read_info. So it is
more readable to directly check the bit here.

While at it order feat checks by byte and bit.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 lib/s390x/sclp.c | 3 +--
 lib/s390x/sclp.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 1ffcf448e558..9d9fd3cbcb8c 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -157,8 +157,6 @@ void sclp_facilities_setup(void)
 	assert(read_info);
 
 	cpu = sclp_get_cpu_entries();
-	if (read_info->offset_cpu > 134)
-		sclp_facilities.has_diag318 = read_info->byte_134_diag318;
 	sclp_facilities.has_sop = sclp_feat_check(80, SCLP_FEAT_80_BIT_SOP);
 	sclp_facilities.has_gsls = sclp_feat_check(85, SCLP_FEAT_85_BIT_GSLS);
 	sclp_facilities.has_esop = sclp_feat_check(85, SCLP_FEAT_85_BIT_ESOP);
@@ -168,6 +166,7 @@ void sclp_facilities_setup(void)
 	sclp_facilities.has_esca = sclp_feat_check(116, SCLP_FEAT_116_BIT_ESCA);
 	sclp_facilities.has_ibs = sclp_feat_check(117, SCLP_FEAT_117_BIT_IBS);
 	sclp_facilities.has_pfmfi = sclp_feat_check(117, SCLP_FEAT_117_BIT_PFMFI);
+	sclp_facilities.has_diag318 = sclp_feat_check(134, SCLP_FEAT_134_BIT_DIAG318);
 
 	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
 		/*
diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 42a2f2e9f25a..87af429b5798 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -144,6 +144,7 @@ struct sclp_facilities {
 #define SCLP_FEAT_116_BIT_ESCA		4
 #define SCLP_FEAT_117_BIT_PFMFI		1
 #define SCLP_FEAT_117_BIT_IBS		2
+#define SCLP_FEAT_134_BIT_DIAG318	0
 
 typedef struct ReadInfo {
 	SCCBHeader h;
@@ -169,8 +170,6 @@ typedef struct ReadInfo {
 	uint8_t  _reserved5[124 - 122];     /* 122-123 */
 	uint32_t hmfai;
 	uint8_t reserved7[134 - 128];       /* 128-133 */
-	uint8_t byte_134_diag318 : 1;
-	uint8_t : 7;
 	/*
 	 * At the end of the ReadInfo, there are also the CPU entries (see
 	 * struct CPUEntry). When the Extended-Length SCCB (ELS) feature is

-- 
2.53.0

