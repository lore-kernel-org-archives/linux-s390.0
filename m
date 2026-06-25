Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC2A328243
	for <linux-s390@vger.kernel.org>; Thu, 25 Jun 2026 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393397; cv=none; b=SXH4RhOs551qzXEBSG/xH3YB4fReuud+llR94ouV93Nt+/N3bQZeDkWkbEp8Mne6X4chfle3rMQLWzlA3GHNeneWPvrCfY2AkZwgeTags/kjGkQ252csUW8nZikhoTr+iF4uJ3pICwDPfIEmGbgGJ+DzWkZm3CXpweoZaVJ/Xi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393397; c=relaxed/simple;
	bh=sIjnrmQDZdMFEc9ZEbJoqPvGL2JHQjbD/1xlGVAzNoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGCeFo29CKKzwA+iBYKeXfI9Qkhk712ux+nNjDCS3Fgf67XAS+bk+yA02JmW6lamB9BPoLvyq2eR3fAXOEzsluvB0+KLgnJhhRUjKE5UkY9FE2Y7H5ot0XlOZwQWACxnxsFANk0PKq/wuC/WlapIinbuW6I+frsQAo668bM1FcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iY7lDJYY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iY7lDJYY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3mRW32927509;
	Thu, 25 Jun 2026 13:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1zZYrtLRg9ZGULZhY
	n1i/34roCQ3RMVbGDwGbTKJGIw=; b=iY7lDJYY/pw3Hf3leE4B9qHAmBVfi8OM+
	L/iXRD2YwTXpTaZYGn9i7yu43APfb7oYAT4XEOJNtcIWE0vP1a/BeoNXCf+Ygpr4
	Mu09+QBY4kKnELZAwHKyUYOJ5Rww2zs2y+xjx0jaXuBI/jjTYTkB38DcV3leV752
	P11XQP+loF4J4/Zlk6Saxrc7ScSPwQYVpuux6vAzt3JfKL4lkn9mEumW3tPIZT9t
	dkp3ij+Z0k7kBQyM7aMuYfbTqapw+PwTmbAGfUH6XXCvUgGjJbWErze4Eq0dTCXb
	zvEALkggObhb4HdVOBIq5i9C/8MRC9PpBLdSfrrbf7XfKqH3rM5bg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gsn6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 13:16:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PD4kxt004140;
	Thu, 25 Jun 2026 13:16:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyx057-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 13:16:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65PDGSYR29950342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 13:16:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82F0120049;
	Thu, 25 Jun 2026 13:16:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AC282004B;
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
Subject: [PATCH v2 2/2] s390/kvm: Add tracepoint for DIAG 9c directed yield operations
Date: Thu, 25 Jun 2026 15:16:15 +0200
Message-ID: <20260625131615.262367-3-ciunas@linux.ibm.com>
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
X-Proofpoint-GUID: reK00zfNGMOBxOhC_0SVJQ62VWa_vuPF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDExMCBTYWx0ZWRfX8YrdrkiwsEYI
 907I33A69Zo1t2Bj+02SusPpW1uL3Xl9pR6D2a4YWZtxGfpo/70tQzJUeQxl/b4GaKa+Sm5W0Q4
 DGiUpLgG7hJ+zzS40lezZ+ZmY/kUoHU=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3d2a30 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=voEG10PFg9Div1x7oZ0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDExMCBTYWx0ZWRfX0/bjEFq1ffcm
 6QuIXBpJBiKt1S6+9ZJ3rSCLimNnHLoVAac2oSCRyhnUK/xNuxCRpqtAqUYH/OEK3U5VoWyeayN
 1GUezSvmaXruVHRBYqOhAVQ++7PLPHLDVEyBQ4huZFzj3G5Phi/Xdjdr6BfnTChbIozg7aleT+6
 JxRTsidGqnYKWYZlag6vmOcjFsiHJl1qSW9SdFzTcCAxhdhAYmjvH5DCWfoMnbvofpR7yz3hKJU
 KhCh/Fv6u2Tle+Z3U0DZ95rnfjPrQKguM/1CY9kL3ahWdBgmh/BmmiM9hBs6IdHEd5hzIUPV5Gs
 eZ1Bzg/NXl4XuAtup3gFdIpU35UPgGMScnsx3THLtRQ7SQqgQkDfFRDKcw6/q/ZHFWNMSc7DEn5
 kFw6h0CZbCea1dHW3CtTmp9jo1AznY9KIIheEecOFFQuShHE5QGy7Hz0XbEia3TWRTK6z4bbbk+
 0xX4CQ4du2fsqWI/svg==
X-Proofpoint-ORIG-GUID: reK00zfNGMOBxOhC_0SVJQ62VWa_vuPF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250110

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

