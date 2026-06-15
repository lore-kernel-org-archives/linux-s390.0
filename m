Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221BA219301;
	Mon, 15 Jun 2026 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527376; cv=none; b=npiogsZmRlBpjxSeA94uPL7GOBXzXleyCunF34xt1rdccG14wINNNZEKtUHesp4ua1ztpmseJno7nqfu4z+YbhqL3lvaJZl99sy/ezQBbTmXMkRZ+qJfGOGuPRPOcBi5VhT74Xp3UGi22zSlv/bWe0IsMs7CDCnWqCmJDPGwTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527376; c=relaxed/simple;
	bh=//51zd7vctwwUhBm92wjwifjP7CUSgJkDUl0VyrxYYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgRBvwVvZ69+B0Mq0QiylwfI46aiunh4HA65JTjeVx7uTFdy+1kpbrs9u/t0TX3BQhOSal4+glXP2wzXtUGKodVX2+KGE5P9mDPBbugReuiP5YXWvzpHsB6RjZC1ZTbd4mMatvJ165/nRmRwU7WLcm+9pb1Ntco7ENv2mD7W8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NrnAn0mP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NrnAn0mP"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAo2w42208901;
	Mon, 15 Jun 2026 12:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l2WVwzok1dkxISG2m
	rV2clWaIfmcJ4BZ9HPJI6m819c=; b=NrnAn0mPpzyUrxl8CkSDevaauJoSP48M9
	GWm8cE2KttFMk8zYiPrIvJEdBbGpgy162OO867MuHe9ium8zsQgYkbPU6ZPYKMWm
	ngYdnc1JBvVeLZvP58D4ypXMX4paIomKXp4YHd04SUUG2SnObGOEOhU+km3x7hJX
	p4z40jI30YcjyBHNdRGu25fhYnUEol1HnfifzuYzWdyJGOmhXUgs9veORGtSHC3c
	IHBEpBMKxOHUZVAhLrJcWVJMNX1oybIvXdhP3LvUuW3og8F9T7PJTFF6EGoHFpMV
	y5soDuWgvSlWUW3sTMv9ELzLWXXfZvw4Muv40fZ6ldeBxqg8qaX2A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm0g7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYgPV025510;
	Mon, 15 Jun 2026 12:42:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1gxgmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgkXO43647240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0966A20040;
	Mon, 15 Jun 2026 12:42:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94A282004B;
	Mon, 15 Jun 2026 12:42:45 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:45 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 04/17] KVM: selftests: Fix pre_fault_memory_test to run on s390
Date: Mon, 15 Jun 2026 14:42:30 +0200
Message-ID: <20260615124243.187614-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615124243.187614-1-imbrenda@linux.ibm.com>
References: <20260615124243.187614-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX+QukukjtYPvH
 KPZxS1tCBnA+9KZ+u4hUtZiqAbTvclBVQatCXghHkO7iH4cp3CAAAHEP1JX4XiljN6AXJAgUsWL
 Dg1wro2Uk4vRSR8KEFA0uPjKn30bJoU=
X-Proofpoint-GUID: fXBTnPRmESC9onvD8lvvtPA9BX_u8Fl1
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2ff34c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=gJwFvwdI_JxUXFNrYgUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfXylEqBcZsMz26
 F0rtXg7cBZVuIalv7rqdCNp7/afX73Qip6Pl7ea0gBijkcFTCMVr5QGbamWcOngq4/LyiAgECvz
 hg2Q4DqcL9kTZSkzl/FKKp3OiSPKJ6PzFvKTX+pIZNtuzt1JA60ban/Mdbs85QV8Rq38JdKdaDz
 nRWb4cbMbaWxnp6FmRUKDH0a5qjtJjsRXSTRpx30FgF/azLZkdVxgbvFZHt8gTwXM/35v3aswAb
 6SL7xjeqVA35ZQ9ZKiQo/2y/89vA4jHthPRdjBM2J8l0KGffrXkOv2tfGk9xshOZWdytZRLoKH1
 KlvuDYkuWuyGaen0auxp8YpmUfEU+pllEt9AZh5VoTClskDNZECmTfW15L0NknvEUlHgcrfSaL1
 /zoGctFZc8BzgIC/L0OT0S8O6ZNZareN/wNS+LuQ/SaMCaJJM9sePue5V97kQBeAqZHamlw4MXs
 XBWERiz/JbgUqT+r53Q==
X-Proofpoint-ORIG-GUID: fXBTnPRmESC9onvD8lvvtPA9BX_u8Fl1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150130

Add a missing #include <ucall_common.h> which is needed and otherwise
not included on s390.

Remove the assertion  vcpu->run->exit_reason == KVM_EXIT_IO  since it
is x86-specific and redundant anyway.

Acked-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260527144358.186359-5-imbrenda@linux.ibm.com>
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

