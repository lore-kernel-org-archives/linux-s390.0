Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721643F4854;
	Fri,  7 Aug 2026 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096675; cv=none; b=EZy2uNyBSQ+qqiqVWuUlFmY1TX5wo5Gw2mcJHx1UR2MVZ/w8k1L0e/gpNa2BLH/D/tqnWdQ9Ki535sZO7CSYAQcEfe3WQWyX5Lt9f78Cj+0BXklbeLX038jZdMO45mQNcxLi5emIye2+jExcfI1YB+TEdpwBa+oChGKch6xXxM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096675; c=relaxed/simple;
	bh=QXoyVHokJVHwZEBq7uPai9QxDyeKDwoOuUWI7KdxBR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E998lZI45E7plsiW41x8j3Gx2BM8ZXFzEbRzE81tujmX9QRrrNot0NfA01EHoKhNY3gg+wX4lXWnFocog6axtnPL27NJrrpQsqQHk8bEfG5VrQK2ztcaErkWst/JrjOg5iUmTV+WTUvkzgmjcXw5wFeHVUWOOgYPo9nas6rQjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QEblreeM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QEblreeM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HmVn016229;
	Fri, 7 Aug 2026 09:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ncEgsf
	CkTrJNLdSfX1xDlsWDD0wUSiy+K4L6Gee3aEw=; b=QEblreeM9TmHTkxOx56WnM
	Vo88tvZJ1zKNiEc1D13XGDr9EKkk9GAQngccQWXGrCdkng+xSU2GLG6Ka7p0xN+s
	sB9qre4Ii/Aq03qrlq6sXz1Ub4kXHtfpD/9vXnw8nbDXqICkPjwxFsz2mDVjuAFX
	WzeXiWgQLeiY8Kv7VHVU1oR6LeCYEVjjB/Y7vqNHic6cp8l88NoiL0jTmo9biTW/
	EGCFDfqpArS5aUNThPP9CPb/OtMs4iBdKW/yXxbP6kGxN29DokovmWNBu5W1cuy5
	J4XwJ1drhpXDHMx6f7X+BRQQNc0KAaqQPuajQm1RtMYBtW+OeICKFqwbP0GIg7fA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy00b6v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:57:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6779uWFG013673;
	Fri, 7 Aug 2026 09:57:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qy9yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 09:57:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6779vkCP49545670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 09:57:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23DE12004F;
	Fri,  7 Aug 2026 09:57:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 881AB20040;
	Fri,  7 Aug 2026 09:57:45 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.87.136.120])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 09:57:45 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 07 Aug 2026 11:57:42 +0200
Subject: [PATCH 1/6] KVM: s390: Remove double 64bscao feature check
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-vsie-cleanup-202607-v1-1-b18659b55e3d@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=QXoyVHokJVHwZEBq7uPai9QxDyeKDwoOuUWI7KdxBR4=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmlayQeuUWY1MlEfP1XsO1PAPuG3pqF14+rPP38y8Lx4
 87aSa+aO0pZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZhIRxcjw0yPyrLttg9OBEv+
 zdr47Di7iYqnC9MVVvdE1bzWCZKXDBj+J8Su3n591k8H5hPfl9VuajwvsUh6e3TXdPUmx6BrcY6
 XOAE=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3NCBTYWx0ZWRfX68W/mOrYk6EJ
 KHQiWtxHxRVah0YA6fyRYAsbKILwKg95VXcnGRdt8Y+FnG8TaFh0yT/5saX0Fi0xcqYwIqnyErX
 cv7vEXRWunUhPzsRgXrlJDhU9QTzUas=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a75ac1f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=TDcXjUL1frRt-f2QLQkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cW1rpJ3NU-SBrf3JDbqCGDMRLnKs5RVk
X-Proofpoint-GUID: cW1rpJ3NU-SBrf3JDbqCGDMRLnKs5RVk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3NCBTYWx0ZWRfXwQUBfn/ZSWoh
 sdjCUgiYBh28XhrlZ8VwSEMWu7AQzSxQGa9OAvBxggfIHy5Y3fPMdMxHuIrGZBxIuk++RsYUX91
 ZG70aDbuoyLwmCvmtZ9j9/Do+a7zpkb1TU3Y4P7p6ErTWp6srTaIwqMsOM/AR2vNtO2w+lLsixZ
 gNmsSsTjqloZwgBVWIz+rVREagv/5U3kXTeBbKXZJaWruEBkhFnoUMI2eU1NDHfcJL6Vf8LbrID
 PVrijZtD5Pq4IlWXCijKjWcN2cyALEa68T2nO5O2wJWMBTpEhX/ZJHXyKGgHEDDnsPZYFqaesNB
 iW+Dx4doqhmyFCEMWBW/6qxK9MjNMMJprefjpVSPXf+Adv+/ujSJA2XN4sxxaQdnaE641XnqqaS
 6yikDrVMRfyEGpcQyejnEAbB88t0S7YKwJERCwP22Ue1qg6+ceN8Za/l3ii7DU/ksk7pO+q9BEO
 IhKKlY+BDV/tqdutOrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070074

sclp.has_64bscao is already verified in the guard clause a few lines
above this. So we cannot reach this code if it is not true.

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 150b5dd2170e..c679d8f83c0e 100644
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

