Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680943D905D;
	Thu, 21 May 2026 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368755; cv=none; b=hbK7LLizSUT4Ahxmy2EeS7Et5KJOR7t3UvbOhudo1bR+2qYpfDh79rAT8y6wEEb0iUWHGWbIC7DM9NevkZVF8iw6UQNaOTSDwFqq6KmOvCvZ1mbqhGckzBP1JYo5nQHJlGzrzgXvvoDl1qD97UBtMpV/lvryQbez6IPRRaLfMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368755; c=relaxed/simple;
	bh=c1rvPNfFVi/0HEMjmH5uoCqWi1E1uVPeFLwzxvHVQG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScPwMm3o37SenxcBTzikHFOM0vsQ7RARsmjLfk0TiVGNZtVwZi1ZmwAKgfjyi97SHrFGay8KHquNhFAHs2uj30eCwlw2K82sNEFLW5l0esI3YaJFJUr77ZFIxpkuqVKb637002vCNgf9m/cMfFXUySoSzYCDb/ei8n4m1rSObzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K5iiwryR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K5iiwryR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1kPwo2907049;
	Thu, 21 May 2026 13:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w1f8/z6o5AGbH9GJN
	LN0HPVIWPqrSdLjcZxRErpY+UU=; b=K5iiwryRWqgHmUJNx4mSPxYn3uEkj1WM0
	PWqqDl+7+DRDH0nOhjVzEBR/pk/LvvI/Bn2xtMSMq6SJhPDpBD6dj9iEqArUFbTj
	TX8z0ANF7ut3itTgN/xEjB/P19WuBZP7OdVgfXRW22wYADvqZNmvq8M61/qkHLLI
	a6durCZp5rDNG1kchiPATGloDOA+lPqQ+Ye/LuswLFzTqOu7Rb7hnlJbdp49zHys
	7BQyibJsUByCBrlNf7LhL9iWf+NE3KRBOfnbcgPlnr9WsqYG5H2L1C8gIfKXmb5F
	w3gwt2aLKof/4zfys0H2JYagPH0Vd5n9K8ndPWvI4TmKmKRXf7mRg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mxycy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 13:05:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LCs4Nm023951;
	Thu, 21 May 2026 13:05:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqcdrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 13:05:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LD5ZbS48824688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 13:05:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D45720040;
	Thu, 21 May 2026 13:05:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D64E22004D;
	Thu, 21 May 2026 13:05:34 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 13:05:34 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v2 4/5] KVM: selftests: Fix pre_fault_memory_test to run on s390
Date: Thu, 21 May 2026 15:05:32 +0200
Message-ID: <20260521130533.156491-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521130533.156491-1-imbrenda@linux.ibm.com>
References: <20260521130533.156491-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: BrOACi0d9YJN2QHTPY0fPUUGCVXpKTm-
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0f0325 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=LqbLTa_TKMQyRjCc8hQA:9
X-Proofpoint-ORIG-GUID: 9-vbXoEfemzFWfEEu6lkB1vcDdnHxkxf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEyNiBTYWx0ZWRfX92qzcFv18+yu
 qiV+fekLZP0KzgIsDMy/etbwvn2DVFcILEqXwcKJZLvr1agsnnGhEIgL7vhHtERTsN4MeoRNwTK
 ns5LZtoLSbOjJqJlsUr2jOxtl+N0r4fhGdqSvQ8cQ5sbtE/lFjhp0J6mLyJh15pP2YZQwA5zPk9
 i5UU8HF5xX3mPN3xvl1ARYQjS10sIBManGSr008ciMEpk/DqdfdOJFFVnwvLVwEoABezOK8xdaq
 vlNqJzh2D8JswEIQU8LmKL2jlBLaD7AA2rY84kuBWE4zUaqZ+vloHX4e5U0B33rSeRtqf6fGAnz
 /8N8tV1I3RboablQKRblgMDyhaNuhIsFbUW/JOZ3iwxgHIYfG1Eu/XSrt30wEfWndFeJWrEeJmQ
 W7/1VFTaOsRkd7h6svqDaV7nT7SMjeWfqzM2ElYmY1FANB95WL1c5BkMkIiSHhbrjpvX1hnhuKn
 t5e5l7WieRQbnFtVV0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210126

Add a missing #include <ucall_common.h> which is needed and otherwise
not included on s390.

Remove the assertion  vcpu->run->exit_reason == KVM_EXIT_IO  since it
is x86-specific and redundant anyway.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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

