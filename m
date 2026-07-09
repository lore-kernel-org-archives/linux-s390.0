Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6EB3446CB;
	Thu,  9 Jul 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610134; cv=none; b=Ki2/0eOCZYah+z29OI+H5wlS00Jz9hVkV2ChPMQFbrV/Rc4YpBbYJxtbWC6mqWSlxYNkeVNu05kIG51culOvx0QCEmOsuFs1L/+lJlAxs6BgAjYsc+34S+CwlGFEqCjyjO0az/gHFwwyr/l6bSIpzZeco0gEbS3YpWs2CEc0VUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610134; c=relaxed/simple;
	bh=9q+tC7d9UllRD2lfV6eksu9bIuGN19tw9nQnOhx/JIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khj7nMhLMnIniM+20hLyBRJ95wcIYU3NxpOKkl+oGeysKdy9D6QxVeGHPBcIgYpmZTxyRcw1YJRqcCWazZkYsQ6xe8TIXPIwRQ+/BIabUQhn14E3qd42XrQXr3P9cygV9pOghARoFieMhwPAjh2aZoYlh2FP8d4ZZ3VWUEOIkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P+mn7CJK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P+mn7CJK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIGOt2914084;
	Thu, 9 Jul 2026 15:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c6xy4Z
	2FNtUG2sbfnelUsxNmR5PUYAgVAkcuxRdtwf0=; b=P+mn7CJKYGdO9X111AmtY9
	TYKSLRtx4YsbdXg1L/VHMnFGwWlLDD5TEnV72RI9yt/zgsYVgaAm0vkfvwWz4MKa
	TGBJaPN40QXhFArYiA8EATAAhlaCzja94dSrDbu7aXuhTpi37YU2cIf3heE9rxyJ
	h10N6FYRkJpU0+c5AQ3Z9fhsa9Gdzx5SZlT5PjplZaUL/n6893tW9bQvQMyiBNL5
	6FCVrm8duux2HQb6rI9+YAMxELM1viP38Wwu8f0oZ/rW8DSoLJpZxu7igrvwEasM
	p3vKn8GK/Z3JYgbMzk6cW5320mQy+GBgH0KtfpdsO7OBpjJ83QBpl+zFeIH2qRaQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur22vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669F4aA0012228;
	Thu, 9 Jul 2026 15:15:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ydc1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFKrK10420666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 072B12004B;
	Thu,  9 Jul 2026 15:15:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 578AB2004D;
	Thu,  9 Jul 2026 15:15:19 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:19 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:01 +0200
Subject: [PATCH 01/21] KVM: s390: Remove double 64bscao feature check
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-1-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Eric Farman <farman@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@de.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=9q+tC7d9UllRD2lfV6eksu9bIuGN19tw9nQnOhx/JIo=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u5meCcc2FsTXViTechES1PilHlPtJXR7yr1n9qLf3
 19j7v3RUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwEQqqxn+uwZFm4upLV8+NSBC
 qvD1vnkRh6bsPyood23XrThuyacc5YwMB0yWvWc8H/Kzct2DQ/6lfaeXyd/e4Zj2T8tLe+usTq0
 ZbAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX0GdRG81CSTYn
 4zHYPXJAbWpaREAooQyaA8JEzlaJPJIrrFFmMlcoHdf7v9dg7CG/Ec0w921DiINkPHJT5ilT8ff
 5nZPJNRjv65N+kNF1RW2vzkFxnzLcXU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX2FywVWcOeI22
 rF2gsNAMD5SYsWtAZVKnXRbRLmRDfU5nGFhlEginF7WvTAx1NPgTtn3LU/VQAaqwQ6kaj0dJO1x
 MIZUzREbbPWloYAJZ2vjzLbkyFOmpEgtXCl9i63iDAV1I/1z/z3UnS7s4gd7yAik/b5PXHMKO9g
 oUyE/LMbGMjpsUMC2jnjo1G4Z3nIGy3HJFc3PxcRVT7mMw5SRuWzQ7r3OOvFrxwYA7SOQKmBQHR
 utAFbU01xM4iUDTFaiHmGPanf6DyXWKbsaciZ4tsuYFfByNY5/DdYqKSFzDQYrb62w25wj5nHhh
 Qc10oCi3+qkWpY2Vx/Ey0/8neeN7ausqIIyyPl57ckQjKVcl7CO2l0N2FGiGDsVN9n5LcZ9jfwc
 7ASJR43CSx2vcAq/YQQtPaYrN5VNlb4Xeeuvv6+bpFFJ0ZtobS5m+xywXLzPvHLJkISJTFNfWhw
 RXqi3aWf61FVewdI7vg==
X-Proofpoint-GUID: EqjIRCXg9CAiR-YXKlhitO_vc8wH_6p1
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4fbb10 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=TDcXjUL1frRt-f2QLQkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EqjIRCXg9CAiR-YXKlhitO_vc8wH_6p1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

sclp.has_64bscao is already verified in the guard clause a few lines
above this. So we cannot reach this code if it is not true.

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@de.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 23c817595e28..4b1ef955c7e8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -455,8 +455,7 @@ static void __init kvm_s390_cpu_feat_init(void)
 	    !test_facility(3) || !nested)
 		return;
 	allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIEF2);
-	if (sclp.has_64bscao)
-		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_64BSCAO);
+	allow_cpu_feat(KVM_S390_VM_CPU_FEAT_64BSCAO);
 	if (sclp.has_siif)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIIF);
 	if (sclp.has_gpere)

-- 
2.55.0

