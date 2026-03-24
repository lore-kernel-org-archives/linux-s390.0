Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993B4405ADC;
	Tue, 24 Mar 2026 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366137; cv=none; b=bxGdZ+djG4vlk/BpN4E31nEoFnqOBtbMp9pUQqb2lZNnzqFx2qIxgnR8+W8yWpm3PbTWkiQPFPBBvZ6ObN3jF6h/QDCyeAd+PLaUojb7gHdJLCSlcVWBB/MXX26ac2n6YGKQgdh6GFrDxJ8tN/R8Qc2dM8gK6UO15xt81X/o9mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366137; c=relaxed/simple;
	bh=jk4VL04jcXImyvsapwJsVwCPzVp5csCqxd+AkUyFmT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iW2b62IWXe/S56tGJAaM74vtewVPAE1dTESjIsjMTcYn/ayIzOHXhBC35141YGt1IFNDJwgh31Ws1zw/YzNUl46zgrYRGNKSe3Yc9Ewqh3R38EDeUncPd1SK1IoQFMfUh2fgrNcVfv9EhB4l5yrC+1lQyNO+IO9cYengLN2Z9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fs2qY/GG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fs2qY/GG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O7K4kP484163;
	Tue, 24 Mar 2026 15:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TlOzgA
	1nuWBt5n+cZcs7D9wiBeqzRCI5kNzuqORY64E=; b=Fs2qY/GGBRcRH6F2HhAip2
	N03+QDiX7ia7SgANANDE3jb7h3pvuSrhLq0KbJ0+Y4jqDGmQid38t5pEsYisKG+E
	jOCZ7iyt5xOr4yjyYVbg+dSvCtp7KsMKglOmdajuQsYbrZ7IV+14zQ3mpYxIsXEF
	nATSEdUbyLnb3WwJPas2NyExZseBykORz/BBg733SonZuj3wMyo3+5drQD7V20E+
	Gf8QQPMWo0Ss8ZYaUj9lZgXYfoJqXYF9SLpeNbJbNa0i/8yV6oNsL+Wzg0Ojg2Ak
	umCDw2oy01pWkFCDE7XJHT+CiElY+0OwemGxmt9YhojBbYcztAxUDfVDp/Eihojw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxv7u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:28:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OCnogQ012203;
	Tue, 24 Mar 2026 15:28:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk2abp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:28:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OFSmrG46530934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 15:28:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DE0720043;
	Tue, 24 Mar 2026 15:28:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82C8120040;
	Tue, 24 Mar 2026 15:28:47 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.21.79])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 15:28:47 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 24 Mar 2026 16:28:07 +0100
Subject: [kvm-unit-tests PATCH v2 3/5] s390x: sclp: Rework
 sclp_facilities_setup() for simpler control flow
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-vsie-stfle-fac-v2-3-5e52be2e4081@linux.ibm.com>
References: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
In-Reply-To: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org, Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2430;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=jk4VL04jcXImyvsapwJsVwCPzVp5csCqxd+AkUyFmT4=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmH1q4prdJqf7/yjMEWFe/lHVwMp9/aMVUlnNFJjtl5t
 lv5T9DCjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACbi58jwv66UuUOC898CSYuW
 UsN5DL+jMjpe/2+aL/J1poJY2wdpJ0aGHfxBoWu8zsqxdF/PkcicfcGwJ9uiK+gRf037yU9JjP/
 4AQ==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c2adb5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=M4Ik7g3vCtbGSaaBp14A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX2GcF9XqsDvk0
 9joXfjnBd4c76BhHAaZUDXtNGGkEYnmHqJ6FGi1wP8x+VlKojmAZukP3DaBVyuAryr1GRZdYhJV
 q+ONuLeJdohXG9ioHxeRAe2A6XzdK7j8Vp/wsTh9vf42+qzQOkMLbZMQhv3G1wUYZiJS576ZZTt
 T1qD2qfxMPBbJfy+hHmQ1bIisM9UsGaZLtwirrc33FfhR5IictzVCmoGdJR4lEvQzCIWP/haKAb
 dRf2XRik7l9KhF+RDgmRPkfg0kRX3mRuZ6o3aRS7pax7SpvMblNf/oks5iSVZVLxkXsk9uLO84U
 GkU11DHJ9Xf2zUlpiY5abV9DQWHKxIEzMWb6RGS64BvF8PZFegBf5aW3/8VbbpE3B0vgLljJE+m
 ZwG/GLG6SpKTgJcQ2jtHr9hwKA9PdYKVoX9BAyANGdALm1wzRY+Y3+nGXtsZrgmpUG0lpNXywix
 VTs19LnJV9BP0m4aAuA==
X-Proofpoint-GUID: HRQ709TO8NQz-f7H5e0QOT6hz4J--qaM
X-Proofpoint-ORIG-GUID: HRQ709TO8NQz-f7H5e0QOT6hz4J--qaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240119

Reverse the order of operations to allow for early exits with increasing
cpu offsets when reading facility bits in the extended range.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 lib/s390x/sclp.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 2f902e39e785ff4e139a39be2ffe11b5fa01edc0..d624872cba608fcbbd0c482a25f091fe19475a43 100644
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

