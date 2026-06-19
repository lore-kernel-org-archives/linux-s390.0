Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA0D3624DE
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864040; cv=none; b=JZ8rys6d14AiF8JOaasWl2Vx3wytXrMZCuGnJ3eopASs/a19yX4VmwzQII3LNE8utqUDSRXrz95Rue8vOlk61AgsSi3fEhvwkfwfCzHdUz0MHMfQX2O2G6AGLxlqoUkLlnCbArpDoSt+PKZHl9D3SdIiQMfL/Wg+S2j9G+O3lxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864040; c=relaxed/simple;
	bh=TVsi4+WNrGtJZYJYXKdUTESI+sFkfIbwVLjlYm+T7dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlNxzi4pFpFHEwaLXJ5TPw1fyzhJYSGq3GE/3k4ijEm0UPa5RaQPG0j3ccnc0MbC1pz2yA5NNTJjHtm4USRKr5CdX93NPoKRPxzIQm8101DM9mC6TSvaZwwQuIV9zlkzm7VU7WdaonnU/6FrLZfpXYkWppcjRsqmNNfNe14c73k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mx4cUD78; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mx4cUD78"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mQOF1674590
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I8jhQUz0BKL+Ysm2d
	LXxQjRhqf9C6QNODV3TwjShQX8=; b=mx4cUD78W4piIKMROU+VKe3+xG7+kGakr
	bsWBVrPPMq6eM7HWkkdHmoZbn6P4wIJnl5rw1QIP3PNH/HiKwT5qxLNnylb1S/8j
	bIDSqBvLJPvzSCJHhclnfsdtX8mFCzqhrcdRsXiS8QkA/mgVRmtCktWaK3CBARrp
	VpeuTBTztdhUCP9OjiclCzn5u20DhvXnYZiOaey2M7HlNxL44cTcryXA6CQ1uIaT
	OeqqdBIEkAm2nh2g3Egg1JlraI/IFhl61c6DdOaialLZZgfDlRqQzFlMz17kC1IG
	fU5YflPa/Fpxrb/ib8H6Ex8VVuAOhatQ97LqVFARymrL+SQ15Ring==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw506x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JA4e3N031864
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1728aqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JADqxt59572582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 10:13:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF6812006C;
	Fri, 19 Jun 2026 10:13:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA4C42006B;
	Fri, 19 Jun 2026 10:13:52 +0000 (GMT)
Received: from t35lp84.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 10:13:52 +0000 (GMT)
From: Ciunas Bennett <ciunas@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Ciunas Bennett <ciunas@linux.ibm.com>
Subject: [PATCH 1/2] s390/kvm: Refactor __diag_time_slice_end_directed for single exit point
Date: Fri, 19 Jun 2026 12:13:48 +0200
Message-ID: <20260619101349.162430-2-ciunas@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619101349.162430-1-ciunas@linux.ibm.com>
References: <20260619101349.162430-1-ciunas@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA5MSBTYWx0ZWRfX/HMySNtkYswJ
 xI5hOmnVngGj7/dxdraYyNUDgFdVSapULgzHVjJAOif4NQI67uZDPG7qwe7jNfAS+Un7mMLtD6l
 jjY8VVJXXJpDCcRrYNcLUcs5LnNGP6w=
X-Proofpoint-GUID: XgzVpMlzV5CE9aDVSjgYl3jCaSd7-CGh
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a351665 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=95mcOe01666WQwagYVMA:9
X-Proofpoint-ORIG-GUID: XgzVpMlzV5CE9aDVSjgYl3jCaSd7-CGh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA5MSBTYWx0ZWRfX81InP0VqqmBD
 w4wKHzgQU2mfLERVg97CeFpVxV6q8zbJGFy/e9UE+ajg6o9GO8qHY3WKsTyhUdIryFuFu0lK3/a
 T6WX92LUncMnRlhzoxM/8R4EjVjXQbSvOzBOxzi6aw3TYWDBpQidQyfrfPOAGrReluWUw1JrpoZ
 TGLhZ2EHIEYJgZ0aeRLJu1BOATfTSYhE02LIdsMQpqeV4sPrerTc+vlwAALko0TgXVzSpVKSO3k
 +RbUNREBQ1eqT5mmdqFxfkVJM0L2oa/h7ZBOKBO4nruP3fezbjrihbdVihzUasZqTukQYC0i4Qp
 Ufz5Khbb67oWyyoFuntL8Z6+5k89rGklt6UIA1f3AsbIG4SxKfN8JOIi927myccmmnSxXEioEUe
 9G/bAx/jl7yiLLwlyPebleGIUXuVXBAkPtuunEruq+8If0Tcgrx6QdBO8xnbS6SVi56/woj5Rd1
 uP8p9Lxwyu4HDOM6iMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190091

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

