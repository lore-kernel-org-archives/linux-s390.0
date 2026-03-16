Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF933D4F5;
	Mon, 16 Mar 2026 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684268; cv=none; b=O7qUWqIb73ADq8AfgqPoP/MfHCZoEvjDRlW4nNfrS3/n2H9rNSHyJomoWOCH4PkkldyS+4YDxPxI1X3+bar+Od4GQWrDaXnbveSdfu+Xg1+qCjw4ZXYO7xCUn6c3qCg2S3IENGUizKZBafaNDpW/EKkjRKHq9pwX+5t+MeuGUBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684268; c=relaxed/simple;
	bh=pjvUL4N16EIJqIEmu6PjcwPeAzvmdEy7S2vMcsgMfqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeEJwAdTijSBxRFwaZZDS0JsL09LWq4wKLdmw/Afwsdkt2lBoAlDPbqrDuabaDycjs425pdNZJM8VfsGWtUl3pWfB9BGIfX+Hp0cx611TsaykEDRUHUqRIAPRkWvVxJLVX77gzlAhJp+w/mW6Ub+i4wXY8EJvWb/SbT+p8QZUjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QcX/jdOa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QcX/jdOa"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G9Z8Cr3775990;
	Mon, 16 Mar 2026 18:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wFrgKRu2SXw07wHO6
	5tNYTckL2FtwHbGUQz2Kqw+DiE=; b=QcX/jdOatlUDE6VAMKiECEoMU0J7/vUQ5
	10dWCizzCMhTv64NpAg7H+K2+wljJGI58n0dNh3ZHGRslrB+YRy4Pf96aQbjYjkU
	MFKQT+6a+nv7w/annsg5CaVENi4AoOeC88Hd16HB1eEmfZR4aCpZRklSU2lvWwW5
	+XbCVLa3miLPrNJj8/JKwu0/3qGc6ya7QWZKKxCVfDxNWlt4FWCyurPP/PX4Obpc
	ybMduOJ6AYXh6tV0ahCWWiI+wdKrdSkR6fmYW4rVkubxAbtegWE3JoufVQJszi+B
	yiIbY1zhUyY8HllKXEhsfQ2gmFRNDaAW1hefQ1l5e4ialzw+JdiKA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs15fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GF0Mh0015662;
	Mon, 16 Mar 2026 18:04:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n5tsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:04:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GI4LOo28705206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:04:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F31CF2004B;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA73620040;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:04:20 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [RFC 04/10] KVM: s390: kvm_s390_real_to_abs() should return gpa_t
Date: Mon, 16 Mar 2026 16:23:51 +0000
Message-ID: <20260316180310.17765-5-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316180310.17765-1-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b8462a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=OoK7OCtaIc60VG8IaVcA:9
X-Proofpoint-ORIG-GUID: ISHDKx0hq-6oFoa3d5QpZTgSIXR1SKDi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzOSBTYWx0ZWRfXzvJsEZOqyr4U
 rCBU/0TCRZQ8EZc9EjvntP0p4kqLwTi1dHGdoU9ElfvykWSt+/yTTKny/ktCd96YUMXisXu3lmz
 L3/dAaz2D1xUfv9UPCE5rupbZvBflQjTgEOTffU7u2AY8zkVeb1FCVxb8Btw2rqbCPEJSvM3Fgt
 HK24TC3CvKzVsmUBYjG2YRwCR92enkE3tzOUvPerulAMrAD/FNfVPUbfnQANBApxKRG5vOo0R03
 poKkeQwoT3nTM+4l+qd8v31rXfKC6H247AGgt1f7hYexcrz34s9uSgzuwt7A340+TK+yo55KQYz
 0T5ZZ2H7ZMYqoCCl8mlTisUF7+u+lNhGMnGbtrWC0p4cqcwyG1Gb7TgjXcRTDf8NGdm4nKSasgo
 8iLaEqVNMvbm0Xe2GvPay6XiK4Re6YJNt5hyH0iDquMBO9f42UiUaa+AWVxwP0BxeKhxX6lq4IM
 IQpcUgjpSYingupdlJA==
X-Proofpoint-GUID: ISHDKx0hq-6oFoa3d5QpZTgSIXR1SKDi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160139

An absolute address is definitely guest physical.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/gaccess.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index b5385cec60f4..ee346b607a07 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -24,7 +24,7 @@
  * Returns the guest absolute address that corresponds to the passed guest real
  * address @gra of by applying the given prefix.
  */
-static inline unsigned long _kvm_s390_real_to_abs(u32 prefix, unsigned long gra)
+static inline gpa_t _kvm_s390_real_to_abs(u32 prefix, unsigned long gra)
 {
 	if (gra < 2 * PAGE_SIZE)
 		gra += prefix;
@@ -41,8 +41,8 @@ static inline unsigned long _kvm_s390_real_to_abs(u32 prefix, unsigned long gra)
  * Returns the guest absolute address that corresponds to the passed guest real
  * address @gra of a virtual guest cpu by applying its prefix.
  */
-static inline unsigned long kvm_s390_real_to_abs(struct kvm_vcpu *vcpu,
-						 unsigned long gra)
+static inline gpa_t kvm_s390_real_to_abs(struct kvm_vcpu *vcpu,
+					 unsigned long gra)
 {
 	return _kvm_s390_real_to_abs(kvm_s390_get_prefix(vcpu), gra);
 }
-- 
2.51.0

