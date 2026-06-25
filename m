Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C13328267
	for <linux-s390@vger.kernel.org>; Thu, 25 Jun 2026 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393397; cv=none; b=LlX9c3FDyBQMi3WsCfeGXzOz03veDt5uKYvTjxwhTcdP1LsRft1FUriuAuRQym1lLzKne976GejDxXy+jsPi4+Rm6e/76c9S0W07p13h3/hTBhUKRSxOOr4jyczyDnPfcXk0ldJ6rImIde6o1hXxHLrcc0z0kkSy3dbeSovE6iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393397; c=relaxed/simple;
	bh=TVsi4+WNrGtJZYJYXKdUTESI+sFkfIbwVLjlYm+T7dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4/8/laGgJH93TZm7G3ZRhH8ioL1J3omxpWThe8zUo4I/bJNnQ2Tuy3Gc5FUzmSiM1j3797hYR+6Z5zdEuCrkNGnQjtM4oVJ7F39uhskDQlopCi+j68O3Tpc8MwxWBEapR0LphOdox4uAe/YpbSzfc0BNWOn95D2syoH6OxjXrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KXd5s4Mt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KXd5s4Mt"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3mMSK2927284;
	Thu, 25 Jun 2026 13:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I8jhQUz0BKL+Ysm2d
	LXxQjRhqf9C6QNODV3TwjShQX8=; b=KXd5s4Mt7VWvGcTZ+EHLYZfcYcLNF8po3
	VEWAWuz9RVBDMkgsD1qJp9znVqgu/AyFGJgKdjtMnP9x5e64hM9TwPFCggs8V2IR
	AWIS2n19yPKlbTdS3m50ARuvo8pcw4zhg6xg+WsjJTkCxunUrMmEbcLtwz+h0Fx3
	flDKENWx+HSRri/Y4hZObJdEqX84HkbzdoDS5tM/s0NMnAK73QRllMGMf0yJ4ll3
	NyIBV/wrmTIo9Xg0aI2VKOVvWvzCW/uDc2OmJ51KYiujyvV/nRIFZDSFxch/C3HY
	DNDtTbJcQoPekU4FPkp2yWvwC67uf3bNU29IlzwtVSMQ7Ff1Zw00w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gsn6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 13:16:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PD4q5j015646;
	Thu, 25 Jun 2026 13:16:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwpe0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 13:16:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65PDGS9D41222586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 13:16:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 558DF20049;
	Thu, 25 Jun 2026 13:16:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BCF42004D;
	Thu, 25 Jun 2026 13:16:28 +0000 (GMT)
Received: from t35lp84.lnxne.boe (unknown [9.87.84.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 13:16:28 +0000 (GMT)
From: Ciunas Bennett <ciunas@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com,
        Ciunas Bennett <ciunas@linux.ibm.com>
Subject: [PATCH v2 1/2] s390/kvm: Refactor __diag_time_slice_end_directed for single exit point
Date: Thu, 25 Jun 2026 15:16:14 +0200
Message-ID: <20260625131615.262367-2-ciunas@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625131615.262367-1-ciunas@linux.ibm.com>
References: <20260625131615.262367-1-ciunas@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QeFjffUSMJcCK5EX_6at5X1TPL6v-4I_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDExMCBTYWx0ZWRfX5fgaiuD3fZ4P
 GMPTzAKwtnSxW8zlHeBMCQTUGGWfGPWKDZ+w2Oq5L/4DgXlax2snPjXSzaCtprP52xjWKG46NOG
 O8HOUWVaofo5nalH/hjWH40N1CLc/jQ=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3d2a31 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=95mcOe01666WQwagYVMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDExMCBTYWx0ZWRfX8BEVFJ7zTSed
 Is+fVP6CTJt16pDSFurmdTBz/bscPsDwHeTmtH5IvMcaUviY0n65Q1UlypF3rFuXqAnbLNyYlx4
 Ux9eiaDsIMCuqnfSqsMgyCsVHxDT/6F9/E1vfIsRreJKyzWTkamVzpi+OznpehnJESB0U/JMNFd
 I839S2nGLB0L8zg5wsWd9m5VlUpbrQftvHApoNELI8vRgU7flnafdDwc//WnbxxiVFP4jhCruxy
 Xq5FPHBEyWGZ7KqixWTNjGOxD0GwRgR0IsmOJpOkIrOC03DPiFBhkDovuj6kiFsI1z/eztlGijK
 KmMbpOzEbny1gBFFpgFjKYnF1QXFAGGrHQoUnX155Lz/1Ql3RKPp15s+xThp+54ksLX6ajsi3ZP
 RdL98MmOeL+OMkS2F3tOV/O+LTv8atRnC1XZUTIbIAzk7j/KYHt1CNtImDb3xLI/YQbFx5WJNSD
 SwGdU2HqHLFgKTlhFpA==
X-Proofpoint-ORIG-GUID: QeFjffUSMJcCK5EX_6at5X1TPL6v-4I_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250110

Refactor the DIAG 9c (directed yield) handler to use a unified exit path,
improving code maintainability and reducing duplication.
Changes:
 - Consolidate all exit paths to use a single 'out' label
 - Replace multiple VCPU_EVENT logging calls with one unified call
 - Introduce 'result' string variable to track operation outcome
 - Initialize tcpu_cpu to -1 for safe handling across all code paths
 - Ensure statistics updates occur before the common exit point

This refactoring maintains identical functionality while making the control
flow clearer and easier to maintain. All three possible outcomes (yield
forwarded, done, ignored) now converge at a single logging point

Signed-off-by: Ciunas Bennett <ciunas@linux.ibm.com>
---
 arch/s390/kvm/diag.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index d89d1c381522..85c84421b510 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -186,7 +186,8 @@ static int diag9c_forwarding_overrun(void)
 static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu *tcpu;
-	int tcpu_cpu;
+	const char *result;
+	int tcpu_cpu = -1;
 	int tid;
 
 	tid = vcpu->run->s.regs.gprs[(vcpu->arch.sie_block->ipa & 0xf0) >> 4];
@@ -211,21 +212,22 @@ static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
 		if (!vcpu_is_preempted(tcpu_cpu))
 			goto no_yield;
 		smp_yield_cpu(tcpu_cpu);
-		VCPU_EVENT(vcpu, 5,
-			   "diag time slice end directed to %d: yield forwarded",
-			   tid);
 		vcpu->stat.diag_9c_forward++;
-		return 0;
+		result = "yield forwarded";
+		goto out;
 	}
 
 	if (kvm_vcpu_yield_to(tcpu) <= 0)
 		goto no_yield;
 
-	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: done", tid);
-	return 0;
+	result = "done";
+	goto out;
 no_yield:
-	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: ignored", tid);
 	vcpu->stat.diag_9c_ignored++;
+	result = "ignored";
+out:
+	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: %s", tid,
+		   result);
 	return 0;
 }
 
-- 
2.54.0

