Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0738A72F
	for <linux-s390@vger.kernel.org>; Fri, 24 Jul 2026 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890926; cv=none; b=A/n1VofDPYLZCbgFxynwJoEbzK/RoTGo/NSRrSKFF02lMHRZaBzJSikfpRAu3mCzsNvk1QuIp9/zfLsZcL0UDCYX4jU9t72NUgsAv6+hutlOuYKA7BbTxQG+HbSy72Mg9kee2WowFC+VNTeHkgoAhB8heU4LJH3dJNugHXlEVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890926; c=relaxed/simple;
	bh=TcCwJYJIxTj1Rfo9Bux1sKsrFb+1IXOFxyVgfu4PVis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASwg4RWMRFRQPtp/W3QaiksQ2NTqRKTMDVJqjS5Zj/yqXYxmc23ynjKOQTj4SoWflItkT9JciSEVgWBpNdrsPTy1I36lzFxTyq7vWSn4Y4lGgdothdcvp7rELw5S5x/mErNIvHB3H2HFr431x59bXdSSjBs2XFgAWLMYQjEJtOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tK+zg8p3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tK+zg8p3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADbTu1427370;
	Fri, 24 Jul 2026 11:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GcsusTNWb8mHNmFpc
	PYkgjecikp0j991iiLI+z2690k=; b=tK+zg8p3QCdIXz90lsP4Zzt+D2a5E4QXB
	eIsIyec0ZIq6cZqmScui5dtL7/3L7hZdpBsKBvaQYLCgSd1bv/Mrdw7wu6p7V6ld
	rwFIrvJCc43uGRk6YZNYz6zCrggA5Cj3iNNG19WkDvjXkNVLqV6AnI0kzC7n8SGX
	wbRVPyBpFopPr9HQA/dmGEwzj+z8wWsaVbpalwL8H1yiCYF3ZphnxXMu13TvWZSL
	BSrbeGxL4bFu/JTH2EI0hKIpdY+s/KS0/gAkAsFPbco0AubA00Qa4outJfUtvCz6
	pGgYx78xibhhcRXQ1ls6t1bBCyVrYrY6ZsymNMBzaWKGkD0bLRd7w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gkm2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 11:01:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OAntvJ006983;
	Fri, 24 Jul 2026 11:01:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyra5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 11:01:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OB1mKS51446132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 11:01:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59A2F20040;
	Fri, 24 Jul 2026 10:40:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34D7020067;
	Fri, 24 Jul 2026 10:40:07 +0000 (GMT)
Received: from t35lp84.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 10:40:07 +0000 (GMT)
From: Ciunas Bennett <ciunas@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com,
        Ciunas Bennett <ciunas@linux.ibm.com>
Subject: [PATCH v3 2/2] s390/kvm: Add tracepoint for DIAG 9c directed yield operations
Date: Fri, 24 Jul 2026 12:39:58 +0200
Message-ID: <20260724103959.14861-3-ciunas@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5NyBTYWx0ZWRfX0anUpc+pGQ32
 IUHidBtOUY7farUgtwk1ZLGZJBOQBTuybcObVuz1u2wwlrkbXwr81mKKQnGJPF2hwldcShtkGRv
 Q9ZGdr64CZRzmb5wh/wJCouXA6KI2x5LJVlwwv2jMM9Mzde1gXrdhuJPtnhErfrpuMjbYwZ2wmU
 ECUoPo2fbDOtGRro/fnPbRFHl3B9JFG6Q2DCawSHRP91MlyG6Eesl2EB8K/wpYpKwSyKjqw4q0y
 A0o1PyLGb8JIuKQihOVQjjGKjhWmjmSWDbcNVfqJtUsVpl6NM+yH+lc1pVT/nfzDE3jMAHVZebk
 9H1Er7CQgMgTzDWMXQy0knuCSdArPhEI/ZbAYfS9IGbjBpQjBFhHwF5lvK7Vd5BOtspbRfprm1p
 UkgQo4mHJ3nMjch/gGWYO+lZ9VaiQRj5OvEUahgmy/o9hkX96iAlPXv3qnOwVfYkSa4RtYC3OPL
 ZHUG6xRijq69tts0rGA==
X-Proofpoint-GUID: rhITw7bo984Am8-23G0R2eITonLFQRht
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a634621 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=voEG10PFg9Div1x7oZ0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5NyBTYWx0ZWRfXzRCEjYh6eexu
 HDkSLZeFYElBe55FfwaXA35wgIqXdztrwpL6ht9cOsO44blcOz+r6lgP+WVbRZ1QLUA4PM6xBSq
 6VYO3IWplJXaayaNmxR7txeCT4lyId0=
X-Proofpoint-ORIG-GUID: rhITw7bo984Am8-23G0R2eITonLFQRht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240097

Add a new tracepoint, kvm_s390_diag_9c, to provide visibility into
directed yield operations. The tracepoint records:

  - Source vCPU context via the standard vCPU tracepoint fields
  - Target vCPU ID
  - Target physical CPU number
  - Operation result (done, ignored, or yield forwarded)

This improves observability of vCPU scheduling behaviour and helps
diagnose performance issues related to directed yields in virtualised
s390 environments.

Signed-off-by: Ciunas Bennett <ciunas@linux.ibm.com>
---
 arch/s390/kvm/diag.c  |  1 +
 arch/s390/kvm/trace.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 85c84421b510..031ab6e5d6c4 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -228,6 +228,7 @@ static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
 out:
 	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: %s", tid,
 		   result);
+	trace_kvm_s390_diag_9c(vcpu, tid, tcpu_cpu, result);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
index aa419eb6a0c8..dd2685c7df5b 100644
--- a/arch/s390/kvm/trace.h
+++ b/arch/s390/kvm/trace.h
@@ -283,6 +283,32 @@ TRACE_EVENT(kvm_s390_handle_diag,
 			   __print_symbolic(__entry->code, diagnose_codes))
 	);
 
+TRACE_EVENT(kvm_s390_diag_9c,
+	    TP_PROTO(VCPU_PROTO_COMMON, int target_vcpu, int target_cpu,
+		     const char *result),
+	    TP_ARGS(VCPU_ARGS_COMMON, target_vcpu, target_cpu, result),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(int, target_vcpu)
+		    __field(int, target_cpu)
+		    __string(result, result)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->target_vcpu = target_vcpu;
+		    __entry->target_cpu = target_cpu;
+		    __assign_str(result);
+		    ),
+
+	    VCPU_TP_PRINTK(
+		       "diag=9c target_vcpu=%d target_pcpu=%d result=%s",
+		       __entry->target_vcpu,
+		       __entry->target_cpu,
+		       __get_str(result))
+	);
+
 TRACE_EVENT(kvm_s390_handle_lctl,
 	    TP_PROTO(VCPU_PROTO_COMMON, int g, int reg1, int reg3, u64 addr),
 	    TP_ARGS(VCPU_ARGS_COMMON, g, reg1, reg3, addr),
-- 
2.54.0

