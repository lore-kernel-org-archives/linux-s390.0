Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC5236F41C
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864041; cv=none; b=qbxXoavbdiG5d5Lqc0r/PLEtld2QhPU+R1SqZLgkU4o2qj3waoBq/ThkHyFu//m20YQH3i0/3yPT1FnvHn3unC399E8VSurHtBnL+CjeZhrDc2nd2TMtWhhnTp2WKzh+kCxUZ5NBIqmr1mXrPAFEK91qojg0TftlvsEjDnYzoKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864041; c=relaxed/simple;
	bh=sIjnrmQDZdMFEc9ZEbJoqPvGL2JHQjbD/1xlGVAzNoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MU8+uDSzi66nP28r4DsRGnLzVpVHGfvfvAd+jLBtJs+UigBg7TQPrUIO49uvglHqipOWHBYDcMMz+37kAfABzKWcWV2rCp25xTiXgrGUfYokRbWvg5ciMxty4SYbx+KOCPlG+RZRMoAV3tB9J4vpkN8x7q4a9OradFCm5B5nLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gP0y/wHt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gP0y/wHt"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7maJ51616495
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1zZYrtLRg9ZGULZhY
	n1i/34roCQ3RMVbGDwGbTKJGIw=; b=gP0y/wHt4rxFf9rOjle5dAQheQAcywhov
	eAwfvGJgstrT2s16oLhbzDaj3sOP4Tlet6sZsnv7i0T+OTiAGi+H77S6tMlcUTn9
	LH5an/4dFuH/sGHiXX9wchU1q6+qkH39X9CtIMk26zMeCluvuMee6O9zHF5hfg6N
	raGERBYLmoRefh3wwsjw44IMMp+wfcYIVYka3FCI/mz4VhSModTYFwCPBT8xQWo4
	wsov6RJczqulnwqicpOi7HnHrs0T6NFK3QTcPskCv1XXBnadByZEyOaMzTmmhxyM
	qT0eZnVPS5QDVn91wAEiITzq7Yzc+A9jALEdkO0DCqbS66avtMtvw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxmr51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JA4dPu006926
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172ga1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 10:13:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JADr3g54985008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 10:13:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 664AF2006C;
	Fri, 19 Jun 2026 10:13:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51CFA2006B;
	Fri, 19 Jun 2026 10:13:53 +0000 (GMT)
Received: from t35lp84.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 10:13:53 +0000 (GMT)
From: Ciunas Bennett <ciunas@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Ciunas Bennett <ciunas@linux.ibm.com>
Subject: [PATCH 2/2] s390/kvm: Add tracepoint for DIAG 9c directed yield operations
Date: Fri, 19 Jun 2026 12:13:49 +0200
Message-ID: <20260619101349.162430-3-ciunas@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a351665 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=voEG10PFg9Div1x7oZ0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA5MSBTYWx0ZWRfXz4falZ7tW8JW
 4vG2bbUv6jrxCOHkjoVgjhJ04Z8KEXTulam3yNR31lxtrzfN1REnweMi75QI8k04n3/M7tYge9q
 wJ2T0B8RVxdYfrDbNZAItWNYmdnX+lCx2K6iyin9UXyGF5CWVHcoC1KCx2HiBc29kShD9E0yOcr
 N1XAj43Cm8oq/Lg+bugxcxcZ1VBTZ57iJZOJf3dlyzqyan2UU38Wf1hj70Ko1E6rZE624RvideU
 hZMjfHZVdrWtqc/uGbTakSymb73W/6LpiwE1TBa1ogTV3osEPRjY2le9toDsbyTTxKXRqwDVFqf
 T8nfYDQ4MgEn2VvwPU+NDoCskVN02nPaks6wm4s2O5mUeawNSukBHxO6Y8WEKxZGXJ4KUGTFrgg
 e0F51JvaE0bkm8DjqymYCpmk6mCt0Ge0slcvNYJHFS6SSCefyDB4KC8iy7wsX7LnWZWxsnPLaEu
 HVcrI6qs4hKB9onnYdw==
X-Proofpoint-GUID: k2l-Xeo6E0PRKdFejM3RSe-N4PCCKWTf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA5MSBTYWx0ZWRfX8FArXDLQwtbH
 pbQFo/SoReXoSq/+x81QsYSZBMb1i+YxyC80wwLKEciK6p5dcu2ES6gIi56Gp+7OaO7JzlVjf26
 4BvGAD3MjUdbZDEUDBOfmNBQ4GlFnWs=
X-Proofpoint-ORIG-GUID: k2l-Xeo6E0PRKdFejM3RSe-N4PCCKWTf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190091

Add a new tracepoint kvm_s390_diag_9c to provide detailed observability
for directed yield operations. The tracepoint captures:
- Source and target VCPU IDs
- Current and target physical CPU numbers
- Operation result (done, ignored, yield forwarded)

This enables better analysis of VCPU scheduling behaviour and helps
diagnose performance issues related to directed yields in virtualised
s390 environments.

Signed-off-by: Ciunas Bennett <ciunas@linux.ibm.com>
---
 arch/s390/kvm/diag.c  |  1 +
 arch/s390/kvm/trace.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

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
index aa419eb6a0c8..2d6da21f590c 100644
--- a/arch/s390/kvm/trace.h
+++ b/arch/s390/kvm/trace.h
@@ -283,6 +283,36 @@ TRACE_EVENT(kvm_s390_handle_diag,
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
+		    __field(int, current_cpu)
+		    __string(result, result)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->target_vcpu = target_vcpu;
+		    __entry->target_cpu = target_cpu;
+		    __entry->current_cpu = smp_processor_id();
+		    __assign_str(result);
+		    ),
+
+	    VCPU_TP_PRINTK(
+		       "diag=9c vcpu=%d pcpu=%d target_vcpu=%d target_pcpu=%d result=%s",
+		       __entry->id,
+		       __entry->current_cpu,
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

