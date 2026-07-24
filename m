Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD8E38A72F
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890923; cv=none; b=mg6ayrG2Kdu+yBHKSfjURkjUjzR01Jwt6Z4nbxGm2xB8Q2RGNntUhgQeezvnyNNj3pkOyO8yWPXW5pSG9KqeSijzTAwLvN977u0x4fo6kPoTVmKUuDU0DYu4ptyM3mOZ146HAcHqvhl7H2gNpeqpuz5MqPQw4WBo6+SroMT+NU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890923; c=relaxed/simple;
	bh=TVsi4+WNrGtJZYJYXKdUTESI+sFkfIbwVLjlYm+T7dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBQZSWINkP+WCLlhQUoDIMaCQw3zc5ViKpwCU9hRmu58shJbCgjRSLyvVcEXxslWQCFRkUAOyh8+pRHCe/rtZAmULEjGU5PHuXffqV46RwuhGN+5wXcZDWNtBHtDfE4YzCDUqVfopnAIV9wu5M5Lj12Ji/g2TIymMq21tvwR5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lmFHRodw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lmFHRodw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADJG71455958;
	Fri, 24 Jul 2026 11:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I8jhQUz0BKL+Ysm2d
	LXxQjRhqf9C6QNODV3TwjShQX8=; b=lmFHRodwpbyPACucvohU3UgKLwkwJs5JT
	OOp3pPw9xh0CgCsf4XbnpUJOENEGapyy+isf65mnKr3yQO5W3nMDSf4zRVYL2Xu/
	Kd23E8hN4kIUR0nnZgLJ9B6/LlO3qwtVPwdSIXgKwfJsufVIbRT30jQZ5Lp7XOTM
	B4MRcLxEikX76tVzsVKR15rM3YiIi8kQaZYzrqI/vxNeIUq+g91shyvUsTG2mpI/
	fDOI8BIAHeqZsPSGWNTQNy0ip+Dw6Pk/b3plxDbAlczLEogmKvHtKumLjRBIE501
	dTrdAFBFStF0CFKxPjep00mMdwSEVfmDU/toGd/YRmvPTuRvN4VPg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kkphn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 11:01:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OAns8t012512;
	Fri, 24 Jul 2026 11:01:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqgr5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 11:01:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OB1mbf49152452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 11:01:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A6A22004E;
	Fri, 24 Jul 2026 10:40:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47B8C20065;
	Fri, 24 Jul 2026 10:40:06 +0000 (GMT)
Received: from t35lp84.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 10:40:06 +0000 (GMT)
From: Ciunas Bennett <ciunas@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com,
        Ciunas Bennett <ciunas@linux.ibm.com>
Subject: [PATCH v3 1/2] s390/kvm: Refactor __diag_time_slice_end_directed for single exit point
Date: Fri, 24 Jul 2026 12:39:57 +0200
Message-ID: <20260724103959.14861-2-ciunas@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724103959.14861-1-ciunas@linux.ibm.com>
References: <20260724103959.14861-1-ciunas@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a634621 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=95mcOe01666WQwagYVMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5NyBTYWx0ZWRfX+ih5teIesD+F
 k9eUHAhaWScso+4Qi9CR1aas0ZMhDAuHLVQeJ7G7MdrPIXG+bLQN9yJo0DYH5EpLOEzzg1fWKf/
 O4mG0pjVNNiEGK6MyFBhhtv1woOdKXflH1SnFTJL3TwMNdyw5CEGSLKpiw/baJGsBlaUekVuseY
 GtOkujjdcyIKanf5U8svEUp6jMgJM+vzmFMQLum+82SXLp7+jnIqmg3v9tqKabIc7hO6Zz3nRnf
 F/NBwhDazQlFp5fjD1q9pa8jUdlvMncZyvweuezLBbyywggRfUtJk4lpb03uQywMtFyWjVBd4W6
 R/d0cl7V+huT1uHQhrqk+5TdREMAAR4wYn9sHCK6/CHVXyXMu20Xiu0mUMslPxNSTlrpjS1Bbff
 op/jCYSzIBhcl8YrpgFMjldc76WtvYqonBvwa7jiE4hqNbKnKFICc2G3LZZNNAr+JxZlCBsmRz8
 YaXWjzRYmdRQl3V5EcA==
X-Proofpoint-ORIG-GUID: o5WRJSyAaC4EG1I9cPMQpK8-Wt7VghcC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5NyBTYWx0ZWRfX0cvWlL4dVy8H
 CfAziYoAePrC+cKl73NdcbIWsY2tcjoPbSjtHloQQ1a+fi8CBYe/0404T/ax03rac3D1LE6UGu2
 uSCuk9mCOyvymKauhBNSSrmB/JtvTwM=
X-Proofpoint-GUID: o5WRJSyAaC4EG1I9cPMQpK8-Wt7VghcC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240097

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

