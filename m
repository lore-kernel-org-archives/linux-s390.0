Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DBC3FF88A;
	Wed, 27 May 2026 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893053; cv=none; b=t10z6+o/3b4osYqdhxDJeI5QweExufIvJyYWdJKrBnw2ej/hKqqDjbu0X02I2KqawrkTfWxsJ/Twbnq3Btm9t8Iwt/Rt3IfshRAzHJ2GlZIMa4WaYG/WdRO+7uL7hRgz2LjZwJzi0y1MYu/eiFxIfY8ScvHucDBtyrCNDO8wqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893053; c=relaxed/simple;
	bh=S7GGhHTOuo+dByIWG9WF9ru2vJYFFQOHqb0uTxx2X8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YE3W0AHlQ2DyTdTUG/aaB85YnbfTQWNVK8BJi1IBQafcurxs8mOZLpRQDHgaSDsnL8yhm/zqgk6/rygSGhfqnz3L5Udf9hjfypDkSEbmi1KOb3gWVG/73MgCtCIs/NMyCA0pa/KZ4pSLKsHq6eIuy+u+v4NVX8N7pPKB+t1w5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XuGlEwpH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XuGlEwpH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCQoGu736243;
	Wed, 27 May 2026 14:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rNQL8SpV/n85OJA2N
	7zCuZzIiLAo6gT2p0S/zS5qvBw=; b=XuGlEwpHN0njRt3NxdauzL8XtwTe2huJP
	5+wNCzaa4rz3Y1iuXMN0p7AWSwC2pnFWKOZKHZvuRF+ehY5NeW9tRMB4ETW2g2fS
	eEtl7LbX8AzGmY6g2fuRyKG1AgL5gWbt+JuHmwfUVXwAVHfuwdOh/ZaBRFZbGNiz
	l3SpAt7xSA7dw7VSMUqIvCYDMExcPA7W17aYtfEUPb0gdQHR77X4whGDoRoPSO1t
	9oYeptWaJCgzBWuXcRELHp6XGWbuPNMjTpQI6fXdN6sjn5eCxpnemF8nE2gkAR03
	5VYGXVdsXpw/h+zUHNYNu71LaUsDI0HObbrH561b9RDvzB7eJ54CQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nc8k13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:44:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64REd5LM019625;
	Wed, 27 May 2026 14:44:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb3f4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:44:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64REhxSG30998880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 14:43:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A737720040;
	Wed, 27 May 2026 14:43:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 747AC20043;
	Wed, 27 May 2026 14:43:59 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 14:43:59 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v3 4/5] KVM: selftests: Fix pre_fault_memory_test to run on s390
Date: Wed, 27 May 2026 16:43:57 +0200
Message-ID: <20260527144358.186359-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527144358.186359-1-imbrenda@linux.ibm.com>
References: <20260527144358.186359-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a170336 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=LqbLTa_TKMQyRjCc8hQA:9
X-Proofpoint-ORIG-GUID: sy2F1_qvd-oCMy-zEC4VREJdt-7lvui0
X-Proofpoint-GUID: nyz6MRrimiOFRnFXSK-94gsLtRaXJo1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE0NCBTYWx0ZWRfX+j7cy0nh9W/i
 CzsMpaKKZewwxaVNSQppIU6mVbWXa9d7TeIQIKDQybUf5bJPEhi9hxeb4LsqdKLdaNlAxkbU/Gx
 jd5X1cPhzR9qJ1E+oaNRNRIeqsnex8gb5p4pZRdzHkOuiW9T92nWwEhoQxZQaSE29ZSpr6U8hwP
 ZYadlcIAJKrFk6OrpI0vDbThgJy4PtBmYPJV/T2R7dgEDwY/CDopo8ZGHmIiRK115tfrrZN9Dx9
 MfzCPqjW6moLxL2HMoj7Lzp+1QVaOHK0FGR7ISzzXXq1vU/5+ItsI2C76zfG5fHj6bHSKqc2fJ9
 FYd9yWeQEuOSix72kci4NVuuVn/3BVwen7COWJPa4+v1CIpWwckohdtI/rXJn+e4g9/V2zO8WJ0
 SDrqGZBsw3Fr91ZBX4gX2tNHbeg7GEiU5MK7XKwR6UuzlGglz0i1olL8674CRY9QqWFe/suV9bJ
 3bzJR6dIcKNVAw/rW9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270144

Add a missing #include <ucall_common.h> which is needed and otherwise
not included on s390.

Remove the assertion  vcpu->run->exit_reason == KVM_EXIT_IO  since it
is x86-specific and redundant anyway.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/pre_fault_memory_test.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index fcb57fd034e6..a0fcae3cb7a8 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -11,6 +11,7 @@
 #include <kvm_util.h>
 #include <processor.h>
 #include <pthread.h>
+#include <ucall_common.h>
 
 /* Arbitrarily chosen values */
 #define TEST_SIZE		(SZ_2M + PAGE_SIZE)
@@ -167,7 +168,6 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
 		.type = vm_type,
 	};
 	struct kvm_vcpu *vcpu;
-	struct kvm_run *run;
 	struct kvm_vm *vm;
 	struct ucall uc;
 
@@ -193,11 +193,6 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
 	vcpu_args_set(vcpu, 1, gva);
 	vcpu_run(vcpu);
 
-	run = vcpu->run;
-	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
-		    "Wanted KVM_EXIT_IO, got exit reason: %u (%s)",
-		    run->exit_reason, exit_reason_str(run->exit_reason));
-
 	switch (get_ucall(vcpu, &uc)) {
 	case UCALL_ABORT:
 		REPORT_GUEST_ASSERT(uc);
-- 
2.54.0

